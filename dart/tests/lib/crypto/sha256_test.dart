// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Library tag to allow Dartium to run the tests.
library sha256_test;

import 'dart:crypto';

part 'sha256_long_test_vectors.dart';
part 'sha256_short_test_vectors.dart';

List<int> createTestArr(int len) {
  var arr = new List<int>(len);
  for (var i = 0; i < len; i++) {
    arr[i] = i;
  }
  return arr;
}

void test() {
  final expected_values = const [
      'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
      '6e340b9cffb37a989ca544e6bb780a2c78901d3fb33738768511a30617afa01d',
      'b413f47d13ee2fe6c845b2ee141af81de858df4ec549a58b7970bb96645bc8d2',
      'ae4b3280e56e2faf83f414a6e3dabe9d5fbe18976544c05fed121accb85b53fc',
      '054edec1d0211f624fed0cbca9d4f9400b0e491c43742af2c5b0abebf0c990d8',
      '08bb5e5d6eaac1049ede0893d30ed022b1a4d9b5b48db414871f51c9cb35283d',
      '17e88db187afd62c16e5debf3e6527cd006bc012bc90b51a810cd80c2d511f43',
      '57355ac3303c148f11aef7cb179456b9232cde33a818dfda2c2fcb9325749a6b',
      '8a851ff82ee7048ad09ec3847f1ddf44944104d2cbd17ef4e3db22c6785a0d45',
      'f8348e0b1df00833cbbbd08f07abdecc10c0efb78829d7828c62a7f36d0cc549',
      '1f825aa2f0020ef7cf91dfa30da4668d791c5d4824fc8e41354b89ec05795ab3',
      '78a6273103d17c39a0b6126e226cec70e33337f4bc6a38067401b54a33e78ead',
      'fff3a9bcdd37363d703c1c4f9512533686157868f0d4f16a0f02d0f1da24f9a2',
      '86eba947d50c2c01570fe1bb5ca552958dabbdbb59b0657f0f26e21ff011e5c7',
      'ab107f1bd632d3c3f5c724a99d024f7faa033f33c07696384b604bfe78ac352d',
      '7071fc3188fde7e7e500d4768f1784bede1a22e991648dcab9dc3219acff1d4c',
      'be45cb2605bf36bebde684841a28f0fd43c69850a3dce5fedba69928ee3a8991',
      '3e5718fea51a8f3f5baca61c77afab473c1810f8b9db330273b4011ce92c787e',
      '7a096cc12702bcfa647ee070d4f3ba4c2d1d715b484b55b825d0edba6545803b',
      '5f9a753613d87b8a17302373c4aee56faa310d3b24b6ae1862d673aa22e1790f',
      'e7aebf577f60412f0312d442c70a1fa6148c090bf5bab404caec29482ae779e8',
      '75aee9dcc9fbe7ddc9394f5bc5d38d9f5ad361f0520f7ceab59616e38f5950b5',
      '22cb4df00cddd6067ad5cfa2bba9857f21a06843e1a6e39ad1a68cb9a45ab8b7',
      'f6a954a68555187d88cd9a026940d15ab2a7e24c7517d21ceeb028e93c96f318',
      '1d64add2a6388367c9bc2d1f1b384b069a6ef382cdaaa89771dd103e28613a25',
      'b729ce724d9a48d3884dbfcbee1d3793d922b29fa9d639e7290af4978263772b',
      'b858da80d8a57dc546905fd147612ebddd3c9188620405d058f9ee5ab1e6bc52',
      'd78750726155a89c9131d0ecf2704b973b8710865bf9e831845de4f2dcbc19da',
      'dc27f8e8ee2d08a2bccbb2dbd6c8e07ffba194101fc3458c34ded55f72c0971a',
      'd09bea65dff48928a14b79741de3274b646f55ac898b71a66fa3eae2d9facd77',
      'f2192584b67da35dfc26f743e5f53bb0376046f899dc6dabd5e7b541ae86c32f',
      '4f23c2ca8c5c962e50cd31e221bfb6d0adca19111dca8e0c62598ff146dd19c4',
      '630dcd2966c4336691125448bbb25b4ff412a49c732db2c8abc1b8581bd710dd',
      '5d8fcfefa9aeeb711fb8ed1e4b7d5c8a9bafa46e8e76e68aa18adce5a10df6ab',
      '14cdbf171499f86bd18b262243d669067efbdbb5431a48289cf02f2b5448b3d4',
      'f12dd12340cb84e4d0d9958d62be7c59bb8f7243a7420fd043177ac542a26aaa',
      '5d7e2d9b1dcbc85e7c890036a2cf2f9fe7b66554f2df08cec6aa9c0a25c99c21',
      'f4d285f47a1e4959a445ea6528e5df3efab041fa15aad94db1e2600b3f395518',
      'a2fd0e15d72c9d18f383e40016f9ddc706673c54252084285aaa47a812552577',
      '4aba23aea5e2a91b7807cf3026cdd10a1c38533ce55332683d4ccb88456e0703',
      '5faa4eec3611556812c2d74b437c8c49add3f910f10063d801441f7d75cd5e3b',
      '753629a6117f5a25d338dff10f4dd3d07e63eecc2eaf8eabe773f6399706fe67',
      '40a1ed73b46030c8d7e88682078c5ab1ae5a2e524e066e8c8743c484de0e21e5',
      'c033843682818c475e187d260d5e2edf0469862dfa3bb0c116f6816a29edbf60',
      '17619ec4250ef65f083e2314ef30af796b6f1198d0fddfbb0f272930bf9bb991',
      'a8e960c769a9508d098451e3d74dd5a2ac6c861eb0341ae94e9fc273597278c9',
      '8ebfeb2e3a159e9f39ad7cc040e6678dade70d4f59a67d529fa76af301ab2946',
      'ef8a7781a95c32fa02ebf511eda3dc6e273be59cb0f9e20a4f84d54f41427791',
      '4dbdc2b2b62cb00749785bc84202236dbc3777d74660611b8e58812f0cfde6c3',
      '7509fe148e2c426ed16c990f22fe8116905c82c561756e723f63223ace0e147e',
      'a622e13829e488422ee72a5fc92cb11d25c3d0f185a1384b8138df5074c983bf',
      '3309847cee454b4f99dcfe8fdc5511a7ba168ce0b6e5684ef73f9030d009b8b5',
      'c4c6540a15fc140a784056fe6d9e13566fb614ecb2d9ac0331e264c386442acd',
      '90962cc12ae9cdae32d7c33c4b93194b11fac835942ee41b98770c6141c66795',
      '675f28acc0b90a72d1c3a570fe83ac565555db358cf01826dc8eefb2bf7ca0f3',
      '463eb28e72f82e0a96c0a4cc53690c571281131f672aa229e0d45ae59b598b59',
      'da2ae4d6b36748f2a318f23e7ab1dfdf45acdc9d049bd80e59de82a60895f562',
      '2fe741af801cc238602ac0ec6a7b0c3a8a87c7fc7d7f02a3fe03d1c12eac4d8f',
      'e03b18640c635b338a92b82cce4ff072f9f1aba9ac5261ee1340f592f35c0499',
      'bd2de8f5dd15c73f68dfd26a614080c2e323b2b51b1b5ed9d7933e535d223bda',
      '0ddde28e40838ef6f9853e887f597d6adb5f40eb35d5763c52e1e64d8ba3bfff',
      '4b5c2783c91ceccb7c839213bcbb6a902d7fe8c2ec866877a51f433ea17f3e85',
      'c89da82cbcd76ddf220e4e9091019b9866ffda72bee30de1effe6c99701a2221',
      '29af2686fd53374a36b0846694cc342177e428d1647515f078784d69cdb9e488',
      'fdeab9acf3710362bd2658cdc9a29e8f9c757fcf9811603a8c447cd1d9151108',
      '4bfd2c8b6f1eec7a2afeb48b934ee4b2694182027e6d0fc075074f2fabb31781',
      'b6dfd259f6e0d07deb658a88148f8253f9bbbb74ddd6db3edbe159a56bc35073',
      '8fa5913b62847d42bb4b464e00a72c612d2ab0df2af0b9a96af8d323fa509077',
      '7ded979c0153ebb9ef28a15a314d0b27b41c4f8eed700b54974b48eb3ecaf91c',
      '1cf3aa651dcf35dbfe296e770ad7ebc4e00bcccd0224db296183dc952d0008c9',
      '5767d69a906d4860db9079eb7e90ab4a543e5cb032fce846554aef6ceb600e1d',
      '8189e3d54767d51e8d1942659a9e2905f9ec3ae72860c16a66e75b8cc9bd2087',
      '107de2bc788e11029f7851f8e1b0b5afb4e34379c709fc840689ebd3d1f51b5b',
      '169f6f093a9be82febe1a6a4471425697ec25d5040b472c5b1822aeea2625988',
      '2087ebd358ae3ea2a092fc19c2dfee57c5f0860296bc7b057c14e1227c5cb9d1',
      '182ab56f7739e43cee0b9ba1e92c4b2a81b088705516a5243910159744f21be9',
      '081f6c68899a48a1be455a55416104921d2fe4bdae696f4b72f9d9626a47915e',
      '5ce02376cc256861b78f87e34783814ba1aec6d09ab500d579ed8ee95c8afcc8',
      'b93e407404e3e95f20fd647365e0e7f46afabe9af1ff083af996135e00d54009',
      'e81fa832b37be8ed8f79da29987aa4d61310dcb14b2859dedf8fb1daa2541fd3',
      'c56705fea5b110b8dc63688533ced21167e628017387c885423b835a55edd5ef',
      'c2226285d08a245a17058ed2d24ad095b714f608ae364fddf119e0a7df890540',
      'f9c270da8793221a6809ac685fdd4f5387e0fe1ee6aaf01c74f1e0a719621614',
      'e69befd6ef7f685c36e343ac1702d87ad6a0e4ac8c0d5c521d04aad4ef0b7458',
      '4e3033562ad74a7d43eb5ff5fc2382622c6307cb10e245ad62da77c4c63cb178',
      '2ea17629472564a59e5eb845a2cdd04f442df2ff26bcc866e400f77158d612a1',
      'b90223df74dd49a8a1461f340f2d7a90f96903ccbb5bc3c74ea3658fc8948b20',
      'e0209f42b927ec9c0f6d6a76007ed540e9bdd6e427b3368a1ea6c5e7565972dd',
      '10d9bd424114319c0999adf6288f74060cd8918ef1228827a6269b2bf0f0880c',
      '7d1978a65ac94dbbcdc62e3d81850299fe157dd9b7bd9e01b170156210d2815a',
      'e052dff9e1c94aaa49556f86fad55029a4875839fda57f5005f4c4403876b256',
      '58d29459b2130a2e151252d408b95e6dac424c564062eb911cc76440cb926ca0',
      '4e4530c392316f598e1bd07f32166380a8f712a33a48e9eb4247131ec5dc05d3',
      'a09c9d3e42342c7dea44edb4aeb48cf6727cacd8032a12cf77a25829fc249d32',
      'eb978d0f1ac03ce5c3510b5f4a16073a7a2bdc15c4ab7777dcf01030cc316667',
      '7d1905a3ace827ea1ac51c4fa08c281ed3be87e7f4e928d696bfde35c8f2dc0f',
      '08359b108fa567f5dcf319fa3434da6abbc1d595f426372666447f09cc5a87dc',
      'a7b3830ffab0f2bbabbef6df0b169a7917008bf238880bbf8c20b8e000077312',
      'b4f5d9b1555994c5ebaebd82918d560a3bf82962a171a1614e7551939e943366',
      '014ecaea1b378900f1212898c6ddb01565d81af1d0ef78df5e28d46e9caf7cfc',
      'bce0aff19cf5aa6a7469a30d61d04e4376e4bbf6381052ee9e7f33925c954d52',
      '4565d7b898ccea3139ad260f9273115f806b30079d7683218c4e3ecd43af3b33',
      'ddadeb660fe8902c9fb2db9b6cf237c9ce5b31753398085c4367eb5910b9cc13',
      'c15a8928131f6687dd10f3c115ddf8d7c8f2df7e18d12c08c4fd16f666ce60ba',
      'ae8e3d799b1353a39815f90eceebefa265cc448fe39faf2008cb20784cb2df9f',
      '98545371a3d9981abe5ab4a32a1d7b2fadd9801d89da52a94a4f78a42740d21c',
      '6323dce2f8b3a04dcea8d205602348c40403cb200c677eb1a1c0fe37edb6eb2f',
      '8150f7c5da910d709ff02ddf85dd293c6a2672633de8cda30f2e0aa58b14b0c4',
      '44d21db70716bd7644cb0d819fa6791805ebc526ea32996a60e41dc753fcfafc',
      'b9b7c375cca45db19466ebd0fe7c9e147948cc42c1c90f0579728cfb2651956d',
      'a47a551b01e55aaaa015531a4fa26a666f1ebd4ba4573898de712b8b5e0ca7e9',
      '60780e9451bdc43cf4530ffc95cbb0c4eb24dae2c39f55f334d679e076c08065',
      '09373f127d34e61dbbaa8bc4499c87074f2ddb10e1b465f506d7d70a15011979',
      '13aaa9b5fb739cdb0e2af99d9ac0a409390adc4d1cb9b41f1ef94f8552060e92',
      '5b0a32f1219524f5d72b00ba1a1b1c09a05ff10c83bb7a86042e42988f2afc06',
      '32796a0a246ea67eb785eda2e045192b9d6e40b9fe2047b21ef0cee929039651',
      'da9ab8930992a9f65eccec4c310882cab428a708e6c899181046a8c73af00855',
      '9c94557382c966753c8cab0957eaedbe1d737b5fcb35c56c220ddd36f8a2d351',
      'd32ab00929cb935b79d44e74c5a745db460ff794dea3b79be40c1cc5cf5388ef',
      'da18797ed7c3a777f0847f429724a2d8cd5138e6ed2895c3fa1a6d39d18f7ec6',
      'f52b23db1fbb6ded89ef42a23ce0c8922c45f25c50b568a93bf1c075420bbb7c',
      '335a461692b30bba1d647cc71604e88e676c90e4c22455d0b8c83f4bd7c8ac9b',
      '3d08c4d7bdda7ec922b0741df357de46e7bd102f9ab7a5c67624ab58da6d9d75',
      'cc63be92e3a900cd067da89473b61b40579b54ef54f8305c2ffcc893743792e9',
      '865447fc4fae01471f2fc973bfb448de00217521ef02e3214d5177ea89c3ef31',
      '3daa582f9563601e290f3cd6d304bff7e25a9ee42a34ffbac5cf2bf40134e0d4',
      '5dda7cb7c2282a55676f8ad5c448092f4a9ebd65338b07ed224fcd7b6c73f5ef',
      '92ca0fa6651ee2f97b884b7246a562fa71250fedefe5ebf270d31c546bfea976',
      '471fb943aa23c511f6f72f8d1652d9c880cfa392ad80503120547703e56a2be5',
      '5099c6a56203f9687f7d33f4bfdf576d31dc91f6b695ecea38b2770c87631135',
      '8d39b60b9c767c58975b270c1d6b13c9b4507e5aee7ad496a3528e4c7f880721',
      '3acc128faf01077789746edcfd1051d90bc1591342402d9b3cdd06d7315702a4',
      'ce1662d4c8b1f54d322593ee8ab385763e51dea92c9b4d56bc0e2f85111f0438',
      'aacb65e7c9055b105cf02c47024cdf79a58229132e66ca0ddf0d74ef6a3fd5c8',
      '478ab134487ede9921619f1eebac30646919d6ab7146c6928c44732ccc897929',
      '6a053848cfe83c0fc8c8a81dd84f6b946c63193cd25cdd5dad45f08be8019e89',
      'ffc555203945df4e81d75f316e4c25fdc0bc4e96412f4f469349eb716f001a7d',
      '81d45be06329d63a2d8a8599d445676933bea1678fc586795b4ecbb838d4d158',
      'd08809a9e5b00fc9266b3813679f40acd6c2596d3de4f28f4d20d98c440aa483',
      'e1796a03c9ed287ef757eee771d116e4dfd8c416f6b5a9e592c1f0e81c0deaa1',
      'b4a4e5d6560fa3e9629064546ac97f14cd4d023c097ccbf06838ccef4fdcd8f1',
      '9b293d748d30240d3ddc496b722fc92d57f665271b060e82410d8de18970dc1d',
      'ef145232e5b19630e0b389891f688161d047c269c7cf22dbff114514572f5813',
      '985f19128703afeee38d22797c0cae5f450cc290a6a5b9253dd908420e9032ff',
      '66f952a83339274eb287b64ef7b028d88915ac6df06a183f7c0436fa2b25107b',
      '46af22be1b576de71971c25e88c18a3295f0ac762a412a11105cef20fa2f5840',
      'e81901f41344683448a03db259d1071c9b2f91001781ae34a0b39a0988381fc2',
      'a5c602c1401ad5029efffaf188f27f9b96b441631a77448551ee337b9dc0e7e8',
      '8317b3fb2181158cfdccfaeb8f8a1736961476717801ae9de7c9a59dc395ef1c',
      '7834d0515667e46923f3a6c054268e06bc2301491b8eda225d1f4317918206fe',
      'f22b2e614e92d6453612b707385038300293d2cc292b148bc5335754b5ea30fd',
      '1d683f2a7c58ac74fab45761235c3e9682f1329b6d96e260a7c67d2d58b233b6',
      'f584eff8c5152fb6b2699806508cdb7148138ecb6dd564b02bfc021fd0ec586a',
      'afa8661046fa83e7c261167f35f6379c00d3a3a9ca46c48fb0bad2c49dda7933',
      '9fedc8a3aa430d6d911b714a151e5f17a4acf52f4239617eec7c9b9d7775612b',
      '8de202b9c283c236da5d2cd5e556de9c1822c19dab36e09f690cf70d3c963e97',
      '31b96fecbf0c2839a29c4acd7098c2701cab152d424e266cf07a16875604365e',
      '3f1a0f65ee12f7efe64477247359af8ef02cf27d104481b4f5922f71432b8178',
      'f4c34f764e0a9e37c080d28f01c4bbe24dad0cc65a88b1fa6b28802a4b799865',
      '85ac7f3761f77772e28c3a9b658aa0e04d9dd3a6bc365c30324948b0ede18b88',
      '448ebbc9e1a31220a2f3830c18eef61b9bd070e5084b7fa2a359fe729184c719',
      '97f5eac07cdc76f1f0faa10b0081cfaff3fab72095680a4516c723fde98916de',
      '6b572b21caa06fc6a1bdab77da3bc07377919088ee96603628354c0b3800661d',
      '27fcdcc7e2ee00f1dcb07aac445a436ab5dee2c14b04621acd387ec50e8efa50',
      'e839cfc21e8e77997e643efa04f7150e6cc68864cbea745aefaf47a9363df709',
      'ba6bad069acc2d0bedf36e2b6cc005d31eb76b0da9de46e09209ff004ae25200',
      '7d3e6ad6d9017d79d15eb518ebbac828d64449c39f0942ee6e7798479e7615a4',
      '697c581d18edb2692249fc07aae307d3cc263033cb32f16ef3c0b57429695a43',
      '7f7193dd3c6c273cdd66488f8aa5dbe3542a22bf0fcda7d6fb93235178c4589e',
      '6e944d621f9e13bc22d4ae68aaa8cb15605ed9680acd7f16e5b0f94149b634cd',
      '491602f722b2a6ef3976a696e286d99e19259d3a4ffb957d18a7128a6fb37a8c',
      'f2b51a1a5c12e9b07f152812895f2ab51a9727021e389555a58507ea7ff16e51',
      'dfabc97f215403a3cc2bcf132a35fc832e87b7de0f2e7560f2ad9d8f06e38b63',
      '73b1f1000c7677ebdcef2a2a25e27b06d9c163209add77a16f0e2b70e56d5c52',
      '21803c877b81b590015dab430568cf4d7c0247eea6147a18ac4fc3492996cb79',
      'b7e3c3ea326a5fd558d70efe2bc6469732a2894dfdeca106093611a4a8d4b025',
      '5ae91d2295e6706191b760661d48e365441de12340006130c42c7b38faa48393',
      'efe3f35371f700217362155403d2b3f912b751d69d6bf80a59a86d4911718651',
      'af37eee16b62d9665944da23a7712f454640ceeb958f20fd33fdd1ee515dabd9',
      '2537ac29dc1561ee49a0bc1aadb863c435a669d18d5e7e890ed3e11a014ce411',
      'e360918d85b02d655ea572d081c83b019691e8665908d6a6fbf9d5673a13d892',
      '37e7218560603527cc8db9a5a1da89fa27df1da7dd9c54c0c7a2405d8a5208a1',
      '621009f0bf8ca1d70eedfa30eb6e2979794469b4e99ee385fd9501712b45cb6a',
      'b1459345163aed1c356302a5230f8912564b04f340610b18ef1aa2c47b418981',
      '82f63a1d007fd9796756abbbf51c246884dde3d79cf9cacacc901462ae75e3ff',
      '78d8ce1ccd46cf92fb4e255f183bc9f355e5e494b3180c0da9154e17a1d61f74',
      '8882ee8501069ba507a3a5f309e8e3f9dcfb13987ec293c60feba4f1fabc5ba7',
      'c62efddbd622094486c1ededca74ad47c8ce4c7661d9f58c2723403bb42b45b6',
      '93301c8548f3afc25d7e157eaf7c8dbf5edb029bd829136600593067cd4b0c5c',
      '19961686c66d9e10e2ce38a14652121e533d5f04bbeea193210cb0a7b88396f3',
      'b454dbe07fb100ea743cd193ea1953a9e6d62a07fde0f3325c362e4f3d7b694f',
      'd280f473c251cb75c91880ea0eca2a2f1cda3152bef54a38c4a3aedad615c819',
      '8b4a544837a1a0280fa8a7c82865c27a1064b3cc6281fda0753566b9bb104a87',
      '7daafa7aed7d63d06a98b7b6f785eab5427d084f30d5c9ee6dd0d2f3ada329e6',
      'dc0b1c61c4001cfe707c52875e026e4eefbafc09ab767f8f3ac55e9c78406e4a',
      'cd855c9ecb3cd846efd1111aeb02c8563f7aef9988ac4c597fab35b4235604c5',
      '28ece33729cdeff79a863cdfa359b51cebe29f8a947954306338c11a89866e62',
      '59a6aed6a44d5a52565289ccc377966b6a1ab41ac339e72475f49bb136befa91',
      '3458d07857503fcadabbc5dfc7b905bc373b77cb058d87feb35443a0aa7ce204',
      '76ccea5a51d93c238bd3a745ff8acd3c848a15c85d12e3d5c9743ecc094773a4',
      '1901da1c9f699b48f6b2636e65cbf73abf99d0441ef67f5c540a42f7051dec6f',
      '747db6ff08731ff7908224c50f71f51fef1283e65341e2dbcdc664f0f41bf8c5',
      '07ff1080d3d4aaed9cd77850c0207e75e7f9697bed15a8cda7057f6a24c010d2',
      '8f0512e800a511953a28bf11bb5e9c305c4026867bc9a31f76cb96fc5bd87027',
      'fed886fe3977e2d21a6b0db5977b8deee5b456d323f8c208d24b8adff08f11de',
      'ea98780a92c30a1038d20bd3d0c87106353306bf9751df5c3c88f9d4b31a0088',
      '121aea684d4d62866514564293f1928c6d4d9e9aa62f2bd2df94f392bf75a838',
      '6f03900ba86980a79f6f8a5d633bd9e8dc9ca30690c86b31ce892d83115a2326',
      '94e9c48301753f123bad54d917d13da64c18b1789da85dc8ed3d8427c56978f7',
      'f934aea49262b4fd587eb74ebe2c69b857aca07876acadc23f89d6c0bbbccdd5',
      '02d53b4529c38363c1ddc9053e3e58bcb6e3001f01c26aa7c4a9e17884cc71e5',
      '018513c8e6cf9ba66351428984e5d44824fee364c26bed1533ca3ece8f3574c3',
      '21209622b064b7f81c5a3524abe7c9708d4585ad4ea21b072ce76993afdd3bf9',
      'aa361163f6b53f6e6de29daae28a336a8f7c05bf5e8a6eeaa46a51bcd66ac7f7',
      'dedff2184de121c60ec94c4cb94a0450cac47257c56afa8f2e11c5f64d3dd661',
      '1d64137df721078b35bdc1a3595a73cebcbe49865fb308c78791540d1d349cd7',
      '9d42d74bac443eafbd9878145b745387eb1397174332564bc8fa6db414ab381f',
      '11a6171d8d193f7cf83315199bb3a7e07e8e00c33e5b620855e0b879cfa4c68c',
      'a9cda05987272ee71100f81f59ad3959b0978a576235c6836eccb65a9577126f',
      'fd53126210abfcb0d6a56c90853b716d02acd8dfa319a60cf51b1a2b4ef6d7f3',
      '17c1453315e3dc1890e8a1c2848d781d207ad73335450e9a236e44c8a2ad3b06',
      'bd2e01835226c56a32ff58df38e6e179830335d4033a40d9c60d269b145c9f6a',
      '3b7a22d9ef089d4aa382eff3deeba73d41e4af58b0967e9c8603d860431c3ec7',
      '7a7f89f00b0e9b1b9e99490a7b9d9ce7740a403047efbb94ad35fd13a35b4ac6',
      '7e47dde9a2e52a0067f80a149abf606ea4ec25690637632d34561432c0738877',
      '5d5771856bd52662bd20e37424abf39e1f3b50264ff09ffd62b3dcc8f05d01f0',
      '6c851b50e115cecfe3b4b910e6a7406af282f9dbcd4ce9cca0db8d488a125f01',
      '5f6e61fa3cdc91285b09f1934b31e426108dfad7ff04c367651f4a59f5c78722',
      'ada6b2683a885f5fef657b8c9b44a44f1e739af8b35c64a51c4072d2a86602c4',
      '3a6a36895262b4af79fdc476e90a9ebc06320e64dd8417b8ebba5f6fec87eaac',
      'c2c67787b86319330e4d0657bc2c0ad67482dff0647b925cc9b8c20a535edc37',
      '6f473cf63f854fb1fa5ad59c463f640dda1a2a1bacac0e15ffa400e663a7f6e7',
      '619a4c7ba6e34fd2246ef3ced6f1e13a5091aa8ea990b59a5e86479c9cb533bf',
      '96e054622771ebf6d4ec206a04c68e0d8bacede86a71a1a546f5e2f8b59178fa',
      'ca9dedc42398e60506e48a2ac95c19882db3c1adeb8da5877e6ad9db4b4c4cd0',
      'f0f1ed236d1a3db9501ff5f2c5cd43d48f2fc30d59cce3155e7f0695c0d529f9',
      '93b2ef94e81337432b267cd50347945f32d9b689b198ccd495215da088ac89b1',
      '69e640e22c3ddd1e1d8391aa4db54aa6ac8aa60ff687a5986f1bea86c49651ab',
      '6f58ce599facae90d94a287e9bf8cb06eaf17da2c293700eeb6bc087fec676b1',
      '5e1c10284710f5c2db48f88de3d051579643a1ed042afa846a7844895351a77b',
      'abf4bafcddb38bbf3855e47b5e61b75dedbcf42aa44ffd4bb85d0b08d97e2682',
      '211882aeac8a599b0a55ec280e1a978923edef69cd86541bcbd58db864c45eac',
      '632a48a7a9a3ac5966a5caa71d456ef1f95f402859df61157cb95ed951237714',
      '6b9425a4c4d39c932fd310704bc144d283f1c090bea989c9b3e96fc0925da531',
      '17610efb99d0f9e4eb1aa13eb1d86289c7dde37d17833ed23dd10e469e2543ff',
      'f5e7bdf4880d87a14055bf371328fe7396315f4848900e7f2471c5edb2a4c23c',
      '5b6cca1b8ac9199d191ea31152d47057fa329994b392db72eda29dbb60d1750c',
      '4b96ec3b91e9f764ac0227ca7df451bd8294cd46298047b43b960ae1c0b0afc5',
      'c6fefe1bfbe6f5364bf0e40447ffca27fde55f1cd815e1fa3bafb46a41c91749',
      '552a69d052ae2980aa92ef44b4a8752fc585d70127d9df1ac53137e266786e4d',
      '369d7da16156c5e2c0d519cdbab3996a7249e20d3e48c36a3a873e987190bd89',
      'ef67e0723230f6c535ff556e45ca2174e1e97deed306e9e87f1b65579076ec06',
      '2cb1e75cd7505a2783769276f30b122cb136fbbd03300510b71a7196ca670b37',
      '1211b6885890be48f89934ec5246f1ce3cfff46c626cfcd686d5fdce9b1fb830',
      'd6a8bdb01e763fb64f3a02512e7be905679a5add6bb408f8750d679d17cad92f',
      '3f8591112c6bbe5c963965954e293108b7208ed2af893e500d859368c654eabe' ];

  for (var i = 0; i < expected_values.length; i++) {
    var d = new SHA256().update(createTestArr(i)).digest();
    Expect.equals(expected_values[i], CryptoUtils.bytesToHex(d), '$i');
  }
}

void testInvalidUse() {
  var sha = new SHA256();
  sha.digest();
  Expect.throws(() => sha.update([0]), (e) => e is HashException);
}

void testRepeatedDigest() {
  var sha = new SHA256();
  var digest = sha.digest();
  Expect.listEquals(digest, sha.digest());
}

void testStandardVectors(inputs, mds) {
  for (var i = 0; i < inputs.length; i++) {
    var d = new SHA256().update(inputs[i]).digest();
    Expect.equals(mds[i], CryptoUtils.bytesToHex(d), '$i');
  }
}

void main() {
  test();
  testInvalidUse();
  testRepeatedDigest();
  testStandardVectors(sha256_long_inputs, sha256_long_mds);
  testStandardVectors(sha256_short_inputs, sha256_short_mds);
}

