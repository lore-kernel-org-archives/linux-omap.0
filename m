From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/6] ARM: OMAP3: DMA: Fix for sDMA Errata 1.113
Date: Fri, 05 Dec 2008 12:05:09 -0800
Message-ID: <20081205200509.31125.57671.stgit@localhost>
References: <20081205195846.31125.21080.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52631 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbYLEUFM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 15:05:12 -0500
In-Reply-To: <20081205195846.31125.21080.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

SDMA channel is not disabled after transaction error. So explicitly disable it.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked By : Nishant kamat <nskamat@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 50f8b4a..3df3740 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1848,9 +1848,22 @@ static int omap2_dma_handle_ch(int ch)
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

