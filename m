From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 03/12] arm: omap3: Only sleep in cpuidle driver if I/O
 wake-ups work
Date: Wed, 11 Apr 2012 15:23:13 -0700
Message-ID: <20120411222313.GC31197@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-4-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1204111532280.29473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:46156 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933525Ab2DKWXO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 18:23:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204111532280.29473@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Wed, Apr 11, 2012 at 03:37:47PM -0600, Paul Walmsley wrote:
> 
> On Wed, 11 Apr 2012, Mark A. Greer wrote:
> 
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > 
> > Currently, the OMAP3 cpuidle driver calls omap3_enter_idle()
> > which calls omap_sram_idle().  omap_sram_idle() eventually
> > causes a 'wfi' instruction to be executed effectively putting
> > the system to sleep.  It is assumed that an I/O wake-up event
> > will occur to wake the system up again.  This doesn't work on
> > systems that don't support I/O wake-ups (indicated by
> > omap3_has_io_wakeup() returning false).
> > 
> > To handle this, follow the same path in omap3_enter_idle()
> > that would be followed if an interrupt were pending.
> 
> I don't quite understand this patch.  Are you saying that AM3517/3505 
> can't wake from WFI?  That would seem odd.

No, I'm saying that I/O doesn't seem to wake it up from the WFI.
I've learned to not trust the am35x TRM much so I'm pretty much
feeling my way along in the dark.  I do know that without this
patch, the system is extremely slow which I believe is from it
only returning from the WFI because of a timer expiration or
something like that.

> There are other sources of wakeup on the system other than I/O wakeup.  
> I/O wakeup only applies to wakeups from the I/O pads when the chip is in 
> RETENTION or OFF.  And as I understand it, neither of those apply to 
> AM3517/3505?

Hmm, its true that RETENTION and OFF aren't supported.  It does wake up
occasionally (as mentioned above) it just seems that I/O doesn't wake
it up.  I may be mistaken.  I'm only going from what I've seen since and
the TRM seems to have lots of errors so I'm not sure what to trust in it.

> Even if I/O wakeups aren't supported, many of the IP blocks on the system 
> should be able to cause the ARM to exit WFI by asserting their 
> SWAKEUP lines and raising their interrupt lines.

Okay, but that doesn't seem to be working.  I'll look some more to see
why they aren't working.

> So this change doesn't seem quite right to me...
> 
> More broadly, if AM3517/3505 only supports powerdomains ON, then you 
> should probably use your own CPUIdle driver that doesn't touch the 
> powerdomain states at all.

Okay, I can do that.

Mark
--
