From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH] ARM: OMAP3: DMA: Fix for sDMA Errata 1.113
Date: Thu, 25 Sep 2008 15:31:23 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB028BF72897@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39315 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998AbYIYKBe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 06:01:34 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m8PA1PxC011370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 25 Sep 2008 05:01:33 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id m8PA1PYJ022985
	for <linux-omap@vger.kernel.org>; Thu, 25 Sep 2008 15:31:25 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

SDMA channel is not disabled after transaction error. So explicitly disable it.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked By : Nishant kamat <nskamat@ti.com>
---
Index: linux-omap-2.6/arch/arm/plat-omap/dma.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/dma.c	2008-09-23 16:41:23.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/dma.c	2008-09-25 14:54:00.162059260 +0530
@@ -1849,9 +1849,22 @@ static int omap2_dma_handle_ch(int ch)
 		printk(KERN_INFO
 		       "DMA synchronization event drop occurred with device "
 		       "%d\n", dma_chan[ch].dev_id);
-	if (unlikely(status & OMAP2_DMA_TRANS_ERR_IRQ))
+	if (unlikely(status & OMAP2_DMA_TRANS_ERR_IRQ)) {
 		printk(KERN_INFO "DMA transaction error with device %d\n",
 		       dma_chan[ch].dev_id);
+		if (cpu_class_is_omap2()) {
+			/* Errata: sDMA Channel is not disabled
+			 * after a transaction error. So we explicitely
+			 * disable the channel
+			 */
+			u32 ccr;
+
+			ccr = dma_read(CCR(ch));
+			ccr &= ~OMAP_DMA_CCR_EN;
+			dma_write(ccr, CCR(ch));
+			dma_chan[ch].flags &= ~OMAP_DMA_ACTIVE;
+		}
+	}
 	if (unlikely(status & OMAP2_DMA_SECURE_ERR_IRQ))
 		printk(KERN_INFO "DMA secure error with device %d\n",
 		       dma_chan[ch].dev_id);