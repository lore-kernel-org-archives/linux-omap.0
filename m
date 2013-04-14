From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Sun, 14 Apr 2013 03:35:44 +0200
Message-ID: <CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <4F47AD08.4030504@ti.com> <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
 <512D39DA.7020306@ti.com> <512D3AB1.1080202@wwwdotorg.org>
 <512D3EC2.6050408@ti.com> <20130302200524.D230F3E1571@localhost>
 <51391F41.5000303@ti.com> <CAAwP0s1CFRO-rf==p5sYs1n0gigMif7wuT8Yv0N_iLUDMrtcOg@mail.gmail.com>
 <CACRpkdYHj-rEF3Rk_CWnmmMw_Amr7m8SgQ=-2zsDYuLeuu3azw@mail.gmail.com>
 <514C79E1.4090106@wwwdotorg.org> <514CE0AB.6060207@ti.com>
 <CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com>
 <515319D5.20105@wwwdotorg.org> <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com>
 <5155C902.7080207@wwwdotorg.org> <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com>
 <5165CB9D.1090202@wwwdotorg.org> <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com>
 <51671D7B.5060303@wwwdotorg.org> <CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com>
 <51673D70.3010503@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:37593 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055Ab3DNBgG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Apr 2013 21:36:06 -0400
Received: by mail-ia0-f176.google.com with SMTP id i9so1121186iad.21
        for <linux-omap@vger.kernel.org>; Sat, 13 Apr 2013 18:36:04 -0700 (PDT)
In-Reply-To: <51673D70.3010503@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Apr 12, 2013 at 12:47 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/11/2013 04:16 PM, Linus Walleij wrote:
>> On Thu, Apr 11, 2013 at 10:30 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 04/10/2013 03:28 PM, Linus Walleij wrote:
>>
>>>> So the only reason I'm rambing on about this is that it breaks the
>>>
>>> I'm not sure I understand this paragraph; what is "it" in the line above.
>>>
>>> If "it" is this patch, then should "breaks" be re-establishes?
>>
>> No I'm replying to Javier Martinez Canillas mail in this thread:
>> http://marc.info/?l=linux-arm-kernel&m=136334655902407&w=2
>> which is stating a question to grand, and contains the below
>> hunk:
>>
>>> +static int gpio_irq_request(struct irq_data *d)
>>> +{
>>> +       struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
>>> +
>>> +       return gpio_request(irq_to_gpio(bank, d->irq), "gpio-irq");
>>> +}
>>
>> irq_to_gpio(). Notice that. not my_funny_driver_irq_to_gpio().
>
> OK, right. sorry for being so confused/confusing.
>
> Yes, that code should certainly call e.g. omap_gpio__irq_to_gpio() not
> irq_to_gpio(). Probably gpio_irq_request() wants renaming to something
> more like omap_gpio__irq_request() too, so the names don't look like
> they'd clash with global functions. (__ added for clarity but probably
> only one _ at a time)

Stephen, Linus,

Is the following inlined patch [1] what you were thinking that would
be the right approach?

With this patch an explicit call to call gpio_request() before a call
to chip->irq_set_type() is needed. I've tested both with DT and
without DT where a explicit call to gpio_request() is made and it
works in both cases. So it shouldn't have a functional change for
non-DT cases as far as I know.

If you agree with [1] then I'll split in two patches (one that adds
the irq_request function pointer to irq_chip and another one that adds
the implementation for gpio-omap) and send as a patch-set. I just
thought that it would be easier for you if I posted here an inlined
patch so you could have context.

Thanks a lot for your feedback and best regards,
Javier

[1]
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 685e850..e035e64 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -811,6 +811,13 @@ static void gpio_unmask_irq(struct irq_data *d)
 	spin_unlock_irqrestore(&bank->lock, flags);
 }

+static int omap_gpio_irq_request(struct irq_data *d)
+{
+	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+
+	return omap_gpio_request(&bank->chip, d->hwirq);
+}
+
 static struct irq_chip gpio_irq_chip = {
 	.name		= "GPIO",
 	.irq_shutdown	= gpio_irq_shutdown,
@@ -819,6 +826,7 @@ static struct irq_chip gpio_irq_chip = {
 	.irq_unmask	= gpio_unmask_irq,
 	.irq_set_type	= gpio_irq_type,
 	.irq_set_wake	= gpio_wake_enable,
+	.irq_request    = omap_gpio_irq_request,
 };

 /*---------------------------------------------------------------------*/
@@ -1028,6 +1036,7 @@ omap_mpuio_alloc_gc(struct gpio_bank *bank,
unsigned int irq_start,
 	ct->chip.irq_mask = irq_gc_mask_set_bit;
 	ct->chip.irq_unmask = irq_gc_mask_clr_bit;
 	ct->chip.irq_set_type = gpio_irq_type;
+	ct->chip.irq_request = omap_gpio_irq_request;

 	if (bank->regs->wkup_en)
 		ct->chip.irq_set_wake = gpio_wake_enable,
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 0e8e3a6..85596cc 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -303,6 +303,7 @@ struct irq_chip {
 	void		(*irq_shutdown)(struct irq_data *data);
 	void		(*irq_enable)(struct irq_data *data);
 	void		(*irq_disable)(struct irq_data *data);
+	int             (*irq_request)(struct irq_data *data);

 	void		(*irq_ack)(struct irq_data *data);
 	void		(*irq_mask)(struct irq_data *data);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index fa17855..a4bd4f7 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -588,6 +588,12 @@ int __irq_set_trigger(struct irq_desc *desc,
unsigned int irq,
 			unmask = 1;
 	}

+	if (chip->irq_request) {
+			ret = chip->irq_request(&desc->irq_data);
+			if (ret)
+				return ret;
+	}
+
 	/* caller masked out all except trigger mode flags */
 	ret = chip->irq_set_type(&desc->irq_data, flags);
