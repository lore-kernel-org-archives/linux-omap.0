From: Joachim Eastwood <manabian@gmail.com>
Subject: HDMI on OMAP4460: clk rate mismatch warning
Date: Tue, 15 Apr 2014 19:36:37 +0200
Message-ID: <CAGhQ9Vx-3H3yCzMv-8Mp83FWv94gOHvHP9hMiaPWHthZR_ezTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:61550 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaDORgi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2014 13:36:38 -0400
Received: by mail-lb0-f182.google.com with SMTP id n15so7369591lbi.27
        for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2014 10:36:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>

Hello,

I am trying to get HDMI work with DT on my VAR-STK-OM44 (4460) board.
But during kernel boot I get the following message:

[ 0.953796] ------------[ cut here ]------------
[ 0.953826] WARNING: CPU: 0 PID: 1 at
drivers/video/omap2/dss/dss.c:483 dss_set_fck_rate+0x7c/0x8c()
[ 0.953826] clk rate mismatch: 153600000 != 170666666
[ 0.953857] Modules linked in:
[ 0.953857] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
3.15.0-rc1-00030-gef9175d699c2 #25
[ 0.953918] [<c0014f68>] (unwind_backtrace) from [<c0011c2c>]
(show_stack+0x10/0x14)
[ 0.953918] [<c0011c2c>] (show_stack) from [<c05a7774>] (dump_stack+0x84/0x94)
[ 0.953948] [<c05a7774>] (dump_stack) from [<c0036e18>]
(warn_slowpath_common+0x70/0x8c)
[ 0.953979] [<c0036e18>] (warn_slowpath_common) from [<c0036e64>]
(warn_slowpath_fmt+0x30/0x40)
[ 0.953979] [<c0036e64>] (warn_slowpath_fmt) from [<c02a9928>]
(dss_set_fck_rate+0x7c/0x8c)
[ 0.954010] [<c02a9928>] (dss_set_fck_rate) from [<c083b7f8>]
(omap_dsshw_probe+0x21c/0x3a0)
[ 0.954040] [<c083b7f8>] (omap_dsshw_probe) from [<c030bc38>]
(platform_drv_probe+0x18/0x48)
[ 0.954040] [<c030bc38>] (platform_drv_probe) from [<c030a4bc>]
(driver_probe_device+0x124/0x240)
[ 0.954071] [<c030a4bc>] (driver_probe_device) from [<c030a6b0>]
(__driver_attach+0x94/0x98)
[ 0.954101] [<c030a6b0>] (__driver_attach) from [<c0308a94>]
(bus_for_each_dev+0x60/0x94)
[ 0.954101] [<c0308a94>] (bus_for_each_dev) from [<c0309c6c>]
(bus_add_driver+0x14c/0x1f4)
[ 0.954132] [<c0309c6c>] (bus_add_driver) from [<c030aca4>]
(driver_register+0x78/0xf8)
[ 0.954132] [<c030aca4>] (driver_register) from [<c030bc90>]
(platform_driver_probe+0x20/0xa8)
[ 0.954162] [<c030bc90>] (platform_driver_probe) from [<c083b54c>]
(omap_dss_init+0x24/0xb4)
[ 0.954162] [<c083b54c>] (omap_dss_init) from [<c000897c>]
(do_one_initcall+0xf8/0x148)
[ 0.954193] [<c000897c>] (do_one_initcall) from [<c080fc58>]
(kernel_init_freeable+0x13c/0x1dc)
[ 0.954223] [<c080fc58>] (kernel_init_freeable) from [<c05a2a80>]
(kernel_init+0xc/0xe8)
[ 0.954223] [<c05a2a80>] (kernel_init) from [<c000e2c8>]
(ret_from_fork+0x14/0x2c)
[ 0.954254] ---[ end trace ce91e7215ac78433 ]---
[ 0.954345] OMAP DSS rev 4.0
[ 0.956970] connector-hdmi connector.10: failed to find video source
[ 0.957031] connector-hdmi: probe of connector.10 failed with error -22
[ 0.959167] omapfb omapfb: no displays
[ 0.961547] omapfb omapfb: failed to setup omapfb
[ 0.961578] platform omapfb: Driver omapfb requests probe deferral

Googling turned up this thread:
https://lkml.org/lkml/2014/1/27/285

So I guess one possible explanation would be a bug in the omap4460 clock data.

Has anybody gotten HDMI to work on a 4460?


complete dmesg: http://slexy.org/raw/s2MZvlmrqL
.config:http://slexy.org/raw/s20A0bwQg9
dt nodes: http://slexy.org/raw/s21L4ToVva

regards
Joachim Eastwood
