From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 13/13] OMAP3: hwmod data: add data for OMAP3 IVA2
Date: Thu, 24 Jun 2010 16:44:44 -0700
Message-ID: <1277423084-25528-14-git-send-email-khilman@deeprootsystems.com>
References: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45007 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141Ab0FXXpQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 19:45:16 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so587510pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 16:45:16 -0700 (PDT)
In-Reply-To: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>

Add hwmod data for IVA2 module on OMAP3.

Naming of "iva" instead of "iva2" to be aligned with OMAP4 naming done
by Benoit Cousson.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   30 ++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 9d9cfb9..d3bf85b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -32,6 +32,7 @@
  */
 
 static struct omap_hwmod omap3xxx_mpu_hwmod;
+static struct omap_hwmod omap3xxx_iva_hwmod;
 static struct omap_hwmod omap3xxx_l3_main_hwmod;
 static struct omap_hwmod omap3xxx_l4_core_hwmod;
 static struct omap_hwmod omap3xxx_l4_per_hwmod;
@@ -168,12 +169,41 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/*
+ * IVA2_2 interface data
+ */
+
+/* IVA2 <- L3 interface */
+static struct omap_hwmod_ocp_if omap3xxx_l3__iva = {
+	.master		= &omap3xxx_l3_main_hwmod,
+	.slave		= &omap3xxx_iva_hwmod,
+	.clk		= "iva2_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_iva_masters[] = {
+	&omap3xxx_l3__iva,
+};
+
+/*
+ * IVA2 (IVA2)
+ */
+
+static struct omap_hwmod omap3xxx_iva_hwmod = {
+	.name		= "iva",
+	.class          = &iva_hwmod_class,
+	.masters	= omap3xxx_iva_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_iva_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
 	&omap3xxx_l4_per_hwmod,
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
+	&omap3xxx_iva_hwmod,
 	NULL,
 };
 
-- 
1.7.0.2

