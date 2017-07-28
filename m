From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/3] tty: serial: 8250 introduce mctrl_gpio helpers
Date: Thu, 27 Jul 2017 23:40:05 -0700
Message-ID: <20170728064004.GI10026@atomide.com>
References: <1501161456-13367-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1501161456-13367-1-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> [170727 06:18]:
> From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> 
> This patch series aims to reintroduce the  mctrl_gpio helpers for 8250
> UARTs.
> 
> There are some UARTs that use GPIO signals as a wakeup-sourse.
> The first patch addresses this issue and tries to destinguish GPIO usage
> via searching for "wakeup-sourse" property. Though it must be decided whether
> this property is secure to use for this purpose.

The wakeup-source part you should be able to handle pretty much
out of box with Linux generic wakeirqs if configured. See for example
drivers/i2c/i2c-core.c for the dev_pm_set_dedicated_wake_irq() part.
As long as the 8250 driver has runtime PM implemented it will wake
up the 8250 device.

This should work just fine also with am335x gpios, just configure the
secondary wakeup gpio interrupt using interrupts-extended in device
tree. Typically the interrupts are named "irq" and "wakeup". And if the
pin is used as gpio, you can just dev_pm_clear_wake_irq() during
runtime.

If having issues, we're still missing the wakeirq level configuration,
the patch below should do the trick there.

Regards,

Tony

8< -----------
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -198,7 +198,8 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 	 * so we use a threaded irq.
 	 */
 	err = request_threaded_irq(irq, NULL, handle_threaded_wake_irq,
-				   IRQF_ONESHOT, dev_name(dev), wirq);
+				   irq_get_trigger_type(irq) | IRQF_ONESHOT,
+				   dev_name(dev), wirq);
 	if (err)
 		goto err_free;
 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
