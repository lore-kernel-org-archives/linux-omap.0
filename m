From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 4/7] omap: mailbox: correct the argument type for irq ops
Date: Fri, 7 Jun 2013 20:57:56 -0500
Message-ID: <1370656676-41320-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57683 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052Ab3FHCD1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jun 2013 22:03:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Jassi Brar <jaswinder.singh@linaro.org>, Loic Pallardy <loic.pallardy@st.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

The argument type used in the actual individual omap_mbox_ops
for irqs should be omap_mbox_irq_t instead of omap_mbox_type_t.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap1/mailbox.c |  6 +++---
 arch/arm/mach-omap2/mailbox.c | 15 ++++-----------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index a343d5f..7246a52 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -86,21 +86,21 @@ static int omap1_mbox_fifo_full(struct omap_mbox *mbox)
 
 /* irq */
 static void
-omap1_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_type_t irq)
+omap1_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	if (irq == IRQ_RX)
 		enable_irq(mbox->irq);
 }
 
 static void
-omap1_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_type_t irq)
+omap1_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	if (irq == IRQ_RX)
 		disable_irq(mbox->irq);
 }
 
 static int
-omap1_mbox_is_irq(struct omap_mbox *mbox, omap_mbox_type_t irq)
+omap1_mbox_is_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	if (irq == IRQ_TX)
 		return 0;
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 9fe0bf2..b01aae6 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -61,9 +61,6 @@ struct omap_mbox2_priv {
 	unsigned long irqdisable;
 };
 
-static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
-				  omap_mbox_type_t irq);
-
 static inline unsigned int mbox_read_reg(size_t ofs)
 {
 	return __raw_readl(mbox_base + ofs);
@@ -124,8 +121,7 @@ static int omap2_mbox_fifo_full(struct omap_mbox *mbox)
 }
 
 /* Mailbox IRQ handle functions */
-static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
-		omap_mbox_type_t irq)
+static void omap2_mbox_enable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	struct omap_mbox2_priv *p = mbox->priv;
 	u32 l, bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
@@ -135,8 +131,7 @@ static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
 	mbox_write_reg(l, p->irqenable);
 }
 
-static void omap2_mbox_disable_irq(struct omap_mbox *mbox,
-		omap_mbox_type_t irq)
+static void omap2_mbox_disable_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	struct omap_mbox2_priv *p = mbox->priv;
 	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
@@ -147,8 +142,7 @@ static void omap2_mbox_disable_irq(struct omap_mbox *mbox,
 	mbox_write_reg(bit, p->irqdisable);
 }
 
-static void omap2_mbox_ack_irq(struct omap_mbox *mbox,
-		omap_mbox_type_t irq)
+static void omap2_mbox_ack_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	struct omap_mbox2_priv *p = mbox->priv;
 	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
@@ -159,8 +153,7 @@ static void omap2_mbox_ack_irq(struct omap_mbox *mbox,
 	mbox_read_reg(p->irqstatus);
 }
 
-static int omap2_mbox_is_irq(struct omap_mbox *mbox,
-		omap_mbox_type_t irq)
+static int omap2_mbox_is_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
 {
 	struct omap_mbox2_priv *p = mbox->priv;
 	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
-- 
1.8.2

