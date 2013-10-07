From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Date: Sun, 6 Oct 2013 19:15:57 -0700
Message-ID: <20131007021556.GV8949@atomide.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
 <524EE00F.7010208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15319 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032Ab3JGCQD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Oct 2013 22:16:03 -0400
Content-Disposition: inline
In-Reply-To: <524EE00F.7010208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [131004 08:42]:
> Hi,
> 
> Just a gentle reminder, anybody have any comments on this series or
> should we start queuing stuff?

Well omap4 seems to work for me just fine, and omap3 in legacy
mode. But looks like omap3 device tree based booting is breaking
after I pulled in your test branch. I get the following on
3630 based dm3730.

Regards,

Tony


[    0.187652] omap_hwmod: uart4: cannot clk_get main_clk uart4_fck
[    0.187713] omap_hwmod: uart4: cannot _init_clocks
[    0.187713] ------------[ cut here ]------------
[    0.187774] WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/omap_hwmod.c:2434 _init+0x6c/0x80()
[    0.187774] omap_hwmod: uart4: couldn't init clocks
[    0.187774] Modules linked in:
[    0.187805] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.12.0-rc2-00020-gdea1778-dirty #791
[    0.187866] [<c001cd54>] (unwind_backtrace+0x0/0xf4) from [<c0018e80>] (show_stack+0x14/0x1c)
[    0.187896] [<c0018e80>] (show_stack+0x14/0x1c) from [<c0554400>] (dump_stack+0x6c/0x9c)
[    0.187927] [<c0554400>] (dump_stack+0x6c/0x9c) from [<c00488a8>] (warn_slowpath_common+0x64/0x84)
[    0.187957] [<c00488a8>] (warn_slowpath_common+0x64/0x84) from [<c004895c>] (warn_slowpath_fmt+0x30/0x40)
[    0.187988] [<c004895c>] (warn_slowpath_fmt+0x30/0x40) from [<c07a4bec>] (_init+0x6c/0x80)
[    0.188018] [<c07a4bec>] (_init+0x6c/0x80) from [<c002e068>] (omap_hwmod_for_each+0x50/0x64)
[    0.188049] [<c002e068>] (omap_hwmod_for_each+0x50/0x64) from [<c07a5440>] (__omap_hwmod_setup_all+0x34/0x4c)
[    0.188079] [<c07a5440>] (__omap_hwmod_setup_all+0x34/0x4c) from [<c00087ac>] (do_one_initcall+0x2c/0x150)
[    0.188110] [<c00087ac>] (do_one_initcall+0x2c/0x150) from [<c0797508>] (do_basic_setup+0x94/0xd0)
[    0.188140] [<c0797508>] (do_basic_setup+0x94/0xd0) from [<c07975c0>] (kernel_init_freeable+0x7c/0x120)
[    0.188171] [<c07975c0>] (kernel_init_freeable+0x7c/0x120) from [<c05526b4>] (kernel_init+0xc/0x164)
[    0.188201] [<c05526b4>] (kernel_init+0xc/0x164) from [<c00149c8>] (ret_from_fork+0x14/0x2c)
[    0.188415] ---[ end trace 1b75b31a2719ed1c ]---

[    0.810241] ------------[ cut here ]------------
[    0.810302] WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/omap_hwmod.c:2126 _enable+0x254/0x280()
[    0.810302] omap_hwmod: timer12: enabled state can only be entered from initialized, idle, or disabled state
[    0.810333] Modules linked in:
[    0.810363] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.12.0-rc2-00020-gdea1778-dirty #791
[    0.810394] [<c001cd54>] (unwind_backtrace+0x0/0xf4) from [<c0018e80>] (show_stack+0x14/0x1c)
[    0.810424] [<c0018e80>] (show_stack+0x14/0x1c) from [<c0554400>] (dump_stack+0x6c/0x9c)
[    0.810455] [<c0554400>] (dump_stack+0x6c/0x9c) from [<c00488a8>] (warn_slowpath_common+0x64/0x84)
[    0.810485] [<c00488a8>] (warn_slowpath_common+0x64/0x84) from [<c004895c>] (warn_slowpath_fmt+0x30/0x40)
[    0.810516] [<c004895c>] (warn_slowpath_fmt+0x30/0x40) from [<c003085c>] (_enable+0x254/0x280)
[    0.810546] [<c003085c>] (_enable+0x254/0x280) from [<c00308b0>] (omap_hwmod_enable+0x28/0x40)
[    0.810577] [<c00308b0>] (omap_hwmod_enable+0x28/0x40) from [<c0030f8c>] (omap_device_enable+0x3c/0x80)
[    0.810607] [<c0030f8c>] (omap_device_enable+0x3c/0x80) from [<c0030fe0>] (_od_runtime_resume+0x10/0x1c)
[    0.810638] [<c0030fe0>] (_od_runtime_resume+0x10/0x1c) from [<c036e120>] (__rpm_callback+0x2c/0x80)
[    0.810668] [<c036e120>] (__rpm_callback+0x2c/0x80) from [<c036e198>] (rpm_callback+0x24/0x78)
[    0.810699] [<c036e198>] (rpm_callback+0x24/0x78) from [<c036f444>] (rpm_resume+0x3c0/0x60c)
[    0.810729] [<c036f444>] (rpm_resume+0x3c0/0x60c) from [<c036f970>] (__pm_runtime_resume+0x4c/0x68)
[    0.810760] [<c036f970>] (__pm_runtime_resume+0x4c/0x68) from [<c0044954>] (omap_dm_timer_probe+0x234/0x334)
[    0.810791] [<c0044954>] (omap_dm_timer_probe+0x234/0x334) from [<c03659ac>] (platform_drv_probe+0x1c/0x24)
[    0.810821] [<c03659ac>] (platform_drv_probe+0x1c/0x24) from [<c03645e4>] (really_probe+0x70/0x200)
[    0.810852] [<c03645e4>] (really_probe+0x70/0x200) from [<c03647a8>] (driver_probe_device+0x34/0x50)
[    0.810852] [<c03647a8>] (driver_probe_device+0x34/0x50) from [<c0364858>] (__driver_attach+0x94/0x98)
[    0.810882] [<c0364858>] (__driver_attach+0x94/0x98) from [<c0362cd4>] (bus_for_each_dev+0x74/0x98)
[    0.810913] [<c0362cd4>] (bus_for_each_dev+0x74/0x98) from [<c0363510>] (bus_add_driver+0xe8/0x278)
[    0.810943] [<c0363510>] (bus_add_driver+0xe8/0x278) from [<c0364e30>] (driver_register+0x5c/0xf8)
[    0.810974] [<c0364e30>] (driver_register+0x5c/0xf8) from [<c00087ac>] (do_one_initcall+0x2c/0x150)
[    0.811004] [<c00087ac>] (do_one_initcall+0x2c/0x150) from [<c0797508>] (do_basic_setup+0x94/0xd0)
[    0.811035] [<c0797508>] (do_basic_setup+0x94/0xd0) from [<c07975c0>] (kernel_init_freeable+0x7c/0x120)
[    0.811065] [<c07975c0>] (kernel_init_freeable+0x7c/0x120) from [<c05526b4>] (kernel_init+0xc/0x164)
[    0.811096] [<c05526b4>] (kernel_init+0xc/0x164) from [<c00149c8>] (ret_from_fork+0x14/0x2c)
[    0.811126] ---[ end trace 1b75b31a2719ed1d ]---

[    0.811889] ------------[ cut here ]------------
[    0.811920] WARNING: CPU: 0 PID: 46 at arch/arm/mach-omap2/omap_hwmod.c:2224 _idle+0xd4/0xf8()
[    0.811920] omap_hwmod: timer12: idle state can only be entered from enabled state
[    0.811950] Modules linked in:
[    0.811981] CPU: 0 PID: 46 Comm: kworker/0:1 Tainted: G        W    3.12.0-rc2-00020-gdea1778-dirty #791
[    0.812011] Workqueue: pm pm_runtime_work
[    0.812042] [<c001cd54>] (unwind_backtrace+0x0/0xf4) from [<c0018e80>] (show_stack+0x14/0x1c)
[    0.812072] [<c0018e80>] (show_stack+0x14/0x1c) from [<c0554400>] (dump_stack+0x6c/0x9c)
[    0.812103] [<c0554400>] (dump_stack+0x6c/0x9c) from [<c00488a8>] (warn_slowpath_common+0x64/0x84)
[    0.812133] [<c00488a8>] (warn_slowpath_common+0x64/0x84) from [<c004895c>] (warn_slowpath_fmt+0x30/0x40)
[    0.812164] [<c004895c>] (warn_slowpath_fmt+0x30/0x40) from [<c003099c>] (_idle+0xd4/0xf8)
[    0.812194] [<c003099c>] (_idle+0xd4/0xf8) from [<c0030c9c>] (omap_hwmod_idle+0x28/0x3c)
[    0.812225] [<c0030c9c>] (omap_hwmod_idle+0x28/0x3c) from [<c0030e6c>] (omap_device_idle+0x3c/0x80)
[    0.812225] [<c0030e6c>] (omap_device_idle+0x3c/0x80) from [<c0030ed0>] (_od_runtime_suspend+0x20/0x2c)
[    0.812255] [<c0030ed0>] (_od_runtime_suspend+0x20/0x2c) from [<c036e120>] (__rpm_callback+0x2c/0x80)
[    0.812286] [<c036e120>] (__rpm_callback+0x2c/0x80) from [<c036e198>] (rpm_callback+0x24/0x78)
[    0.812316] [<c036e198>] (rpm_callback+0x24/0x78) from [<c036e5bc>] (rpm_suspend+0xf4/0x5e4)
[    0.812347] [<c036e5bc>] (rpm_suspend+0xf4/0x5e4) from [<c036fb78>] (pm_runtime_work+0x80/0xa4)
[    0.812377] [<c036fb78>] (pm_runtime_work+0x80/0xa4) from [<c0064058>] (process_one_work+0x204/0x594)
[    0.812408] [<c0064058>] (process_one_work+0x204/0x594) from [<c0064530>] (worker_thread+0x148/0x480)
[    0.812438] [<c0064530>] (worker_thread+0x148/0x480) from [<c0069c20>] (kthread+0xa0/0xac)
[    0.812469] [<c0069c20>] (kthread+0xa0/0xac) from [<c00149c8>] (ret_from_fork+0x14/0x2c)
[    0.812499] ---[ end trace 1b75b31a2719ed1e ]---


[    2.595031] ------------[ cut here ]------------
[    2.599945] WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/omap_hwmod.c:2126 _enable+0x254/0x280()
[    2.609313] omap_hwmod: uart4: enabled state can only be entered from initialized, idle, or disabled state
[    2.619506] Modules linked in:
[    2.622772] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.12.0-rc2-00020-gdea1778-dirty #791
[    2.632537] [<c001cd54>] (unwind_backtrace+0x0/0xf4) from [<c0018e80>] (show_stack+0x14/0x1c)
[    2.641540] [<c0018e80>] (show_stack+0x14/0x1c) from [<c0554400>] (dump_stack+0x6c/0x9c)
[    2.650115] [<c0554400>] (dump_stack+0x6c/0x9c) from [<c00488a8>] (warn_slowpath_common+0x64/0x84)
[    2.659576] [<c00488a8>] (warn_slowpath_common+0x64/0x84) from [<c004895c>] (warn_slowpath_fmt+0x30/0x40)
[    2.669708] [<c004895c>] (warn_slowpath_fmt+0x30/0x40) from [<c003085c>] (_enable+0x254/0x280)
[    2.678802] [<c003085c>] (_enable+0x254/0x280) from [<c00308b0>] (omap_hwmod_enable+0x28/0x40)
[    2.687927] [<c00308b0>] (omap_hwmod_enable+0x28/0x40) from [<c0030f8c>] (omap_device_enable+0x3c/0x80)
[    2.697875] [<c0030f8c>] (omap_device_enable+0x3c/0x80) from [<c0030fe0>] (_od_runtime_resume+0x10/0x1c)
[    2.707916] [<c0030fe0>] (_od_runtime_resume+0x10/0x1c) from [<c036e120>] (__rpm_callback+0x2c/0x80)
[    2.717559] [<c036e120>] (__rpm_callback+0x2c/0x80) from [<c036e198>] (rpm_callback+0x24/0x78)
[    2.726684] [<c036e198>] (rpm_callback+0x24/0x78) from [<c036f444>] (rpm_resume+0x3c0/0x60c)
[    2.735595] [<c036f444>] (rpm_resume+0x3c0/0x60c) from [<c036f970>] (__pm_runtime_resume+0x4c/0x68)
[    2.745178] [<c036f970>] (__pm_runtime_resume+0x4c/0x68) from [<c035ae30>] (serial_omap_probe+0x294/0x4fc)
[    2.755401] [<c035ae30>] (serial_omap_probe+0x294/0x4fc) from [<c03659ac>] (platform_drv_probe+0x1c/0x24)
[    2.765502] [<c03659ac>] (platform_drv_probe+0x1c/0x24) from [<c03645e4>] (really_probe+0x70/0x200)
[    2.775054] [<c03645e4>] (really_probe+0x70/0x200) from [<c03647a8>] (driver_probe_device+0x34/0x50)
[    2.784729] [<c03647a8>] (driver_probe_device+0x34/0x50) from [<c0364858>] (__driver_attach+0x94/0x98)
[    2.794555] [<c0364858>] (__driver_attach+0x94/0x98) from [<c0362cd4>] (bus_for_each_dev+0x74/0x98)
[    2.804138] [<c0362cd4>] (bus_for_each_dev+0x74/0x98) from [<c0363510>] (bus_add_driver+0xe8/0x278)
[    2.813690] [<c0363510>] (bus_add_driver+0xe8/0x278) from [<c0364e30>] (driver_register+0x5c/0xf8)
[    2.823181] [<c0364e30>] (driver_register+0x5c/0xf8) from [<c07d0028>] (serial_omap_init+0x28/0x44)
[    2.832763] [<c07d0028>] (serial_omap_init+0x28/0x44) from [<c00087ac>] (do_one_initcall+0x2c/0x150)
[    2.842407] [<c00087ac>] (do_one_initcall+0x2c/0x150) from [<c0797508>] (do_basic_setup+0x94/0xd0)
[    2.851898] [<c0797508>] (do_basic_setup+0x94/0xd0) from [<c07975c0>] (kernel_init_freeable+0x7c/0x120)
[    2.861846] [<c07975c0>] (kernel_init_freeable+0x7c/0x120) from [<c05526b4>] (kernel_init+0xc/0x164)
[    2.871490] [<c05526b4>] (kernel_init+0xc/0x164) from [<c00149c8>] (ret_from_fork+0x14/0x2c)
[    2.880432] ---[ end trace 1b75b31a2719ed1f ]---
