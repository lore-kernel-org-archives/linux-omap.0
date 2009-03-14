From: Steve Sakoman <sakoman@gmail.com>
Subject: Overo broken after recent mainline merge
Date: Sat, 14 Mar 2009 06:24:34 -0700
Message-ID: <5e088bd90903140624u5b5098f4vd9b1afa937325779@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:61730 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbZCNNYg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Mar 2009 09:24:36 -0400
Received: by wf-out-1314.google.com with SMTP id 28so987311wfa.4
        for <linux-omap@vger.kernel.org>; Sat, 14 Mar 2009 06:24:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Building from current top of tree I get the following at boot:

mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
regulator: Unable to get requested regulator: vmmc
------------[ cut here ]------------
WARNING: at drivers/gpio/gpiolib.c:826 gpio_free+0x2c/0xe0()
Modules linked in:
[<c04456f8>] (dump_stack+0x0/0x14) from [<c0114b1c>] (warn_slowpath+0x68/0x9c)
[<c0114ab4>] (warn_slowpath+0x0/0x9c) from [<c0281dec>] (gpio_free+0x2c/0xe0)
 r3:00000000 r2:00000000
 r7:ffffffea r6:c05874fc r5:c79a8500 r4:ffffffed
[<c0281dc0>] (gpio_free+0x0/0xe0) from [<c01003c4>]
(twl_mmc_late_init+0xe4/0x130)
 r8:c05874fc r7:c79a7008 r6:c05874fc r5:c79a8500 r4:ffffffed
[<c01002e0>] (twl_mmc_late_init+0x0/0x130) from [<c0024158>]
(omap_mmc_probe+0x36c/0x560)
[<c0023dec>] (omap_mmc_probe+0x0/0x560) from [<c02c71c0>]
(platform_drv_probe+0x20/0x24)
[<c02c71a0>] (platform_drv_probe+0x0/0x24) from [<c02c631c>]
(driver_probe_device+0xd4/0x1a0)
[<c02c6248>] (driver_probe_device+0x0/0x1a0) from [<c02c6454>]
(__driver_attach+0x6c/0x90)
 r7:c7817eb0 r6:c057b0b8 r5:c79a7090 r4:c79a7008
[<c02c63e8>] (__driver_attach+0x0/0x90) from [<c02c5bb0>]
(bus_for_each_dev+0x54/0x90)
 r6:c057b0b8 r5:c02c63e8 r4:00000000
[<c02c5b5c>] (bus_for_each_dev+0x0/0x90) from [<c02c615c>]
(driver_attach+0x20/0x28)
 r7:c7a3bf80 r6:c057b0b8 r5:c002b7e8 r4:00000000
[<c02c613c>] (driver_attach+0x0/0x28) from [<c02c5430>]
(bus_add_driver+0xa8/0x20c)
[<c02c5388>] (bus_add_driver+0x0/0x20c) from [<c02c66a0>]
(driver_register+0xb4/0x140)
 r8:00000000 r7:c0023dd0 r6:c057b0b8 r5:c002b7e8 r4:c002b6c0
[<c02c65ec>] (driver_register+0x0/0x140) from [<c02c7644>]
(platform_driver_register+0x6c/0x88)
 r8:00000000 r7:c0023dd0 r6:00000000 r5:c002b7e8 r4:c002b6c0
[<c02c75d8>] (platform_driver_register+0x0/0x88) from [<c0023de4>]
(omap_mmc_init+0x14/0x1c)
[<c0023dd0>] (omap_mmc_init+0x0/0x1c) from [<c00f22b0>]
(do_one_initcall+0x58/0x198)
[<c00f2258>] (do_one_initcall+0x0/0x198) from [<c00083f8>]
(kernel_init+0x80/0xf0)
 r8:00000000 r7:00000000 r6:00000000 r5:c002b7e8 r4:c002b6c0
[<c0008378>] (kernel_init+0x0/0xf0) from [<c0117ac4>] (do_exit+0x0/0x688)
 r5:00000000 r4:00000000
---[ end trace b8b5cc211eafb14f ]---
mmci-omap-hs mmci-omap-hs.0: err -19 configuring card detect
mmci-omap-hs mmci-omap-hs.1: Failed to get debounce clock
regulator: Unable to get requested regulator: vmmc

I've collected Dave's recent recent regulator patches and will try
again with those applied.

Steve
