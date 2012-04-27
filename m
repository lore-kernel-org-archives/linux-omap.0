From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 03/12] arm: omap3: Only sleep in cpuidle driver if I/O wake-ups work
Date: Fri, 27 Apr 2012 14:12:12 -0700
Message-ID: <87haw4282b.fsf@ti.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
	<1334171147-7517-4-git-send-email-mgreer@animalcreek.com>
	<alpine.DEB.2.00.1204111532280.29473@utopia.booyaka.com>
	<20120424205105.GA26749@animalcreek.com>
	<20120424232506.GA8850@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:40245 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753090Ab2D0VMM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 17:12:12 -0400
Received: by dakh32 with SMTP id h32so1490887dak.23
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 14:12:11 -0700 (PDT)
In-Reply-To: <20120424232506.GA8850@animalcreek.com> (Mark A. Greer's message
	of "Tue, 24 Apr 2012 16:25:06 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> On Tue, Apr 24, 2012 at 01:51:05PM -0700, Mark A. Greer wrote:
>> On Wed, Apr 11, 2012 at 03:37:47PM -0600, Paul Walmsley wrote:
>> > Hi
>> 
>> Hi Paul, Kevin.
>> 
>> > On Wed, 11 Apr 2012, Mark A. Greer wrote:
>> > 
>> > > From: "Mark A. Greer" <mgreer@animalcreek.com>
>> > > 
>> > > Currently, the OMAP3 cpuidle driver calls omap3_enter_idle()
>> > > which calls omap_sram_idle().  omap_sram_idle() eventually
>> > > causes a 'wfi' instruction to be executed effectively putting
>> > > the system to sleep.  It is assumed that an I/O wake-up event
>> > > will occur to wake the system up again.  This doesn't work on
>> > > systems that don't support I/O wake-ups (indicated by
>> > > omap3_has_io_wakeup() returning false).
>> > > 
>> > > To handle this, follow the same path in omap3_enter_idle()
>> > > that would be followed if an interrupt were pending.
>> > 
>> > I don't quite understand this patch.  Are you saying that AM3517/3505 
>> > can't wake from WFI?  That would seem odd.
>> > 
>> > There are other sources of wakeup on the system other than I/O wakeup.  
>> > I/O wakeup only applies to wakeups from the I/O pads when the chip is in 
>> > RETENTION or OFF.  And as I understand it, neither of those apply to 
>> > AM3517/3505?
>> > 
>> > Even if I/O wakeups aren't supported, many of the IP blocks on the system 
>> > should be able to cause the ARM to exit WFI by asserting their 
>> > SWAKEUP lines and raising their interrupt lines.
>> 
>> I have changed the code to keep everything in the ON state and use
>> cpu_do_idle()--basically a wfi, cpu_v7_do_idle() in this case--and everything
>> works well (except networking, see below) when using an mmc-based rootfs.
>> 
>> The issue is with the emac--it can't wake the system up unless there
>> is an irq from the PHY to a wakeup-enabled GPIO (confirmed by h/w engr).
>> So, when using networking or using an nfs-based rootfs, there are all
>> kinds of timeouts, etc.  Basically, doing a wfi (i.e., pm_idle or cpuidle)
>> and expecting the emac to wake the system back up won't work.
>> 
>> How would you like me to proceed (to avoid the wfi in pm_idle & cpuidle)?
>
> Just thinking out loud...
>
> We could chose whether pm_idle & cpuidle issue a wfi based on
> whether there is a davinci-emac present.  The issue with that is
> that someday there may be another SoC that has a davinci-emac that
> can wake up the system.  I know cpu_is_xxx() is frowned upon but
> this does seem like a proper usage of it--the deciding factor
> really is whether its an am35x or not (and CONFIG_TI_DAVINCI_EMAC
> is enabled).

The presence of the davinci_emac is probably overkill, avoiding WFI
should really only be done when the davinci_emac is *active*.
e.g. using an am35x with an EMAC *present*, but not in use because
there's an MMC rootfs for example.

If there's a good way to detect an in-use davinci_emac, then
disable_hlt() can be used to avoid WFI.  When the davinci_emac is not in
use (e.g. module unloaded etc.) then enable_hlt() can be used to
(re)allow WFI.

Kevin


