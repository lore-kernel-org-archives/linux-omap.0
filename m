From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] pinctrl: single: call pcs_soc->rearm() whenever IRQ
 mask is changed
Date: Fri, 11 Oct 2013 10:21:28 -0700
Message-ID: <20131011172128.GT29913@atomide.com>
References: <1381507996-15021-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15364 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752497Ab3JKRVe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 13:21:34 -0400
Content-Disposition: inline
In-Reply-To: <1381507996-15021-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linus.walleij@linaro.org, grygorii.strashko@ti.com, peter.ujfalusi@ti.com, haojian.zhuang@linaro.org, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [131011 09:21]:
> On OMAPs the IO ring must be rearmed each time the pad wakeup
> configuration is changed. So call pcs_soc->rearm() from
> pcs_irq_set().
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/pinctrl/pinctrl-single.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index c2aada7..1800e47 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -1604,6 +1604,9 @@ static inline void pcs_irq_set(struct pcs_soc_data *pcs_soc,
>  		pcs->write(mask, pcswi->reg);
>  		raw_spin_unlock(&pcs->lock);
>  	}
> +
> +	if (pcs_soc->rearm)
> +		pcs_soc->rearm();
>  }
>  
>  /**
> @@ -1626,8 +1629,6 @@ static void pcs_irq_unmask(struct irq_data *d)
>  	struct pcs_soc_data *pcs_soc = irq_data_get_irq_chip_data(d);
>  
>  	pcs_irq_set(pcs_soc, d->irq, true);
> -	if (pcs_soc->rearm)
> -		pcs_soc->rearm();
>  }

This seems to cause the wake-up interrupts to happen also during
runtime for me, which makes the omap3 behave the same way as omap4
already does.

However, the concern I have is that we only want the io chain
wake-up happen during idle and not during runtime.. So counting
on the io chain in your EHCI driver during runtime would require
also additional tracking of idle wake up events vs runtime wake-up
events somewhere once we have the automatic solution for runtime PM.
That is to avoid spurious interrupts during runtime.

In any case, since this is an interrupt controller now, we should
just follow the Linux standard for interrupt controllers, so if
you do a request_irq() on it, you really should get interrupts.

I've updated the patch a litte below to also remove the now bogus
comment, and to update the description.

So considering all that, I suggest that Linus applies the updated
fix below into the pinctrl tree after pulling in the the tag I
posted for "pinctrl-single-for-linus-for-v3.13-signed".

8< -----------------------

From: Roger Quadros <rogerq@ti.com>
Date: Fri, 11 Oct 2013 19:13:16 +0300
Subject: [PATCH] pinctrl: single: call pcs_soc->rearm() whenever IRQ mask is changed

On OMAPs the IO ring must be rearmed each time the pad wakeup
configuration is changed. So call pcs_soc->rearm() from
pcs_irq_set().

As pinctrl-single is now an interrupt controller in some cases,
we should follow the standards and keep the interrupts enabled
constantly, and not just for wake-up events. The tracking of
runtime vs wake-up interrupts can be handled separately for
the automated runtime PM solution when we have it in the
future.

Signed-off-by: Roger Quadros <rogerq@ti.com>
[tony@atomide.com: removed wrong comment, updated description]
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1604,6 +1604,9 @@ static inline void pcs_irq_set(struct pcs_soc_data *pcs_soc,
 		pcs->write(mask, pcswi->reg);
 		raw_spin_unlock(&pcs->lock);
 	}
+
+	if (pcs_soc->rearm)
+		pcs_soc->rearm();
 }
 
 /**
@@ -1626,8 +1629,6 @@ static void pcs_irq_unmask(struct irq_data *d)
 	struct pcs_soc_data *pcs_soc = irq_data_get_irq_chip_data(d);
 
 	pcs_irq_set(pcs_soc, d->irq, true);
-	if (pcs_soc->rearm)
-		pcs_soc->rearm();
 }
 
 /**
@@ -1678,11 +1679,6 @@ static int pcs_irq_handle(struct pcs_soc_data *pcs_soc)
 		}
 	}
 
-	/*
-	 * For debugging on omaps, you may want to call pcs_soc->rearm()
-	 * here to see wake-up interrupts during runtime also.
-	 */
-
 	return count;
 }
 
