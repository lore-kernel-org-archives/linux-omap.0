From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: is LDP broken on todays kernel
Date: Tue, 2 Sep 2008 17:56:55 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087022A167322@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56515 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbYIBM1G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 08:27:06 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m82CQwq9011933
	for <linux-omap@vger.kernel.org>; Tue, 2 Sep 2008 07:27:04 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id m82CQvLu002988
	for <linux-omap@vger.kernel.org>; Tue, 2 Sep 2008 17:56:57 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On today's Linux-omap tony GIT tree I can see that LDP is broken:
Any comments. 

<snip>
6>OMAP DMA hardware revision 4.0
<3>USB: No board-specific platform config found
<6>i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
<6>i2c_omap i2c_omap.2: bus 2 rev3.12 at 400 kHz
<6>i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
<6>TWL4030: TRY attach Slave TWL4030-ID0 on Adapter OMAP I2C adapter [1]
<6>TWL4030: TRY attach Slave TWL4030-ID1 on Adapter OMAP I2C adapter [1]
<6>TWL4030: TRY attach Slave TWL4030-ID2 on Adapter OMAP I2C adapter [1]
<6>TWL4030: TRY attach Slave TWL4030-ID3 on Adapter OMAP I2C adapter [1]
<3>i2c_omap i2c_omap.1: controller timed out
<4>------------[ cut here ]------------
<4>WARNING: at drivers/i2c/chips/twl4030-core.c:903 twl4030_attach_adapter+0x188
/0x470()
Modules linked in:
[<c0026f78>] (dump_stack+0x0/0x14) from [<c0046820>] (warn_on_slowpath+0x4c/0x68
)
[<c00467d4>] (warn_on_slowpath+0x0/0x68) from [<c0019c2c>] (twl4030_attach_adapt
er+0x188/0x470)
 r6:00000000 r5:00000011 r4:c01ff008
[<c0019aa4>] (twl4030_attach_adapter+0x0/0x470) from [<c0148014>] (__attach_adap
ter+0x30/0x38)
[<c0147fe4>] (__attach_adapter+0x0/0x38) from [<c0141e1c>] (class_for_each_devic
e+0x68/0xb4)
 r5:c022bee4 r4:c788f890
[<c0141db4>] (class_for_each_device+0x0/0xb4) from [<c0147a18>] (i2c_register_dr
iver+0xb0/0xcc)
[<c0147968>] (i2c_register_driver+0x0/0xcc) from [<c0019a9c>] (twl4030_init+0x18
/0x20)
 r7:00000000 r6:00000000 r5:c001e308 r4:c022ece0
[<c0019a84>] (twl4030_init+0x0/0x20) from [<c0022298>] (__exception_text_end+0x5
0/0x17c)
[<c0022248>] (__exception_text_end+0x0/0x17c) from [<c00088d4>] (kernel_init+0x7
0/0xdc)
[<c0008864>] (kernel_init+0x0/0xdc) from [<c00493a4>] (do_exit+0x0/0x6e0)
 r5:00000000 r4:00000000
<4>---[ end trace 1b75b31a2719ed1c ]---
