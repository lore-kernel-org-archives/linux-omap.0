From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v3] arm: omap4: hsmmc: check for null pointer
Date: Wed, 25 Apr 2012 17:27:46 +0530
Message-ID: <1335355066-26279-1-git-send-email-balajitk@ti.com>
References: <20120423144348.GF26302@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55782 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758681Ab2DYLyX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 07:54:23 -0400
In-Reply-To: <20120423144348.GF26302@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: balbi@ti.com, tony@atomide.com, Balaji T K <balajitk@ti.com>

platform_device pdev can be NULL if CONFIG_MMC_OMAP_HS is not set.
Add check for NULL pointer. while at it move the duplicated functions
to omap4-common.c

Fixes the following boot crash seen with omap4sdp and omap4panda
when MMC is disabled.

Unable to handle kernel NULL pointer dereference at virtual address 0000008c
pgd = c0004000
[0000008c] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0    Not tainted  (3.4.0-rc1-05971-ga4dfa82 #4)
PC is at omap_4430sdp_init+0x184/0x410
LR is at device_add+0x1a0/0x664

Signed-off-by: Balaji T K <balajitk@ti.com>
Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
v3:
do nothing in omap4_twl6030_hsmmc_init when CONFIG_MMC_OMAP_HS is disabled

v2:
move omap4 mmc board init functions to omap4-common.c

 arch/arm/mach-omap2/board-4430sdp.c     |   44 -----------------------
 arch/arm/mach-omap2/board-omap4panda.c  |   49 --------------------------
 arch/arm/mach-omap2/board-omap4pcm049.c |   45 ------------------------
 arch/arm/mach-omap2/common.h            |    3 ++
 arch/arm/mach-omap2/omap4-common.c      |   58 +++++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+), 138 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index a39fc4b..ec06103 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -488,50 +488,6 @@ static struct platform_device omap_vwlan_device = {
 	},
 };
 
-static int omap4_twl6030_hsmmc_late_init(struct device *dev)
-{
-	int irq = 0;
-	struct platform_device *pdev = container_of(dev,
-				struct platform_device, dev);
-	struct omap_mmc_platform_data *pdata = dev->platform_data;
-
-	/* Setting MMC1 Card detect Irq */
-	if (pdev->id == 0) {
-		irq = twl6030_mmc_card_detect_config();
-		if (irq < 0) {
-			pr_err("Failed configuring MMC1 card detect\n");
-			return irq;
-		}
-		pdata->slots[0].card_detect_irq = irq;
-		pdata->slots[0].card_detect = twl6030_mmc_card_detect;
-	}
-	return 0;
-}
-
-static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
-{
-	struct omap_mmc_platform_data *pdata;
-
-	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
-	if (!dev) {
-		pr_err("Failed %s\n", __func__);
-		return;
-	}
-	pdata = dev->platform_data;
-	pdata->init =	omap4_twl6030_hsmmc_late_init;
-}
-
-static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
-{
-	struct omap2_hsmmc_info *c;
-
-	omap_hsmmc_init(controllers);
-	for (c = controllers; c->mmc; c++)
-		omap4_twl6030_hsmmc_set_late_init(&c->pdev->dev);
-
-	return 0;
-}
-
 static struct regulator_init_data sdp4430_vaux1 = {
 	.constraints = {
 		.min_uV			= 1000000,
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index f864065..0ecf074 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -235,55 +235,6 @@ static struct wl12xx_platform_data omap_panda_wlan_data  __initdata = {
 	.board_ref_clock = 2,
 };
 
-static int omap4_twl6030_hsmmc_late_init(struct device *dev)
-{
-	int irq = 0;
-	struct platform_device *pdev = container_of(dev,
-				struct platform_device, dev);
-	struct omap_mmc_platform_data *pdata = dev->platform_data;
-
-	if (!pdata) {
-		dev_err(dev, "%s: NULL platform data\n", __func__);
-		return -EINVAL;
-	}
-	/* Setting MMC1 Card detect Irq */
-	if (pdev->id == 0) {
-		irq = twl6030_mmc_card_detect_config();
-		if (irq < 0) {
-			dev_err(dev, "%s: Error card detect config(%d)\n",
-				__func__, irq);
-			return irq;
-		}
-		pdata->slots[0].card_detect = twl6030_mmc_card_detect;
-	}
-	return 0;
-}
-
-static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
-{
-	struct omap_mmc_platform_data *pdata;
-
-	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
-	if (!dev) {
-		pr_err("Failed omap4_twl6030_hsmmc_set_late_init\n");
-		return;
-	}
-	pdata = dev->platform_data;
-
-	pdata->init =	omap4_twl6030_hsmmc_late_init;
-}
-
-static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
-{
-	struct omap2_hsmmc_info *c;
-
-	omap_hsmmc_init(controllers);
-	for (c = controllers; c->mmc; c++)
-		omap4_twl6030_hsmmc_set_late_init(&c->pdev->dev);
-
-	return 0;
-}
-
 static struct twl4030_codec_data twl6040_codec = {
 	/* single-step ramp for headset and handsfree */
 	.hs_left_step	= 0x0f,
diff --git a/arch/arm/mach-omap2/board-omap4pcm049.c b/arch/arm/mach-omap2/board-omap4pcm049.c
index 8dc93dc..d46714e 100644
--- a/arch/arm/mach-omap2/board-omap4pcm049.c
+++ b/arch/arm/mach-omap2/board-omap4pcm049.c
@@ -153,51 +153,6 @@ static inline void __init pcm049_init_smsc911x(void)
 static inline void __init pcm049_init_smsc911x(void) { return; }
 #endif
 
-static int omap4_twl6030_hsmmc_late_init(struct device *dev)
-{
-	int ret = 0;
-	struct platform_device *pdev = container_of(dev,
-				struct platform_device, dev);
-	struct omap_mmc_platform_data *pdata = dev->platform_data;
-
-	/* Setting MMC1 Card detect Irq */
-	if (pdev->id == 0) {
-		ret = twl6030_mmc_card_detect_config();
-		if (ret)
-			dev_err(dev, "%s: Error card detect config(%d)\n",
-				__func__, ret);
-		pdata->slots[0].card_detect_irq = TWL6030_IRQ_BASE +
-						MMCDETECT_INTR_OFFSET;
-		pdata->slots[0].card_detect = twl6030_mmc_card_detect;
-	}
-	return ret;
-}
-
-static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
-{
-	struct omap_mmc_platform_data *pdata;
-
-	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
-	if (!dev) {
-		pr_err("Failed omap4_twl6030_hsmmc_set_late_init\n");
-		return;
-	}
-	pdata = dev->platform_data;
-
-	pdata->init =	omap4_twl6030_hsmmc_late_init;
-}
-
-static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
-{
-	struct omap2_hsmmc_info *c;
-
-	omap_hsmmc_init(controllers);
-	for (c = controllers; c->mmc; c++)
-		omap4_twl6030_hsmmc_set_late_init(&c->pdev->dev);
-
-	return 0;
-}
-
 /* Fixed regulator for max1027 */
 static struct regulator_consumer_supply pcm049_vcc_3v3_consumer_supply[] = {
 	REGULATOR_SUPPLY("vcc", "4-0064"),
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 0e95efc..f14b3ae 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -27,6 +27,7 @@
 #ifndef __ASSEMBLER__
 
 #include <linux/delay.h>
+#include <linux/i2c/twl.h>
 #include <plat/common.h>
 #include <asm/proc-fns.h>
 
@@ -252,6 +253,8 @@ static inline u32 omap4_mpuss_read_prev_context_state(void)
 struct omap_sdrc_params;
 extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1);
+struct omap2_hsmmc_info;
+extern int omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers);
 
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 70de277..a8161e5 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -25,11 +25,13 @@
 #include <plat/irqs.h>
 #include <plat/sram.h>
 #include <plat/omap-secure.h>
+#include <plat/mmc.h>
 
 #include <mach/hardware.h>
 #include <mach/omap-wakeupgen.h>
 
 #include "common.h"
+#include "hsmmc.h"
 #include "omap4-sar-layout.h"
 #include <linux/export.h>
 
@@ -207,3 +209,59 @@ static int __init omap4_sar_ram_init(void)
 	return 0;
 }
 early_initcall(omap4_sar_ram_init);
+
+#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
+static int omap4_twl6030_hsmmc_late_init(struct device *dev)
+{
+	int irq = 0;
+	struct platform_device *pdev = container_of(dev,
+				struct platform_device, dev);
+	struct omap_mmc_platform_data *pdata = dev->platform_data;
+
+	/* Setting MMC1 Card detect Irq */
+	if (pdev->id == 0) {
+		irq = twl6030_mmc_card_detect_config();
+		if (irq < 0) {
+			dev_err(dev, "%s: Error card detect config(%d)\n",
+				__func__, irq);
+			return irq;
+		}
+		pdata->slots[0].card_detect_irq = irq;
+		pdata->slots[0].card_detect = twl6030_mmc_card_detect;
+	}
+	return 0;
+}
+
+static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
+{
+	struct omap_mmc_platform_data *pdata;
+
+	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
+	if (!dev) {
+		pr_err("Failed %s\n", __func__);
+		return;
+	}
+	pdata = dev->platform_data;
+	pdata->init =	omap4_twl6030_hsmmc_late_init;
+}
+
+int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
+{
+	struct omap2_hsmmc_info *c;
+
+	omap_hsmmc_init(controllers);
+	for (c = controllers; c->mmc; c++) {
+		/* pdev can be null if CONFIG_MMC_OMAP_HS is not set */
+		if (!c->pdev)
+			continue;
+		omap4_twl6030_hsmmc_set_late_init(&c->pdev->dev);
+	}
+
+	return 0;
+}
+#else
+int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
+{
+	return 0;
+}
+#endif
-- 
1.7.0.4

