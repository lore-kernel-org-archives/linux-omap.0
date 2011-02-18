From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 07/13] OMAP3: hwmod: add dev_attr for McBSP sidetone
Date: Fri, 18 Feb 2011 19:52:22 +0530
Message-ID: <1298038948-19871-8-git-send-email-kishon@ti.com>
References: <1298038948-19871-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49622 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758228Ab1BRO2P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 09:28:15 -0500
In-Reply-To: <1298038948-19871-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, broonie@opensource.wolfsonmicro.com, jhnikula@gmail.com, peter.ujfalusi@nokia.com
Cc: p-basak2@ti.com, kishon@ti.com, charu@ti.com, shubhrajyoti@ti.com

Since the sidetone block is tightly coupled to the mcbsp, sidetone information
is directly added to mcbsp2 & 3 hwmod dev_attr.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   10 ++++++++++
 arch/arm/plat-omap/include/plat/mcbsp.h    |    9 +++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index dd43199..e9298e9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1355,6 +1355,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_mcbsp2_slaves[] = {
 	&omap3xxx_l4_per__mcbsp2,
 };
 
+static struct omap_mcbsp_dev_attr omap34xx_mcbsp2_dev_attr = {
+	.sidetone	= "mcbsp2_sidetone",
+};
+
 static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
@@ -1374,6 +1378,7 @@ static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 	},
 	.slaves		= omap3xxx_mcbsp2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp2_slaves),
+	.dev_attr	= &omap34xx_mcbsp2_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
@@ -1413,6 +1418,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_mcbsp3_slaves[] = {
 	&omap3xxx_l4_per__mcbsp3,
 };
 
+static struct omap_mcbsp_dev_attr omap34xx_mcbsp3_dev_attr = {
+	.sidetone       = "mcbsp3_sidetone",
+};
+
 static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
@@ -1432,6 +1441,7 @@ static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 	},
 	.slaves		= omap3xxx_mcbsp3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp3_slaves),
+	.dev_attr	= &omap34xx_mcbsp3_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index afcbb7b..1fe0637 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -475,6 +475,15 @@ struct omap_mcbsp {
 #endif
 	void *reg_cache;
 };
+
+/**
+ * omap_mcbsp_dev_attr - OMAP McBSP device attributes for omap_hwmod
+ * @sidetone: name of the sidetone device
+ */
+struct omap_mcbsp_dev_attr {
+	const char *sidetone;
+};
+
 extern struct omap_mcbsp **mcbsp_ptr;
 extern int omap_mcbsp_count, omap_mcbsp_cache_size;
 
-- 
1.7.0.4

