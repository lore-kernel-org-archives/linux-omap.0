From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 05/19] OMAP3: voltage: rename "mpu" voltagedomain to "mpu_iva"
Date: Wed, 23 Mar 2011 17:00:19 -0700
Message-ID: <1300924833-26745-6-git-send-email-khilman@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:46640 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933110Ab1CXAAV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 20:00:21 -0400
Received: by mail-iw0-f176.google.com with SMTP id 19so11471931iwr.21
        for <linux-omap@vger.kernel.org>; Wed, 23 Mar 2011 17:00:20 -0700 (PDT)
In-Reply-To: <1300924833-26745-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

This voltage domain (a.k.a. VDD1) contains both the MPU and the IVA, so
rename appropriately.

Also fixup any users of the "mpu" name to use "mpu_iva"

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    4 ++--
 arch/arm/mach-omap2/omap_twl.c                |    2 +-
 arch/arm/mach-omap2/pm.c                      |    2 +-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index c819c30..84feaf1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2909,7 +2909,7 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 	.name		= "sr1_hwmod",
 	.class		= &omap34xx_smartreflex_hwmod_class,
 	.main_clk	= "sr1_fck",
-	.vdd_name	= "mpu",
+	.vdd_name	= "mpu_iva",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -2931,7 +2931,7 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
 	.name		= "sr1_hwmod",
 	.class		= &omap36xx_smartreflex_hwmod_class,
 	.main_clk	= "sr1_fck",
-	.vdd_name	= "mpu",
+	.vdd_name	= "mpu_iva",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 287aef2..57c325a 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -288,7 +288,7 @@ int __init omap3_twl_init(void)
 	if (!twl_sr_enable_autoinit)
 		omap3_twl_set_sr_bit(true);
 
-	voltdm = voltdm_lookup("mpu");
+	voltdm = voltdm_lookup("mpu_iva");
 	omap_voltage_register_pmic(voltdm, &omap3_mpu_volt_info);
 
 	voltdm = voltdm_lookup("core");
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 917e1e3..820b7b5 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -226,7 +226,7 @@ static void __init omap3_init_voltages(void)
 	if (!cpu_is_omap34xx())
 		return;
 
-	omap2_set_init_voltage("mpu", "dpll1_ck", mpu_dev);
+	omap2_set_init_voltage("mpu_iva", "dpll1_ck", mpu_dev);
 	omap2_set_init_voltage("core", "l3_ick", l3_dev);
 }
 
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index 4bee412..2167ef4 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -60,7 +60,7 @@ static struct omap_vdd_info omap3_vdd2_info = {
 };
 
 static struct voltagedomain omap3_voltdm_mpu = {
-	.name = "mpu",
+	.name = "mpu_iva",
 	.vdd = &omap3_vdd1_info,
 };
 
-- 
1.7.4

