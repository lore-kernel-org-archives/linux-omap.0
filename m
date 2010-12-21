From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v1 07/10] OMAP3: hwmod: add dev_attr for McBSP sidetone
Date: Tue, 21 Dec 2010 13:10:27 +0530
Message-ID: <1292917231-13800-7-git-send-email-kishon@ti.com>
References: <1292917231-13800-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43660 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757422Ab0LUHmC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Dec 2010 02:42:02 -0500
In-Reply-To: <1292917231-13800-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, p-basak2@ti.com, b-cousson@ti.com, kishon@ti.com

Add device attribute for OMAP3 McBSP sidetone hwmod data

Discussions related to this change can be found in the following url:
https://patchwork.kernel.org/patch/233221/

Also add a revision member inorder to facilitate the driver to
differentiate between different cpu's.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   12 ++++++++++++
 arch/arm/plat-omap/include/plat/mcbsp.h    |   11 +++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index c9aa2c7..fed722f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -20,6 +20,7 @@
 #include <plat/serial.h>
 #include <plat/l4_3xxx.h>
 #include <plat/i2c.h>
+#include <plat/mcbsp.h>
 #include <plat/omap34xx.h>
 
 #include "omap_hwmod_common_data.h"
@@ -763,6 +764,7 @@ static struct omap_hwmod_class_sysconfig omap3xxx_mcbsp_sysc = {
 static struct omap_hwmod_class omap3xxx_mcbsp_hwmod_class = {
 	.name = "mcbsp",
 	.sysc = &omap3xxx_mcbsp_sysc,
+	.rev  = OMAP_MCBSP_CPU_3,
 };
 
 /* mcbsp1 */
@@ -897,6 +899,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_mcbsp2_slaves[] = {
 	&omap3xxx_l4_per__mcbsp2_dma,
 };
 
+static struct omap_mcbsp_dev_attr omap34xx_mcbsp2_dev_attr = {
+	.sidetone	= "mcbsp2_sidetone",
+};
+
 static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
@@ -916,6 +922,7 @@ static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 	},
 	.slaves		= omap3xxx_mcbsp2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp2_slaves),
+	.dev_attr	= &omap34xx_mcbsp2_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
@@ -974,6 +981,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_mcbsp3_slaves[] = {
 	&omap3xxx_l4_per__mcbsp3_dma,
 };
 
+static struct omap_mcbsp_dev_attr omap34xx_mcbsp3_dev_attr = {
+	.sidetone       = "mcbsp3_sidetone",
+};
+
 static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
@@ -993,6 +1004,7 @@ static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 	},
 	.slaves		= omap3xxx_mcbsp3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp3_slaves),
+	.dev_attr	= &omap34xx_mcbsp3_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index e9bde6e..d8275f7 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -37,6 +37,8 @@ static struct platform_device omap_mcbsp##port_nr = {	\
 	.id	= OMAP_MCBSP##port_nr,			\
 }
 
+#define OMAP_MCBSP_CPU_3	0x3
+
 #define OMAP7XX_MCBSP1_BASE	0xfffb1000
 #define OMAP7XX_MCBSP2_BASE	0xfffb1800
 
@@ -485,6 +487,15 @@ struct omap_mcbsp {
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

