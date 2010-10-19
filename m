From: Steve Sakoman <sakoman@gmail.com>
Subject: DSS2 crash with shutdown -h now
Date: Tue, 19 Oct 2010 15:05:10 -0700
Message-ID: <AANLkTinjRuVx+vi4Pq6pnVLfizB6AKdmGDtRzwbq+d1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35737 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815Ab0JSWFM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 18:05:12 -0400
Received: by eyx24 with SMTP id 24so364172eyx.19
        for <linux-omap@vger.kernel.org>; Tue, 19 Oct 2010 15:05:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm using a 2.6.35 kernel, and the generic panel driver.

I see this crash about 25% of the time, so I suspect a race condition.

Is anyone else encountering this?

Steve


Unmounting local filesystems...
Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa050040
Internal error: : 1028 [#1]
last sysfs file: /sys/devices/virtual/vc/vcs12/uevent
Modules linked in: ipv6 uvcvideo videodev v4l1_compat ads7846
CPU: 0    Not tainted  (2.6.35 #1)
PC is at dss_select_dispc_clk_source+0x20/0x40
LR is at omapdss_dpi_display_disable+0x20/0x50
pc : [<c01f74d4>]    lr : [<c01ffc80>]    psr: 60000013
sp : ded59e38  ip : 00000090  fp : 00000001
r10: 00000001  r9 : ded58000  r8 : c0032084
r7 : ded59e50  r6 : 00000000  r5 : c01fcc28  r4 : c057da00
r3 : 00000000  r2 : fa050000  r1 : c05d062c  r0 : 00000002
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 9ed84019  DAC: 00000015
Process halt (pid: 503, stack limit = 0xded582f0)
Stack: (0xded59e38 to 0xded5a000)
9e20:                                                       c057da00 c020a430
9e40: 00000000 c01fcc48 ded59e50 c022f424 dfc3fc78 dfccc170 dfe02400 c057d4cc
9e60: c057d4c0 c05d4fac 00000000 c0230ba4 c0575de0 c022c6f8 28121969 cdef0123
9e80: fee1dead c0065d58 28121969 c0065ed4 00000014 dfc17dd8 00000001 dfc299c0
9ea0: 00000000 ded59eb0 c0062ee4 c00546f0 000a4800 a0000013 00000000 ded59f08
9ec0: 00000001 00000014 ded58000 00000001 00000001 c0063068 00000000 ded59f08
9ee0: dfc299c0 dfc18500 ded59f08 00000014 ded58000 c0063cb8 00000001 00000000
9f00: 00000006 c0063d2c 00000014 00000164 00000000 000001f7 00000000 dfc299f8
9f20: 00000164 dfc299f0 c057f598 00000000 00000000 fffffffd 00000000 c006e810
9f40: ded59f6c 00000000 dfc299c0 c0052fbc dfc299c0 dff16e00 dec41080 dec92540
9f60: ded59fac ded59f70 c03e841c c0052f90 ffffff9c c0031f58 dec927a8 ded58000
9f80: 00000000 00000000 00000000 00000006 00000025 00000000 00000000 00000006
9fa0: 00000058 c0031f00 00000000 00000000 fee1dead 28121969 4321fedc 00000000
9fc0: 00000000 00000000 00000006 00000058 00000001 00000001 00000001 00000001
9fe0: 00011e50 bef36cb0 0000925c 400e23f8 20000010 fee1dead 00000000 00000000
[<c01f74d4>] (dss_select_dispc_clk_source+0x20/0x40) from [<c01ffc80>]
(omapdss_dpi_display_disable+0x20/0x50)
[<c01ffc80>] (omapdss_dpi_display_disable+0x20/0x50) from [<c020a430>]
(generic_panel_disable+0xc/0x18)
[<c020a430>] (generic_panel_disable+0xc/0x18) from [<c01fcc48>]
(dss_disable_device+0x20/0x2c)
[<c01fcc48>] (dss_disable_device+0x20/0x2c) from [<c022f424>]
(bus_for_each_dev+0x4c/0x8c)
[<c022f424>] (bus_for_each_dev+0x4c/0x8c) from [<c0230ba4>]
(platform_drv_shutdown+0x1c/0x24)
[<c0230ba4>] (platform_drv_shutdown+0x1c/0x24) from [<c022c6f8>]
(device_shutdown+0x70/0x94)
[<c022c6f8>] (device_shutdown+0x70/0x94) from [<c0065d58>]
(kernel_halt+0x10/0x2c)
[<c0065d58>] (kernel_halt+0x10/0x2c) from [<c0065ed4>] (sys_reboot+0x118/0x1dc)
[<c0065ed4>] (sys_reboot+0x118/0x1dc) from [<c0031f00>]
(ret_fast_syscall+0x0/0x30)
Code: e5833000 eafffffd e59f101c e5912000 (e5923040)
OMAPFB: pan_display(0)
OMAPFB: setcmap
OMAPFB: setcmap
OMAPFB: setcmap
---[ end trace 953aeb15ef1f69db ]---
Segmentation fault
