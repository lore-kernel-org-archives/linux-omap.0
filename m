From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Sun, 5 Feb 2012 12:56:26 +0000
Message-ID: <20120205125626.GA11372@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34356 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab2BEM4d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Feb 2012 07:56:33 -0500
Content-Disposition: inline
In-Reply-To: <20120204203453.GD17309@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

And here's another (set of) problem(s) on the 4430SDP board once the
previous have been worked around:

omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.                       
omap_hwmod: ipu: failed to hardreset                                            
omap_hwmod: mcpdm: cannot be enabled (3)                                        
...
machine_constraints_voltage: VUSB: failed to apply 3300000uV constraint         
...
twl_reg twl_reg.46: can't register VUSB, -22                                    
twl_reg: probe of twl_reg.46 failed with error -22                              
...
omap_vc_i2c_init: I2C config for all channels must match.
omap_vc_i2c_init: I2C config for all channels must match.
Power Management for TI OMAP4.
clock: disabling unused clocks to save power
omapfb omapfb: no driver for display: lcd
omapfb omapfb: no driver for display: lcd2
Failed to set PHY power mode to 1
omapdss HDMI error: failed to power on device
------------[ cut here ]------------
WARNING: at /home/rmk/git/linux-omap/arch/arm/mach-omap2/omap_hwmod.c:1604 _idle
+0x34/0xc8()
omap_hwmod: dss_hdmi: idle state can only be entered from enabled state
Modules linked in:
Backtrace:
[<c0017cb0>] (dump_backtrace+0x0/0x10c) from [<c02bdb98>] (dump_stack+0x18/0x1c)
 r7:df6d7d28 r6:c0023e4c r5:c034973d r4:00000644
[<c02bdb80>] (dump_stack+0x0/0x1c) from [<c003448c>] (warn_slowpath_common+0x58/0x70)
[<c0034434>] (warn_slowpath_common+0x0/0x70) from [<c0034548>] (warn_slowpath_fmt+0x38/0x40)
 r8:00000000 r7:00000000 r6:c03e0b90 r5:a0000113 r4:c03e0b90
[<c0034510>] (warn_slowpath_fmt+0x0/0x40) from [<c0023e4c>] (_idle+0x34/0xc8)
 r3:c03496af r2:c0349a89
[<c0023e18>] (_idle+0x0/0xc8) from [<c0024a0c>] (omap_hwmod_idle+0x34/0x48)
mmc0: Voltage range not supported for power class.
mmc0: power class selection to bus width 8 failed
mmc0: new high speed MMC card at address 0001
mmcblk0: mmc0:0001 SEM08G 7.39 GiB
mmcblk0boot0: mmc0:0001 SEM08G partition 1 1.00 MiB
mmcblk0boot1: mmc0:0001 SEM08G partition 2 1.00 MiB
 mmcblk0: unknown partition table
 r4:c03e0be0
[<c00249d8>] (omap_hwmod_idle+0x0/0x48) from [<c00304a8>] (omap_device_idle_hwmods+0x24/0x3c)
 r6:df51f200 r5:df51f180 r4:00000000
[<c0030484>] (omap_device_idle_hwmods+0x0/0x3c) from [<c003069c>] (_omap_device_deactivate+0x5c/0x134)
 r5:df51f200 r4:df51f180
[<c0030640>] (_omap_device_deactivate+0x0/0x134) from [<c00307c0>] (omap_device_idle+0x4c/0x60)
[<c0030774>] (omap_device_idle+0x0/0x60) from [<c00307f8>] (_od_runtime_suspend+0x24/0x2c)
 r4:00000000
[<c00307d4>] (_od_runtime_suspend+0x0/0x2c) from [<c01f6aac>] (__rpm_callback+0x60/0x88)
 r5:00000000 r4:df515408
[<c01f6a4c>] (__rpm_callback+0x0/0x88) from [<c01f7134>] (rpm_suspend+0x3dc/0x644)
 r5:00000000 r4:00000000
[<c01f6d58>] (rpm_suspend+0x0/0x644) from [<c01f841c>] (__pm_runtime_suspend+0x64/0x7c)
[<c01f83b8>] (__pm_runtime_suspend+0x0/0x7c) from [<c01f3744>] (pm_generic_runtime_idle+0x50/0x58)
 r7:c082f300 r6:00000002 r5:00000000 r4:df515408
[<c01f36f4>] (pm_generic_runtime_idle+0x0/0x58) from [<c0030060>] (_od_runtime_idle+0x10/0x14)
 r4:df515408
[<c0030050>] (_od_runtime_idle+0x0/0x14) from [<c01f6aac>] (__rpm_callback+0x60/0x88)
[<c01f6a4c>] (__rpm_callback+0x0/0x88) from [<c01f7560>] (rpm_idle+0x14c/0x180)
 r5:00000000 r4:df515408
[<c01f7414>] (rpm_idle+0x0/0x180) from [<c01f836c>] (pm_runtime_work+0x68/0xb4)
 r6:00000004 r5:df500540 r4:df515408
[<c01f8304>] (pm_runtime_work+0x0/0xb4) from [<c0049430>] (process_one_work+0x264/0x3bc)
 r4:df5154ac
[<c00491cc>] (process_one_work+0x0/0x3bc) from [<c00499b4>] (worker_thread+0x234
/0x41c)
[<c0049780>] (worker_thread+0x0/0x41c) from [<c005000c>] (kthread+0x8c/0x98)
[<c004ff80>] (kthread+0x0/0x98) from [<c0038828>] (do_exit+0x0/0x2ec)
 r7:00000013 r6:c0038828 r5:c004ff80 r4:df45feb0
---[ end trace 0614d9210f06d794 ]---

