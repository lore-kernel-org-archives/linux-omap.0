From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH] OMAP: sDMA: DMA : DMA spurious IRQ in shared usage
Date: Wed, 4 Feb 2009 14:42:30 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A3E3D86D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48546 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbZBDJMk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 04:12:40 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony,
Here is the second patch which fixes the spurious irq issue on sDMA when used by two software modules with independent interrupt lines.

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
Acked By: Nishant Kamat <nskamat@ti.com>
cc: Tony Lindgren <tony@atomide.com>

---
 arch/arm/plat-omap/dma.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

Index: omapkernel/arch/arm/plat-omap/dma.c
===================================================================
--- omapkernel.orig/arch/arm/plat-omap/dma.c	2009-02-04 13:07:51.000000000 +0530
+++ omapkernel/arch/arm/plat-omap/dma.c	2009-02-04 14:00:38.709913959 +0530
@@ -1954,7 +1954,7 @@ static int omap2_dma_handle_ch(int ch)
 /* STATUS register count is from 1-32 while our is 0-31 */
 static irqreturn_t omap2_dma_irq_handler(int irq, void *dev_id)
 {
-	u32 val;
+	u32 val, enable_reg;
 	int i;
 
 	val = dma_read(IRQSTATUS_L0);
@@ -1963,6 +1963,8 @@ static irqreturn_t omap2_dma_irq_handler
 			printk(KERN_WARNING "Spurious DMA IRQ\n");
 		return IRQ_HANDLED;
 	}
+	enable_reg = dma_read(IRQENABLE_L0);
+	val &= enable_reg; /* Dispatch only relevant interrupts */
 	for (i = 0; i < dma_lch_count && val != 0; i++) {
 		if (val & 1)
 			omap2_dma_handle_ch(i);


Regards,
Santosh
