From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: 3.5-rc3: PM/DSS broken (was vdd_mpu_iva warnings)
Date: Tue, 03 Jul 2012 09:37:59 +0100
Message-ID: <WC20120703083759.980337@terrafix.co.uk>
References: <WC20120618103957.6103F2@terrafix.co.uk> <87zk7h5096.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:55975 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750783Ab2GCIiU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jul 2012 04:38:20 -0400
In-Reply-To: <87zk7h5096.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, tomi.valkeinen@ti.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

-----Original Message-----
From: Kevin Hilman <khilman@ti.com>
To: "Joe Woodward" <jw@terrafix.co.uk>
Cc: "linux-omap\@vger.kernel.org" <linux-omap@vger.kernel.org>
Date: Mon, 02 Jul 2012 14:19:49 -0700
Subject: Re: 3.5-rc3: vdd_mpu_iva warnings

> "Joe Woodward" <jw@terrafix.co.uk> writes:
> 
> > I have a GUMSTIX Overo AirSTORM module (AM3703-based).
> >
> > When booting the kernel the following features are listed:
> > OMAP3630 ES1.2 (l2cache neon isp 192mhz_clk )
> >
> > After booting I get the following (repeating every few seconds):
> >
> > [   81.122558] voltdm_scale: No voltage scale API registered for
> vdd_mpu_iva
> > [   81.130340] platform mpu.0: omap_target: unable to scale voltage
> up.
> >
> 
> BTW, after boot, can you run the shell snippet below.  This should run
> the board through MPU DVFS for all the available OPPs:
> 
> Thanks,
> 
> Kevin
> 

First, apologies...

I had added a GPIO control to board-overo.c, and after cleaning and
starting again I realised that in the process I had deleted an
important line.

So, the warnings I posted are not present (i.e. the power domains
do get registered), sorry for the noise!

But, I still have problems with 3.5-rc5 with system suspend and DSS.

I've started again with a completely clean area, built using
omap2plus_defconfig with the following changes (DSS built-in, and
use of devtmpfs and SquashFS):
CONFIG_OMAP2_DSS=y
CONFIG_OMAP2_VRAM_SIZE=4
CONFIG_FB_OMAP2=y

CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_SQUASHFS=y

I also modified board-overo.c to switch from DVI to LCD as the default device:
static struct omap_dss_board_info overo_dss_data = {
	.num_devices	= ARRAY_SIZE(overo_dss_devices),
	.devices	= overo_dss_devices,
//	.default_device	= &overo_dvi_device,
	.default_device	= &overo_lcd43_device,
};

And when suspending I get:

# echo mem > /sys/power/state
[   20.138214] PM: Syncing filesystems ... done.
[   20.158477] Freezing user space processes ... (elapsed 0.01 seconds) done.
[   20.184509] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
[   20.215698] Suspending console(s) (use no_console_suspend to debug)
[   20.804626] Modules linked in:
[   20.401611] PM: suspend of devices complete after 175.963 msecs
[   20.404388] PM: late suspend of devices complete after 2.777 msecs
[   20.409301] PM: noirq suspend of devices complete after 4.882 msecs
[   20.409362] Disabling non-boot CPUs ...
[   20.428527] Powerdomain (core_pwrdm) didn't enter target state 1
[   20.428558] Could not enter target state in pm_suspend
[   20.431060] PM: noirq resume of devices complete after 2.319 msecs
[   20.434173] PM: early resume of devices complete after 1.739 msecs
[   20.803344] mmc1: error -110 during resume (card was removed?)
[   20.804595] ------------[ cut here ]------------
[   20.804626] WARNING: at drivers/video/omap2/dss/dispc.c:376 dispc_runtime_get+0x50/0x64()
[   20.804687] [<c001b61c>] (unwind_backtrace+0x0/0xf0) from [<c00401fc>] (warn_slowpath_common+0x4c/0x64)
[   20.804718] [<c00401fc>] (warn_slowpath_common+0x4c/0x64) from [<c0040230>] (warn_slowpath_null+0x1c/0x24)
[   20.804718] [<c0040230>] (warn_slowpath_null+0x1c/0x24) from [<c02a72d4>] (dispc_runtime_get+0x50/0x64)
[   20.804748] [<c02a72d4>] (dispc_runtime_get+0x50/0x64) from [<c02b2d80>] (omapdss_dpi_display_enable+0x48/0x230)
[   20.804779] [<c02b2d80>] (omapdss_dpi_display_enable+0x48/0x230) from [<c02c9a28>] (generic_dpi_panel_power_on+0x2c/0x78)
[   20.804779] [<c02c9a28>] (generic_dpi_panel_power_on+0x2c/0x78) from [<c02c9a80>] (generic_dpi_panel_resume+0xc/0x1c)
[   20.804809] [<c02c9a80>] (generic_dpi_panel_resume+0xc/0x1c) from [<c02ae28c>] (dss_resume_device+0x28/0x40)
[   20.804840] [<c02ae28c>] (dss_resume_device+0x28/0x40) from [<c02fc848>] (bus_for_each_dev+0x50/0x7c)
[   20.804870] [<c02fc848>] (bus_for_each_dev+0x50/0x7c) from [<c02ff530>] (platform_pm_resume+0x2c/0x50)
[   20.804901] [<c02ff530>] (platform_pm_resume+0x2c/0x50) from [<c0303aa4>] (dpm_run_callback.clone.7+0x30/0xb0)
[   20.804901] [<c0303aa4>] (dpm_run_callback.clone.7+0x30/0xb0) from [<c0304828>] (device_resume+0xc8/0x188)
[   20.804931] [<c0304828>] (device_resume+0xc8/0x188) from [<c0304c50>] (dpm_resume+0xfc/0x21c)
[   20.804962] [<c0304c50>] (dpm_resume+0xfc/0x21c) from [<c0304f04>] (dpm_resume_end+0xc/0x18)
[   20.804962] [<c0304f04>] (dpm_resume_end+0xc/0x18) from [<c007ffe4>] (suspend_devices_and_enter+0x15c/0x2d0)
[   20.804992] [<c007ffe4>] (suspend_devices_and_enter+0x15c/0x2d0) from [<c00802e4>] (pm_suspend+0x18c/0x208)
[   20.805023] [<c00802e4>] (pm_suspend+0x18c/0x208) from [<c007f588>] (state_store+0x120/0x134)
[   20.805053] [<c007f588>] (state_store+0x120/0x134) from [<c026800c>] (kobj_attr_store+0x14/0x20)
[   20.805053] [<c026800c>] (kobj_attr_store+0x14/0x20) from [<c0169ff4>] (sysfs_write_file+0x100/0x184)
[   20.805084] [<c0169ff4>] (sysfs_write_file+0x100/0x184) from [<c01093fc>] (vfs_write+0xb4/0x148)
[   20.805114] [<c01093fc>] (vfs_write+0xb4/0x148) from [<c0109684>] (sys_write+0x40/0x70)
[   20.805145] [<c0109684>] (sys_write+0x40/0x70) from [<c0013d60>] (ret_fast_syscall+0x0/0x3c)
[   20.805145] ---[ end trace c7f1420c2bbb60a2 ]---
[   20.805511] dpm_run_callback(): platform_pm_resume+0x0/0x50 returns -13
[   20.805541] PM: Device omapdss failed to resume: error -13
[   20.857238] PM: resume of devices complete after 422.943 msecs
[   21.162658] Restarting tasks ... done.
sh: write error: Operation not permitted

This returns immediately.

Any ideas?

Cheers,
Joe Woodward


