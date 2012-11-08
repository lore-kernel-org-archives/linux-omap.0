From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 14/26] ARM: OMAP3: clock: Add 3xxx data using common
 struct clk
Date: Thu, 8 Nov 2012 22:01:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211082158310.20703@utopia.booyaka.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com> <1352337181-29427-15-git-send-email-mturquette@ti.com> <alpine.DEB.2.00.1211081800210.20703@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54910 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757098Ab2KHWBe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 17:01:34 -0500
In-Reply-To: <alpine.DEB.2.00.1211081800210.20703@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Thu, 8 Nov 2012, Paul Walmsley wrote:

> Am seeing warnings during the disable-unused-clocks phase of the boot on 
> the OMAP3 test boards here.

Similar problems during system suspend on 3530ES3 Beagle.  Not sure
what's causing these yet.  At this point the clockdomain usecounts
should be accurate.


- Paul

 
root@beagleboard:~# echo mem > /sys/power/state
[   36.488800] PM: Syncing filesystems ... done.
[   37.037841] Freezing user space processes ... (elapsed 0.01 seconds) done.
[   37.059600] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
[   37.082885] Suspending console(s) (use no_console_suspend to debug)
[   37.222747] PM: suspend of devices complete after 129.791 msecs
[   37.228057] PM: late suspend of devices complete after 5.310 msecs
[   37.235412] ------------[ cut here ]------------
[   37.235473] WARNING: at arch/arm/mach-omap2/clockdomain.c:961 _clkdm_clk_hwmod_disable+0xc4/0xd8()
[   37.235504] Modules linked in:
[   37.235565] [<c001c1cc>] (unwind_backtrace+0x0/0xf0) from [<c00435f8>] (warn_slowpath_common+0x4c/0x64)
[   37.235565] [<c00435f8>] (warn_slowpath_common+0x4c/0x64) from [<c004362c>] (warn_slowpath_null+0x1c/0x24)
[   37.235595] [<c004362c>] (warn_slowpath_null+0x1c/0x24) from [<c003697c>] (_clkdm_clk_hwmod_disable+0xc4/0xd8)
[   37.235626] [<c003697c>] (_clkdm_clk_hwmod_disable+0xc4/0xd8) from [<c0437d1c>] (__clk_disable+0x70/0xa8)
[   37.235656] [<c0437d1c>] (__clk_disable+0x70/0xa8) from [<c0437d74>] (clk_disable+0x20/0x34)
[   37.235687] [<c0437d74>] (clk_disable+0x20/0x34) from [<c002a330>] (_disable_clocks+0x18/0x68)
[   37.235717] [<c002a330>] (_disable_clocks+0x18/0x68) from [<c002b09c>] (_idle+0xf8/0x1b4)
[   37.235717] [<c002b09c>] (_idle+0xf8/0x1b4) from [<c002bf08>] (omap_hwmod_idle+0x24/0x40)
[   37.235748] [<c002bf08>] (omap_hwmod_idle+0x24/0x40) from [<c002ce34>] (omap_device_idle_hwmods+0x24/0x3c)
[   37.235778] [<c002ce34>] (omap_device_idle_hwmods+0x24/0x3c) from [<c002d024>] (_omap_device_deactivate+0x9c/0x138)
[   37.235778] [<c002d024>] (_omap_device_deactivate+0x9c/0x138) from [<c002d984>] (omap_device_idle+0x28/0x54)
[   37.235809] [<c002d984>] (omap_device_idle+0x28/0x54) from [<c002da48>] (_od_suspend_noirq+0x74/0x7c)
[   37.235839] [<c002da48>] (_od_suspend_noirq+0x74/0x7c) from [<c034cbec>] (dpm_run_callback.clone.9+0x30/0xb4)
[   37.235870] [<c034cbec>] (dpm_run_callback.clone.9+0x30/0xb4) from [<c034d440>] (dpm_suspend_end+0x364/0x554)
[   37.235870] [<c034d440>] (dpm_suspend_end+0x364/0x554) from [<c0084ec0>] (suspend_devices_and_enter+0xbc/0x2d0)
[   37.235900] [<c0084ec0>] (suspend_devices_and_enter+0xbc/0x2d0) from [<c0085260>] (pm_suspend+0x18c/0x208)
[   37.235931] [<c0085260>] (pm_suspend+0x18c/0x208) from [<c00844f4>] (state_store+0x120/0x134)
[   37.235961] [<c00844f4>] (state_store+0x120/0x134) from [<c02d29b8>] (kobj_attr_store+0x14/0x20)
[   37.235992] [<c02d29b8>] (kobj_attr_store+0x14/0x20) from [<c017a630>] (sysfs_write_file+0x100/0x184)
[   37.236022] [<c017a630>] (sysfs_write_file+0x100/0x184) from [<c0116630>] (vfs_write+0xb4/0x148)
[   37.236022] [<c0116630>] (vfs_write+0xb4/0x148) from [<c01168b4>] (sys_write+0x40/0x6c)
[   37.236053] [<c01168b4>] (sys_write+0x40/0x6c) from [<c0013ee0>] (ret_fast_syscall+0x0/0x3c)
[   37.236083] ---[ end trace 86835b3ee8ec9dde ]---
[   37.236083] ------------[ cut here ]------------
[   37.236114] WARNING: at arch/arm/mach-omap2/clockdomain.c:961 _clkdm_clk_hwmod_disable+0xc4/0xd8()
[   37.236145] Modules linked in:
[   37.236175] [<c001c1cc>] (unwind_backtrace+0x0/0xf0) from [<c00435f8>] (warn_slowpath_common+0x4c/0x64)
[   37.236175] [<c00435f8>] (warn_slowpath_common+0x4c/0x64) from [<c004362c>] (warn_slowpath_null+0x1c/0x24)
[   37.236206] [<c004362c>] (warn_slowpath_null+0x1c/0x24) from [<c003697c>] (_clkdm_clk_hwmod_disable+0xc4/0xd8)
[   37.236236] [<c003697c>] (_clkdm_clk_hwmod_disable+0xc4/0xd8) from [<c0437d1c>] (__clk_disable+0x70/0xa8)
[   37.236267] [<c0437d1c>] (__clk_disable+0x70/0xa8) from [<c0437d74>] (clk_disable+0x20/0x34)
[   37.236267] [<c0437d74>] (clk_disable+0x20/0x34) from [<c002a330>] (_disable_clocks+0x18/0x68)
[   37.236297] [<c002a330>] (_disable_clocks+0x18/0x68) from [<c002b09c>] (_idle+0xf8/0x1b4)
[   37.236328] [<c002b09c>] (_idle+0xf8/0x1b4) from [<c002bf08>] (omap_hwmod_idle+0x24/0x40)
[   37.236328] [<c002bf08>] (omap_hwmod_idle+0x24/0x40) from [<c002ce34>] (omap_device_idle_hwmods+0x24/0x3c)
[   37.236358] [<c002ce34>] (omap_device_idle_hwmods+0x24/0x3c) from [<c002d024>] (_omap_device_deactivate+0x9c/0x138)
[   37.236389] [<c002d024>] (_omap_device_deactivate+0x9c/0x138) from [<c002d984>] (omap_device_idle+0x28/0x54)
[   37.236389] [<c002d984>] (omap_device_idle+0x28/0x54) from [<c002da48>] (_od_suspend_noirq+0x74/0x7c)
[   37.236419] [<c002da48>] (_od_suspend_noirq+0x74/0x7c) from [<c034cbec>] (dpm_run_callback.clone.9+0x30/0xb4)
[   37.236450] [<c034cbec>] (dpm_run_callback.clone.9+0x30/0xb4) from [<c034d440>] (dpm_suspend_end+0x364/0x554)
[   37.236450] [<c034d440>] (dpm_suspend_end+0x364/0x554) from [<c0084ec0>] (suspend_devices_and_enter+0xbc/0x2d0)
[   37.236480] [<c0084ec0>] (suspend_devices_and_enter+0xbc/0x2d0) from [<c0085260>] (pm_suspend+0x18c/0x208)
[   37.236511] [<c0085260>] (pm_suspend+0x18c/0x208) from [<c00844f4>] (state_store+0x120/0x134)
[   37.236541] [<c00844f4>] (state_store+0x120/0x134) from [<c02d29b8>] (kobj_attr_store+0x14/0x20)
[   37.236541] [<c02d29b8>] (kobj_attr_store+0x14/0x20) from [<c017a630>] (sysfs_write_file+0x100/0x184)
[   37.236572] [<c017a630>] (sysfs_write_file+0x100/0x184) from [<c0116630>] (vfs_write+0xb4/0x148)
[   37.236602] [<c0116630>] (vfs_write+0xb4/0x148) from [<c01168b4>] (sys_write+0x40/0x6c)
[   37.236602] [<c01168b4>] (sys_write+0x40/0x6c) from [<c0013ee0>] (ret_fast_syscall+0x0/0x3c)
[   37.236633] ---[ end trace 86835b3ee8ec9ddf ]---
[   37.237213] PM: noirq suspend of devices complete after 9.124 msecs
[   37.237304] Disabling non-boot CPUs ...
[   37.237792] Successfully put all powerdomains to target state
[   37.242034] PM: noirq resume of devices complete after 3.967 msecs
[   37.247161] PM: early resume of devices complete after 3.570 msecs
[   37.536956] PM: resume of devices complete after 289.550 msecs
[   37.815185] Restarting tasks ... done.
root@beagleboard:~# 
