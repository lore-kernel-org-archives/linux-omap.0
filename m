From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/7] ARM: OMAP: dma: Make use of cpu_class_is_omap2() to avoid future patching.
Date: Wed, 2 May 2012 15:18:10 +0530
Message-ID: <1335952093-12541-5-git-send-email-santosh.shilimkar@ti.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49954 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111Ab2EBJsd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 05:48:33 -0400
In-Reply-To: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

cpu_class_is_omap2() contains all OMAP2+ devices. So update the DMA code
cpu checks accordingly so that there is no need to patch
the file for any future OMAP2+ devices.

In long run, all these attributes should come from hwmod dev_attr based
on DMA IP version.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/dma.c |    2 +-
 arch/arm/plat-omap/dma.c  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index b19d849..2750bb9 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -227,7 +227,7 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 
 	dma_stride		= OMAP2_DMA_STRIDE;
 	dma_common_ch_start	= CSDP;
-	if (cpu_is_omap3630() || cpu_is_omap44xx())
+	if (omap_rev() >= OMAP3630_REV_ES1_0)
 		dma_common_ch_end = CCDN;
 	else
 		dma_common_ch_end = CCFN;
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index ecdb3da..c046a19 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -843,7 +843,7 @@ omap_dma_set_prio_lch(int lch, unsigned char read_prio,
 	}
 	l = p->dma_read(CCR, lch);
 	l &= ~((1 << 6) | (1 << 26));
-	if (cpu_is_omap2430() || cpu_is_omap34xx() ||  cpu_is_omap44xx())
+	if (cpu_class_is_omap2() && !cpu_is_omap242x())
 		l |= ((read_prio & 0x1) << 6) | ((write_prio & 0x1) << 26);
 	else
 		l |= ((read_prio & 0x1) << 6);
@@ -2057,7 +2057,7 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx())
+	if (cpu_class_is_omap2() && !cpu_is_omap242x())
 		omap_dma_set_global_params(DMA_DEFAULT_ARB_RATE,
 				DMA_DEFAULT_FIFO_DEPTH, 0);
 
-- 
1.7.5.4

