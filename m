From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP/voltdm_c][PATCH 07/11] OMAP4: PM: TWL6030: fix voltage conversion formula
Date: Wed, 18 May 2011 00:17:30 -0500
Message-ID: <1305695854-9638-8-git-send-email-nm@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47761 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754867Ab1ERFRk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 01:17:40 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4I5HdUS028658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:39 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4I5HdCr002799
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:39 -0500 (CDT)
In-Reply-To: <1305695854-9638-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Patrick Titiano <p-titiano@ti.com>, Nishanth Menon <nm@ti.com>

From: Patrick Titiano <p-titiano@ti.com>

omap_twl_vsel_to_uv() and omap_twl_uv_to_vsel() functions used to convert
voltages to TWL6030 SMPS commands (a.k.a "vsel") implement incorrect conversion
formula.
It uses legacy OMAP3 formula, but OMAP4 Power IC has different offset and
voltage step:
 - Voltage Step is now 12.66mV (instead of 12.5mV)
 - Offset is either 607.7mV or 709mV depending on TWL6030 chip revision
   (instead of 600mV)
This leads to setting voltages potentially higher than expected, and so
potentially some (limited) power overconsumption.

For reference, see formula and tables in section 8.5.2.3
"Output Voltage Selection (Standard Mode / Extended Mode with or without offset)"
 in TWL6030 functional specifications document.

[nm@ti.com: ported to voltdm_c]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Patrick Titiano <p-titiano@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 82a91be..78fd985 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -106,9 +106,9 @@ static unsigned long twl6030_vsel_to_uv(const u8 vsel)
 		return 1350000;
 
 	if (smps_offset & 0x8)
-		return ((((vsel - 1) * 125) + 7000)) * 100;
+		return ((((vsel - 1) * 1266) + 70900)) * 10;
 	else
-		return ((((vsel - 1) * 125) + 6000)) * 100;
+		return ((((vsel - 1) * 1266) + 60770)) * 10;
 }
 
 static u8 twl6030_uv_to_vsel(unsigned long uv)
@@ -138,9 +138,9 @@ static u8 twl6030_uv_to_vsel(unsigned long uv)
 		return 0x3A;
 
 	if (smps_offset & 0x8)
-		return DIV_ROUND_UP(uv - 700000, 12500) + 1;
+		return DIV_ROUND_UP(uv - 709000, 12660) + 1;
 	else
-		return DIV_ROUND_UP(uv - 600000, 12500) + 1;
+		return DIV_ROUND_UP(uv - 607700, 12660) + 1;
 }
 
 static struct omap_voltdm_pmic omap3_mpu_pmic = {
@@ -187,7 +187,7 @@ static struct omap_voltdm_pmic omap3_core_pmic = {
 
 static struct omap_voltdm_pmic omap4_mpu_pmic = {
 	.slew_rate		= 4000,
-	.step_size		= 12500,
+	.step_size		= 12660,
 	.on_volt		= 1350000,
 	.onlp_volt		= 1350000,
 	.ret_volt		= 837500,
@@ -212,7 +212,7 @@ static struct omap_voltdm_pmic omap4_mpu_pmic = {
 
 static struct omap_voltdm_pmic omap4_iva_pmic = {
 	.slew_rate		= 4000,
-	.step_size		= 12500,
+	.step_size		= 12660,
 	.on_volt		= 1100000,
 	.onlp_volt		= 1100000,
 	.ret_volt		= 837500,
@@ -237,7 +237,7 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
 
 static struct omap_voltdm_pmic omap4_core_pmic = {
 	.slew_rate		= 4000,
-	.step_size		= 12500,
+	.step_size		= 12660,
 	.on_volt		= 1100000,
 	.onlp_volt		= 1100000,
 	.ret_volt		= 837500,
-- 
1.7.0.4

