From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Suspend/Resume questions
Date: Tue, 13 Jan 2009 14:02:38 -0800
Message-ID: <87sknmhnk1.fsf@deeprootsystems.com>
References: <1231780282.21812.194.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:56911 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbZAMWCq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 17:02:46 -0500
Received: by ug-out-1314.google.com with SMTP id 39so317035ugf.37
        for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 14:02:44 -0800 (PST)
In-Reply-To: <1231780282.21812.194.camel@blackhole> (Peter Barada's message of "Mon\, 12 Jan 2009 12\:11\:22 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Peter,

Some suggestions below...

Peter Barada <peterb@logicpd.com> writes:

> I'm using the current PM branch (2.6.28-rc8, revision 2beb9b4b) to
> investigate power consumption on an OMAP35x board (Logic's LV SOM).

First, thanks for testing the PM branch.  Much appreciated!

> When I:
>
> # mount -t vfat /dev/mmc0blkp1 /mnt/sdcard
> # echo mem > /sys/power/state
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> omapfb omapfb: timeout waiting for FRAME DONE
> mmc0: card 133b removed
> MMC: killing requests for dead queue
> cpufreq: suspend failed to assert current frequency is what timing core
> thinks it is.
> Powerdomain (iva2_pwrdm) didn't enter target state 1
> Powerdomain (core_pwrdm) didn't enter target state 1
> Powerdomain (per_pwrdm) didn't enter target state 1
> Could not enter target state in pm_suspend
> cpufreq: resume failed to assert current frequency is what timing core
> thinks it is.
>
> eth0: link down
> soc-audio soc-audio: scheduling resume work
> Restarting tasks ...
> soc-audio soc-audio: starting resume work
> soc-audio soc-audio: resume work completed
> done.
> omap3530# mmc0: new high speed SD card at address 133b
> mmcblk1: mmc0:133b SD02G 1.91 GiB 
>  mmcblk1: p1
> eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
>
> omap3530# ls -l /dev/mmcblk0*
> ls: /dev/mmcblk0*: No such file or directory
> omap3530# 
>
> 1) Is "echo mem > /sys/power/state" the proper method to put the board
> into suspend?

Yes.

> 2) Why does the MMC "move" from /dev/mmcblk0 before the suspend
> to /dev/mmcblk1 after the suspend? (If the card is not mounted, it
> doesn't "move").
>
> 3) Any ideas why the iva2, core, per power domains not change states to
> PWRDM_POWER_RET?  Any way to find out?

Unfortunately, there's currently no easy way other than looking
through the PM registers themselves.  However, in your case, I think I
know what is going on.

IVA2 is not hitting RET most likely because the bootloader powers it
on but the kernel doesn't do anything with it.  The latest PM branch
(just announced) has a patch to ensure that IVA2 is put into RET
during bootup.  Could you try it?

For CORE and PER these are likely because the UART clocks console are
keeping these domains active.  If you

# echo 1 > /sys/power/clocks_off_while_idle

then the UART clocks will be disabled in idle or suspend allowing
those domains to hit retention.

If this still isn't working, can you enable CONFIG_PM_DEBUG and
CONFIG_DEBUG_FS and send me the output of 'cat /debug/pm_debug/count'
just after bootup.

Kevin

> 4) Any suggestions on how to code the power button (attached to TWL4030
> PWRON pin) to wake it back up again?
>
> Thanks in advance!
>
> -- 
> Peter Barada <peterb@logicpd.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
