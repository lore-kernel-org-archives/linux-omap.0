From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP2/3 Avoid GPIO pending irq status been set after irq_disable
Date: Thu, 04 Jun 2009 16:01:46 -0700
Message-ID: <87d49jeh7p.fsf@deeprootsystems.com>
References: <B00E06E2766C2744B022DE9BAF3C59D5372B9F@zmy16exm69.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:65050 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbZFDXBq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 19:01:46 -0400
Received: by pzk1 with SMTP id 1so462945pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 04 Jun 2009 16:01:48 -0700 (PDT)
In-Reply-To: <B00E06E2766C2744B022DE9BAF3C59D5372B9F@zmy16exm69.ds.mot.com> (Wang Sawsd-A's message of "Fri\, 5 Jun 2009 05\:58\:18 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Sawsd-A24013 <cqwang@motorola.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, Mike Chan <mikechan@google.com>

"Wang Sawsd-A24013" <cqwang@motorola.com> writes:

>  
>> What do you think about disabling the level/edge detection when
>> disable_irq_wake() is called instead?  This seems more logical
>> and expected.
>
> Kevin, if we look at the current code, enable_irq_wake and
> disable_irq_wake Does not even touch any GPIO WAKEEN register, it
> seems it is intended To just log the gpio bit and enable its WAKEUP
> and IOPAD wakeup when suspend happens.

Correct.

> And also, enable_irq_wake/disable_irq_wake
> Are designed to be able used when both IRQ is enabled AND disabled,
> In another words, enable_irq_wake may be called after irq_disable,
> Disable_irq_wake may be called after irq_enable, if we change
> Level/edge detect then it may cause either IRQ never happen

Good point.

> After irq_enable, or IRQ staus bit also set after irq_disable. Since
> The root reason is the level/edge detect can cause IRQ status, it
> Is related with IRQ, not wakeup.

Correct again.

> What do you think?

I'm thinking I'm not thinking very clearly on the subject today.  It's
too hot in Seattle today.  ;)

I'm also thinking that this isn't just going to be a problem with
suspend/resume but also for hitting retention in idle.  Any
level-triggered GPIO IRQ that is masked, yet still has level/edge
detect configured can prevent retention during idle since it will
cause IRQ status as you've pointed out.

Can you think of any reason not to disable the level/edge detect in
the ->mask() hook and to re-enable it in the ->unmask hook?  Something
like the patch below?

Could you try this patch with your TS GPIO configured as level-triggered?

Kevin

commit f8eb69a2edd684c9e0b72bc3c84c6af9718bd4a4
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Thu Jun 4 15:57:10 2009 -0700

    OMAP: GPIO: clear/restore level/edge detect settings on mask/unmask
    
    <needs detailed description>

    Signed-off-by: Kevin Hilman <khilman@ti.deeprootsystems.com>

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 3b2054b..83ac494 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1135,6 +1135,7 @@ static void gpio_mask_irq(unsigned int irq)
 	struct gpio_bank *bank = get_irq_chip_data(irq);
 
 	_set_gpio_irqenable(bank, gpio, 0);
+	_set_gpio_triggering(bank, get_gpio_index(gpio), IRQ_TYPE_NONE);
 }
 
 static void gpio_unmask_irq(unsigned int irq)
@@ -1142,6 +1143,11 @@ static void gpio_unmask_irq(unsigned int irq)
 	unsigned int gpio = irq - IH_GPIO_BASE;
 	struct gpio_bank *bank = get_irq_chip_data(irq);
 	unsigned int irq_mask = 1 << get_gpio_index(gpio);
+	struct irq_desc *desc = irq_to_desc(irq);
+	u32 trigger = desc->status & IRQ_TYPE_SENSE_MASK;
+
+	if (trigger)
+		_set_gpio_triggering(bank, get_gpio_index(gpio), trigger);
 
 	/* For level-triggered GPIOs, the clearing must be done after
 	 * the HW source is cleared, thus after the handler has run */
