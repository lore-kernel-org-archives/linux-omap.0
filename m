From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 02/12] arm: omap3: Only sleep during cpu_idle if I/O
 wake-ups work
Date: Thu, 12 Apr 2012 17:13:03 -0700
Message-ID: <20120413001303.GQ31197@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-3-git-send-email-mgreer@animalcreek.com>
 <4F8616F4.4010109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:57213 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab2DMANE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Apr 2012 20:13:04 -0400
Content-Disposition: inline
In-Reply-To: <4F8616F4.4010109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, paul@pwsan.com

On Wed, Apr 11, 2012 at 06:42:44PM -0500, Jon Hunter wrote:
> Hi Mark,
> 
> On 04/11/2012 02:05 PM, Mark A. Greer wrote:
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > 
> > Currently in the OMAP3 code, cpu_idle() calls pm_idle(),
> > which is a function pointer set to omap3_pm_idle()).
> > omap3_pm_idle() calls omap_sram_idle() which eventually
> > causes a 'wfi' instruction to be executed effectively
> > putting the system to sleep.  It is assumed that an
> > I/O wake-up event will occur to wake the system up again.
> > This doesn't work on systems that don't support I/O wake-ups
> > (indicated by omap3_has_io_wakeup() returning false).
> > 
> > Leaving pm_idle() pointing to default_idle() won't work
> > either because the cpu_<processor>_do_idle() routine which
> > is eventually called may also execute a 'wfi' instruction
> > (e.g., cpu_v7_do_idle()).
> 
> So with this change you will never execute wfi?

Correct.

> I would have thought a timer or peripheral interrupt would be able to
> bring you out of wfi.

It occasionally wakes up so I'm guessing its a timer interrupt.
It seems that peripheral interrupts aren't waking it up.
Perhaps something isn't configured correctly but everything I've
looked at looks okay (AFAICT).

> IO wake-ups would only be needed for very low
> power states. At least that is how it is on OMAP devices. I am not sure
> how the AMxxx devices differ.

The am35x isn't supposed to have them so there's no real info on it
but I'm sure its the same as regular OMAP devices.

Mark
--
