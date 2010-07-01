From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [RFC 1/6] omap: add iva2 hwmod support to omap3
Date: Fri,  2 Jul 2010 01:23:09 +0300
Message-ID: <1278022994-28476-2-git-send-email-ohad@wizery.com>
References: <1278022994-28476-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39213 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451Ab0GAWXd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 18:23:33 -0400
Received: by mail-bw0-f46.google.com with SMTP id 1so1212641bwz.19
        for <linux-omap@vger.kernel.org>; Thu, 01 Jul 2010 15:23:32 -0700 (PDT)
In-Reply-To: <1278022994-28476-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohadb@ti.com>

From: Ohad Ben-Cohen <ohadb@ti.com>

Add preliminary iva2 hwmod support to omap3.
We do not include iva2_clk; that will be part of a separate
hwmod, which will be controlled by iommu.

Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_34xx.h        |   23 +++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_34xx.h b/arch/arm/mach-omap2/omap_hwmod_34xx.h
index b6076b9..d363a95 100644
--- a/arch/arm/mach-omap2/omap_hwmod_34xx.h
+++ b/arch/arm/mach-omap2/omap_hwmod_34xx.h
@@ -22,6 +22,7 @@
 #include "prm-regbits-34xx.h"
 
 static struct omap_hwmod omap34xx_mpu_hwmod;
+static struct omap_hwmod omap34xx_iva2_hwmod;
 static struct omap_hwmod omap34xx_l3_hwmod;
 static struct omap_hwmod omap34xx_l4_core_hwmod;
 static struct omap_hwmod omap34xx_l4_per_hwmod;
@@ -47,9 +48,17 @@ static struct omap_hwmod_ocp_if omap34xx_mpu__l3 = {
 	.user	= OCP_USER_MPU,
 };
 
+/* IVA2 -> L3 interface */
+static struct omap_hwmod_ocp_if omap34xx_iva2__l3 = {
+	.master	= &omap34xx_iva2_hwmod,
+	.slave	= &omap34xx_l3_hwmod,
+	.user	= OCP_USER_IVA2,
+};
+
 /* Slave interfaces on the L3 interconnect */
 static struct omap_hwmod_ocp_if *omap34xx_l3_slaves[] = {
 	&omap34xx_mpu__l3,
+	&omap34xx_iva2__l3,
 };
 
 /* Master interfaces on the L3 interconnect */
@@ -150,12 +159,26 @@ static struct omap_hwmod omap34xx_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/* Master interfaces on the IVA2 device */
+static struct omap_hwmod_ocp_if *omap34xx_iva2_masters[] = {
+	&omap34xx_iva2__l3,
+};
+
+/* IVA2 */
+static struct omap_hwmod omap34xx_iva2_hwmod = {
+	.name		= "iva2_hwmod",
+	.masters	= omap34xx_iva2_masters,
+	.masters_cnt	= ARRAY_SIZE(omap34xx_iva2_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
 static __initdata struct omap_hwmod *omap34xx_hwmods[] = {
 	&omap34xx_l3_hwmod,
 	&omap34xx_l4_core_hwmod,
 	&omap34xx_l4_per_hwmod,
 	&omap34xx_l4_wkup_hwmod,
 	&omap34xx_mpu_hwmod,
+	&omap34xx_iva2_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 3393325..5e64992 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -160,6 +160,7 @@ struct omap_hwmod_addr_space {
  */
 #define OCP_USER_MPU			(1 << 0)
 #define OCP_USER_SDMA			(1 << 1)
+#define OCP_USER_IVA2			(1 << 2)
 
 /* omap_hwmod_ocp_if.flags bits */
 #define OCPIF_HAS_IDLEST		(1 << 0)
-- 
1.7.0.4

