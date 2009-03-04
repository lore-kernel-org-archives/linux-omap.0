From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/7] ARM: OMAP: Dispatch only relevant DMA interrupts
Date: Wed, 04 Mar 2009 13:54:55 -0800
Message-ID: <20090304215455.21101.47444.stgit@localhost>
References: <20090304214540.21101.72079.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60970 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812AbZCDVy7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 16:54:59 -0500
In-Reply-To: <20090304214540.21101.72079.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Nishant Kamat <nskamat@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

This fixes the spurious interrupt issue on a DMA channel.

In OMAP sDMA, contrast to the SDMA.DMA4_CSRi registers, the
SDMA.DMA4_IRQSTATUS_Lj registers are updated regardless of
the corresponding bits in the SDMA.DMA4_IRQENABLE_Lj registers.
Since there are four sDMA interrupt lines and if more than one
line is actively used by two concurrently running sDMA softwares
modules,then the spurious interrupt can be observed on the other
lines.

Fix in this patch will only dispatch the relevant and enabled
interrupts on a particular line thus perevting spurious IRQ.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Nishant Kamat <nskamat@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index eca43bb..c46e5a4 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1901,7 +1901,7 @@ static int omap2_dma_handle_ch(int ch)
 /* STATUS register count is from 1-32 while our is 0-31 */
 static irqreturn_t omap2_dma_irq_handler(int irq, void *dev_id)
 {
-	u32 val;
+	u32 val, enable_reg;
 	int i;
 
 	val = dma_read(IRQSTATUS_L0);
@@ -1910,6 +1910,8 @@ static irqreturn_t omap2_dma_irq_handler(int irq, void *dev_id)
 			printk(KERN_WARNING "Spurious DMA IRQ\n");
 		return IRQ_HANDLED;
 	}
+	enable_reg = dma_read(IRQENABLE_L0);
+	val &= enable_reg; /* Dispatch only relevant interrupts */
 	for (i = 0; i < dma_lch_count && val != 0; i++) {
 		if (val & 1)
 			omap2_dma_handle_ch(i);

