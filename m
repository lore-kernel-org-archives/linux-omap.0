From: Daniel Mack <zonque@gmail.com>
Subject: Re: [RFC 00/15] Add basic suspend-resume support for AM33XX
Date: Fri, 02 Nov 2012 23:16:53 +0100
Message-ID: <50944655.20602@gmail.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44705 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199Ab2KBWRA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Nov 2012 18:17:00 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1517406bkc.19
        for <linux-omap@vger.kernel.org>; Fri, 02 Nov 2012 15:16:58 -0700 (PDT)
In-Reply-To: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, paul@pwsan.com, b-cousson@ti.com

On 02.11.2012 13:32, Vaibhav Bedia wrote:
> This patch series adds support for suspend-resume on AM33XX.

Thanks a lot for working on this!

[...]

> [root@arago /]# echo 1 > ./sys/devices/ocp.2/wkup_m3.4/firmware/am335x-pm-firmware.bin/loading
> [root@arago /]# cat binary_blob > ./sys/devices/ocp.2/wkup_m3.4/firmware/am335x-pm-firmware.bin/data
> [root@arago /]# echo 0 > ./sys/devices/ocp.2/wkup_m3.4/firmware/am335x-pm-firmware.bin/loading
> [   28.770356] Copied the M3 firmware to UMEM
> [   28.778178] omap_hwmod: wkup_m3: _wait_target_disable failed
> [root@arago /]# echo mem > /sys/power/state
> [   32.959753] PM: Syncing filesystems ... done.
> [   32.988434] Freezing user space processes ... (elapsed 0.02 seconds) done.
> [   33.016120] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
> [   33.047607] Suspending console(s) (use no_console_suspend to debug)
> [   33.070420] PM: suspend of devices complete after 11.538 msecs
> [   33.074095] PM: late suspend of devices complete after 3.651 msecs
> [   33.079135] PM: noirq suspend of devices complete after 5.011 msecs
> [   33.079196] Disabling non-boot CPUs ...
> [   33.083923] GFX domain entered low power state
> [   33.083973] Successfully transitioned to low power state
> [   33.087132] PM: noirq resume of devices complete after 2.663 msecs
> [   33.090629] PM: early resume of devices complete after 2.346 msecs
> [   33.097607] PM: resume of devices complete after 6.951 msecs
> [   33.155869] Restarting tasks ... done.
> [root@arago /]#
> 
> All the patches have been run through checkpatch and i have also
> tried a few OMAP build configs that Paul uses to ensure that these
> patches do not introduce any new build warnings/errors for the OMAP
> family.
> 
> A few TODOs
> 0. Test all the patches on OMAP platforms like BeagleBoard

I'm testing this on a custom AM33xx board, and with
"no_console_suspend", I get the following:

# echo mem >/sys/power/state
[   27.306144] PM: Syncing filesystems ... done.
[   27.335524] Freezing user space processes ... (elapsed 0.01 seconds)
done.
[   27.361603] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[   27.408269] ------------[ cut here ]------------
[   27.413147] WARNING: at drivers/net/ethernet/ti/cpsw.c:298
cpsw_rx_handler+0xbd/0xdc()
[   27.421438] Modules linked in: ipv6
[   27.425158] [<c0010d85>] (unwind_backtrace+0x1/0x9c) from
[<c0319f77>] (dump_stack+0xb/0xc)
[   27.433932] [<c0319f77>] (dump_stack+0xb/0xc) from [<c00266a3>]
(warn_slowpath_common+0x33/0x48)
[   27.443149] [<c00266a3>] (warn_slowpath_common+0x33/0x48) from
[<c00266c9>] (warn_slowpath_null+0x11/0x14)
[   27.453273] [<c00266c9>] (warn_slowpath_null+0x11/0x14) from
[<c020f4b9>] (cpsw_rx_handler+0xbd/0xdc)
[   27.462943] [<c020f4b9>] (cpsw_rx_handler+0xbd/0xdc) from
[<c020d773>] (__cpdma_chan_free+0x83/0x90)
[   27.472519] [<c020d773>] (__cpdma_chan_free+0x83/0x90) from
[<c020d815>] (__cpdma_chan_process+0x95/0xb8)
[   27.482550] [<c020d815>] (__cpdma_chan_process+0x95/0xb8) from
[<c020d8ff>] (cpdma_chan_stop+0x93/0x110)
[   27.492490] [<c020d8ff>] (cpdma_chan_stop+0x93/0x110) from
[<c020d9ab>] (cpdma_ctlr_stop+0x2f/0x6c)
[   27.501975] [<c020d9ab>] (cpdma_ctlr_stop+0x2f/0x6c) from
[<c020f033>] (cpsw_ndo_stop+0x2b/0x128)
[   27.511278] [<c020f033>] (cpsw_ndo_stop+0x2b/0x128) from [<c020f145>]
(cpsw_suspend+0x15/0x20)
[   27.520311] [<c020f145>] (cpsw_suspend+0x15/0x20) from [<c01cce83>]
(platform_pm_suspend+0x13/0x28)
[   27.529809] [<c01cce83>] (platform_pm_suspend+0x13/0x28) from
[<c01cfb8b>] (dpm_run_callback.clone.6+0x1f/0x78)
[   27.540390] [<c01cfb8b>] (dpm_run_callback.clone.6+0x1f/0x78) from
[<c01d0337>] (__device_suspend+0xb3/0x168)
[   27.550789] [<c01d0337>] (__device_suspend+0xb3/0x168) from
[<c01d0a3d>] (dpm_suspend+0x45/0x178)
[   27.560095] [<c01d0a3d>] (dpm_suspend+0x45/0x178) from [<c01d0d15>]
(dpm_suspend_start+0x39/0x44)
[   27.569404] [<c01d0d15>] (dpm_suspend_start+0x39/0x44) from
[<c0046fdd>] (suspend_devices_and_enter+0x31/0x148)
[   27.579981] [<c0046fdd>] (suspend_devices_and_enter+0x31/0x148) from
[<c0047203>] (pm_suspend+0x10f/0x170)
[   27.590103] [<c0047203>] (pm_suspend+0x10f/0x170) from [<c004693f>]
(state_store+0x43/0x7c)
[   27.598870] [<c004693f>] (state_store+0x43/0x7c) from [<c019500d>]
(kobj_attr_store+0x9/0x10)
[   27.607828] [<c019500d>] (kobj_attr_store+0x9/0x10) from [<c00cdb2d>]
(sysfs_write_file+0xb5/0x104)
[   27.617319] [<c00cdb2d>] (sysfs_write_file+0xb5/0x104) from
[<c008cb5b>] (vfs_write+0x77/0x110)
[   27.626442] [<c008cb5b>] (vfs_write+0x77/0x110) from [<c008cd75>]
(sys_write+0x2d/0x48)
[   27.634844] [<c008cd75>] (sys_write+0x2d/0x48) from [<c000cfc1>]
(ret_fast_syscall+0x1/0x50)
[   27.643683] ---[ end trace f2a0c58ea7742606 ]---
[   27.650834] PM: suspend of devices complete after 253.597 msecs
[   27.660392] PM: late suspend of devices complete after 3.253 msecs
[   27.674504] omap_hwmod: cpgmac0: _wait_target_disable failed

And the power consumption does not drop noticable at this point.

What event did you use to bring the system back to life? I tried a GPIO
button which has "linux,wakeup" set and is connected to GPIO bank 0, but
without success.


Thanks,
Daniel

