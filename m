From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/9] ARM: OMAP: Mask interrupts when disabling interrupts
Date: Wed, 28 Jan 2009 10:32:09 -0800
Message-ID: <20090128183209.21007.86828.stgit@localhost>
References: <20090128181931.21007.73744.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62703 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbZA1ScM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 13:32:12 -0500
In-Reply-To: <20090128181931.21007.73744.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Kim Kyuwon <chammoru@gmail.com>, linux-omap@vger.kernel.org

=46rom: =EA=B9=80=EA=B7=9C=EC=9B=90 <chammoru@gmail.com>

By Ingo Molnar, interrupts are not masked by default.
(refer to 76d2160147f43f982dfe881404cfde9fd0a9da21)

But if interrupts are not masked, the processor can wake up while in
Suspend-to-RAM state by an external interrupt. For example, if an
OMAP3 board is connected to Host PC by USB and entered to Suspend-to-RA=
M
state, it wake up automatically by M_IRQ_92. The disable_irq() function
can't disable the interrupt in H/W level, So I modified
arch/arm/mach-omap2/irq.c

Signed-off-by: Kim Kyuwon <chammoru@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/irq.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 636e282..52772f9 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -123,6 +123,11 @@ static void omap_unmask_irq(unsigned int irq)
 	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_CLEAR0 + offset=
);
 }
=20
+static void omap_disable_irq(unsigned int irq)
+{
+	omap_mask_irq(irq);
+}
+
 static void omap_mask_ack_irq(unsigned int irq)
 {
 	omap_mask_irq(irq);
@@ -134,6 +139,7 @@ static struct irq_chip omap_irq_chip =3D {
 	.ack	=3D omap_mask_ack_irq,
 	.mask	=3D omap_mask_irq,
 	.unmask	=3D omap_unmask_irq,
+	.disable =3D omap_disable_irq,
 };
=20
 static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
