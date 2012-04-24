From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 03/12] arm: omap3: Only sleep in cpuidle driver if I/O
 wake-ups work
Date: Tue, 24 Apr 2012 13:51:05 -0700
Message-ID: <20120424205105.GA26749@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-4-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1204111532280.29473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:50139 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab2DXUvH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 16:51:07 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204111532280.29473@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Apr 11, 2012 at 03:37:47PM -0600, Paul Walmsley wrote:
> Hi

Hi Paul, Kevin.

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
> 
> There are other sources of wakeup on the system other than I/O wakeup.  
> I/O wakeup only applies to wakeups from the I/O pads when the chip is in 
> RETENTION or OFF.  And as I understand it, neither of those apply to 
> AM3517/3505?
> 
> Even if I/O wakeups aren't supported, many of the IP blocks on the system 
> should be able to cause the ARM to exit WFI by asserting their 
> SWAKEUP lines and raising their interrupt lines.

I have changed the code to keep everything in the ON state and use
cpu_do_idle()--basically a wfi, cpu_v7_do_idle() in this case--and everything
works well (except networking, see below) when using an mmc-based rootfs.

The issue is with the emac--it can't wake the system up unless there
is an irq from the PHY to a wakeup-enabled GPIO (confirmed by h/w engr).
So, when using networking or using an nfs-based rootfs, there are all
kinds of timeouts, etc.  Basically, doing a wfi (i.e., pm_idle or cpuidle)
and expecting the emac to wake the system back up won't work.

How would you like me to proceed (to avoid the wfi in pm_idle & cpuidle)?

Thanks,

Mark
