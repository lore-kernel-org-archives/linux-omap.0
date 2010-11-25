From: Srikar <ext-srikar.1.bhavanarayana@nokia.com>
Subject: [PATCH 2/2] enabled vdda_dac regulator support tvout on rx51
Date: Thu, 25 Nov 2010 17:52:23 +0200
Message-ID: <1290700343-26640-2-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
References: <1290700343-26640-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:54054 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785Ab0KYPxc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Nov 2010 10:53:32 -0500
In-Reply-To: <1290700343-26640-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org
Cc: Srikar <ext-srikar.1.bhavanarayana@nokia.com>

To support tvout on rx51,added the venc vdac regulator
consumer supply data  and also intialised the vdac regulator
with vdac regulator consumer supply data which enables the
power supply to venc through twl4030 on rx51

Signed-off-by: Srikar <ext-srikar.1.bhavanarayana@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index e56d6d7..ec47402 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -372,6 +372,16 @@ static struct regulator_consumer_supply rx51_vaux1_consumers[] = {
 #endif
 };
 
+static struct regulator_consumer_supply rx51_vdac_supply[] = {
+	{
+#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
+		.supply	= "vdda_dac",
+		.dev	= &rx51_display_device.dev,
+	},
+#endif
+};
+
+
 static struct regulator_init_data rx51_vaux1 = {
 	.constraints = {
 		.name			= "V28",
@@ -489,14 +499,17 @@ static struct regulator_init_data rx51_vsim = {
 
 static struct regulator_init_data rx51_vdac = {
 	.constraints = {
+		.name			= "VDAC",
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
+		.apply_uV		= true,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &rx51_vdac_supply,
 };
 
 static struct regulator_init_data rx51_vio = {
-- 
1.7.1

