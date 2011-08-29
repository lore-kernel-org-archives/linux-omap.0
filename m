From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 4/5] OMAP4: PM: TWL6030: fix ON/RET/OFF voltages
Date: Mon, 29 Aug 2011 11:15:20 -0700
Message-ID: <1314641721-5172-5-git-send-email-khilman@ti.com>
References: <1314641721-5172-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:54548 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754416Ab1H2SPA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 14:15:00 -0400
Received: by mail-yw0-f42.google.com with SMTP id 3so4748476ywb.15
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 11:15:00 -0700 (PDT)
In-Reply-To: <1314641721-5172-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

From: Patrick Titiano <p-titiano@ti.com>

According to latest OMAP4430 Data Manual v0.4 dated March 2011:
 - Retention voltage shall be set to 0.83V. See tables 2.2, 2.4 and 2.6 in DM.
   This allows saving a little more power in retention states.
 - OPP100 IVA nominal voltage is 1.188V. See table 2.4 in DM.
   This allows saving a little power when CPU wakes up until Smart-Reflex is
   not yet resumed.

[nm@ti.com: ported to voltdm_c]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Patrick Titiano <p-titiano@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index b30adf3..4bc99fb 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -197,10 +197,10 @@ static struct omap_voltdm_pmic omap3_core_pmic = {
 static struct omap_voltdm_pmic omap4_mpu_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.on_volt		= 1350000,
-	.onlp_volt		= 1350000,
-	.ret_volt		= 837500,
-	.off_volt		= 600000,
+	.on_volt		= 1375000,
+	.onlp_volt		= 1375000,
+	.ret_volt		= 830000,
+	.off_volt		= 0,
 	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
@@ -218,10 +218,10 @@ static struct omap_voltdm_pmic omap4_mpu_pmic = {
 static struct omap_voltdm_pmic omap4_iva_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.on_volt		= 1100000,
-	.onlp_volt		= 1100000,
-	.ret_volt		= 837500,
-	.off_volt		= 600000,
+	.on_volt		= 1188000,
+	.onlp_volt		= 1188000,
+	.ret_volt		= 830000,
+	.off_volt		= 0,
 	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
@@ -239,10 +239,10 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
 static struct omap_voltdm_pmic omap4_core_pmic = {
 	.slew_rate		= 4000,
 	.step_size		= 12660,
-	.on_volt		= 1100000,
-	.onlp_volt		= 1100000,
-	.ret_volt		= 837500,
-	.off_volt		= 600000,
+	.on_volt		= 1200000,
+	.onlp_volt		= 1200000,
+	.ret_volt		= 830000,
+	.off_volt		= 0,
 	.volt_setup_time	= 0,
 	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
 	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
-- 
1.7.6

