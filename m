From: Stephan Raue <mailinglists@openelec.tv>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Thu, 17 Mar 2011 22:34:03 +0100
Message-ID: <4D827E4B.5000404@openelec.tv>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>	 <1299764643.2017.177.camel@deskari> <4D78E3F5.2090600@openelec.tv>	 <1299827578.2567.1.camel@deskari> <4D79E0A0.9040900@openelec.tv>	 <1299849774.2479.3.camel@deskari> <4D7A4B44.2030801@openelec.tv>	 <1299868049.2479.33.camel@deskari> <4D7A6D0F.40906@openelec.tv>	 <AANLkTin+fnZfFte5v8+G0saDcjCqsT=oQ4U_oGSm-UGn@mail.gmail.com>	 <4D7CD588.3080100@openelec.tv> <4D7CEEC8.50803@openelec.tv>	 <1300258302.1917.32.camel@lappyti>	 <AANLkTinNynOpnJyHZeyA01E5oVMcs_PnAYRH4dSznJ_d@mail.gmail.com>	 <4D814C72.9010300@openelec.tv> <1300360287.1909.62.camel@lappyti> <EAF47CD23C76F840A9E7FCE10091EFAB033D1A86F2@dbde02.ent.ti.com> <4D826C33.1090705@openelec.tv> <4D82798D.5090504@openelec.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail04.solnet.ch ([212.101.4.138]:58051 "EHLO mail04.solnet.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755753Ab1CQVeI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 17:34:08 -0400
In-Reply-To: <4D82798D.5090504@openelec.tv>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Am 17.03.2011 22:13, schrieb Stephan Raue:
> Am 17.03.2011 21:16, schrieb Stephan Raue:
> an update:
>
> compiled with DSS/HDMI support as modules, loading modules with:
>
>   modprobe omapdss
>   modprobe omapfb
>
> and doing a
>
>   dmesg
>
> in the init script gives me:
>
>   modprobe: can't load module omapdss 
> (kernel/drivers/video/omap2/dss/omapdss.ko): invalid module format
>   modprobe: can't load module cfbcopyarea 
> (kernel/drivers/video/cfbcopyarea.ko): invalid module format
>
> see: http://paste.pocoo.org/show/355300/ line 254,255,514,515
>
> why? the complete kernel with modules is rebuild from scratch
next update:

disable:

CONFIG_LOCALVERSION_AUTO
CONFIG_MODULE_FORCE_LOAD
CONFIG_MODULE_FORCE_UNLOAD
CONFIG_MODVERSIONS
CONFIG_MODULE_SRCVERSION_ALL

gives:

[    3.934814] Bad mode in data abort handler detected
[    3.939941] Internal error: Oops - bad mode: 0 [#1] SMP
[    3.945404] last sysfs file: /sys/devices/virtual/graphics/fbcon/cursor_blink
[    3.952911] Modules linked in: omapdss(+)
[    3.957122] CPU: 0    Not tainted  (2.6.38 #1)
[    3.961791] PC is at 0xffff0018
[    3.965179] LR is at omap_dsshw_probe+0x1d4/0x358 [omapdss]
[    3.971008] pc : [<ffff0018>]    lr : [<bf000d14>]    psr: 60000092
[    3.971038] sp : ef149d08  ip : c0e2bcd8  fp : 00000000
[    3.983093] r10: 00000028  r9 : c0ef4338  r8 : 00000000
[    3.988555] r7 : bf012904  r6 : 00000000  r5 : ef947c40  r4 : 00000000
[    3.995422] r3 : f08fc000  r2 : 02102006  r1 : ef149cf0  r0 : 00000000
[    4.002288] Flags: nZCv  IRQs off  FIQs on  Mode IRQ_32  ISA ARM  Segment user
[    4.009857] Control: 10c53c7d  Table: af3b404a  DAC: 00000015
[    4.015899] Process modprobe (pid: 559, stack limit = 0xef1482f8)
[    4.022308] Stack: (0xef149d08 to 0xef14a000)
[    4.026885] 9d00:                   00000000 ef149cf0 02102006 f08fc000 00000000 ef947c40
[    4.035461] 9d20: 00000000 bf012904 00000000 c0ef4338 00000028 00000000 c0e2bcd8 ef149d08
[    4.044067] 9d40: bf000d14 ffff0018 60000092 ffffffff bf013050 ef947c40 00000000 bf000d14
[    4.052642] 9d60: ef954008 ef95403c bf012904 c067b8b4 c067b8a0 c067aacc 00000000 ef954008
[    4.061248] 9d80: ef95403c bf012904 00000000 c067abf0 bf012904 ef149da0 c067ab88 c0679d38
[    4.069824] 9da0: ef84f658 ef949730 bf012904 bf012904 ef1e7a60 c09cac08 00000000 c067a3d0
[    4.078430] 9dc0: bf00e65b 00000468 00000000 bf012904 c09b4d90 c09b0b28 bf012848 00000000
[    4.087005] 9de0: 00000028 c067ae44 00000000 bf013034 c09b4d90 c09b0b28 bf012848 00000000
[    4.095611] 9e00: 00000028 bf00053c c09b4d90 efa72690 c0aa1380 c09b4d98 c09b4dcc bf012848
[    4.104217] 9e20: bf012848 00000000 00000028 c067b8b4 c067b8a0 c067aacc 00000000 c09b4d98
[    4.112792] 9e40: c09b4dcc bf012848 00000000 c067abf0 bf012848 ef149e60 c067ab88 c0679d38
[    4.121398] 9e60: ef84f658 ef9491b0 bf012848 bf012848 ef1e7c60 c09cac08 00000000 c067a3d0
[    4.129974] 9e80: bf00e09e 00000468 00000000 bf012848 00000000 ef27f9a0 bf01d000 00000000
[    4.138580] 9ea0: 00000028 c067ae44 c067b8d8 00000000 00000000 ef27f9a0 bf01d000 00000000
[    4.147155] 9ec0: 00000028 bf01d064 bf012ed4 c0431694 00000000 00000001 bf012ed4 bf012ed4
[    4.155761] 9ee0: 00000001 bf012ed4 00000000 ef27f9a0 bf012f1c 00000001 00000028 c04af9e4
[    4.164337] 9f00: bf012ee0 000aa048 00000003 c04ad17c c0ef4330 c07f45bc bf013018 000aa048
[    4.172943] 9f20: 00000000 f08d9000 000201b0 f08ec450 f08ec2dc f08f11a8 ef385800 00014740
[    4.181518] 9f40: 000186a0 00000000 00000000 00000023 00000024 00000019 00000000 0000000f
[    4.190124] 9f60: 00000000 bf011a34 00000016 00000000 00000000 00000000 00000000 00000080
[    4.198699] 9f80: 60000010 400368e0 00000000 00000000 00000080 c043b5c8 ef148000 00000000
[    4.207305] 9fa0: 00000003 c043b400 400368e0 00000000 4020e000 000201b0 000aa048 00000003
[    4.215881] 9fc0: 400368e0 00000000 00000000 00000080 00000000 00000000 000aa048 00000003
[    4.224487] 9fe0: bee1a880 bee1a870 00036138 401ab0a0 60000010 4020e000 aaaaaaaa aaaaaaaa
[    4.233093] [<bf000d14>] (omap_dsshw_probe+0x1d4/0x358 [omapdss]) from [<f08fc000>] (0xf08fc000)
[    4.242340] Code: e59ff410 ea0000bb ea00009a ea0000fa (ea000078)
[    4.248748] ------------[ cut here ]------------
[    4.253601] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:98 l3_interrupt_handler+0xb8/0x134()
[    4.262664] L3 standard error: SOURCE:DSS  at address 0x10
[    4.268402] Modules linked in: omapdss(+)
[    4.272644] [<c044239c>] (unwind_backtrace+0x0/0xe4) from [<c047457c>] (warn_slowpath_common+0x4c/0x64)
[    4.282531] [<c047457c>] (warn_slowpath_common+0x4c/0x64) from [<c0474614>] (warn_slowpath_fmt+0x2c/0x3c)
[    4.292572] [<c0474614>] (warn_slowpath_fmt+0x2c/0x3c) from [<c0455898>] (l3_interrupt_handler+0xb8/0x134)
[    4.302734] [<c0455898>] (l3_interrupt_handler+0xb8/0x134) from [<c04b46f8>] (handle_IRQ_event+0x6c/0x15c)
[    4.312896] [<c04b46f8>] (handle_IRQ_event+0x6c/0x15c) from [<c04b6344>] (handle_level_irq+0xdc/0x160)
[    4.322692] [<c04b6344>] (handle_level_irq+0xdc/0x160) from [<c0431088>] (asm_do_IRQ+0x88/0xc8)
[    4.331848] [<c0431088>] (asm_do_IRQ+0x88/0xc8) from [<c07e985c>] (__irq_svc+0x3c/0xe0)
[    4.340240] Exception stack(0xef149c90 to 0xef149cd8)
[    4.345550] 9c80:                                     c07e93cc 00000001 ef149cc8 00000000
[    4.354125] 9ca0: c0978d1c ef148000 efa72200 00000001 00000000 c0ef4338 00000028 00000000
[    4.362731] 9cc0: 00000000 ef149cd8 c07e93cc c07e93d0 60000013 ffffffff
[    4.369689] [<c07e985c>] (__irq_svc+0x3c/0xe0) from [<c07e93d0>] (_raw_spin_unlock_irq+0x28/0x2c)
[    4.378997] [<c07e93d0>] (_raw_spin_unlock_irq+0x28/0x2c) from [<c043f868>] (die+0x15c/0x1e0)
[    4.387969] [<c043f868>] (die+0x15c/0x1e0) from [<c043fb18>] (bad_mode+0x3c/0x60)
[    4.395843] [<c043fb18>] (bad_mode+0x3c/0x60) from [<bf000d14>] (omap_dsshw_probe+0x1d4/0x358 [omapdss])
[    4.405853] [<bf000d14>] (omap_dsshw_probe+0x1d4/0x358 [omapdss]) from [<f08fc000>] (0xf08fc000)
[    4.415069] ---[ end trace 19eb980927cfdf2c ]---
[    4.419952] ---[ end trace 19eb980927cfdf2d ]---
Segmentation fault
[   34.458221] omapfb: gave up waiting for init of module omapdss.
[   34.464447] omapfb: Unknown symbol omap_dss_get_num_overlays (err -16)
[   64.466033] omapfb: gave up waiting for init of module omapdss.
[   64.472259] omapfb: Unknown symbol omap_dss_get_device (err -16)

see also: http://paste.pocoo.org/show/355314/

thanks much,

Stephan


