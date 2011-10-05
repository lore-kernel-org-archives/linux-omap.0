From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 09/11] omap4: twl: added pmic startup / shutdown times
Date: Wed, 5 Oct 2011 20:17:09 +0300
Message-ID: <1317835031-8201-10-git-send-email-t-kristo@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42967 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935137Ab1JERRj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 13:17:39 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p95HHdlP021844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:39 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p95HHcGU027593
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:38 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p95HHcSj001803
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:38 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 62ed050..c095cf2 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -55,6 +55,13 @@ static bool __initdata twl_sr_enable_autoinit;
 #define REG_SMPS_OFFSET         0xE0
 #define SMARTREFLEX_ENABLE     BIT(3)
 
+struct twl_lp_description {
+	u32 osc_shut_time;
+	u32 osc_start_time;
+	u32 pmic_shut_time;
+	u32 pmic_start_time;
+};
+
 static unsigned long twl4030_vsel_to_uv(const u8 vsel)
 {
 	return (((vsel * 125) + 6000)) * 100;
@@ -220,9 +227,15 @@ static struct omap_voltdm_pmic omap4_core_pmic = {
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
 
+static struct twl_lp_description omap4_pmic_lp_desc = {
+	.pmic_shut_time		= 500,
+	.pmic_start_time	= 500,
+};
+
 int __init omap4_twl_init(void)
 {
 	struct voltagedomain *voltdm;
+	struct twl_lp_description *desc;
 
 	if (!cpu_is_omap44xx())
 		return -ENODEV;
@@ -236,6 +249,10 @@ int __init omap4_twl_init(void)
 	voltdm = voltdm_lookup("core");
 	omap_voltage_register_pmic(voltdm, &omap4_core_pmic);
 
+	desc = &omap4_pmic_lp_desc;
+
+	omap_pm_set_pmic_lp_time(desc->pmic_start_time, desc->pmic_shut_time);
+
 	return 0;
 }
 
-- 
1.7.4.1


Texas Instruments Oy, Porkkalankatu 22, 00180 Helsinki, Finland. Business ID: 0115040-6. Domicile: Helsinki
 

