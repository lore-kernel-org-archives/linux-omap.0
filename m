From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Thu, 12 Jul 2012 11:25:37 -0700
Message-ID: <87mx34et0e.fsf@ti.com>
References: <WC20120712081507.600002@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:51761 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751112Ab2GLSZj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jul 2012 14:25:39 -0400
Received: by yhr47 with SMTP id 47so3510508yhr.14
        for <linux-omap@vger.kernel.org>; Thu, 12 Jul 2012 11:25:36 -0700 (PDT)
In-Reply-To: <WC20120712081507.600002@terrafix.co.uk> (Joe Woodward's message
	of "Thu, 12 Jul 2012 09:15:07 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Joe Woodward" <jw@terrafix.co.uk> writes:

> ...snip...
>> > Hmm, interesting, I don't see this on my 3730-based Over FireSTORM.
>> >
>> > But, after "converting" mine into an AirStorm[1], I see the same
>> errors
>> > as you're seeing.  We're obviously doing something wrong when IVA
>> and/or
>> > SGX are not present, so I will look into it.
>> 
>> With the hack below on top of my pm branch, can you try to
>> suspend/resume on your AirSTORM?
>> 
>> You'll get a bunch of noise from the clockdomain code becasue of the
>> missing power domains, but you can ignore them.  
>> 
>> I'm hoping this will fix your issue.  Obviously, this hack is not a
>> real
>> fix but just a test to see if the problem is where I think it is.  If
>> so, then I know the right solution and it's been discussed before but
>> never been a priority (at least for me) to fix.
>> 
>> Basically, we still need to fix up the registration of certain hwmods
>> and powerdomains based on whether or not certain IPs exist or not.  We
>> currently are rather blindly registering the hwmods for IVA, GFX etc.
>> 
>> Kevin
>> 
>
> After applying the patch (and also your GPIO fix for the ads7846).
>
> As you said, when booting lots of warnings are spat out:
>
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: at arch/arm/mach-omap2/clockdomain.c:237 _resolve_clkdm_deps.clone.0+0x98/0x108()
> [    0.000000] Modules linked in:
> [    0.000000]
> [    0.000000] [<c001b75c>] (unwind_backtrace+0x0/0xf0) from [<c0041788>] (warn_slowpath_common+0x4c/0x64)
> [    0.000000] [<c0041788>] (warn_slowpath_common+0x4c/0x64) from [<c0041834>] (warn_slowpath_fmt+0x30/0x40)
> [    0.000000] [<c0041834>] (warn_slowpath_fmt+0x30/0x40) from [<c00321a0>] (_resolve_clkdm_deps.clone.0+0x98/0x108)
> [    0.000000] [<c00321a0>] (_resolve_clkdm_deps.clone.0+0x98/0x108) from [<c0032bb8>] (clkdm_complete_init+0x3c/0xa0)
> [    0.000000] [<c0032bb8>] (clkdm_complete_init+0x3c/0xa0) from [<c06d2458>] (omap3_init_early+0x20/0x30)
> [    0.000000] [<c06d2458>] (omap3_init_early+0x20/0x30) from [<c06ce1a8>] (setup_arch+0x814/0x934)
> [    0.000000] [<c06ce1a8>] (setup_arch+0x814/0x934) from [<c06ca584>] (start_kernel+0x88/0x300)
> [    0.000000] [<c06ca584>] (start_kernel+0x88/0x300) from [<80008044>] (0x80008044)
> [    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
>
> And now when suspending I get:
>
> # echo mem > /sys/power/state
> [   78.174713] PM: Syncing filesystems ... done.
> [   78.190582] Freezing user space processes ... (elapsed 0.01 seconds) done.
> [   78.216430] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
> [   78.247558] Suspending console(s) (use no_console_suspend to debug)
> [   78.379241] PM: suspend of devices complete after 120.605 msecs
> [   78.382934] PM: late suspend of devices complete after 3.692 msecs
> [   78.388671] PM: noirq suspend of devices complete after 5.706 msecs
> [   78.388732] Disabling non-boot CPUs ...
> [  107.219818] Powerdomain (core_pwrdm) didn't enter target state 1
> [  107.219818] Could not enter target state in pm_suspend
> [  107.222808] PM: noirq resume of devices complete after 2.838 msecs
> [  107.226684] PM: early resume of devices complete after 2.380 msecs
> [  107.592620] mmc1: error -110 during resume (card was removed?)
> [  107.602752] PM: resume of devices complete after 375.946 msecs
> [  107.667449] Restarting tasks ... done.
> sh: write error: Operation not permitted
>
> So most of the warnings have gone, but core still fails to enter the target state.
>
> This is sitll using the omap2plus_defconfig with:
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
>
> CONFIG_DMADEVICES=y
> CONFIG_DMA_OMAP=y
>
> CONFIG_SQUASHFS=y
>
> All running from RAM-based RFS.

OK, if you're using a RAM-based rootfs, do you need DMA engine?  Can you
disable that for now?  I don't think it's related, but just want to rule
it out.

Also, (I'm shooting in the dark now), can you try a couple more things
with the hack that I sent, and send me the *full* console output of a
boot and a suspend/resume attemp:

1) use my hack as is
2) use my hack but only comment out IVA
3) use my hack but only comment out SGX

Thanks,

Kevin



