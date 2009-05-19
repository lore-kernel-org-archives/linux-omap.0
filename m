From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/10] ARM: OMAP: McBSP: Fix legacy interrupts to clear their
	status
Date: Tue, 19 May 2009 16:33:30 -0700
Message-ID: <20090519233330.12760.24949.stgit@localhost>
References: <20090519232905.12760.15490.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58596 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254AbZESXdg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 19:33:36 -0400
In-Reply-To: <20090519232905.12760.15490.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

If XSYNCERR or RSYNCERR interrupts are enabled, they are never
cleared causing the IRQ handler to be continuously called.
This patch clears the IRQs in question in the event they are
enabled and taken.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/mcbsp.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 28b0a82..efa0e01 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -91,11 +91,20 @@ static void omap_mcbsp_dump_reg(u8 id)
 static irqreturn_t omap_mcbsp_tx_irq_handler(int irq, void *dev_id)
 {
 	struct omap_mcbsp *mcbsp_tx = dev_id;
+	u16 irqst_spcr2;
 
-	dev_dbg(mcbsp_tx->dev, "TX IRQ callback : 0x%x\n",
-		OMAP_MCBSP_READ(mcbsp_tx->io_base, SPCR2));
+	irqst_spcr2 = OMAP_MCBSP_READ(mcbsp_tx->io_base, SPCR2);
+	dev_dbg(mcbsp_tx->dev, "TX IRQ callback : 0x%x\n", irqst_spcr2);
 
-	complete(&mcbsp_tx->tx_irq_completion);
+	if (irqst_spcr2 & XSYNC_ERR) {
+		dev_err(mcbsp_tx->dev, "TX Frame Sync Error! : 0x%x\n",
+			irqst_spcr2);
+		/* Writing zero to XSYNC_ERR clears the IRQ */
+		OMAP_MCBSP_WRITE(mcbsp_tx->io_base, SPCR2,
+			irqst_spcr2 & ~(XSYNC_ERR));
+	} else {
+		complete(&mcbsp_tx->tx_irq_completion);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -103,11 +112,20 @@ static irqreturn_t omap_mcbsp_tx_irq_handler(int irq, void *dev_id)
 static irqreturn_t omap_mcbsp_rx_irq_handler(int irq, void *dev_id)
 {
 	struct omap_mcbsp *mcbsp_rx = dev_id;
+	u16 irqst_spcr1;
 
-	dev_dbg(mcbsp_rx->dev, "RX IRQ callback : 0x%x\n",
-		OMAP_MCBSP_READ(mcbsp_rx->io_base, SPCR2));
+	irqst_spcr1 = OMAP_MCBSP_READ(mcbsp_rx->io_base, SPCR1);
+	dev_dbg(mcbsp_rx->dev, "RX IRQ callback : 0x%x\n", irqst_spcr1);
 
-	complete(&mcbsp_rx->rx_irq_completion);
+	if (irqst_spcr1 & RSYNC_ERR) {
+		dev_err(mcbsp_rx->dev, "RX Frame Sync Error! : 0x%x\n",
+			irqst_spcr1);
+		/* Writing zero to RSYNC_ERR clears the IRQ */
+		OMAP_MCBSP_WRITE(mcbsp_rx->io_base, SPCR1,
+			irqst_spcr1 & ~(RSYNC_ERR));
+	} else {
+		complete(&mcbsp_rx->tx_irq_completion);
+	}
 
 	return IRQ_HANDLED;
 }

