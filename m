From: =?UTF-8?B?UGV0ZXIgS8O8bW1lbA==?= <syntheticpp@gmx.net>
Subject: 3.18.1->3.19-rc2: In-band Error seen by MPU
Date: Thu, 01 Jan 2015 19:12:51 +0100
Message-ID: <54A58E23.5080103@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:58690 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbbAASM6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Jan 2015 13:12:58 -0500
Received: from [192.168.178.38] ([79.242.26.171]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MU0U9-1YFNDy2A9R-00QiUX for
 <linux-omap@vger.kernel.org>; Thu, 01 Jan 2015 19:12:55 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

When updating (custom DM3730 board) from 3.18.1 ro 3.19-rc2 I see a "In-band ERROR" warning which wasn't present in 3.18.1.
Could it be that I missed some DT updates?

And  should I care of "irq: no irq domain found for /ocp/pinmux@48002030"?

Many thanks!

[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/166/600 MHz
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 65536000000000ns
[    0.000030] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000183] Console: colour dummy device 80x30
[    0.000244] Calibrating delay loop... 597.60 BogoMIPS (lpj=2988032)
[    0.118988] pid_max: default: 32768 minimum: 301
[    0.119140] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.119171] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.119934] CPU: Testing write buffer coherency: ok
[    0.120330] Setting up static identity map for 0x803d5b28 - 0x803d5b80
[    0.121856] devtmpfs: initialized
[    0.122680] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    0.138458] omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
[    0.138977] omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
[    0.182159] omap_hwmod: mcbsp2: cannot be enabled for reset (3)
[    0.228424] pinctrl core: initialized pinctrl subsystem
[    0.259399] NET: Registered protocol family 16
[    0.260131] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.288696] cpuidle: using governor ladder
[    0.318572] cpuidle: using governor menu
[    0.324981] Reprogramming SDRC clock to 166000000 Hz
[    0.333160] OMAP GPIO hardware version 2.5
[    0.340515] irq: no irq domain found for /ocp/pinmux@48002030 !
[    0.356994] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    0.360015] platform 48058000.ssi-controller: Cannot lookup hwmod 'ssi'
[    0.366882] In-band Error seen by MPU  at address 0
[    0.366912] ------------[ cut here ]------------
[    0.366943] WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_smx.c:166 omap3_l3_app_irq+0x100/0x134()
[    0.366943] Modules linked in:
[    0.366973] CPU: 0 PID: 1 Comm: swapper Not tainted 3.19.0-rc2-DM+ #2
[    0.366973] Hardware name: Generic OMAP36xx (Flattened Device Tree)
[    0.367004] Backtrace:
[    0.367034] [<c00117a4>] (dump_backtrace) from [<c00119c8>] (show_stack+0x18/0x1c)
[    0.367034]  r6:c0213e50 r5:00000009 r4:00000000 r3:00000000
[    0.367065] [<c00119b0>] (show_stack) from [<c03cf9c8>] (dump_stack+0x24/0x28)
[    0.367095] [<c03cf9a4>] (dump_stack) from [<c002f688>] (warn_slowpath_common+0x8c/0xb8)
[    0.367126] [<c002f5fc>] (warn_slowpath_common) from [<c002f758>] (warn_slowpath_null+0x24/0x2c)
[    0.367126]  r8:00000000 r7:00000000 r6:04001b00 r5:00000000 r4:f8001400
[    0.367156] [<c002f734>] (warn_slowpath_null) from [<c0213e50>] (omap3_l3_app_irq+0x100/0x134)
[    0.367187] [<c0213d50>] (omap3_l3_app_irq) from [<c005b50c>] (handle_irq_event_percpu+0x80/0x148)
[    0.367218]  r9:c3953e00 r8:00000013 r7:00000000 r6:00000000 r5:c39581c0 r4:c39581c0
[    0.367248] [<c005b48c>] (handle_irq_event_percpu) from [<c005b63c>] (handle_irq_event+0x68/0x90)
[    0.367248]  r10:c3856000 r9:80000000 r8:c3803200 r7:00000001 r6:00000000 r5:c39581c0
[    0.367279]  r4:c3953e00
[    0.367279] [<c005b5d4>] (handle_irq_event) from [<c005dfd0>] (handle_level_irq+0xa4/0x160)
[    0.367309]  r5:00000000 r4:c3953e00
[    0.367309] [<c005df2c>] (handle_level_irq) from [<c005ac0c>] (generic_handle_irq+0x34/0x44)
[    0.367340]  r4:00000013 r3:c005df2c
[    0.367370] [<c005abd8>] (generic_handle_irq) from [<c005ae70>] (__handle_domain_irq+0x5c/0xb0)
[    0.367370]  r4:c055db00 r3:00000106
[    0.367401] [<c005ae14>] (__handle_domain_irq) from [<c000866c>] (omap_intc_handle_irq+0xd0/0xd8)
[    0.367401]  r8:60000113 r7:0000000a r6:c05842c0 r5:c3857d00 r4:c055dd20 r3:c3857d00
[    0.367431] [<c000859c>] (omap_intc_handle_irq) from [<c0012500>] (__irq_svc+0x40/0x74)
[    0.367431] Exception stack(0xc3857d00 to 0xc3857d48)
[    0.367462] 7d00: 00000000 0000001c 00000001 00000000 c38b7e00 c0554a80 0000001c 00000000
[    0.367492] 7d20: 60000113 80000000 c3856000 c3857d74 c3857d28 c3857d48 c005e3c0 c005c8f8
[    0.367492] 7d40: 40000113 ffffffff
[    0.367492]  r7:c3857d34 r6:ffffffff r5:40000113 r4:c005c8f8
[    0.367523] [<c005c66c>] (__setup_irq) from [<c005cc3c>] (setup_irq+0x48/0x90)
[    0.367523]  r8:20000113 r7:c39ec400 r6:c0554a80 r5:0000001c r4:c38b7e00
[    0.367553] [<c005cbf4>] (setup_irq) from [<c002a7fc>] (omap_system_dma_probe+0x224/0x2f8)
[    0.367584]  r6:00000600 r5:c057342c r4:0000001c r3:00000030
[    0.367614] [<c002a5d8>] (omap_system_dma_probe) from [<c02875d8>] (platform_drv_probe+0x4c/0xac)
[    0.367614]  r10:00000000 r9:c04ff5f0 r8:00000000 r7:fffffdfb r6:c0554a3c r5:c39ec410
[    0.367645]  r4:c05875f0
[    0.367645] [<c028758c>] (platform_drv_probe) from [<c0285eb8>] (driver_probe_device+0x110/0x244)
[    0.367675]  r7:c0554a3c r6:00000000 r5:c39ec410 r4:c05875f0
[    0.367675] [<c0285da8>] (driver_probe_device) from [<c02860cc>] (__driver_attach+0x94/0x98)
[    0.367706]  r8:0000006a r7:00000000 r6:c39ec444 r5:c0554a3c r4:c39ec410 r3:00000000
[    0.367736] [<c0286038>] (__driver_attach) from [<c0284270>] (bus_for_each_dev+0x74/0xa8)
[    0.367736]  r6:c0286038 r5:c0554a3c r4:00000000 r3:00000000
[    0.367767] [<c02841fc>] (bus_for_each_dev) from [<c02859ac>] (driver_attach+0x24/0x28)
[    0.367797]  r6:c0564448 r5:c39d4c00 r4:c0554a3c
[    0.367828] [<c0285988>] (driver_attach) from [<c0285664>] (bus_add_driver+0x150/0x1f8)
[    0.367828] [<c0285514>] (bus_add_driver) from [<c028655c>] (driver_register+0x80/0x100)
[    0.367828]  r7:c050d4bc r6:c39ed580 r5:c053fba0 r4:c0554a3c
[    0.367858] [<c02864dc>] (driver_register) from [<c028751c>] (__platform_driver_register+0x5c/0x64)
[    0.367889]  r5:c053fba0 r4:c053fba0
[    0.367889] [<c02874c0>] (__platform_driver_register) from [<c050d4d8>] (omap_system_dma_init+0x1c/0x20)
[    0.367919] [<c050d4bc>] (omap_system_dma_init) from [<c0008868>] (do_one_initcall+0x94/0x1dc)
[    0.367950] [<c00087d4>] (do_one_initcall) from [<c04ffdc0>] (kernel_init_freeable+0x12c/0x1d0)
[    0.367950]  r10:c0528b78 r9:c04ff5f0 r8:0000006a r7:c0572880 r6:c0572880 r5:00000003
[    0.367980]  r4:c0535b80
[    0.367980] [<c04ffc94>] (kernel_init_freeable) from [<c03cdd9c>] (kernel_init+0x10/0xf0)
[    0.368011]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c03cdd8c
[    0.368011]  r4:00000000
[    0.368041] [<c03cdd8c>] (kernel_init) from [<c000ea78>] (ret_from_fork+0x14/0x3c)
[    0.368041]  r4:00000000 r3:c3856000
[    0.368103] ---[ end trace 417eab97f066e1a5 ]---
