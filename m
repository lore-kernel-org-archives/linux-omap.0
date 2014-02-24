From: =?UTF-8?q?Stefan=20S=C3=B8rensen?=
	<stefan.sorensen@spectralink.com>
Subject: [PATCH] ARM: OMAP2+: Use handle_fasteoi_irq for INTC interrupt handling
Date: Mon, 24 Feb 2014 11:09:16 +0100
Message-ID: <1393236556-12361-1-git-send-email-stefan.sorensen@spectralink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 213083164162.static.sonofon.dk ([213.83.164.162]:30079 "EHLO
	HORWDSPRD01.spectralink.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751622AbaBXKJa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Feb 2014 05:09:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <stefan.sorensen@spectralink.com>

Currently INTC interrupts are handled using handle_level_irq which
will acknowledge the interrupt before running the handler. If a second
interrupt is then asserted and this interrupt is disabled while
running the first handler, the INTC will be brought into an
inconsistent state. In this state the INTC will interrupt the CPU but
the interrupt pending registers will show no pending interrupts
causing the CPU to take no action. This will repeat until another
higher priority interrupt triggers, hogging the CPU.

handle_fasteoi_irq does not acknowledge the interrupt before after
running the handler, so using this for handling INTC interrupts avoid
the above problem. This also brings the handling more in line with the
sequence described in the TRM.

Signed-off-by: Stefan S=C3=B8rensen <stefan.sorensen@spectralink.com>
---
 arch/arm/mach-omap2/irq.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index e022a86..9d09914 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -97,12 +97,6 @@ static void omap_ack_irq(struct irq_data *d)
 	intc_bank_write_reg(0x1, &irq_banks[0], INTC_CONTROL);
 }
=20
-static void omap_mask_ack_irq(struct irq_data *d)
-{
-	irq_gc_mask_disable_reg(d);
-	omap_ack_irq(d);
-}
-
 static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
 {
 	unsigned long tmp;
@@ -145,9 +139,9 @@ omap_alloc_gc(void __iomem *base, unsigned int irq_=
start, unsigned int num)
 	struct irq_chip_type *ct;
=20
 	gc =3D irq_alloc_generic_chip("INTC", 1, irq_start, base,
-					handle_level_irq);
+					handle_fasteoi_irq);
 	ct =3D gc->chip_types;
-	ct->chip.irq_ack =3D omap_mask_ack_irq;
+	ct->chip.irq_eoi =3D omap_ack_irq;
 	ct->chip.irq_mask =3D irq_gc_mask_disable_reg;
 	ct->chip.irq_unmask =3D irq_gc_unmask_enable_reg;
 	ct->chip.flags |=3D IRQCHIP_SKIP_SET_WAKE;
--=20
1.8.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
