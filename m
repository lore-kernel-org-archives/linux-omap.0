From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 20/23] twl4030-gpio: irq and other cleanup
Date: Mon, 29 Sep 2008 17:30:45 -0700
Message-ID: <200809291730.46154.david-b@pacbell.net>
References: <1222707783-18936-1-git-send-email-me@felipebalbi.com> <1222707783-18936-20-git-send-email-me@felipebalbi.com> <1222707783-18936-21-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:29600 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752101AbYI3Aas (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Sep 2008 20:30:48 -0400
In-Reply-To: <1222707783-18936-21-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

This update (to this patch) resolves that problem ... please
merge this into the next version.
--- beagle.orig/drivers/gpio/twl4030-gpio.c	2008-09-29 17:19:37.000000000 -0700
+++ beagle/drivers/gpio/twl4030-gpio.c	2008-09-29 17:16:04.000000000 -0700
@@ -41,9 +41,22 @@
 #include <linux/i2c/twl4030-gpio.h>
 
 
+static inline void activate_irq(int irq)
+{
+#ifdef CONFIG_ARM
+	/* ARM requires an extra step to clear IRQ_NOREQUEST, which it
+	 * sets on behalf of every irq_chip.  Also sets IRQ_NOPROBE.
+	 */
+	set_irq_flags(irq, IRQF_VALID);
+#else
+	/* same effect on other architectures */
+	set_irq_noprobe(irq);
+#endif
+}
+
+static struct gpio_chip twl_gpiochip;
 static int twl4030_gpio_irq_base;
 static int twl4030_gpio_irq_end;
-static struct gpio_chip twl_gpiochip;
 
 /* genirq interfaces are not available to modules */
 #ifdef MODULE
@@ -839,9 +852,9 @@ static int __devinit gpio_twl4030_probe(
 		/* install an irq handler for each of the gpio interrupts */
 		for (irq = twl4030_gpio_irq_base; irq < twl4030_gpio_irq_end;
 				irq++) {
-			set_irq_noprobe(irq);
 			set_irq_chip_and_handler(irq, &twl4030_gpio_irq_chip,
 					do_twl4030_gpio_irq);
+			activate_irq(irq);
 		}
 
 		/* gpio module IRQ */



