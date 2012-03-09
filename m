From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/4] ARM: OMAP2+: hsmmc: Add a flag to identify modules supporting clock src selection
Date: Fri, 9 Mar 2012 14:41:46 +0530
Message-ID: <1331284309-22101-2-git-send-email-rnayak@ti.com>
References: <1331284309-22101-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47059 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077Ab2CIJMT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Mar 2012 04:12:19 -0500
In-Reply-To: <1331284309-22101-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Balaji TK <balajitk@ti.com>, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

hsmmc2_before_set_reg() seems to do a clock source selection (supported
only on some mmc IP blocks) but decides to do so based on a 'HSMMC_HAS_PBIAS'
feature flag which seems completely wrong. Fix this by adding a new controller
flag 'OMAP_HSMMC_SUPPORTS_CLKSRC_SELECT' which can be then used to identify which
controller instance supports this feature.

Looking at the TRM for OMAP2/3/4, it turns out only the 2 controller instances on
OMAP3 support this, so update this flag in the .dev_attr structure for the
corresponding hwmods.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Balaji TK <balajitk@ti.com>
Cc: Venkatraman S <svenkatr@ti.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/hsmmc.c                |   15 +++++++--------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   14 +++++++++++---
 arch/arm/plat-omap/include/plat/mmc.h      |    1 +
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 19dd165..11e26fc 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -408,8 +408,7 @@ static int omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 			c->caps &= ~MMC_CAP_8_BIT_DATA;
 			c->caps |= MMC_CAP_4_BIT_DATA;
 		}
-		if (mmc->slots[0].features & HSMMC_HAS_PBIAS) {
-			/* off-chip level shifting, or none */
+		if (mmc->controller_flags & OMAP_HSMMC_SUPPORTS_CLKSRC_SELECT) {
 			mmc->slots[0].before_set_reg = hsmmc2_before_set_reg;
 			mmc->slots[0].after_set_reg = NULL;
 		}
@@ -447,12 +446,6 @@ void omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
 		goto done;
 	}
 
-	if (omap_hsmmc_pdata_init(hsmmcinfo, mmc_data) < 0) {
-		pr_err("%s fails!\n", __func__);
-		goto done;
-	}
-	omap_hsmmc_mux(mmc_data, (ctrl_nr - 1));
-
 	name = "omap_hsmmc";
 
 	l = snprintf(oh_name, MAX_OMAP_MMC_HWMOD_NAME_LEN,
@@ -471,6 +464,12 @@ void omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
 		mmc_data->controller_flags = mmc_dev_attr->flags;
 	}
 
+	if (omap_hsmmc_pdata_init(hsmmcinfo, mmc_data) < 0) {
+		pr_err("%s fails!\n", __func__);
+		goto done;
+	}
+	omap_hsmmc_mux(mmc_data, (ctrl_nr - 1));
+
 	pdev = omap_device_build(name, ctrl_nr - 1, oh, mmc_data,
 		sizeof(struct omap_mmc_platform_data), NULL, 0, false);
 	if (IS_ERR(pdev)) {
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 3c8dd92..236785f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3145,13 +3145,15 @@ static struct omap_hwmod_ocp_if *omap3xxx_mmc1_slaves[] = {
 };
 
 static struct omap_mmc_dev_attr mmc1_dev_attr = {
-	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
+	.flags = (OMAP_HSMMC_SUPPORTS_DUAL_VOLT |
+		  OMAP_HSMMC_SUPPORTS_CLKSRC_SELECT),
 };
 
 /* See 35xx errata 2.1.1.128 in SPRZ278F */
 static struct omap_mmc_dev_attr mmc1_pre_es3_dev_attr = {
 	.flags = (OMAP_HSMMC_SUPPORTS_DUAL_VOLT |
-		  OMAP_HSMMC_BROKEN_MULTIBLOCK_READ),
+		  OMAP_HSMMC_BROKEN_MULTIBLOCK_READ |
+		  OMAP_HSMMC_SUPPORTS_CLKSRC_SELECT),
 };
 
 static struct omap_hwmod omap3xxx_pre_es3_mmc1_hwmod = {
@@ -3219,9 +3221,14 @@ static struct omap_hwmod_ocp_if *omap3xxx_mmc2_slaves[] = {
 	&omap3xxx_l4_core__mmc2,
 };
 
+static struct omap_mmc_dev_attr mmc2_dev_attr = {
+	.flags = OMAP_HSMMC_SUPPORTS_CLKSRC_SELECT,
+};
+
 /* See 35xx errata 2.1.1.128 in SPRZ278F */
 static struct omap_mmc_dev_attr mmc2_pre_es3_dev_attr = {
-	.flags = OMAP_HSMMC_BROKEN_MULTIBLOCK_READ,
+	.flags = (OMAP_HSMMC_BROKEN_MULTIBLOCK_READ |
+		  OMAP_HSMMC_SUPPORTS_CLKSRC_SELECT),
 };
 
 static struct omap_hwmod omap3xxx_pre_es3_mmc2_hwmod = {
@@ -3262,6 +3269,7 @@ static struct omap_hwmod omap3xxx_es3plus_mmc2_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_MMC2_SHIFT,
 		},
 	},
+	.dev_attr	= &mmc2_dev_attr,
 	.slaves		= omap3xxx_mmc2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mmc2_slaves),
 	.class		= &omap34xx_mmc_class,
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index f75946c..5d9c98b 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -49,6 +49,7 @@
  */
 #define OMAP_HSMMC_SUPPORTS_DUAL_VOLT		BIT(0)
 #define OMAP_HSMMC_BROKEN_MULTIBLOCK_READ	BIT(1)
+#define OMAP_HSMMC_SUPPORTS_CLKSRC_SELECT	BIT(2)
 
 struct omap_mmc_dev_attr {
 	u8 flags;
-- 
1.7.1

