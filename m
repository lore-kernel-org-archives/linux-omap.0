From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP/voltdm_c][PATCH 10/11] OMAP4: PM: TWL6030: fix ON/RET/OFF voltages
Date: Wed, 18 May 2011 00:17:33 -0500
Message-ID: <1305695854-9638-11-git-send-email-nm@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44509 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096Ab1ERFRl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 01:17:41 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4I5HedN005410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:40 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4I5Heqr002255
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:40 -0500 (CDT)
In-Reply-To: <1305695854-9638-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Patrick Titiano <p-titiano@ti.com>, Nishanth Menon <nm@ti.com>

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
index 8b1e93c..54a6e02 100644
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
@@ -222,10 +222,10 @@ static struct omap_voltdm_pmic omap4_mpu_pmic = {
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
@@ -247,10 +247,10 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
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
1.7.0.4

