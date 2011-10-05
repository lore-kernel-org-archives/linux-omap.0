From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 08/11] omap3+: voltage: remove obsolete parameters
Date: Wed, 5 Oct 2011 20:17:08 +0300
Message-ID: <1317835031-8201-9-git-send-email-t-kristo@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33972 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935152Ab1JERRi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 13:17:38 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p95HHcgm019523
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:38 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p95HHbUm019468
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:37 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p95HHaDY001745
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:37 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Voltages for different operating modes are now provided by vc_params.
Oscillator setup times are handled as board specific.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |   25 -------------------------
 arch/arm/mach-omap2/vc.h       |    1 -
 2 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index df4e7c3..62ed050 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -141,11 +141,6 @@ static u8 twl6030_uv_to_vsel(unsigned long uv)
 static struct omap_voltdm_pmic omap3_mpu_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
-	.on_volt		= 1200000,
-	.onlp_volt		= 1000000,
-	.ret_volt		= 975000,
-	.off_volt		= 600000,
-	.volt_setup_time	= 0xfff,
 	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
@@ -162,11 +157,6 @@ static struct omap_voltdm_pmic omap3_mpu_pmic = {
 static struct omap_voltdm_pmic omap3_core_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12500,
-	.on_volt                = 1200000,
-	.onlp_volt              = 1000000,
-	.ret_volt               = 975000,
-	.off_volt               = 600000,
-	.volt_setup_time        = 0xfff,
 	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
@@ -183,11 +173,6 @@ static struct omap_voltdm_pmic omap3_core_pmic = {
 static struct omap_voltdm_pmic omap4_mpu_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.on_volt		= 1375000,
-	.onlp_volt		= 1375000,
-	.ret_volt		= 830000,
-	.off_volt		= 0,
-	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
@@ -205,11 +190,6 @@ static struct omap_voltdm_pmic omap4_mpu_pmic = {
 static struct omap_voltdm_pmic omap4_iva_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.on_volt		= 1188000,
-	.onlp_volt		= 1188000,
-	.ret_volt		= 830000,
-	.off_volt		= 0,
-	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
@@ -227,11 +207,6 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
 static struct omap_voltdm_pmic omap4_core_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.on_volt		= 1200000,
-	.onlp_volt		= 1200000,
-	.ret_volt		= 830000,
-	.off_volt		= 0,
-	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
 	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index ec50643..e6fdd23 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -80,7 +80,6 @@ struct omap_vc_channel {
 	u16 i2c_slave_addr;
 	u16 volt_reg_addr;
 	u16 cmd_reg_addr;
-	u16 setup_time;
 	u8 cfg_channel;
 	bool i2c_high_speed;
 
-- 
1.7.4.1


Texas Instruments Oy, Porkkalankatu 22, 00180 Helsinki, Finland. Business ID: 0115040-6. Domicile: Helsinki
 

