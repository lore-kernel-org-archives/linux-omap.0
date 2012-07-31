From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC 1/6] ARM: OMAP3: PRM: move prcm interrupt handlers to PRM driver code
Date: Mon, 30 Jul 2012 17:31:14 -0700
Message-ID: <87ipd4g4a5.fsf@ti.com>
References: <1342197459-7920-1-git-send-email-t-kristo@ti.com>
	<1342197459-7920-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:41273 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753026Ab2GaAbS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 20:31:18 -0400
Received: by pbbrq13 with SMTP id rq13so11235469pbb.8
        for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 17:31:17 -0700 (PDT)
In-Reply-To: <1342197459-7920-2-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Fri, 13 Jul 2012 19:37:34 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> PM code doesn't really care about the PRCM wakeup + io interrupts on
> OMAP3, as these are used only for acking PRCM internal events, and the
> IO chain handler is taken care of by hwmod code. Thus move the interrupt
> handling logic from pm34xx.c to prm2xxx_3xxx.c file. This patch also
> includes a minor cleanup for removing the priority handling and replacing
> it with a mechanism for acking pending events. This gets rid of the need
> for registering the shared interrupt handlers in specific order.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Like Rajendra, I found this combination a bit difficult to review, so I
decided to apply it and test it first.

Testing with just this patch (on top of Paul's omap4_warnings_fix_3.6
branch, which has the setup_preprogram hooks), and I get a hang on
3530 and 3730 Overo platforms (works fine on 3430/n900 and 3630/xM.)

I'm not sure what is happening yet, but there seems to be a race between
the IO and wkup handlers...

[...]

> +/**
> + * omap3xxx_prm_clear_wakeups - clears wakeup event sources
> + * @events: active PRCM interrupt event mask
> + *
> + * This function will first check if PRCM chain handler detected
> + * a wakeup event or not. If yes, it will continue to clear any
> + * pending wakeup events from PRCM module. Typically the module
> + * will generate an actual interrupt together with the wakeup event,
> + * which will then be handled separately by the driver code.
> + */
> +void omap3xxx_prm_clear_wakeups(unsigned long *events)
> +{
> +	int c;
> +
> +	/*
> +	 * If we didn't come here because of a wakeup event, do nothing
> +	 */
> +	if (!(events[0] & OMAP3430_WKUP_ST_MASK))
> +		return;

... because if I comment out the above two lines, it goes back to
working again.

> +	c = _prcm_clear_mod_irqs(WKUP_MOD, 1);
> +	c += _prcm_clear_mod_irqs(CORE_MOD, 1);
> +	c += _prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1);
> +	if (omap_rev() > OMAP3430_REV_ES1_0) {
> +		c += _prcm_clear_mod_irqs(CORE_MOD, 3);
> +		c += _prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1);
> +	}
> +}

At first, I wasn't sure why this was happening on Overo boards and not
on the other boards, but then I notcied there was a *lot* more pm_wkup
interrupts during boot on Overo compared to the other boards.  This is
because of the GPIO IRQ for the network interface as well as the network
stack itself setting timers, resulting in a lot more pm_wkup events
during boot and making the race more likely.

Kevin

