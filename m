From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 03/12] arm: omap3: Only sleep in cpuidle driver if I/O
 wake-ups work
Date: Wed, 11 Apr 2012 16:08:35 -0700
Message-ID: <20120411230835.GG31197@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-4-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1204111532280.29473@utopia.booyaka.com>
 <20120411222313.GC31197@animalcreek.com>
 <alpine.DEB.2.00.1204111637490.29473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:41044 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515Ab2DKXh4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 19:37:56 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204111637490.29473@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: govindraj.raja@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Wed, Apr 11, 2012 at 04:47:31PM -0600, Paul Walmsley wrote:
> cc Govindraj
> 
> On Wed, 11 Apr 2012, Mark A. Greer wrote:
> 
> > On Wed, Apr 11, 2012 at 03:37:47PM -0600, Paul Walmsley wrote:
> >
> > > I don't quite understand this patch.  Are you saying that AM3517/3505 
> > > can't wake from WFI?  That would seem odd.
> > 
> > No, I'm saying that I/O doesn't seem to wake it up from the WFI.
> > I've learned to not trust the am35x TRM much so I'm pretty much
> > feeling my way along in the dark.
> 
> Hehe, no worries, just curious.
> 
> > I do know that without this patch, the system is extremely slow which I 
> > believe is from it only returning from the WFI because of a timer 
> > expiration or something like that.
> 
> How are you trying to wake it up -- from an incoming character via 
> the UART?
> 
> Does the system pause in the middle of UART transmits, or does it get the 
> transmit buffers out cleanly and just not respond promptly to incoming 
> characters?

Both cpu_idle/pm_idle thread (arch/arm/kernel/process.c:cpu_idle()) and
the cpu idle driver (arch/arm/mach-omap2/cpuidle34xx.c:omap3_enter_idle())
behave the same without the 2 patches I posted.  During boot, things
become extremely sluggish.  I took that to mean that the WFI wasn't being
woken up unless a timer expired.  I also believed that not having I/O
wake-ups would cause that so I made those patches.

There don't appear to be any missing or additional characters from the UART.
This is all during the boot-up so I'm not even trying to enter characters
via the UART.  That's all I did for "testing", if you can call it that.

For the emif4, etc. patches, I would do a suspend-to-RAM and hit a key
on the keyboard to wake it up again.  There are no dropped or added
characters in the [serial] console output.  It does complain that the
expected state wasn't entered (INACTIVE) and by looking at
/sys/kernel/debug/pm_debug/count, the CORE domain is the only one that
didn't increment its "INA" count.

> > > There are other sources of wakeup on the system other than I/O wakeup.  
> > > I/O wakeup only applies to wakeups from the I/O pads when the chip is in 
> > > RETENTION or OFF.  And as I understand it, neither of those apply to 
> > > AM3517/3505?
> > 
> > Hmm, its true that RETENTION and OFF aren't supported.  It does wake up
> > occasionally (as mentioned above) it just seems that I/O doesn't wake
> > it up.  I may be mistaken.  I'm only going from what I've seen since and
> > the TRM seems to have lots of errors so I'm not sure what to trust in it.
> 
> OK no problem, just trying to understand what's going on.  Sounds like 
> you've gotten tossed into the deep end :-)

:)

> > > Even if I/O wakeups aren't supported, many of the IP blocks on the system 
> > > should be able to cause the ARM to exit WFI by asserting their 
> > > SWAKEUP lines and raising their interrupt lines.
> > 
> > Okay, but that doesn't seem to be working.  I'll look some more to see
> > why they aren't working.
> 
> There could be a hidden dependency on I/O wakeup being present in the UART 
> driver. We've been going through some UART driver angst recently...

OK.

Mark
--
