From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 06/11] ARM: omap: remove mmc platform data dma_mask and
 initialization
Date: Thu, 07 Jun 2012 12:08:14 +0100
Message-ID: <E1ScaZa-0003tu-OD@rmk-PC.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54317 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260Ab2FGLIU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 07:08:20 -0400
In-Reply-To: <20120607110610.GB15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

DMAengine uses the DMA engine device structure when mapping/unmapping
memory for DMA, so the MMC devices do not need their DMA masks
initialized (this reflects hardware: the MMC device is not the device
doing DMA.)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/board-h2-mmc.c    |    1 -
 arch/arm/mach-omap1/board-h3-mmc.c    |    1 -
 arch/arm/mach-omap1/board-nokia770.c  |    1 -
 arch/arm/mach-omap2/board-n8x0.c      |    1 -
 arch/arm/mach-omap2/hsmmc.c           |    1 -
 arch/arm/plat-omap/include/plat/mmc.h |    2 --
 6 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
index da0e37d..e1362ce 100644
--- a/arch/arm/mach-omap1/board-h2-mmc.c
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -54,7 +54,6 @@ static struct omap_mmc_platform_data mmc1_data = {
 	.nr_slots                       = 1,
 	.init				= mmc_late_init,
 	.cleanup			= mmc_cleanup,
-	.dma_mask			= 0xffffffff,
 	.slots[0]       = {
 		.set_power              = mmc_set_power,
 		.ocr_mask               = MMC_VDD_32_33 | MMC_VDD_33_34,
diff --git a/arch/arm/mach-omap1/board-h3-mmc.c b/arch/arm/mach-omap1/board-h3-mmc.c
index f8242aa..c74daac 100644
--- a/arch/arm/mach-omap1/board-h3-mmc.c
+++ b/arch/arm/mach-omap1/board-h3-mmc.c
@@ -36,7 +36,6 @@ static int mmc_set_power(struct device *dev, int slot, int power_on,
  */
 static struct omap_mmc_platform_data mmc1_data = {
 	.nr_slots                       = 1,
-	.dma_mask			= 0xffffffff,
 	.slots[0]       = {
 		.set_power              = mmc_set_power,
 		.ocr_mask               = MMC_VDD_32_33 | MMC_VDD_33_34,
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 7212ae9..c54b45f 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -185,7 +185,6 @@ static int nokia770_mmc_get_cover_state(struct device *dev, int slot)
 
 static struct omap_mmc_platform_data nokia770_mmc2_data = {
 	.nr_slots                       = 1,
-	.dma_mask			= 0xffffffff,
 	.max_freq                       = 12000000,
 	.slots[0]       = {
 		.set_power		= nokia770_mmc_set_power,
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 8ca14e8..6d70e81 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -470,7 +470,6 @@ static struct omap_mmc_platform_data mmc1_data = {
 	.cleanup			= n8x0_mmc_cleanup,
 	.shutdown			= n8x0_mmc_shutdown,
 	.max_freq			= 24000000,
-	.dma_mask			= 0xffffffff,
 	.slots[0] = {
 		.wires			= 4,
 		.set_power		= n8x0_mmc_set_power,
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index be697d4..a9675d8 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -315,7 +315,6 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	mmc->slots[0].caps = c->caps;
 	mmc->slots[0].pm_caps = c->pm_caps;
 	mmc->slots[0].internal_clock = !c->ext_clock;
-	mmc->dma_mask = 0xffffffff;
 	mmc->max_freq = c->max_freq;
 	if (cpu_is_omap44xx())
 		mmc->reg_offset = OMAP4_MMC_REG_OFFSET;
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index a7754a8..a76f423 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -81,8 +81,6 @@ struct omap_mmc_platform_data {
 	/* Return context loss count due to PM states changing */
 	int (*get_context_loss_count)(struct device *dev);
 
-	u64 dma_mask;
-
 	/* Integrating attributes from the omap_hwmod layer */
 	u8 controller_flags;
 
-- 
1.7.4.4

