From: Abraham Arce <abraham.arce.moreno@gmail.com>
Subject: Issues with PM Branch
Date: Tue, 28 Apr 2009 11:17:22 -0500
Message-ID: <cb8016980904280917r453eee32tb582a212a6f529e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:40663 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbZD1QRY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 12:17:24 -0400
Received: by yx-out-2324.google.com with SMTP id 3so362316yxj.1
        for <linux-omap@vger.kernel.org>; Tue, 28 Apr 2009 09:17:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I am having some hangs using origin/pm branch. SDPs used to test, same
behaviour:

 SDP3430 PROCESSOR BD, ES2.0
 SDP3430 PROCESSOR BD III, OMAP3430 ES3.0 EMU(MT), TWL5030 ES1.0

The commit taken is latest:

 commit	9d76f46e79302058464b569dbad9af8c594dbe53
 author	Roger Quadros <ext-roger.quadros@nokia.com>
 PM: OMAP: Fix build with CONFIG_OMAP_PM_NONE set

If default configuration is used (omap_3430sdp_defconfig) then a
kernel panic will occur:

 <7>Switched to high resolution mode on CPU 0
 <6>musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=3D0
 <1>Unhandled fault: external abort on non-linefetch (0x1028) at 0xd80a=
b404
 Internal error: : 1028 [#1]
 Modules linked in:
 CPU: 0    Not tainted  (2.6.29-omap1-05686-g9d76f46 #1)
 PC is at musb_platform_init+0x5c/0xf8
 LR is at omap2_clk_enable+0x114/0x184
 pc : [<c001f6d0>]    lr : [<c003b84c>]    psr: 40000013
 sp : c7817d50  ip : 00000001  fp : c7817d64
 r10: 00000000  r9 : c78281f0  r8 : c03ad128
 r7 : c7831240  r6 : c78280d8  r5 : 00000000  r4 : c78280d8
 r3 : d80ab000  r2 : 00000200  r1 : 00000000  r0 : 00000000
 Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
 Control: 10c5387d  Table: 80004019  DAC: 00000017
 Process swapper (pid: 1, stack limit =3D 0xc78162e0)
 Stack: (0xc7817d50 to 0xc7818000)
 ...
 [<c001f674>] (musb_platform_init+0x0/0xf8) from [<c001ecd0>]
(musb_probe+0x244/0xbe8) r5:00000000 r4:c0394db8
 [<c001ea8c>] (musb_probe+0x0/0xbe8) from [<c01c0930>]
(platform_drv_probe+0x20/0x24)
 [<c01c0910>] (platform_drv_probe+0x0/0x24) from [<c01bfb20>]
(driver_probe_device+0xd4/0x180)

If USB is disabled then a hang now will be present in Power Management
for TI OMAP3

 <6>RPC: Registered udp transport module.
 RPC: Registered udp transport module.
 <6>RPC: Registered tcp transport module.
 RPC: Registered tcp transport module.
 <3>Power Management for TI OMAP3.
 Power Management for TI OMAP3.
 <=F6

To avoid this last hang going back to the previous commit is needed,
after this, the boot is Ok

 commit 90c3bdfb394ff2ddd87a72defb49c2f2456dd621
 Author: Rajendra Nayak <rnayak@ti.com>
     OMAP3 clock: Update cpufreq driver

If minimal defconfig (omap_3430sdp_min_defconfig) is used, boot will be=
 ok.

Has anyone faced same issue?

Best Regards
Abraham
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
