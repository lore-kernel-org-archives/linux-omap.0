From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/3] OMAP4: clockdomain: Add clkdm static dependency srcs
Date: Mon,  7 Feb 2011 18:47:09 +0530
Message-ID: <1297084631-27474-2-git-send-email-rnayak@ti.com>
References: <1297084631-27474-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40888 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396Ab1BGNR2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Feb 2011 08:17:28 -0500
In-Reply-To: <1297084631-27474-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

OMAP4 supports static dependencies and dynamic dependencies
between clock domains. Static dependencies imply both
wakeup as well as sleep dependencies.
Generate all clockdomain static dependency sources.
(Dynamic dependency sources are hardwired and
cannot to controlled from software).

The autogen scripts are updated to generate the contents
of this patch.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomains44xx_data.c |  390 ++++++++++++++++++++++++++-
 1 files changed, 385 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 2fe1570..7df8001 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -18,11 +18,6 @@
  * published by the Free Software Foundation.
  */
 
-/*
- * To-Do List
- * -> Populate the Sleep/Wakeup dependencies for the domains
- */
-
 #include <linux/kernel.h>
 #include <linux/io.h>
 
@@ -37,6 +32,355 @@
 #include "prcm44xx.h"
 #include "prcm_mpu44xx.h"
 
+/* Static Dependencies for OMAP4 Clock Domains */
+
+static struct clkdm_dep ducati_wkup_sleep_deps[] = {
+	{
+		.clkdm_name	 = "abe_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "ivahd_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_1_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_2_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_dss_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_emif_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_gfx_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_init_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_cfg_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_per_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_secure_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_wkup_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "tesla_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{ NULL },
+};
+
+static struct clkdm_dep iss_wkup_sleep_deps[] = {
+	{
+		.clkdm_name	 = "ivahd_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_1_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_emif_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{ NULL },
+};
+
+static struct clkdm_dep ivahd_wkup_sleep_deps[] = {
+	{
+		.clkdm_name	 = "l3_1_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_emif_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{ NULL },
+};
+
+static struct clkdm_dep l3_d2d_wkup_sleep_deps[] = {
+	{
+		.clkdm_name	 = "abe_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "ivahd_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_1_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_2_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_emif_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_init_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_cfg_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_per_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{ NULL },
+};
+
+static struct clkdm_dep l3_dma_wkup_sleep_deps[] = {
+	{
+		.clkdm_name	 = "abe_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "ducati_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "ivahd_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_1_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_dss_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_emif_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_init_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_cfg_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_per_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_secure_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_wkup_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{ NULL },
+};
+
+static struct clkdm_dep l3_dss_wkup_sleep_deps[] = {
+	{
+		.clkdm_name	 = "ivahd_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_2_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_emif_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{ NULL },
+};
+
+static struct clkdm_dep l3_gfx_wkup_sleep_deps[] = {
+	{
+		.clkdm_name	 = "ivahd_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_1_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_emif_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{ NULL },
+};
+
+static struct clkdm_dep l3_init_wkup_sleep_deps[] = {
+	{
+		.clkdm_name	 = "abe_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "ivahd_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_emif_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_cfg_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_per_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_secure_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_wkup_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{ NULL },
+};
+
+static struct clkdm_dep l4_secure_wkup_sleep_deps[] = {
+	{
+		.clkdm_name	 = "l3_1_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_emif_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_per_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{ NULL },
+};
+
+static struct clkdm_dep mpuss_wkup_sleep_deps[] = {
+	{
+		.clkdm_name	 = "abe_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "ducati_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "ivahd_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_1_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_2_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_dss_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_emif_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_gfx_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_init_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_cfg_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_per_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_secure_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_wkup_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "tesla_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{ NULL },
+};
+
+static struct clkdm_dep tesla_wkup_sleep_deps[] = {
+	{
+		.clkdm_name	 = "abe_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "ivahd_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_1_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_2_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_emif_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l3_init_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_cfg_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_per_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{
+		.clkdm_name	 = "l4_wkup_clkdm",
+		.omap_chip	 = OMAP_CHIP_INIT(CHIP_IS_OMAP4430)
+	},
+	{ NULL },
+};
 
 static struct clockdomain l4_cefuse_44xx_clkdm = {
 	.name		  = "l4_cefuse_clkdm",
@@ -54,6 +398,7 @@ static struct clockdomain l4_cfg_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM2_PARTITION,
 	.cm_inst	  = OMAP4430_CM2_CORE_INST,
 	.clkdm_offs	  = OMAP4430_CM2_CORE_L4CFG_CDOFFS,
+	.dep_bit	  = OMAP4430_L4CFG_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -64,6 +409,9 @@ static struct clockdomain tesla_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM1_PARTITION,
 	.cm_inst	  = OMAP4430_CM1_TESLA_INST,
 	.clkdm_offs	  = OMAP4430_CM1_TESLA_TESLA_CDOFFS,
+	.dep_bit	  = OMAP4430_TESLA_STATDEP_SHIFT,
+	.wkdep_srcs	  = tesla_wkup_sleep_deps,
+	.sleepdep_srcs	  = tesla_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -74,6 +422,9 @@ static struct clockdomain l3_gfx_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM2_PARTITION,
 	.cm_inst	  = OMAP4430_CM2_GFX_INST,
 	.clkdm_offs	  = OMAP4430_CM2_GFX_GFX_CDOFFS,
+	.dep_bit	  = OMAP4430_GFX_STATDEP_SHIFT,
+	.wkdep_srcs	  = l3_gfx_wkup_sleep_deps,
+	.sleepdep_srcs	  = l3_gfx_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -84,6 +435,9 @@ static struct clockdomain ivahd_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM2_PARTITION,
 	.cm_inst	  = OMAP4430_CM2_IVAHD_INST,
 	.clkdm_offs	  = OMAP4430_CM2_IVAHD_IVAHD_CDOFFS,
+	.dep_bit	  = OMAP4430_IVAHD_STATDEP_SHIFT,
+	.wkdep_srcs	  = ivahd_wkup_sleep_deps,
+	.sleepdep_srcs	  = ivahd_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -94,6 +448,9 @@ static struct clockdomain l4_secure_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM2_PARTITION,
 	.cm_inst	  = OMAP4430_CM2_L4PER_INST,
 	.clkdm_offs	  = OMAP4430_CM2_L4PER_L4SEC_CDOFFS,
+	.dep_bit	  = OMAP4430_L4SEC_STATDEP_SHIFT,
+	.wkdep_srcs	  = l4_secure_wkup_sleep_deps,
+	.sleepdep_srcs	  = l4_secure_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -104,6 +461,7 @@ static struct clockdomain l4_per_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM2_PARTITION,
 	.cm_inst	  = OMAP4430_CM2_L4PER_INST,
 	.clkdm_offs	  = OMAP4430_CM2_L4PER_L4PER_CDOFFS,
+	.dep_bit	  = OMAP4430_L4PER_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -114,6 +472,7 @@ static struct clockdomain abe_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM1_PARTITION,
 	.cm_inst	  = OMAP4430_CM1_ABE_INST,
 	.clkdm_offs	  = OMAP4430_CM1_ABE_ABE_CDOFFS,
+	.dep_bit	  = OMAP4430_ABE_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -133,6 +492,9 @@ static struct clockdomain l3_init_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM2_PARTITION,
 	.cm_inst	  = OMAP4430_CM2_L3INIT_INST,
 	.clkdm_offs	  = OMAP4430_CM2_L3INIT_L3INIT_CDOFFS,
+	.dep_bit	  = OMAP4430_L3INIT_STATDEP_SHIFT,
+	.wkdep_srcs	  = l3_init_wkup_sleep_deps,
+	.sleepdep_srcs	  = l3_init_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -143,6 +505,8 @@ static struct clockdomain mpuss_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM1_PARTITION,
 	.cm_inst	  = OMAP4430_CM1_MPU_INST,
 	.clkdm_offs	  = OMAP4430_CM1_MPU_MPU_CDOFFS,
+	.wkdep_srcs	  = mpuss_wkup_sleep_deps,
+	.sleepdep_srcs	  = mpuss_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -173,6 +537,7 @@ static struct clockdomain l3_emif_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM2_PARTITION,
 	.cm_inst	  = OMAP4430_CM2_CORE_INST,
 	.clkdm_offs	  = OMAP4430_CM2_CORE_MEMIF_CDOFFS,
+	.dep_bit	  = OMAP4430_MEMIF_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -193,6 +558,9 @@ static struct clockdomain ducati_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM2_PARTITION,
 	.cm_inst	  = OMAP4430_CM2_CORE_INST,
 	.clkdm_offs	  = OMAP4430_CM2_CORE_DUCATI_CDOFFS,
+	.dep_bit	  = OMAP4430_DUCATI_STATDEP_SHIFT,
+	.wkdep_srcs	  = ducati_wkup_sleep_deps,
+	.sleepdep_srcs	  = ducati_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -203,6 +571,7 @@ static struct clockdomain l3_2_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM2_PARTITION,
 	.cm_inst	  = OMAP4430_CM2_CORE_INST,
 	.clkdm_offs	  = OMAP4430_CM2_CORE_L3_2_CDOFFS,
+	.dep_bit	  = OMAP4430_L3_2_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -213,6 +582,7 @@ static struct clockdomain l3_1_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM2_PARTITION,
 	.cm_inst	  = OMAP4430_CM2_CORE_INST,
 	.clkdm_offs	  = OMAP4430_CM2_CORE_L3_1_CDOFFS,
+	.dep_bit	  = OMAP4430_L3_1_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -223,6 +593,8 @@ static struct clockdomain l3_d2d_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM2_PARTITION,
 	.cm_inst	  = OMAP4430_CM2_CORE_INST,
 	.clkdm_offs	  = OMAP4430_CM2_CORE_D2D_CDOFFS,
+	.wkdep_srcs	  = l3_d2d_wkup_sleep_deps,
+	.sleepdep_srcs	  = l3_d2d_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -233,6 +605,8 @@ static struct clockdomain iss_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM2_PARTITION,
 	.cm_inst	  = OMAP4430_CM2_CAM_INST,
 	.clkdm_offs	  = OMAP4430_CM2_CAM_CAM_CDOFFS,
+	.wkdep_srcs	  = iss_wkup_sleep_deps,
+	.sleepdep_srcs	  = iss_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -243,6 +617,9 @@ static struct clockdomain l3_dss_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM2_PARTITION,
 	.cm_inst	  = OMAP4430_CM2_DSS_INST,
 	.clkdm_offs	  = OMAP4430_CM2_DSS_DSS_CDOFFS,
+	.dep_bit	  = OMAP4430_DSS_STATDEP_SHIFT,
+	.wkdep_srcs	  = l3_dss_wkup_sleep_deps,
+	.sleepdep_srcs	  = l3_dss_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -253,6 +630,7 @@ static struct clockdomain l4_wkup_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.cm_inst	  = OMAP4430_PRM_WKUP_CM_INST,
 	.clkdm_offs	  = OMAP4430_PRM_WKUP_CM_WKUP_CDOFFS,
+	.dep_bit	  = OMAP4430_L4WKUP_STATDEP_SHIFT,
 	.flags		  = CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -273,6 +651,8 @@ static struct clockdomain l3_dma_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_CM2_PARTITION,
 	.cm_inst	  = OMAP4430_CM2_CORE_INST,
 	.clkdm_offs	  = OMAP4430_CM2_CORE_SDMA_CDOFFS,
+	.wkdep_srcs	  = l3_dma_wkup_sleep_deps,
+	.sleepdep_srcs	  = l3_dma_wkup_sleep_deps,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
-- 
1.7.0.4

