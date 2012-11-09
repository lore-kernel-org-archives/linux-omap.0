From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 14/26] ARM: OMAP3: clock: Add 3xxx data using common
 struct clk
Date: Fri, 9 Nov 2012 00:33:53 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211090028250.20703@utopia.booyaka.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com> <1352337181-29427-15-git-send-email-mturquette@ti.com> <alpine.DEB.2.00.1211081800210.20703@utopia.booyaka.com> <alpine.DEB.2.00.1211082158310.20703@utopia.booyaka.com>
 <alpine.DEB.2.00.1211090002380.20703@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55412 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab2KIAdy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 19:33:54 -0500
In-Reply-To: <alpine.DEB.2.00.1211090002380.20703@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Fri, 9 Nov 2012, Paul Walmsley wrote:

> One observation is that dpll4_m5x2_ck and dpll4_m6x2_ck are never enabled.  
> The tracebacks occur when something in the suspend path tries to disable 
> those clocks.

Sorry, this part is inaccurate - I misread the trace.  The suspend path 
errors are coming from a disable of dpll4_m2x2_ck which is probably caused 
by the disable of i2c1_fck.  Here's the unredacted trace of this section.

The enables and disables of dpll4_m2x2_ck from the entire log appear to be balanced:

[    0.135589] enabling clkdm dpll4_clkdm during enable of clk dpll4_m2x2_ck
[    0.135681] disabling clkdm dpll4_clkdm during disable of clk dpll4_m2x2_ck
[    0.135833] enabling clkdm dpll4_clkdm during enable of clk dpll4_m2x2_ck
[    0.135894] disabling clkdm dpll4_clkdm during disable of clk dpll4_m2x2_ck
[    0.136047] enabling clkdm dpll4_clkdm during enable of clk dpll4_m2x2_ck
[    0.136138] disabling clkdm dpll4_clkdm during disable of clk dpll4_m2x2_ck
[    0.136322] enabling clkdm dpll4_clkdm during enable of clk dpll4_m2x2_ck
[   38.999145] disabling clkdm dpll4_clkdm during disable of clk dpll4_m2x2_ck


- Paul

[   38.986267] PM: suspend of devices complete after 129.760 msecs
[   38.991668] PM: late suspend of devices complete after 5.340 msecs
[   38.996459] disabling clkdm core_l4_clkdm during disable of clk mmchs1_fck
[   38.998718] disabling clkdm per_clkdm during disable of clk uart3_fck
[   38.998840] disabling clkdm core_l4_clkdm during disable of clk uart2_fck
[   38.998931] disabling clkdm core_l4_clkdm during disable of clk uart1_fck
[   38.999114] disabling clkdm core_l4_clkdm during disable of clk i2c1_fck
[   38.999145] disabling clkdm dpll4_clkdm during disable of clk dpll4_m2x2_ck
[   38.999145] ------------[ cut here ]------------
[   38.999206] WARNING: at arch/arm/mach-omap2/clockdomain.c:962 _clkdm_clk_hwmod_disable+0xa4/0xf8()
[   38.999206] Modules linked in:
[   38.999267] [<c001c1cc>] (unwind_backtrace+0x0/0xf0) from [<c0043680>] (warn_slowpath_common+0x4c/0x64)
[   38.999298] [<c0043680>] (warn_slowpath_common+0x4c/0x64) from [<c00436b4>] (warn_slowpath_null+0x1c/0x24)
[   38.999328] [<c00436b4>] (warn_slowpath_null+0x1c/0x24) from [<c003695c>] (_clkdm_clk_hwmod_disable+0xa4/0xf8)
[   38.999359] [<c003695c>] (_clkdm_clk_hwmod_disable+0xa4/0xf8) from [<c0437d38>] (__clk_disable+0x70/0xac)
[   38.999389] [<c0437d38>] (__clk_disable+0x70/0xac) from [<c0437d94>] (clk_disable+0x20/0x34)
[   38.999420] [<c0437d94>] (clk_disable+0x20/0x34) from [<c002a330>] (_disable_clocks+0x18/0x68)
[   38.999420] [<c002a330>] (_disable_clocks+0x18/0x68) from [<c002b09c>] (_idle+0xf8/0x1b4)
[   38.999450] [<c002b09c>] (_idle+0xf8/0x1b4) from [<c002bf08>] (omap_hwmod_idle+0x24/0x40)
[   38.999481] [<c002bf08>] (omap_hwmod_idle+0x24/0x40) from [<c002ce34>] (omap_device_idle_hwmods+0x24/0x3c)
[   38.999511] [<c002ce34>] (omap_device_idle_hwmods+0x24/0x3c) from [<c002d024>] (_omap_device_deactivate+0x9c/0x138)
[   38.999511] [<c002d024>] (_omap_device_deactivate+0x9c/0x138) from [<c002d984>] (omap_device_idle+0x28/0x54)
[   38.999542] [<c002d984>] (omap_device_idle+0x28/0x54) from [<c002da48>] (_od_suspend_noirq+0x74/0x7c)
[   38.999572] [<c002da48>] (_od_suspend_noirq+0x74/0x7c) from [<c034cc6c>] (dpm_run_callback.clone.9+0x30/0xb4)
[   38.999603] [<c034cc6c>] (dpm_run_callback.clone.9+0x30/0xb4) from [<c034d4c0>] (dpm_suspend_end+0x364/0x554)
[   38.999603] [<c034d4c0>] (dpm_suspend_end+0x364/0x554) from [<c0084f48>] (suspend_devices_and_enter+0xbc/0x2d0)
[   38.999633] [<c0084f48>] (suspend_devices_and_enter+0xbc/0x2d0) from [<c00852e8>] (pm_suspend+0x18c/0x208)
[   38.999664] [<c00852e8>] (pm_suspend+0x18c/0x208) from [<c008457c>] (state_store+0x120/0x134)
[   38.999694] [<c008457c>] (state_store+0x120/0x134) from [<c02d2a38>] (kobj_attr_store+0x14/0x20)
[   38.999725] [<c02d2a38>] (kobj_attr_store+0x14/0x20) from [<c017a6b8>] (sysfs_write_file+0x100/0x184)
[   38.999755] [<c017a6b8>] (sysfs_write_file+0x100/0x184) from [<c01166b8>] (vfs_write+0xb4/0x148)
[   38.999755] [<c01166b8>] (vfs_write+0xb4/0x148) from [<c011693c>] (sys_write+0x40/0x6c)
[   38.999786] [<c011693c>] (sys_write+0x40/0x6c) from [<c0013ee0>] (ret_fast_syscall+0x0/0x3c)
[   38.999816] ---[ end trace 72e2d7bdcf98ea8e ]---
[   38.999816] disabling clkdm dpll4_clkdm during disable of clk dpll4_ck
[   38.999847] ------------[ cut here ]------------
[   38.999847] WARNING: at arch/arm/mach-omap2/clockdomain.c:962 _clkdm_clk_hwmod_disable+0xa4/0xf8()
[   38.999877] Modules linked in:
[   38.999908] [<c001c1cc>] (unwind_backtrace+0x0/0xf0) from [<c0043680>] (warn_slowpath_common+0x4c/0x64)
[   38.999938] [<c0043680>] (warn_slowpath_common+0x4c/0x64) from [<c00436b4>] (warn_slowpath_null+0x1c/0x24)
[   38.999938] [<c00436b4>] (warn_slowpath_null+0x1c/0x24) from [<c003695c>] (_clkdm_clk_hwmod_disable+0xa4/0xf8)
[   38.999969] [<c003695c>] (_clkdm_clk_hwmod_disable+0xa4/0xf8) from [<c0437d38>] (__clk_disable+0x70/0xac)
[   38.999999] [<c0437d38>] (__clk_disable+0x70/0xac) from [<c0437d94>] (clk_disable+0x20/0x34)
[   38.999999] [<c0437d94>] (clk_disable+0x20/0x34) from [<c002a330>] (_disable_clocks+0x18/0x68)
[   39.000030] [<c002a330>] (_disable_clocks+0x18/0x68) from [<c002b09c>] (_idle+0xf8/0x1b4)
[   39.000061] [<c002b09c>] (_idle+0xf8/0x1b4) from [<c002bf08>] (omap_hwmod_idle+0x24/0x40)
[   39.000061] [<c002bf08>] (omap_hwmod_idle+0x24/0x40) from [<c002ce34>] (omap_device_idle_hwmods+0x24/0x3c)
[   39.000091] [<c002ce34>] (omap_device_idle_hwmods+0x24/0x3c) from [<c002d024>] (_omap_device_deactivate+0x9c/0x138)
[   39.000122] [<c002d024>] (_omap_device_deactivate+0x9c/0x138) from [<c002d984>] (omap_device_idle+0x28/0x54)
[   39.000152] [<c002d984>] (omap_device_idle+0x28/0x54) from [<c002da48>] (_od_suspend_noirq+0x74/0x7c)
[   39.000152] [<c002da48>] (_od_suspend_noirq+0x74/0x7c) from [<c034cc6c>] (dpm_run_callback.clone.9+0x30/0xb4)
[   39.000183] [<c034cc6c>] (dpm_run_callback.clone.9+0x30/0xb4) from [<c034d4c0>] (dpm_suspend_end+0x364/0x554)
[   39.000213] [<c034d4c0>] (dpm_suspend_end+0x364/0x554) from [<c0084f48>] (suspend_devices_and_enter+0xbc/0x2d0)
[   39.000213] [<c0084f48>] (suspend_devices_and_enter+0xbc/0x2d0) from [<c00852e8>] (pm_suspend+0x18c/0x208)
[   39.000244] [<c00852e8>] (pm_suspend+0x18c/0x208) from [<c008457c>] (state_store+0x120/0x134)
[   39.000274] [<c008457c>] (state_store+0x120/0x134) from [<c02d2a38>] (kobj_attr_store+0x14/0x20)
[   39.000274] [<c02d2a38>] (kobj_attr_store+0x14/0x20) from [<c017a6b8>] (sysfs_write_file+0x100/0x184)
[   39.000305] [<c017a6b8>] (sysfs_write_file+0x100/0x184) from [<c01166b8>] (vfs_write+0xb4/0x148)
[   39.000335] [<c01166b8>] (vfs_write+0xb4/0x148) from [<c011693c>] (sys_write+0x40/0x6c)
[   39.000366] [<c011693c>] (sys_write+0x40/0x6c) from [<c0013ee0>] (ret_fast_syscall+0x0/0x3c)
[   39.000366] ---[ end trace 72e2d7bdcf98ea8f ]---
[   39.000823] disabling clkdm wkup_clkdm during disable of clk gpio1_ick
[   39.000976] PM: noirq suspend of devices complete after 9.307 msecs
[   39.001068] Disabling non-boot CPUs ...

