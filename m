From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 03/12] OMAP3: hwmod: add data for OMAP3 IVA2
Date: Wed, 16 Jun 2010 17:17:04 -0700
Message-ID: <1276733833-18510-4-git-send-email-khilman@deeprootsystems.com>
References: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60436 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759623Ab0FQARr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 20:17:47 -0400
Received: by pva4 with SMTP id 4so937569pva.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 17:17:38 -0700 (PDT)
In-Reply-To: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, thara@ti.com, b-cousson@ti.com

Add hwmod data for DSP on OMAP3 (a.k.a. IVA2.)

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   41 ++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index f1df4c9..571bb37 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -33,6 +33,7 @@
  */
 
 static struct omap_hwmod omap3xxx_mpu_hwmod;
+static struct omap_hwmod omap3xxx_iva2_hwmod;
 static struct omap_hwmod omap3xxx_l3_hwmod;
 static struct omap_hwmod omap3xxx_l4_core_hwmod;
 static struct omap_hwmod omap3xxx_l4_per_hwmod;
@@ -205,6 +206,45 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/*
+ * IVA2_2 interface data
+ */
+
+static struct omap_hwmod_addr_space omap3xxx_iva2_addrs[] = {
+	{
+		.pa_start	= 0x5c000000,
+		.pa_end		= 0x5effffff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* IVA2 <- L3 interface */
+static struct omap_hwmod_ocp_if omap3xxx_l3__iva2 = {
+	.master		= &omap3xxx_l3_hwmod,
+	.slave		= &omap3xxx_iva2_hwmod,
+	.clk		= "iva2_ck",
+	.addr		= omap3xxx_iva2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_iva2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_iva2_masters[] = {
+	&omap3xxx_l3__iva2,
+};
+
+/*
+ * IVA2 (IVA2)
+ */
+
+static struct omap_hwmod omap3xxx_iva2_hwmod = {
+	.name		= "dsp",
+	.class		= &dsp_hwmod_class,
+	.main_clk	= "iva2_ck",
+	.masters	= omap3xxx_iva2_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_iva2_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
 /* SR common */
 static struct omap_hwmod_sysc_fields omap34xx_sr_sysc_fields = {
 	.clkact_shift	= 20,
@@ -373,6 +413,7 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l4_per_hwmod,
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
+	&omap3xxx_iva2_hwmod,
 	&omap34xx_sr1_hwmod,
 	&omap34xx_sr2_hwmod,
 	&omap36xx_sr1_hwmod,
-- 
1.7.0.2

