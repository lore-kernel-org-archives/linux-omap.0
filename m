From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 00/14] GPIO: OMAP: first round of cleanup
Date: Thu, 16 Jun 2011 13:32:46 -0600
Message-ID: <20110616193246.GL3795@ponder.secretlab.ca>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
 <20110527032439.GK5032@ponder.secretlab.ca>
 <87r56trc8k.fsf@ti.com>
 <20110616162604.GE3795@ponder.secretlab.ca>
 <877h8lljzt.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55501 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab1FPTct (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jun 2011 15:32:49 -0400
Received: by pzk9 with SMTP id 9so1260718pzk.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 12:32:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <877h8lljzt.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-kernel@lists.infradead.org

On Thu, Jun 16, 2011 at 11:16:38AM -0700, Kevin Hilman wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
> 
> > On Thu, Jun 16, 2011 at 09:07:39AM -0700, Kevin Hilman wrote:
> >> Grant Likely <grant.likely@secretlab.ca> writes:
> >> 
> >> > On Fri, May 20, 2011 at 05:14:43PM +0200, Kevin Hilman wrote:
> >> >> Start moving SoC-specific register handling out of the driver by passing
> >> >> in register offsets in via platform data.
> >> >> 
> >> >> Also, move OMAP1 MPUIO IRQ handling over to genric IRQ chip.
> >> >> 
> >> >> Applies on top of Tony's for-next branch (which include's the generic
> >> >> IRQ chip work from tglx) and the OMAP GPIO driver move to
> >> >> drivers/gpio.
> >> >
> >> > Hey Kevin,
> >> >
> >> > If you've got a branch with this series in it and tested, then I'd be
> >> > happy to pull that instead of applying the patches myself.
> >> >
> >> 
> >> OK, I rebased this on v3.0-rc2 and now it's been through quite a bit
> >> more testing.
> >> 
> >> Here's a branch for you.
> >
> > Thanks.  A minor comment though...
> >
> >> 
> >> Also FYI, we'll probably have 2nd round of GPIO cleanups/updates and
> >> runtime PM conversion for the upcoming merge window too.
> >
> > Okay.
> >
> >> 
> >> Kevin
> >> 
> >> The following changes since commit 2c53b436a30867eb6b47dd7bab23ba638d1fb0d2:
> >> 
> >>   Linux 3.0-rc3 (2011-06-13 15:29:59 -0700)
> >> 
> >> are available in the git repository at:
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.1/gpio-cleanup
> >> 
> >> Charulatha V (1):
> >>       GPIO: OMAP: remove get_gpio_bank()
> >> 
> >> Kevin Hilman (13):
> >>       GPIO: OMAP: _clear_gpio_irqbank: fix flushing of posted write
> >>       GPIO: OMAP: remove MPUIO handling from _clear_gpio_irqbank()
> >>       GPIO: OMAP: move bank width into struct gpio_bank
> >>       GPIO: OMAP: _get_gpio_irqbank_mask: replace hard-coded mask with bank->width
> >>       GPIO: OMAP: replace get_gpio_index() by using bank width
> >>       GPIO: OMAP: consolidate direction, input, output, remove #ifdefs
> >>       GPIO: OMAP: consolidate IRQ status handling, remove #ifdefs
> >>       GPIO: OMAP: conslidate enable/disable of GPIO IRQs, remove ifdefs
> >>       GPIO: OMAP: convert MPUIO IRQ over to generic irq_chip
> >>       GPIO: OMAP: remove useless gpio_valid() & check_gpio() checks
> >>       GPIO: OMAP: cleanup _set_gpio_wakeup(), remove ifdefs
> >>       GPIO: OMAP: debounce remove SoC specific registers, use pdata
> >>       GPIO: OMAP: cleanup show revision, remove cpu_is checks, display only once
> >
> > Use this form for the patch summaries please: "gpio/omap: ...."
> >
> > It's better for the pull req to Linus when all the gpio patches look the same.
> 
> heh, every subsystem has it's own conventions.
> 
> OK, reworded the shortlogs, re-spun it and re-pushed to the same branch
> name.  It might not be to all the mirrors yet, so you might want to pull
> using ssh://master.kernel.org/...

Merged, thanks.

g.

