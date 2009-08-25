From: Peter Barada <peterb@logicpd.com>
Subject: Problem tryhing to bring up new LCD on OMAP Logic board
Date: Tue, 25 Aug 2009 15:07:26 -0400
Message-ID: <1251227246.16110.71.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:26725 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755616AbZHYTCr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Aug 2009 15:02:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

I'm using 2.6.31-rc5 from Kevin's PM branch (commit ID
70a1f2249bbe765f78cf5e220e4e3f539b41eb7f) and I'm trying to add in LCD
panel support for our OMAP boards.

I've cloned drivers/video/lcd_omap3evm.c, and when I call into
omapfb_main::omapfb_register_panel() it crashes with:

<4>Platform driver 'omapfb' needs updating - please use dev_pm_ops
omapfb_probe:1829 pdev c03f0258
omap3logic: Registering platform driver
<4>Platform driver 'omap3logic_lcd' needs updating - please use
dev_pm_ops
omap3logic_panel_probe:463 panel c0425de4 (name 15)
omapfb_register_panel:1842
omapfb_do_probe:1673 pdev c03f0258 panel c0425de4
omapfb_do_probe:1697
<4>MUX: setup D28_34XX_DSS_PCLK (0xd80020d4): 0x0000 -> 0x0108
<4>MUX: setup D26_34XX_DSS_HSYNC (0xd80020d6): 0x0000 -> 0x0108
<4>MUX: setup D27_34XX_DSS_VSYNC (0xd80020d8): 0x0000 -> 0x0108
<4>MUX: setup E27_34XX_DSS_ACBIAS (0xd80020da): 0x0000 -> 0x0108
<4>MUX: setup AG22_34XX_DSS_D0 (0xd80020dc): 0x0000 -> 0x0108
<4>MUX: setup AH22_34XX_DSS_D1 (0xd80020de): 0x0000 -> 0x0108
<4>MUX: setup AG23_34XX_DSS_D2 (0xd80020e0): 0x0000 -> 0x0108
<4>MUX: setup AH23_34XX_DSS_D3 (0xd80020e2): 0x0000 -> 0x0108
<4>MUX: setup AG24_34XX_DSS_D4 (0xd80020e4): 0x0000 -> 0x0108
<4>MUX: setup AH24_34XX_DSS_D5 (0xd80020e6): 0x0000 -> 0x0108
<4>MUX: setup E26_34XX_DSS_D6 (0xd80020e8): 0x0000 -> 0x0108
<4>MUX: setup F28_34XX_DSS_D7 (0xd80020ea): 0x0000 -> 0x0108
<4>MUX: setup F27_34XX_DSS_D8 (0xd80020ec): 0x0000 -> 0x0108
<4>MUX: setup G26_34XX_DSS_D9 (0xd80020ee): 0x0000 -> 0x0108
<4>MUX: setup AD28_34XX_DSS_D10 (0xd80020f0): 0x0000 -> 0x0108
<4>MUX: setup AD27_34XX_DSS_D11 (0xd80020f2): 0x0000 -> 0x0108
<4>MUX: setup AB28_34XX_DSS_D12 (0xd80020f4): 0x0000 -> 0x0108
<4>MUX: setup AB27_34XX_DSS_D13 (0xd80020f6): 0x0000 -> 0x0108
<4>MUX: setup AA28_34XX_DSS_D14 (0xd80020f8): 0x0000 -> 0x0108
<4>MUX: setup AA27_34XX_DSS_D15 (0xd80020fa): 0x0000 -> 0x0108
<4>MUX: setup G26_34XX_DSS_D16 (0xd80020fc): 0x0000 -> 0x0108
<4>MUX: setup H27_34XX_DSS_D17 (0xd80020fe): 0x0000 -> 0x0108
<4>MUX: setup H26_34XX_DSS_D18 (0xd8002100): 0x0000 -> 0x0108
<4>MUX: setup H25_34XX_DSS_D19 (0xd8002102): 0x0000 -> 0x0108
<4>MUX: setup E28_34XX_DSS_D20 (0xd8002104): 0x0000 -> 0x0108
<4>MUX: setup J26_34XX_DSS_D21 (0xd8002106): 0x0000 -> 0x0108
<4>MUX: setup AC27_34XX_DSS_D22 (0xd8002108): 0x0000 -> 0x0108
<4>MUX: setup AC27_34XX_DSS_D23 (0xd800210a): 0x0000 -> 0x0108
<4>MUX: setup AD2_34XX_GPIO154 (0xd8002188): 0x0101 -> 0x0004
<4>MUX: setup AC1_34XX_GPIO155 (0xd800218a): 0x0101 -> 0x0004
<6>omapfb: configured for panel 15
omapfb_do_probe:1733
<6>omapfb: DISPC version 3.0 initialized
omapfb_do_probe:1741
omapfb_do_probe:1745
planes_init:1540 region_cnt 1
<4>------------[ cut here ]------------
<4>WARNING: at kernel/mutex.c:207 __mutex_lock_slowpath+0xb8/0x240()
<d>Modules linked in:
[<c0033444>] (unwind_backtrace+0x0/0xd4) from [<c005a02c>]
(warn_slowpath_common+0x4c/0x68)
[<c005a02c>] (warn_slowpath_common+0x4c/0x68) from [<c02dc104>]
(__mutex_lock_slowpath+0xb8/0x240)
[<c02dc104>] (__mutex_lock_slowpath+0xb8/0x240) from [<c02dc298>]
(mutex_lock+0xc/0x1c)
[<c02dc298>] (mutex_lock+0xc/0x1c) from [<c01a417c>] (set_fb_fix
+0x40/0xcc)
[<c01a417c>] (set_fb_fix+0x40/0xcc) from [<c01a4dc8>] (omapfb_do_probe
+0x4d0/0x9d0)
[<c01a4dc8>] (omapfb_do_probe+0x4d0/0x9d0) from [<c01a7ef4>]
(omap3logic_panel_probe+0x4c/0x6c)
[<c01a7ef4>] (omap3logic_panel_probe+0x4c/0x6c) from [<c01cbfe8>]
(platform_drv_probe+0x1c/0x24)
[<c01cbfe8>] (platform_drv_probe+0x1c/0x24) from [<c01cb22c>]
(driver_probe_device+0xb8/0x164)
[<c01cb22c>] (driver_probe_device+0xb8/0x164) from [<c01cb338>]
(__driver_attach+0x60/0x84)
[<c01cb338>] (__driver_attach+0x60/0x84) from [<c01ca6b8>]
(bus_for_each_dev+0x48/0x80)
[<c01ca6b8>] (bus_for_each_dev+0x48/0x80) from [<c01cac48>]
(bus_add_driver+0xa0/0x224)
[<c01cac48>] (bus_add_driver+0xa0/0x224) from [<c01cb634>]
(driver_register+0xac/0x134)
[<c01cb634>] (driver_register+0xac/0x134) from [<c002d2b0>]
(do_one_initcall+0x50/0x17c)
[<c002d2b0>] (do_one_initcall+0x50/0x17c) from [<c000888c>] (kernel_init
+0x88/0x100)
[<c000888c>] (kernel_init+0x88/0x100) from [<c002ece0>]
(kernel_thread_exit+0x0/0x8)

I believe the problem is in set_fb_fix() (called from planes_init())
trying to pull the lock for fbi->mm_lock which is not initialized since
register_framebuffer() has not yet been called (called after
planes_init() is called).

Any ideas what I'm doing wrong?

-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
