From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH] gpio/omap: fix pm_runtime for IRQ functions
Date: Mon, 21 Jan 2013 12:08:53 +0530
Message-ID: <50FCE27D.7060500@ti.com>
References: <1358531362-27933-1-git-send-email-jlu@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------040004010206080608070705"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60156 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792Ab3AUGiJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Jan 2013 01:38:09 -0500
In-Reply-To: <1358531362-27933-1-git-send-email-jlu@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Luebbe <jlu@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, kernel@pengutronix.de, Rajendra Nayak <rnayak@ti.com>

--------------040004010206080608070705
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On Friday 18 January 2013 11:19 PM, Jan Luebbe wrote:
> Other devices in the device tree can use omap-gpio as an interrupt
> controller with something like:
> 	interrupt-parent = <&gpio1>;
> 	interrupts = <19 8>;
> (in this case with #interrupt-cells = <2> in the gpio node to be able
> to configure the IRQ flags in DT)
>
> Currently this triggers an unhandled fault (external abort on non-
> linefetch) because the gpio bank has been disabled by runtime pm.
> The current driver keeps a reference count in omap_gpio_request
> and omap_gpio_free, but these are not called when configuring
> an IRQ via device tree. The current code expects that users
> always request a gpio before trying to use the IRQ functions.
> When using DT, this is no longer the case.
>
> To fix this problem, I changed bank->mod_usage from per pin flags
> to a simple refcount and update it from gpio_unmask_irq and
> gpio_mask_irq, as well. Depending on the content of bank->mod_usage,
> pm_runtime_get_sync and pm_runtime_put are called.
>
> I'm unsure about the code to en-/disable the module clock gate.
> Maybe it should be moved to omap_gpio_runtime_{suspend,resume} or
> separate helpers?
> Another unclear point is whether the pm_runtime_* calls have a too
> large overhead for unmask/mask.
>
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> ---
The main issue is the request_gpio() isn't getting triggered in the
DT case. GPIO driver do expect users to do request_gpio() to be called
for any further usage.
IIRC, similar issue was discussed previously without any conclusion.

Grant/Linus,
Whats your suggestion on above mentioned issue. How gpio_request()
can be triggered from the framework when a gpio irq binding is found
in DT blob() ? Rajendra cooked up a patch while back on the same
topic which am attaching for the reference. Please let us know
your input whether attached patch make sense or any other
alternative you have.

Regards
Santosh




--------------040004010206080608070705
Content-Type: text/x-patch;
	name="0001-irqdomain-Do-a-gpio_request-in-case-of-a-gpio-irq_do.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-irqdomain-Do-a-gpio_request-in-case-of-a-gpio-irq_do.pa";
	filename*1="tch"

>From 90290e5fac1673745f0bd38ac1cf49c4ce502593 Mon Sep 17 00:00:00 2001
From: Rajendra Nayak <rnayak@ti.com>
Date: Fri, 3 Aug 2012 16:33:54 +0530
Subject: [PATCH] irqdomain: Do a gpio_request in case of a gpio irq_chip

On architectures which support DT, and have devices which use gpios as irqs,
the irqdomain does the job of transalating the gpio number mapped to the
gpio based irq controller to a virtual irq number in the linux irq space.
A gpio_request in such cases though, seems to be missing.

Add a flag to irq_chip for identifying if its a gpio based irq_chip,
and use it to then do a gpio_request() from irq_domain.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Reported-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reported-by: Sourav Poddar <sourav.poddar@ti.com>
---
 include/linux/irq.h    |    1 +
 kernel/irq/irqdomain.c |    6 ++++++
 2 files changed, 7 insertions(+)

Index: linux-2.6/kernel/irq/irqdomain.c
===================================================================
--- linux-2.6.orig/kernel/irq/irqdomain.c	2012-08-07 18:52:18.347378581 +0530
+++ linux-2.6/kernel/irq/irqdomain.c	2012-08-07 18:55:12.618377958 +0530
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/smp.h>
 #include <linux/fs.h>
+#include <linux/gpio.h>
 
 #define IRQ_DOMAIN_MAP_LEGACY 0 /* driver allocated fixed range of irqs.
 				 * ie. legacy 8259, gets irqs 1..15 */
@@ -617,6 +618,7 @@
 				   const u32 *intspec, unsigned int intsize)
 {
 	struct irq_domain *domain;
+	struct irq_chip *chip;
 	irq_hw_number_t hwirq;
 	unsigned int type = IRQ_TYPE_NONE;
 	unsigned int virq;
@@ -654,6 +656,10 @@
 	if (!virq)
 		return virq;
 
+	chip = irq_get_chip(virq);
+	if (chip->flags & IRQCHIP_IS_GPIO)
+		gpio_request(irq_to_gpio(virq), "irq_domain");
+
 	/* Set type if specified and different than the current one */
 	if (type != IRQ_TYPE_NONE &&
 	    type != (irqd_get_trigger_type(irq_get_irq_data(virq))))
Index: linux-2.6/include/linux/irq.h
===================================================================
--- linux-2.6.orig/include/linux/irq.h	2012-08-07 18:52:18.339378810 +0530
+++ linux-2.6/include/linux/irq.h	2012-08-07 18:52:59.434199592 +0530
@@ -349,6 +349,7 @@
 	IRQCHIP_MASK_ON_SUSPEND		= (1 <<  2),
 	IRQCHIP_ONOFFLINE_ENABLED	= (1 <<  3),
 	IRQCHIP_SKIP_SET_WAKE		= (1 <<  4),
+	IRQCHIP_IS_GPIO			= (1 <<  5),
 };
 
 /* This include will go away once we isolated irq_desc usage to core code */

--------------040004010206080608070705--
