From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 12/20] GPIO: OMAP: Use wkup_status for all SoCs
Date: Tue, 12 Jul 2011 08:30:32 -0700
Message-ID: <87hb6rtt2f.fsf@ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
	<1309513634-20971-13-git-send-email-tarun.kanti@ti.com>
	<87k4bwkz9y.fsf@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB037BE78072@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:36892 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753854Ab1GLPah (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jul 2011 11:30:37 -0400
Received: by mail-iy0-f178.google.com with SMTP id 26so4961493iyb.9
        for <linux-omap@vger.kernel.org>; Tue, 12 Jul 2011 08:30:36 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037BE78072@dbde02.ent.ti.com>
	(Tarun Kanti DebBarma's message of "Tue, 12 Jul 2011 05:34:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> Kevin,
> [...]
>> 
>> >  		set_gpio_trigger(bank, gpio, trigger);
>> >  	} else if (bank->regs->irqctrl) {
>> >  		reg += bank->regs->irqctrl;
>> > @@ -295,13 +296,7 @@ static int _set_gpio_triggering(struct gpio_bank
>> *bank, int gpio, int trigger)
>> >  		if (trigger & IRQ_TYPE_EDGE_FALLING)
>> >  			l |= 1 << (gpio << 1);
>> >
>> > -		if (trigger)
>> > -			/* Enable wake-up during idle for dynamic tick */
>> > -			__raw_writel(1 << gpio, bank->base
>> > -						+ bank->regs->wkup_set);
>> > -		else
>> > -			__raw_writel(1 << gpio, bank->base
>> > -						+ bank->regs->wkup_clear);
>> > +		MOD_REG_BIT(bank->regs->wkup_status, 1 << gpio, trigger != 0);
>> 
>> This isn't right, so I'm not sure how this is working. At this point:
>> 
>>      base = bank->base;
>>      reg = bank->base + bank->regs->edgectrl[12];
> Right so far...
>
>> 
>> but if you look at MOD_REG_BIT(), it does register access using 'base +
>> reg', but here that will be 'bank->base + bank->base + reg offset',
>> which will be doing a read/modify/write to who-knows-where.
> My understanding was MOD_REG_BIT(bank->regs->wkup_status, ...) translate to:
> bank->base + bank->regs->wkup_status, for the following reason:
>
> In the following macro, reg is equivalent to bank->regs->wkup_status.
> But this is not the case with base, which remains as bank->base.
> Please correct me.

You're right.  

This is a good example why using macros like this (with some arguments
passed and some arguments implied) leads to confusion.

> #define MOD_REG_BIT(reg, bit_mask, set) \
> do {    \
>         int l = __raw_readl(base + reg); \
>         if (set) l |= bit_mask; \
>         else l &= ~bit_mask; \
>         __raw_writel(l, base + reg); \
> } while(0)
>
>> 
>> >  		__raw_writel(l, reg);
>> 
>> Oh, now I see why it works: because you have an additional write here,
>> which isn't right either because MOD_REG_BIT() already does the read
>> *and* write.
> This should be writing to following still.
> reg = bank->base + bank->regs->edgectrl[12];

Yes, but it is a duplicate write since the MOD_REG_BIT() already does
the write.

A better solution is to just get rid of this macro and use a static inline.

The patch below does just this, and I'm including it into my
gpio-cleanup series (branch: for_3.1/gpio-cleanup-2.)  Please rebase
your updated series on that branch.

Kevin

>From 0c3da6533061f51236743ebaf4bae23561e315fe Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Tue, 12 Jul 2011 08:18:15 -0700
Subject: [PATCH] gpio/omap: replace MOD_REG_BIT macro with static inline

This macro is ugly and confusing, especially since it passes in most
arguments, but uses an implied 'base' from the caller.

Replace it with an equivalent static inline.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/gpio/gpio-omap.c |   54 ++++++++++++++++++++++++---------------------
 1 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 501ca3d..6d616ee 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -148,13 +148,17 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 	return (__raw_readl(reg) & GPIO_BIT(bank, gpio)) != 0;
 }
 
-#define MOD_REG_BIT(reg, bit_mask, set)	\
-do {	\
-	int l = __raw_readl(base + reg); \
-	if (set) l |= bit_mask; \
-	else l &= ~bit_mask; \
-	__raw_writel(l, base + reg); \
-} while(0)
+static inline void _gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set)
+{
+	int l = __raw_readl(base + reg);
+
+	if (set) 
+		l |= mask;
+	else
+		l &= ~mask;
+
+	__raw_writel(l, base + reg);
+}
 
 /**
  * _set_gpio_debounce - low level gpio debounce time
@@ -210,28 +214,28 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 	u32 gpio_bit = 1 << gpio;
 
 	if (cpu_is_omap44xx()) {
-		MOD_REG_BIT(OMAP4_GPIO_LEVELDETECT0, gpio_bit,
-			trigger & IRQ_TYPE_LEVEL_LOW);
-		MOD_REG_BIT(OMAP4_GPIO_LEVELDETECT1, gpio_bit,
-			trigger & IRQ_TYPE_LEVEL_HIGH);
-		MOD_REG_BIT(OMAP4_GPIO_RISINGDETECT, gpio_bit,
-			trigger & IRQ_TYPE_EDGE_RISING);
-		MOD_REG_BIT(OMAP4_GPIO_FALLINGDETECT, gpio_bit,
-			trigger & IRQ_TYPE_EDGE_FALLING);
+		_gpio_rmw(base, OMAP4_GPIO_LEVELDETECT0, gpio_bit,
+			  trigger & IRQ_TYPE_LEVEL_LOW);
+		_gpio_rmw(base, OMAP4_GPIO_LEVELDETECT1, gpio_bit,
+			  trigger & IRQ_TYPE_LEVEL_HIGH);
+		_gpio_rmw(base, OMAP4_GPIO_RISINGDETECT, gpio_bit,
+			  trigger & IRQ_TYPE_EDGE_RISING);
+		_gpio_rmw(base, OMAP4_GPIO_FALLINGDETECT, gpio_bit,
+			  trigger & IRQ_TYPE_EDGE_FALLING);
 	} else {
-		MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT0, gpio_bit,
-			trigger & IRQ_TYPE_LEVEL_LOW);
-		MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT1, gpio_bit,
-			trigger & IRQ_TYPE_LEVEL_HIGH);
-		MOD_REG_BIT(OMAP24XX_GPIO_RISINGDETECT, gpio_bit,
-			trigger & IRQ_TYPE_EDGE_RISING);
-		MOD_REG_BIT(OMAP24XX_GPIO_FALLINGDETECT, gpio_bit,
-			trigger & IRQ_TYPE_EDGE_FALLING);
+		_gpio_rmw(base, OMAP24XX_GPIO_LEVELDETECT0, gpio_bit,
+			  trigger & IRQ_TYPE_LEVEL_LOW);
+		_gpio_rmw(base, OMAP24XX_GPIO_LEVELDETECT1, gpio_bit,
+			  trigger & IRQ_TYPE_LEVEL_HIGH);
+		_gpio_rmw(base, OMAP24XX_GPIO_RISINGDETECT, gpio_bit,
+			  trigger & IRQ_TYPE_EDGE_RISING);
+		_gpio_rmw(base, OMAP24XX_GPIO_FALLINGDETECT, gpio_bit,
+			  trigger & IRQ_TYPE_EDGE_FALLING);
 	}
 	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
 		if (cpu_is_omap44xx()) {
-			MOD_REG_BIT(OMAP4_GPIO_IRQWAKEN0, gpio_bit,
-				trigger != 0);
+			_gpio_rmw(base, OMAP4_GPIO_IRQWAKEN0, gpio_bit,
+				  trigger != 0);
 		} else {
 			/*
 			 * GPIO wakeup request can only be generated on edge
-- 
1.7.6

