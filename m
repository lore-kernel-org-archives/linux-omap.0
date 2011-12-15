From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2/3: intc: Add DT support for TI interrupt
 controller
Date: Thu, 15 Dec 2011 18:49:50 +0100
Message-ID: <4EEA333E.9030502@ti.com>
References: <1323291049-24964-1-git-send-email-b-cousson@ti.com> <1323291049-24964-3-git-send-email-b-cousson@ti.com> <4EDFD88B.8060008@gmail.com> <4EE0D0E6.3060202@ti.com> <4EE20B38.8050006@gmail.com> <4EE2209E.2040209@ti.com> <4EE227A4.2030209@gmail.com> <4EE2320D.2030309@ti.com> <4EE2335C.7050902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40546 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551Ab1LORuD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 12:50:03 -0500
In-Reply-To: <4EE2335C.7050902@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: tony@atomide.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/9/2011 5:12 PM, Rob Herring wrote:
> On 12/09/2011 10:06 AM, Cousson, Benoit wrote:

[...]

>> My point is that even in the DT case I do have some devices that are
>> initialized without DT for the moment and thus cannot get access to the
>> interrupt-controller node and then cannot retrieve the domain information.
>>
>> How can I ensure the proper hwirq ->  irq translation then for such devices?
>> Only the one created by DT will have the correct irq number.
> 
> Okay, I missed that aspect of it. So I guess 0 base is fine for now.
> 
> Rob

Following that discussion, I made a patch (included below) last week to add domain support just before this one for DT migration.
I'm now wondering if it makes sense to do it like that considering your recent patch: irq: convert generic-chip to use irq_domain.

What do you think?

Thanks,
Benoit

---
>From 3083589f48604aab3d801179810c2af8339525ae Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Thu, 8 Dec 2011 22:16:51 +0100
Subject: [PATCH] ARM: OMAP2/3: intc: Add irqdomain support

Introduce the usage of the irqdomain to prepare the DT support.
The irq_base is still hard coded to 0 to allow non-DT drivers
to work with the previous assumption that was hwirq = irq.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-omap2/irq.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 42b1d65..2f65dfd 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -17,6 +17,7 @@
 #include <mach/hardware.h>
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
+#include <linux/irqdomain.h>
 
 
 /* selected INTC register offsets */
@@ -57,6 +58,8 @@ static struct omap_irq_bank {
 	},
 };
 
+static struct irq_domain domain;
+
 /* Structure to save interrupt controller context */
 struct omap3_intc_regs {
 	u32 sysconfig;
@@ -158,6 +161,17 @@ static void __init omap_init_irq(u32 base, int nr_irqs)
 	if (WARN_ON(!omap_irq_base))
 		return;
 
+	/*
+	 * XXX: Use a 0 irq_base for the moment since the legacy devices
+	 * created statically are expected a hwirq = irq mapping.
+	 * A proper offset will be added later, when IRQ resource creation
+	 * will be handled by DT.
+	 */
+	domain.irq_base = 0;
+	domain.nr_irq = nr_irqs;
+	domain.ops = &irq_domain_simple_ops;
+	irq_domain_add(&domain);
+
 	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
 		struct omap_irq_bank *bank = irq_banks + i;
 
@@ -225,8 +239,10 @@ out:
 		irqnr = readl_relaxed(base_addr + INTCPS_SIR_IRQ_OFFSET);
 		irqnr &= ACTIVEIRQ_MASK;
 
-		if (irqnr)
+		if (irqnr) {
+			irqnr = irq_domain_to_irq(&domain, irqnr);
 			handle_IRQ(irqnr, regs);
+		}
 	} while (irqnr);
 }
 
-- 
1.7.0.4
