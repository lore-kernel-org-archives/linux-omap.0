From: Paul Walmsley <paul@pwsan.com>
Subject: TWL4030 intermittent freakout on boot
Date: Thu, 8 May 2008 12:13:00 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0805081201450.27986@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57030 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbYEHSNF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 14:13:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, peter.de-schrijver@nokia.com


Hello everyone,

occasionally the TWL4030 driver on the 3430SDP freaks out on boot.  (This 
is either an ES2.0 or ES2.1, not sure.)  Here's a partial console log with 
initcall debugging enabled.  This probably happens every thirty or forty 
boots, I would guess.  The board does boot to userspace when this happens.

Perhaps the TWL4030 experts out there might know what's going on?


- Paul

calling  i2c_init+0x0/0x60()
initcall i2c_init+0x0/0x60() returned 0 after 7 msecs
calling  omap_i2c_init_driver+0x0/0x1c()
<6>i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
<6>i2c_omap i2c_omap.2: bus 2 rev3.12 at 400 kHz
<6>i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
initcall omap_i2c_init_driver+0x0/0x1c() returned 0 after 22 msecs
calling  twl4030_init+0x0/0x20()
<6>TWL4030: TRY attach Slave TWL4030-ID0 on Adapter OMAP I2C adapter [1]
<6>TWL4030: TRY attach Slave TWL4030-ID1 on Adapter OMAP I2C adapter [1]
<6>TWL4030: TRY attach Slave TWL4030-ID2 on Adapter OMAP I2C adapter [1]
<6>TWL4030: TRY attach Slave TWL4030-ID3 on Adapter OMAP I2C adapter [1]
initcall twl4030_init+0x0/0x20() returned 0 after 29 msecs
calling  twl4030_pwrirq_init+0x0/0xf8()
initcall twl4030_pwrirq_init+0x0/0xf8() returned 0 after 0 msecs
calling  twl4030_usb_init+0x0/0x1e8()
<3>irq 56: nobody cared (try booting with the "irqpoll" option)
[<c002cd14>] (dump_stack+0x0/0x14) from [<c006f9fc>] 
(__report_bad_irq+0x38/0x88)
[<c006f9c4>] (__report_bad_irq+0x0/0x88) from [<c006fc5c>] 
(note_interrupt+0x210/0x270)
 r5:c0336820 r4:00000000
[<c006fa4c>] (note_interrupt+0x0/0x270) from [<c0070868>] 
(handle_level_irq+0x94/0xf0)
[<c00707d4>] (handle_level_irq+0x0/0xf0) from [<c0028048>] 
(__exception_text_start+0x48/0x64)
 r5:c0336820 r4:00000038
[<c0028000>] (__exception_text_start+0x0/0x64) from [<c00285b0>] 
(__irq_svc+0x30/0x80)
Exception stack(0xc7c1dd78 to 0xc7c1ddc0)
dd60:                                                       00000020 c0354f60
dd80: c0354f60 00000000 00000002 c0354f60 0000000a 00000001 c7c5d800 00000001
dda0: 00000001 c7c1dddc c7c1dde0 c7c1ddc0 c0050ec0 c0050b44 20000113 ffffffff
 r7:00000001 r6:0000000a r5:d8200000 r4:ffffffff
[<c0050b00>] (__do_softirq+0x0/0xb8) from [<c0050ec0>] (irq_exit+0x48/0x8c)
 r7:00000001 r6:00000000 r5:c03363f8 r4:00000025
[<c0050e78>] (irq_exit+0x0/0x8c) from [<c002804c>] (__exception_text_start+0x4c/0x64)
 r5:c03363f8 r4:00000025
[<c0028000>] (__exception_text_start+0x0/0x64) from [<c00285b0>] (__irq_svc+0x30/0x80)
Exception stack(0xc7c1de18 to 0xc7c1de60)
de00:                                                       c7c5d800 000001e2
de20: d8070000 0000601f c7c5d800 c7c5d800 c0344c3c 00000001 c7c5d800 00000001
de40: 00000001 c7c1de74 c7c1de78 c7c1de60 c0195be8 c019593c 60000013 ffffffff
 r7:00000001 r6:c0344c3c r5:d8200000 r4:ffffffff
[<c0195914>] (omap_i2c_idle+0x0/0x68) from [<c0195be8>] (omap_i2c_xfer+0x26c/0x284)
 r5:c7c5d800 r4:00000001
[<c019597c>] (omap_i2c_xfer+0x0/0x284) from [<c0193284>] (i2c_transfer+0x88/0x9c)
[<c01931fc>] (i2c_transfer+0x0/0x9c) from [<c0196780>] (twl4030_i2c_write+0xc0/0xe8)
 r7:00000001 r6:00000000 r5:c0344c48 r4:c0344ac8
[<c01966c0>] (twl4030_i2c_write+0x0/0xe8) from [<c01967d0>] (twl4030_i2c_write_u8+0x28/0x30)
[<c01967a8>] (twl4030_i2c_write_u8+0x0/0x30) from [<c0197e14>] (twl4030_i2c_write_u8_verify+0x20/0x9c)
[<c0197df4>] (twl4030_i2c_write_u8_verify+0x0/0x9c) from [<c01982b0>] (twl4030_i2c_access+0x120/0x150)
 r6:00000000 r5:c7c59a60 r4:00000000
[<c0198190>] (twl4030_i2c_access+0x0/0x150) from [<c001a93c>] (twl4030_usb_init+0x18c/0x1e8)
 r5:c7c59a60 r4:00000001
[<c001a7b0>] (twl4030_usb_init+0x0/0x1e8) from [<c0008928>] (kernel_init+0xa0/0x218)
 r6:00000000 r5:00000000 r4:c0024000
[<c0008888>] (kernel_init+0x0/0x218) from [<c004ec70>] (do_exit+0x0/0x5fc)
<3>handlers:
<3>[<c0195f58>] (omap_i2c_isr+0x0/0x308)
<0>Disabling IRQ #56
<3>i2c_omap i2c_omap.1: controller timed out
<3>i2c_omap i2c_omap.1: controller timed out
<3>twl4030_usb: i2c write failed, line 422


