From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 07/13] OMAP3: hwmod: add dev_attr for McBSP sidetone
Date: Mon, 31 Jan 2011 20:20:31 +0530
Message-ID: <1296485437-12806-8-git-send-email-kishon@ti.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40377 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176Ab1AaO4X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Jan 2011 09:56:23 -0500
In-Reply-To: <1296485437-12806-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, p-basak2@ti.com, Kishon Vijay Abraham I <kishon@ti.com>

Since the sidetone block is tightly coupled to the mcbsp, sidetone information
is directly added to mcbsp2 & 3 hwmod dev_attr.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   10 ++++++++++
 arch/arm/plat-omap/include/plat/mcbsp.h    |    9 +++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 0fb05d5..7c50609 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1388,6 +1388,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_mcbsp2_slaves[] = {
 	&omap3xxx_l4_per__mcbsp2_dma,
 };
 
+static struct omap_mcbsp_dev_attr omap34xx_mcbsp2_dev_attr = {
+	.sidetone	= "mcbsp2_sidetone",
+};
+
 static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
@@ -1407,6 +1411,7 @@ static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 	},
 	.slaves		= omap3xxx_mcbsp2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp2_slaves),
+	.dev_attr	= &omap34xx_mcbsp2_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
@@ -1465,6 +1470,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_mcbsp3_slaves[] = {
 	&omap3xxx_l4_per__mcbsp3_dma,
 };
 
+static struct omap_mcbsp_dev_attr omap34xx_mcbsp3_dev_attr = {
+	.sidetone       = "mcbsp3_sidetone",
+};
+
 static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
@@ -1484,6 +1493,7 @@ static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 	},
 	.slaves		= omap3xxx_mcbsp3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp3_slaves),
+	.dev_attr	= &omap34xx_mcbsp3_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 06bd1dc..27bfb1d 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -489,6 +489,15 @@ struct omap_mcbsp {
 #endif
 	void *reg_cache;
 };
+
+/**
+ * omap_mcbsp_dev_attr - OMAP MCBSP device attributes for omap_hwmod
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

