From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/14] omap: Use ioremap in dma.c
Date: Fri, 16 Oct 2009 16:40:41 -0700
Message-ID: <20091016234041.2463.47395.stgit@localhost>
References: <20091016233624.2463.26653.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59868 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbZJPXki (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 19:40:38 -0400
In-Reply-To: <20091016233624.2463.26653.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Use ioremap in dma.c

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |   34 ++++++++++++++++++++++++----------
 1 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 0eb676d..034686d 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2347,40 +2347,46 @@ EXPORT_SYMBOL(omap_stop_lcd_dma);
 
 static int __init omap_init_dma(void)
 {
+	unsigned long base;
 	int ch, r;
 
 	if (cpu_class_is_omap1()) {
-		omap_dma_base = OMAP1_IO_ADDRESS(OMAP1_DMA_BASE);
+		base = OMAP1_DMA_BASE;
 		dma_lch_count = OMAP1_LOGICAL_DMA_CH_COUNT;
 	} else if (cpu_is_omap24xx()) {
-		omap_dma_base = OMAP2_IO_ADDRESS(OMAP24XX_DMA4_BASE);
+		base = OMAP24XX_DMA4_BASE;
 		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
 	} else if (cpu_is_omap34xx()) {
-		omap_dma_base = OMAP2_IO_ADDRESS(OMAP34XX_DMA4_BASE);
+		base = OMAP34XX_DMA4_BASE;
 		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
 	} else if (cpu_is_omap44xx()) {
-		omap_dma_base = OMAP2_IO_ADDRESS(OMAP44XX_DMA4_BASE);
+		base = OMAP44XX_DMA4_BASE;
 		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
 	} else {
 		pr_err("DMA init failed for unsupported omap\n");
 		return -ENODEV;
 	}
 
+	omap_dma_base = ioremap(base, SZ_4K);
+	BUG_ON(!omap_dma_base);
+
 	if (cpu_class_is_omap2() && omap_dma_reserve_channels
 			&& (omap_dma_reserve_channels <= dma_lch_count))
 		dma_lch_count = omap_dma_reserve_channels;
 
 	dma_chan = kzalloc(sizeof(struct omap_dma_lch) * dma_lch_count,
 				GFP_KERNEL);
-	if (!dma_chan)
-		return -ENOMEM;
+	if (!dma_chan) {
+		r = -ENOMEM;
+		goto out_unmap;
+	}
 
 	if (cpu_class_is_omap2()) {
 		dma_linked_lch = kzalloc(sizeof(struct dma_link_info) *
 						dma_lch_count, GFP_KERNEL);
 		if (!dma_linked_lch) {
-			kfree(dma_chan);
-			return -ENOMEM;
+			r = -ENOMEM;
+			goto out_free;
 		}
 	}
 
@@ -2454,7 +2460,7 @@ static int __init omap_init_dma(void)
 				for (i = 0; i < ch; i++)
 					free_irq(omap1_dma_irq[i],
 						 (void *) (i + 1));
-				return r;
+				goto out_free;
 			}
 		}
 	}
@@ -2496,11 +2502,19 @@ static int __init omap_init_dma(void)
 			       "(error %d)\n", r);
 			for (i = 0; i < dma_chan_count; i++)
 				free_irq(omap1_dma_irq[i], (void *) (i + 1));
-			return r;
+			goto out_free;
 		}
 	}
 
 	return 0;
+
+out_free:
+	kfree(dma_chan);
+
+out_unmap:
+	iounmap(omap_dma_base);
+
+	return r;
 }
 
 arch_initcall(omap_init_dma);

