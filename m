From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 13/13] gpio/omap: fix incorrect update to context.irqenable1
Date: Mon, 12 Mar 2012 15:09:54 -0700
Message-ID: <87haxtwjwt.fsf@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
	<1331118963-26364-14-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob129.obsmtp.com ([74.125.149.136]:55806 "EHLO
	na3sys009amx259.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757262Ab2CLWJr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 18:09:47 -0400
Received: by mail-iy0-f170.google.com with SMTP id h11so14886439iae.1
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 15:09:46 -0700 (PDT)
In-Reply-To: <1331118963-26364-14-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 7 Mar 2012 16:46:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> In _enable_gpio_irqbank() when bank->regs->set_irqenable is valid,
> gpio_mask can be directly set by writing to set_irqenable register
> without overwriting current value. 

Ouch.  Nice catch.

> In order to ensure the same is
> stored in context.irqenable1, we must read from regs->irqenable
> instead of overwriting it with gpio_mask.
> The overwriting makes sense only in the second case where irqenable
> is explicitly read and updated with new gpio_mask before writing it
> back. However, for consistency reading regs->irqenable into the
> bank->context.irqenable1 takes care of both the scenarios.

...takes care of both scenarios, but adds and extra duplicate read for
the second.

Instead, how about just move the context update into each side of the
if/else?  untested patch below to show what I mean.

Kevin


diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 752ae9b..f8b7099 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -442,6 +442,7 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	if (bank->regs->set_irqenable) {
 		reg += bank->regs->set_irqenable;
 		l = gpio_mask;
+		bank->context.irqenable1 |= gpio_mask;
 	} else {
 		reg += bank->regs->irqenable;
 		l = __raw_readl(reg);
@@ -449,10 +450,10 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 			l &= ~gpio_mask;
 		else
 			l |= gpio_mask;
+		bank->context.irqenable1 = l;
 	}
 
 	__raw_writel(l, reg);
-	bank->context.irqenable1 = l;
 }
 
 static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
@@ -463,6 +464,7 @@ static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	if (bank->regs->clr_irqenable) {
 		reg += bank->regs->clr_irqenable;
 		l = gpio_mask;
+		bank->context.irqenable1 &= ~gpio_mask;
 	} else {
 		reg += bank->regs->irqenable;
 		l = __raw_readl(reg);
@@ -470,10 +472,10 @@ static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 			l |= gpio_mask;
 		else
 			l &= ~gpio_mask;
+		bank->context.irqenable1 = l;
 	}
 
 	__raw_writel(l, reg);
-	bank->context.irqenable1 = l;
 }
 
 static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)

