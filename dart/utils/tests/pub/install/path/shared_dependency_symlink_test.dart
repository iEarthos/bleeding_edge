// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import '../../../../../pkg/pathos/lib/path.dart' as path;

import '../../test_pub.dart';

main() {
  // new File().fullPathSync() does not resolve through NTFS junction points,
  // so this feature does not work on Windows.
  if (Platform.operatingSystem == "windows") return;

  initConfig();
  integration("shared dependency with symlink", () {
    dir("shared", [
      libDir("shared"),
      libPubspec("shared", "0.0.1")
    ]).scheduleCreate();

    dir("foo", [
      libDir("foo"),
      libPubspec("foo", "0.0.1", deps: [
        {"path": "../shared"}
      ])
    ]).scheduleCreate();

    dir("bar", [
      libDir("bar"),
      libPubspec("bar", "0.0.1", deps: [
        {"path": "../link/shared"}
      ])
    ]).scheduleCreate();

    dir(appPath, [
      pubspec({
        "name": "myapp",
        "dependencies": {
          "foo": {"path": "../foo"},
          "bar": {"path": "../bar"}
        }
      })
    ]).scheduleCreate();

    dir("link").scheduleCreate();
    scheduleSymlink("shared", path.join("link", "shared"));

    schedulePub(args: ["install"],
        output: new RegExp(r"Dependencies installed!$"));

    dir(packagesPath, [
      dir("foo", [file("foo.dart", 'main() => "foo";')]),
      dir("bar", [file("bar.dart", 'main() => "bar";')]),
      dir("shared", [file("shared.dart", 'main() => "shared";')])
    ]).scheduleValidate();
  });
}