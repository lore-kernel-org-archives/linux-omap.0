From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 20/23] twl4030-gpio: irq and other cleanup
Date: Mon, 29 Sep 2008 17:06:08 -0700
Message-ID: <200809291706.09549.david-b@pacbell.net>
References: <1222707783-18936-1-git-send-email-me@felipebalbi.com> <1222707783-18936-20-git-send-email-me@felipebalbi.com> <1222707783-18936-21-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:34196 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752380AbYI3AGM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Sep 2008 20:06:12 -0400
In-Reply-To: <1222707783-18936-21-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

On Monday 29 September 2008, Felipe Balbi wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Remove some ARM and OMAP specific stuff from the twl4030 GPIO code,
> and some unused/undesirable CPP symbols.  Add minor checkpatch fixes.

This one and #0021 share a problem.  Looks like what I tested
wasn't the version I thought I'd tested ...


> @@ -847,9 +839,9 @@ static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
>  		/* install an irq handler for each of the gpio interrupts */
>  		for (irq = twl4030_gpio_irq_base; irq < twl4030_gpio_irq_end;
>  				irq++) {
> -			set_irq_chip(irq, &twl4030_gpio_irq_chip);
> -			set_irq_handler(irq, do_twl4030_gpio_irq);

The problem is right here:

> -			set_irq_flags(irq, IRQF_VALID);
> +			set_irq_noprobe(irq);

What's going on is that set_irq_flags() is ARM-specific; so using it
will break builds everywhere else; it can't be used without adding
undesirable dependencies on ARM.  (Interface changes done in mainline
may well overlook such stuff.  And if this mechanism were important,
it would be needed on other platforms...)

That normal usage (just mark as "valid"):

  - Clears the IRQ_NOREQUEST flag ... the troublesome bit
  - Sets IRQ_NOPROBE ... like the standard set_irq_noprobe() call
  - Clears IRQ_NOAUTOEN ... set for some PCMCIA irqs and little else

Thing is, ARM also *sets* IRQ_NOREQUEST (and NOPROBE) for all IRQs,
very early.  And it's effectively the only architecture which uses
that flag.  (PowerPC doesn't quite count, since you won't even get
an IRQ number until it's been mapped and that flag is cleared.)

... So it looks like I'm going to have to come up with a different
portability fix, sigh.



> +			set_irq_chip_and_handler(irq, &twl4030_gpio_irq_chip,
> +					do_twl4030_gpio_irq);
>  		}
>  
>  		/* gpio module IRQ */

