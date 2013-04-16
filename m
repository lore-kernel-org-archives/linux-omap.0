From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Tue, 16 Apr 2013 16:57:02 -0500
Message-ID: <516DC92E.106@ti.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <514C79E1.4090106@wwwdotorg.org> <514CE0AB.6060207@ti.com> <CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com> <515319D5.20105@wwwdotorg.org> <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com> <5155C902.7080207@wwwdotorg.org> <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com> <5165CB9D.1090202@wwwdotorg.org> <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com> <51671D7B.5060303@wwwdotorg.org> <CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com> <51673D70.3010503@wwwdotorg.org> <CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com> <CACRpkda4h+qXTvsirPAS7E7sjXhMLE62q=VDy53W8UchsYjbNg@mail.gmail.com> <516C31C3.9040505@wwwdotorg.or
 g> <516C73C6.5050409@ti.co m> <516C7C43.3040105@wwwdotorg.org> <516C8760.2050500@ti.com> <516D9B05.1000501@wwwdotorg.org> <516DA60A.5070000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39632 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965425Ab3DPV5O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Apr 2013 17:57:14 -0400
In-Reply-To: <516DA60A.5070000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Alexandre Courbot <acourbot@nvidia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 04/16/2013 02:27 PM, Jon Hunter wrote:

...

> Right. In the DT case though, if someone does provide the IRQ and GPIO
> IDs then at least they would use a different xlate function. Another
> option to consider would be defining the #interrupt-cells = <3> where we
> would have ...
> 
> cell-#1 --> IRQ domain ID
> cell-#2 --> Trigger type
> cell-#3 --> GPIO ID
> 
> Then we could have a generic xlate for 3 cells that would also request
> the GPIO. Again not sure if people are against a gpio being requested in
> the xlate but just an idea. Or given that irq_of_parse_and_map() calls
> the xlate, we could have this function call gpio_request() if the
> interrupt controller is a gpio and there are 3 cells.

So basically some like the following (note I have only included the omap
portion in here for an example). The other benefit being no need to 
re-introduce irq_to_gpio.

Jon

>From f01ce047075a922969fcbe904b339fe8d03a997b Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Tue, 16 Apr 2013 09:54:28 -0500
Subject: [PATCH] gpio: add custom xlate for gpio irqs

---
 drivers/gpio/gpio-omap.c  |    3 ++-
 drivers/gpio/gpiolib-of.c |   24 ++++++++++++++++++++++++
 include/linux/of_gpio.h   |    1 +
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index d337318..b3d7d43 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -24,6 +24,7 @@
 #include <linux/pm.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/irqdomain.h>
 #include <linux/gpio.h>
 #include <linux/platform_data/gpio-omap.h>
@@ -1135,7 +1136,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 
 
 	bank->domain = irq_domain_add_linear(node, bank->width,
-					     &irq_domain_simple_ops, NULL);
+					     &of_gpio_irq_domain_ops, NULL);
 	if (!bank->domain)
 		return -ENODEV;
 
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 5150df6..fc01ec1 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -15,6 +15,8 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -253,3 +255,25 @@ void of_gpiochip_remove(struct gpio_chip *chip)
 	if (chip->of_node)
 		of_node_put(chip->of_node);
 }
+
+int of_gpio_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
+                            const u32 *intspec, unsigned int intsize,
+                            unsigned long *out_hwirq, unsigned int *out_type)
+{
+       int ret;
+
+       if (WARN_ON(intsize < 3))
+               return -EINVAL;
+
+       ret = gpio_request_one(intspec[2], GPIOF_IN, NULL);
+       if (ret)
+               return ret;
+
+       *out_hwirq = intspec[0];
+       *out_type = (intsize > 1) ? intspec[1] : IRQ_TYPE_NONE;
+       return 0;
+}
+
+const struct irq_domain_ops of_gpio_irq_domain_ops = {
+       .xlate = of_gpio_irq_domain_xlate,
+};
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index a83dc6f..ad2b962 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -58,6 +58,7 @@ extern void of_gpiochip_remove(struct gpio_chip *gc);
 extern int of_gpio_simple_xlate(struct gpio_chip *gc,
 				const struct of_phandle_args *gpiospec,
 				u32 *flags);
+extern const struct irq_domain_ops of_gpio_irq_domain_ops;
 
 #else /* CONFIG_OF_GPIO */
 
-- 
1.7.10.4

