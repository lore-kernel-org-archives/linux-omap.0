From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Mon, 15 Apr 2013 16:40:22 -0500
Message-ID: <516C73C6.5050409@ti.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <51391F41.5000303@ti.com> <CAAwP0s1CFRO-rf==p5sYs1n0gigMif7wuT8Yv0N_iLUDMrtcOg@mail.gmail.com> <CACRpkdYHj-rEF3Rk_CWnmmMw_Amr7m8SgQ=-2zsDYuLeuu3azw@mail.gmail.com> <514C79E1.4090106@wwwdotorg.org> <514CE0AB.6060207@ti.com> <CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com> <515319D5.20105@wwwdotorg.org> <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com> <5155C902.7080207@wwwdotorg.org> <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com> <5165CB9D.1090202@wwwdotorg.org> <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com> <51671D7B.5060303@wwwdotorg.org> <CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com> <51673D70.3010503@wwwdotorg.org> <CAA
 wP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com> <CACRpkda4h+qXTvsirPAS7E7sjXhMLE62q=VDy53W8UchsYjbNg@mail.gmail.com> <516C31C3.9040505@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36867 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756269Ab3DOVkg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Apr 2013 17:40:36 -0400
In-Reply-To: <516C31C3.9040505@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <martinez.javier@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 04/15/2013 11:58 AM, Stephen Warren wrote:
> On 04/14/2013 02:53 PM, Linus Walleij wrote:
>> On Sun, Apr 14, 2013 at 3:35 AM, Javier Martinez Canillas
>> <martinez.javier@gmail.com> wrote:
>>
>>> Is the following inlined patch [1] what you were thinking that would
>>> be the right approach?
>>
>> This looks sort of OK, but I'm still struggling with the question of
>> what we could do to help other implementations facing the same issue.
>>
>> This is a pretty hard design pattern to properly replicate in every such
>> driver is it not?
> 
> Well, instead of adding .request_irq() to the irqchip, and then making
> each driver call gpio_request() from the implementation, perhaps you
> could add a .irq_to_gpio() to the irqchip, have the IRQ core call that,
> and if it gets back a non-error response, the IRQ core could call
> gpio_request(). That means that the change to each GPIO+IRQ driver is
> simply to implement a standalone data transformation function
> .irq_to_gpio().

I am still concerned about the case where a driver may have already
called gpio_request() and then calls request_irq(). I think that the
solution needs to handle cases where the driver may or may not call
gpio_request() to allocate the gpio.

Although it could be argued that this is problem is not DT specific,
it does become a bigger problem to handle in the case of DT. Therefore,
I am wondering if we should just focus on the DT case for now. 

> Now, this does re-introduce irq_to_gpio() in some way, but with the
> following advantages:
> 
> 1) The implementation is per-controller, not a single global function,
> so isn't introducing any kind of centralized mapping scheme again.
> 
> 2) This irq-chip-specific .irq_to_gpio() would only be implemented for
> IRQ+GPIO chips that actually have a 1:1 mapping between GPIOs and IRQs.
> Its potential existence doesn't imply that all IRQ chips need implement
> this; it would be very specifically be for this one particular case.
> 
> So, I think it's reasonable to introduce this.

How about using the gpio irq domain xlate function?

Typically, in DT land a device using a gpio as an interrupt source
will have something like the following ...

eth@0 {
	compatible = "ks8851";
	...
	interrupt-parent = <&gpio2>;
	interrupts = <2 8>; /* gpio line 34, low triggered */
};

... or ...

mmc {
	label = "pandaboard::status2";
 	gpios = <&gpio1 8 0>;
	...
};

Both these devices are using a gpio as an interrupt source, but the mmc
driver is requesting the gpio directly. In the first case the xlate
function for the gpio irq domain will be called where as it is not used
in the 2nd case. Therefore, we could add a custom xlate function. For
example ...

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 53bb8d5..caaeab2 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1085,6 +1085,33 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
        irq_set_handler_data(bank->irq, bank);
 }
 
+
+int omap_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
+                         const u32 *intspec, unsigned int intsize,
+                         unsigned long *out_hwirq, unsigned int *out_type)
+{
+       struct gpio_bank *bank;
+       int irq;
+
+       if (WARN_ON(intsize < 1))
+               return -EINVAL;
+
+       irq = irq_find_mapping(d, intspec[0]);
+       bank = irq_get_chip_data(irq);
+       if (!bank)
+               return -ENODEV;
+
+       gpio_request_one(irq_to_gpio(bank, intspec[0]), GPIOF_IN, ctrlr->name);
+
+       *out_hwirq = intspec[0];
+       *out_type = (intsize > 1) ? intspec[1] : IRQ_TYPE_NONE;
+       return 0;
+}
+
+static const struct irq_domain_ops omap_irq_domain_ops = {
+       .xlate = omap_irq_domain_xlate,
+};
+
 static const struct of_device_id omap_gpio_match[];
 static void omap_gpio_setup_context(struct gpio_bank *p);
 
@@ -1135,7 +1162,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 
 
        bank->domain = irq_domain_add_linear(node, bank->width,
-                                            &irq_domain_simple_ops, NULL);
+                                            &omap_irq_domain_ops, NULL);
        if (!bank->domain)
                return -ENODEV;
 
Cheers
Jon
 
