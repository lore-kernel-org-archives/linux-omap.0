From: "Imberton Guilhem-gimb01" <guilhem.imberton@motorola.com>
Subject: RE: [PATCH 2/2 v3] OMAP3: PM: SR: SmartReflex Refactor Rev4.0
Date: Tue, 27 Oct 2009 11:46:16 -0000
Message-ID: <6A943D54E5EAED4BA437305D3EF62FB30326EE34@zuk35exm61.ds.mot.com>
References: <OMAP3:PM:SR: SmartReflex Refactor Rev3.0> <1256361352-9968-1-git-send-email-nm@ti.com> <1256361352-9968-2-git-send-email-nm@ti.com> <1256361352-9968-3-git-send-email-nm@ti.com> <74583B8642AB8841B30447520659FCA9DDDFCC3A@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail55.messagelabs.com ([216.82.241.163]:52328 "EHLO
	mail55.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbZJ0Lqg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Oct 2009 07:46:36 -0400
Received: from il27exr04.cig.mot.com ([10.17.196.73])
	by motgate3.mot.com (8.14.3/8.14.3) with ESMTP id n9RBkdLb003260
	for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2009 04:46:39 -0700 (MST)
Received: from az10vts04.mot.com (il27vts04.cig.mot.com [10.17.196.88])
	by il27exr04.cig.mot.com (8.13.1/Vontu) with SMTP id n9RBkdkm013055
	for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2009 06:46:39 -0500 (CDT)
Received: from zuk35exm61.ds.mot.com (zuk35exm61.ea.mot.com [10.178.4.19])
	by il27exr04.cig.mot.com (8.13.1/8.13.0) with ESMTP id n9RBkcBY013040
	for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2009 06:46:38 -0500 (CDT)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Mike Chan <mikechan@google.com>, "Nayak, Rajendra" <rnayak@ti.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, "Reddy, Teerth" <teerth@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Hogander Jouni <jouni.hogander@nokia.com>, "Sabatier, Sebastien" <s-sabatier1@ti.com>

Hi Nishanth,

After some testing I have found a little problem with the init

> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
>
> Refactor the smart reflex implementation.

[snip]

> +	return ret;
> +}
> +late_initcall(omap_sr_init);

It seem that with late_initcall we are initializing SR after SGX init. 
This SGX init call DVFS to change opp and we are not yet initialized 
this cause the device to hang (Panic Joined)

One solution will be to change from late_initcall to device_initcall 
so SR will be initialized before SGX

+	return ret;
+}
+device_initcall(omap_sr_init);

Is there any objections or constraint with this ?
Or maybe there is another way to fix this ?

BR

Guilhem

-----[Panic]------
[    8.128723] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[    8.137329] pgd = c0004000
[    8.140289] [00000000] *pgd=00000000
[    8.144042] Internal error: Oops: 5 [#1] PREEMPT
[    8.148895] Modules linked in:
[    8.152099] CPU: 0    Not tainted  (2.6.29-omap1 #43)
[    8.157409] PC is at sr_vp_disable_both+0x18/0x80
[    8.162322] LR is at program_opp+0x80/0x1d0
[    8.166717] pc : [<c004e23c>]    lr : [<c004f544>]    psr: 60000013
[    8.166717] sp : cec1fce0  ip : cec1fcf8  fp : cec1fcf4
[    8.178741] r10: c050d3d8  r9 : 00000003  r8 : 00000000
[    8.184204] r7 : 00000000  r6 : 00000010  r5 : 00000002  r4 :
cec1e000
[    8.191040] r3 : 00000000  r2 : 00000042  r1 : 00000043  r0 :
00000002
[    8.197875] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[    8.205535] Control: 10c5387d  Table: 80c04019  DAC: 00000017
[    8.211578]
[    8.211578] PC: 0xc004e1bc:
[    8.216033] e1bc  eb0df5ab ea000011 ebfffe8f e2504000 15d51000
11a02004 159f003c 1a000006
[    8.224639] e1dc  e1a00005 ebffff8f e2504000 0a000007 e5d51000
e1a02004 e59f0020 eb0df59c
[    8.233245] e1fc  e59f001c e30014bd e3a02000 eb0083d7 e1a00004
e89da830 c04632b6 c04632e7
[    8.241851] e21c  c046330b c046316a e1a0c00d e92dd830 e24cb004
e59f3064 e7e102d0 e5933000
[    8.250457] e23c  e5d32000 e1520000 2a000002 e3a03000 e5833000
eafffffd e7935100 e5d53021
[    8.259033] e25c  e3530000 0a00000a e5d53020 e3530000 1a000007
e1a00005 ebffffc4 e2504000
[    8.267639] e27c  0a000004 e5d51000 e59f0014 eb0df578 ea000000
e3a04000 e1a00004 e89da830
[    8.276245] e29c  c050d3a0 c046332f e1a0c00d e92dddf0 e24cb004
e2535000 e1a06000 e1a07001
[    8.284851]
[    8.284851] LR: 0xc004f4c4:
[    8.289306] f4c4  e1a0c00d e92ddff0 e24cb004 e24dd024 e50b0040
e1a06182 e0810183 e0811006
[    8.297912] f4e4  e50b103c e1a05002 e50b0038 e1a09003 e5d01004
e1a0c00d e51b003c e3cc4d7f
[    8.306518] f504  e51b2040 e3a08000 e59fa168 e201101f e2023003
e5d02004 e3c4403f e1a07008
[    8.315124] f524  e1a03283 e202201f e1832002 e1831001 e1a00002
e50b2034 e50b1030 ebfffb37
[    8.323730] f544  e1550009 d3a02000 c3a02001 e50b2044 e51b3044
e1570003 1a000036 e51bc040
[    8.332336] f564  e35c0001 1a00000c e59f010c e5903000 e59a0210
e7931006 eb000a65 e59f20fc
[    8.340942] f584  e59a0214 e5923000 e7931006 eb000a60 ebffdd91
e59f30e8 ea000023 e3a01040
[    8.349517] f5a4  e3a00c02 ebffdf20 e10f8000 f10c0080 e5943004
e2833001 e5843004 e50b004c
[    8.358123]
[    8.358123] SP: 0xcec1fc60:
[    8.362609] fc60  ffffffff 000002c7 00000000 cedc0720 cec1fc94
cec1fc80 ffffffff cec1fccc
[    8.371215] fc80  00000010 00000000 cec1fcf4 cec1fc98 c003c9ac
c003c200 00000002 00000043
[    8.379821] fca0  00000042 00000000 cec1e000 00000002 00000010
00000000 00000000 00000003
[    8.388397] fcc0  c050d3d8 cec1fcf4 cec1fcf8 cec1fce0 c004f544
c004e23c 60000013 ffffffff
[    8.397003] fce0  cec1e000 00000002 cec1fd44 cec1fcf8 c004f544
c004e230 22222222 22222222
[    8.405609] fd00  22222222 00000002 c04db200 c04db208 00000042
00000043 00000000 c04da0a8
[    8.414215] fd20  00000002 00000002 00000000 00000001 00000000
00000003 cec1fd7c cec1fd48
[    8.422821] fd40  c004f7d4 c004f4d0 c04da0cc 60000013 cec1fda4
cec1fd60 c03ccc74 00000000
[    8.431427]
[    8.431427] IP: 0xcec1fc78:
[    8.435882] fc78  ffffffff cec1fccc 00000010 00000000 cec1fcf4
cec1fc98 c003c9ac c003c200
[    8.444488] fc98  00000002 00000043 00000042 00000000 cec1e000
00000002 00000010 00000000
[    8.453094] fcb8  00000000 00000003 c050d3d8 cec1fcf4 cec1fcf8
cec1fce0 c004f544 c004e23c
[    8.461700] fcd8  60000013 ffffffff cec1e000 00000002 cec1fd44
cec1fcf8 c004f544 c004e230
[    8.470275] fcf8  22222222 22222222 22222222 00000002 c04db200
c04db208 00000042 00000043
[    8.478881] fd18  00000000 c04da0a8 00000002 00000002 00000000
00000001 00000000 00000003
[    8.487487] fd38  cec1fd7c cec1fd48 c004f7d4 c004f4d0 c04da0cc
60000013 cec1fda4 cec1fd60
[    8.496093] fd58  c03ccc74 00000000 00000000 c04da0a8 00000002
00000001 cec1fd94 cec1fd80
[    8.504699]
[    8.504699] FP: 0xcec1fc74:
[    8.509155] fc74  cec1fc80 ffffffff cec1fccc 00000010 00000000
cec1fcf4 cec1fc98 c003c9ac
[    8.517761] fc94  c003c200 00000002 00000043 00000042 00000000
cec1e000 00000002 00000010
[    8.526367] fcb4  00000000 00000000 00000003 c050d3d8 cec1fcf4
cec1fcf8 cec1fce0 c004f544
[    8.534973] fcd4  c004e23c 60000013 ffffffff cec1e000 00000002
cec1fd44 cec1fcf8 c004f544
[    8.543579] fcf4  c004e230 22222222 22222222 22222222 00000002
c04db200 c04db208 00000042
[    8.552154] fd14  00000043 00000000 c04da0a8 00000002 00000002
00000000 00000001 00000000
[    8.560760] fd34  00000003 cec1fd7c cec1fd48 c004f7d4 c004f4d0
c04da0cc 60000013 cec1fda4
[    8.569366] fd54  cec1fd60 c03ccc74 00000000 00000000 c04da0a8
00000002 00000001 cec1fd94
[    8.577972]
[    8.577972] R4: 0xcec1df80:
[    8.582427] df80  00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    8.591033] dfa0  00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    8.599639] dfc0  00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    8.608245] dfe0  00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    8.616851] e000  00000002 00000003 00000000 cec13c00 c04df86c
00000000 00000017 cec13c00
[    8.625427] e020  c050e3c0 cec1e000 00000420 cec13e74 c04d0d48
cec1a800 cec1fdb4 cec1fd70
[    8.634033] e040  c03cbd70 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    8.642639] e060  00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    8.651245]
[    8.651245] R10: 0xc050d358:
[    8.655822] d358  00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    8.664398] d378  00000000 00000000 00000000 00000000 cec52e00
c05761c0 c04e1808 00000100
[    8.673004] d398  c0462f97 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    8.681610] d3b8  00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    8.690216] d3d8  00000000 00000000 00000004 00000000 00000000
00000000 00000000 00000000
[    8.698822] d3f8  00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    8.707397] d418  00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    8.716003] d438  00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    8.724609] Process swapper (pid: 1, stack limit = 0xcec1e2e0)
[    8.730712] Stack: (0xcec1fce0 to 0xcec20000)
[    8.735260] fce0: cec1e000 00000002 cec1fd44 cec1fcf8 c004f544
c004e230 22222222 22222222
[    8.743957] fd00: 22222222 00000002 c04db200 c04db208 00000042
00000043 00000000 c04da0a8
[    8.752655] fd20: 00000002 00000002 00000000 00000001 00000000
00000003 cec1fd7c cec1fd48
[    8.761352] fd40: c004f7d4 c004f4d0 c04da0cc 60000013 cec1fda4
cec1fd60 c03ccc74 00000000
[    8.770019] fd60: 00000000 c04da0a8 00000002 00000001 cec1fd94
cec1fd80 c004f89c c004f6a0
[    8.778717] fd80: c04da0a8 00000000 cec1fdb4 cec1fd98 c0058d44
c004f80c c04da0a8 c04da0cc
[    8.787414] fda0: c04dac68 00000002 cec1fdd4 cec1fdb8 c0059294
c0058cf4 c0558be8 00000000
[    8.796112] fdc0: 00000000 00000002 cec1fde4 cec1fdd8 c0058ae8
c00591f0 cec1fdfc cec1fde8
[    8.804779] fde0: c01b7dc8 c0058aa8 c0558bb8 00000000 cec1fe34
cec1fe00 c01b7928 c01b7dac
[    8.813476] fe00: c0558c98 c04dac68 c04dacac 00000001 c04dac68
c04f23ac c04f23ac 00000000
[    8.822174] fe20: 00000000 00000000 cec1fe44 cec1fe38 c01a2e98
c01b7630 cec1fe54 cec1fe48
[    8.830841] fe40: c01cc618 c01a2e7c cec1fe74 cec1fe58 c01cb880
c01cc604 c04dac68 c04dacf0
[    8.839538] fe60: c04f23ac 00000000 cec1fe94 cec1fe78 c01cb990
c01cb7bc c04f23ac cec1fe98
[    8.848236] fe80: c01cb928 00000000 cec1febc cec1fe98 c01cb0bc
c01cb934 cec03a58 c04dac98
[    8.856933] fea0: c04f23ac ced4d180 c04f28b8 00000000 cec1fecc
cec1fec0 c01cb6c8 c01cb078
[    8.865600] fec0: cec1fefc cec1fed0 c01ca9e0 c01cb6b4 c04643e0
c05583e8 00000000 c04f23ac
[    8.874298] fee0: c05583e8 00000000 00000001 00000000 cec1ff24
cec1ff00 c01cbbbc c01ca944
[    8.882995] ff00: c0030fec c05583e8 00000000 00000001 00000000
00000000 cec1ff34 cec1ff28
[    8.891693] ff20: c01cca94 c01cbb30 cec1ff5c cec1ff38 c001d360
c01cca34 c01cca94 c01cbb30
[    8.900360] ff40: cec1ff5c c0030fec c001d30c 00000000 cec1ffd4
cec1ff60 c003c2ec c001d318
[    8.909057] ff60: cec1ff8c cec1ff70 c0113f78 c0113c28 cec1ff00
cec409c0 c0114078 c04e757c
[    8.917755] ff80: cec1ffbc cec1ff90 c00a38f4 c0113f00 c01ca39c
00313533 00000000 c0030000
[    8.926452] ffa0: 00000170 c04e7978 00000000 00000000 c0030fec
c00313e0 00000000 00000000
[    8.935119] ffc0: 00000000 00000000 cec1fff4 cec1ffd8 c0008424
c003c29c 00000000 00000001
[    8.943817] ffe0: 00000000 00000000 00000000 cec1fff8 c0072738
c00083a4 00000000 00000000
[    8.952514] Backtrace:
[    8.955078] [<c004e224>] (sr_vp_disable_both+0x0/0x80) from
[<c004f544>] (program_opp+0x80/0x1d0)
[    8.964385]  r5:00000002 r4:cec1e000
[    8.968139] [<c004f4c4>] (program_opp+0x0/0x1d0) from [<c004f7d4>]
(resource_set_opp_level+0x140/0x16c)
[    8.977996] [<c004f694>] (resource_set_opp_level+0x0/0x16c) from
[<c004f89c>] (set_opp+0x9c/0xb8)
[    8.987304]  r8:00000001 r7:00000002 r6:c04da0a8 r5:00000000
r4:00000000
[    8.994354] [<c004f800>] (set_opp+0x0/0xb8) from [<c0058d44>]
(update_resource_level+0x5c/0x80)
[    9.003479]  r5:00000000 r4:c04da0a8
[    9.007232] [<c0058ce8>] (update_resource_level+0x0/0x80) from
[<c0059294>] (resource_release+0xb0/0xd0)
[    9.017181]  r7:00000002 r6:c04dac68 r5:c04da0cc r4:c04da0a8
[    9.023132] [<c00591e4>] (resource_release+0x0/0xd0) from
[<c0058ae8>] (omap_pm_set_min_bus_tput+0x4c/0x68)
[    9.033355]  r7:00000002 r6:00000000 r5:00000000 r4:c0558be8
[    9.039306] [<c0058a9c>] (omap_pm_set_min_bus_tput+0x0/0x68) from
[<c01b7dc8>] (DisableSGXClocks+0x28/0x90)
[    9.049530] [<c01b7da0>] (DisableSGXClocks+0x0/0x90) from
[<c01b7928>] (SysInitialise+0x304/0x33c)
[    9.058929]  r5:00000000 r4:c0558bb8
[    9.062683] [<c01b7624>] (SysInitialise+0x0/0x33c) from [<c01a2e98>]
(PVRSRVDriverProbe+0x28/0x44)
[    9.072082] [<c01a2e70>] (PVRSRVDriverProbe+0x0/0x44) from
[<c01cc618>] (platform_drv_probe+0x20/0x24)
[    9.081848] [<c01cc5f8>] (platform_drv_probe+0x0/0x24) from
[<c01cb880>] (driver_probe_device+0xd0/0x178)
[    9.091888] [<c01cb7b0>] (driver_probe_device+0x0/0x178) from
[<c01cb990>] (__driver_attach+0x68/0x8c)
[    9.101654]  r7:00000000 r6:c04f23ac r5:c04dacf0 r4:c04dac68
[    9.107604] [<c01cb928>] (__driver_attach+0x0/0x8c) from [<c01cb0bc>]
(bus_for_each_dev+0x50/0x8c)
[    9.117004]  r7:00000000 r6:c01cb928 r5:cec1fe98 r4:c04f23ac
[    9.122955] [<c01cb06c>] (bus_for_each_dev+0x0/0x8c) from
[<c01cb6c8>] (driver_attach+0x20/0x28)
[    9.132171]  r7:00000000 r6:c04f28b8 r5:ced4d180 r4:c04f23ac
[    9.138122] [<c01cb6a8>] (driver_attach+0x0/0x28) from [<c01ca9e0>]
(bus_add_driver+0xa8/0x208)
[    9.147247] [<c01ca938>] (bus_add_driver+0x0/0x208) from [<c01cbbbc>]
(driver_register+0x98/0x120)
[    9.156646]  r8:00000000 r7:00000001 r6:00000000 r5:c05583e8
r4:c04f23ac
[    9.163696] [<c01cbb24>] (driver_register+0x0/0x120) from
[<c01cca94>] (platform_driver_register+0x6c/0x88)
[    9.173919]  r9:00000000 r8:00000000 r7:00000001 r6:00000000
r5:c05583e8
[    9.180755] r4:c0030fec
[    9.183502] [<c01cca28>] (platform_driver_register+0x0/0x88) from
[<c001d360>] (PVRCore_Init+0x54/0x1a0)
[    9.193481] [<c001d30c>] (PVRCore_Init+0x0/0x1a0) from [<c003c2ec>]
(__exception_text_end+0x5c/0x194)
[    9.203155]  r6:00000000 r5:c001d30c r4:c0030fec
[    9.208007] [<c003c290>] (__exception_text_end+0x0/0x194) from
[<c0008424>] (kernel_init+0x8c/0xfc)
[    9.217498]  r9:00000000 r8:00000000 r7:00000000 r6:00000000
r5:c00313e0
[    9.224334] r4:c0030fec
[    9.227081] [<c0008398>] (kernel_init+0x0/0xfc) from [<c0072738>]
(do_exit+0x0/0x784)
[    9.235321]  r5:00000000 r4:00000000
[    9.239074] Code: e24cb004 e59f3064 e7e102d0 e5933000 (e5d32000)
[    9.245574] ---[ end trace 712ea8b08e905fc9 ]---





