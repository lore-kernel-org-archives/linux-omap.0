From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/4] OMAP: hwmod: Rename dma_ch to dma_req
Date: Wed,  4 Aug 2010 23:38:27 +0200
Message-ID: <1280957910-22718-2-git-send-email-b-cousson@ti.com>
References: <1280957910-22718-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44574 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186Ab0HDVij (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Aug 2010 17:38:39 -0400
In-Reply-To: <1280957910-22718-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, Benoit Cousson <b-cousson@ti.com>

The dma request line attribute was named dma channel, which leads
to confusion with the real dma channel definition.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   10 +++++-----
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cb911d7..8bf19a7 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1468,7 +1468,7 @@ int omap_hwmod_count_resources(struct omap_hwmod *oh)
 {
 	int ret, i;
 
-	ret = oh->mpu_irqs_cnt + oh->sdma_chs_cnt;
+	ret = oh->mpu_irqs_cnt + oh->sdma_reqs_cnt;
 
 	for (i = 0; i < oh->slaves_cnt; i++)
 		ret += oh->slaves[i]->addr_cnt;
@@ -1501,10 +1501,10 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 		r++;
 	}
 
-	for (i = 0; i < oh->sdma_chs_cnt; i++) {
-		(res + r)->name = (oh->sdma_chs + i)->name;
-		(res + r)->start = (oh->sdma_chs + i)->dma_ch;
-		(res + r)->end = (oh->sdma_chs + i)->dma_ch;
+	for (i = 0; i < oh->sdma_reqs_cnt; i++) {
+		(res + r)->name = (oh->sdma_reqs + i)->name;
+		(res + r)->start = (oh->sdma_reqs + i)->dma_req;
+		(res + r)->end = (oh->sdma_reqs + i)->dma_req;
 		(res + r)->flags = IORESOURCE_DMA;
 		r++;
 	}
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index a4e508d..5506d80 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -96,7 +96,7 @@ struct omap_hwmod_irq_info {
 /**
  * struct omap_hwmod_dma_info - DMA channels used by the hwmod
  * @name: name of the DMA channel (module local name)
- * @dma_ch: DMA channel ID
+ * @dma_req: DMA request ID
  *
  * @name should be something short, e.g., "tx" or "rx".  It is for use
  * by platform_get_resource_byname().  It is defined locally to the
@@ -104,7 +104,7 @@ struct omap_hwmod_irq_info {
  */
 struct omap_hwmod_dma_info {
 	const char	*name;
-	u16		dma_ch;
+	u16		dma_req;
 };
 
 /**
@@ -410,7 +410,7 @@ struct omap_hwmod_class {
  * @class: struct omap_hwmod_class * to the class of this hwmod
  * @od: struct omap_device currently associated with this hwmod (internal use)
  * @mpu_irqs: ptr to an array of MPU IRQs (see also mpu_irqs_cnt)
- * @sdma_chs: ptr to an array of SDMA channel IDs (see also sdma_chs_cnt)
+ * @sdma_reqs: ptr to an array of System DMA request IDs (see sdma_reqs_cnt)
  * @prcm: PRCM data pertaining to this hwmod
  * @main_clk: main clock: OMAP clock name
  * @_clk: pointer to the main struct clk (filled in at runtime)
@@ -424,7 +424,7 @@ struct omap_hwmod_class {
  * @msuspendmux_reg_id: CONTROL_MSUSPENDMUX register ID (1-6)
  * @msuspendmux_shift: CONTROL_MSUSPENDMUX register bit shift
  * @mpu_irqs_cnt: number of @mpu_irqs
- * @sdma_chs_cnt: number of @sdma_chs
+ * @sdma_reqs_cnt: number of @sdma_reqs
  * @opt_clks_cnt: number of @opt_clks
  * @master_cnt: number of @master entries
  * @slaves_cnt: number of @slave entries
@@ -448,7 +448,7 @@ struct omap_hwmod {
 	struct omap_hwmod_class		*class;
 	struct omap_device		*od;
 	struct omap_hwmod_irq_info	*mpu_irqs;
-	struct omap_hwmod_dma_info	*sdma_chs;
+	struct omap_hwmod_dma_info	*sdma_reqs;
 	union {
 		struct omap_hwmod_omap2_prcm omap2;
 		struct omap_hwmod_omap4_prcm omap4;
@@ -468,7 +468,7 @@ struct omap_hwmod {
 	u8				msuspendmux_shift;
 	u8				response_lat;
 	u8				mpu_irqs_cnt;
-	u8				sdma_chs_cnt;
+	u8				sdma_reqs_cnt;
 	u8				opt_clks_cnt;
 	u8				masters_cnt;
 	u8				slaves_cnt;
-- 
1.6.1.3

