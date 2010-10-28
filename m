From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: OMAP3 low power mode broken on l-o
Date: Thu, 28 Oct 2010 22:40:43 +0200
Message-ID: <AANLkTikzVLW08MrZUPWmVx6+w4E8sXN5NHwM1R7Ya8zX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44265 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933791Ab0J1Ukn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Oct 2010 16:40:43 -0400
Received: by qyk12 with SMTP id 12so5876520qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Oct 2010 13:40:43 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Hi,

The low power mode on the latest l-o master branch is broken, so I
investigated a bit. Here are the results. This has been tested on
OMAP3EVM and Beagleboard.

The problem is that the CORE does not reach the desired mode (RET,
OFF). It is caused by the I2C1 fclk that is left enabled at suspend
time.
Extra printks has been added in the clock enable and disable functions
for I2C and a stack dump has been added in the suspend path if the
clock is still enabled, cf. log below.

In the devices suspend sequence the RTC gets suspended, which triggers
a read of the TWL RTC through the I2C bus, which in turn enables the
I2C1 fclk. That clock is only disabled on devices resume.

I am guessing this is linked to the recent changes in the I2C for HWMOD support.
What is the correct fix to have the I2C modules correctly shut off
before the suspend?

Any thoughts?

Regards,
Jean

=== Boot messages ===
...
[    2.284698] regulator_init_complete: incomplete constraints, leaving VMMC1 on
[    2.292724] *** Enable clock i2c1_fck
[    2.296875] *** Disable clock i2c1_fck
[    2.300964] *** Enable clock i2c1_fck
[    2.305206] *** Disable clock i2c1_fck
[    2.309204] *** Enable clock i2c1_fck
[    2.313537] *** Disable clock i2c1_fck
[    2.317535] twl_rtc twl_rtc: setting system clock to 2000-01-01
02:12:33 UTC (946692753)
[    2.330841] Freeing init memory: 2296K

Please press Enter to activate this console.
/ #

=== Suspend messages ===

/ # echo mem > /sys/power/state
[   11.517578] PM: Syncing filesystems ... done.
[   11.529693] Freezing user space processes ... (elapsed 0.02 seconds) done.
[   11.557861] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[   11.590728] Suspending console(s) (use no_console_suspend to debug)
[   11.602478] *** Enable clock i2c1_fck
[   11.602539] [<c024d478>] (unwind_backtrace+0x0/0xe4) from
[<c0260548>] (clk_enable+0x7c/0xac)
[   11.602569] [<c0260548>] (clk_enable+0x7c/0xac) from [<c0256b58>]
(_enable_clocks+0x18/0x68)
[   11.602630] [<c0256b58>] (_enable_clocks+0x18/0x68) from
[<c0257798>] (_omap_hwmod_enable+0x78/0x)
[   11.602661] [<c0257798>] (_omap_hwmod_enable+0x78/0x150) from
[<c0257898>] (omap_hwmod_enable+0x2)
[   11.602691] [<c0257898>] (omap_hwmod_enable+0x28/0x3c) from
[<c0264ad0>] (omap_device_enable_hwmo)
[   11.602722] [<c0264ad0>] (omap_device_enable_hwmods+0x1c/0x34) from
[<c0264c7c>] (_omap_device_ac)
[   11.602752] [<c0264c7c>] (_omap_device_activate+0x5c/0xf0) from
[<c0264e10>] (omap_device_enable+)
[   11.602813] [<c0264e10>] (omap_device_enable+0x54/0x80) from
[<c0258c88>] (omap_pm_runtime_resume)
[   11.602844] [<c0258c88>] (omap_pm_runtime_resume+0x20/0x48) from
[<c04897c0>] (__pm_runtime_resum)
[   11.602874] [<c04897c0>] (__pm_runtime_resume+0x240/0x30c) from
[<c0489904>] (pm_runtime_resume+0)
[   11.602935] [<c0489904>] (pm_runtime_resume+0x20/0x34) from
[<c05129a4>] (omap_i2c_unidle+0x2c/0x)
[   11.602966] [<c05129a4>] (omap_i2c_unidle+0x2c/0x17c) from
[<c0513030>] (omap_i2c_xfer+0x20/0x324)
[   11.602996] [<c0513030>] (omap_i2c_xfer+0x20/0x324) from
[<c0511070>] (i2c_transfer+0xc4/0x114)
[   11.603027] [<c0511070>] (i2c_transfer+0xc4/0x114) from
[<c048fd74>] (twl_i2c_read+0xe0/0x12c)
[   11.603057] [<c048fd74>] (twl_i2c_read+0xe0/0x12c) from
[<c050f8dc>] (twl_rtc_read_u8+0x24/0x4c)
[   11.603088] [<c050f8dc>] (twl_rtc_read_u8+0x24/0x4c) from
[<c050fa00>] (twl_rtc_read_time+0x18/0x)
[   11.603118] [<c050fa00>] (twl_rtc_read_time+0x18/0xd4) from
[<c050e4e0>] (rtc_read_time+0x64/0x78)
[   11.603179] [<c050e4e0>] (rtc_read_time+0x64/0x78) from
[<c050daf8>] (rtc_suspend+0x44/0x8c)
[   11.603210] [<c050daf8>] (rtc_suspend+0x44/0x8c) from [<c04879d4>]
(legacy_suspend+0x2c/0x64)
[   11.603240] [<c04879d4>] (legacy_suspend+0x2c/0x64) from
[<c0488200>] (__device_suspend+0x7c/0x12)
[   11.603271] [<c0488200>] (__device_suspend+0x7c/0x12c) from
[<c04885d0>] (dpm_suspend_start+0x320)
[   11.603302] [<c04885d0>] (dpm_suspend_start+0x320/0x458) from
[<c02bee48>] (suspend_devices_and_e)
[   11.603332] [<c02bee48>] (suspend_devices_and_enter+0x48/0x200)
from [<c02bf0bc>] (enter_state+0x)
[   11.603363] [<c02bf0bc>] (enter_state+0xbc/0x120) from [<c02be7bc>]
(state_store+0xa4/0xb8)
[   11.603424] [<c02be7bc>] (state_store+0xa4/0xb8) from [<c0429c24>]
(kobj_attr_store+0x18/0x1c)
[   11.603454] [<c0429c24>] (kobj_attr_store+0x18/0x1c) from
[<c035f778>] (sysfs_write_file+0x10c/0x)
[   11.603485] [<c035f778>] (sysfs_write_file+0x10c/0x144) from
[<c03109c8>] (vfs_write+0xb0/0x128)
[   11.603515] [<c03109c8>] (vfs_write+0xb0/0x128) from [<c0310af0>]
(sys_write+0x3c/0x68)
[   11.603576] [<c0310af0>] (sys_write+0x3c/0x68) from [<c0246ac0>]
(ret_fast_syscall+0x0/0x3c)
[   11.611358] PM: suspend of devices complete after 9.674 msecs
[   11.613006] PM: late suspend of devices complete after 1.647 msecs
[   11.613098] Disabling non-boot CPUs ...
[   12.764709] Powerdomain (core_pwrdm) didn't enter target state 1
[   12.764739] Could not enter target state in pm_suspend
[   12.765075] PM: early resume of devices complete after 0.152 msecs
[   12.771789] PM: resume of devices complete after 6.317 msecs
[   12.775695] *** Disable clock i2c1_fck
[   13.100555] *** Enable clock i2c1_fck
[   13.105010] *** Disable clock i2c1_fck
[   13.109222] *** Enable clock i2c1_fck
[   13.113403] *** Disable clock i2c1_fck
[   13.118469] Restarting tasks ... done.
/ #
