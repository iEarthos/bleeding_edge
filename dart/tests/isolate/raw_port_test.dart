// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Test RawReceivePort.

library raw_port_test;
import 'dart:isolate';
import 'dart:async';
import '../../pkg/unittest/lib/unittest.dart';


void remote(SendPort port) { port.send("reply"); }
void remote2(SendPort port) {
  port.send("reply 1");
  port.send("reply 2");
}

main() {
  test("raw receive", () {
    RawReceivePort port = new RawReceivePort();
    Isolate.spawn(remote, port.sendPort);
    port.handler = expectAsync1((v) {
      expect(v, "reply");
      port.close();
    });
  });
  test("raw receive twice - change handler", () {
    RawReceivePort port = new RawReceivePort();
    Isolate.spawn(remote2, port.sendPort);
    port.handler = expectAsync1((v) {
      expect(v, "reply 1");
      port.handler = expectAsync1((v) {
        expect(v, "reply 2");
        port.close();
      });
    });
  });
  test("from-raw-port", () {
    RawReceivePort rawPort = new RawReceivePort();
    Isolate.spawn(remote, rawPort.sendPort);
    rawPort.handler = expectAsync1((v) {
      expect(v, "reply");
      ReceivePort port = new ReceivePort.fromRawReceivePort(rawPort);
      Isolate.spawn(remote, rawPort.sendPort);
      Isolate.spawn(remote, port.sendPort);
      int ctr = 2;
      port.listen(expectAsync1((v) {
                    expect(v, "reply");
                    ctr--;
                    if (ctr == 0) port.close();
                  }, count: 2),
                  onDone: expectAsync0((){}));
    });
  });

}
