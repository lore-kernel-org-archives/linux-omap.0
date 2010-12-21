From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/2] omap: rx51: Add vdda_dac supply for tvout
Date: Tue, 21 Dec 2010 19:25:35 +0200
Message-ID: <1292952335-21314-3-git-send-email-jhnikula@gmail.com>
References: <1292952335-21314-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f45.google.com ([209.85.214.45]:51969 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab0LUR0H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 12:26:07 -0500
Received: by mail-bw0-f45.google.com with SMTP id 16so4816310bwz.4
        for <linux-omap@vger.kernel.org>; Tue, 21 Dec 2010 09:26:06 -0800 (PST)
In-Reply-To: <1292952335-21314-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Commmit 60d24ee "Added video data to support tvout on rx51" broke the DSS
on RX51/N900 since it added DSS VENC support but a patch adding needed
supply is missing from tree and no framebuffers are initialized.

This patch is basically cleaned up version of original one:
http://marc.info/?l=linux-omap&m=129070041402418&w=2

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Srikar <ext-srikar.1.bhavanarayana@nokia.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
Mark cc'edd since he had comments to the original patch what this patch is
trying to address.
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 768f0dc..e75e240 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -363,6 +363,10 @@ static struct regulator_consumer_supply rx51_vaux1_consumers[] = {
 	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
 };
 
+static struct regulator_consumer_supply rx51_vdac_supply[] = {
+	REGULATOR_SUPPLY("vdda_dac", "omapdss"),
+};
+
 static struct regulator_init_data rx51_vaux1 = {
 	.constraints = {
 		.name			= "V28",
@@ -480,14 +484,17 @@ static struct regulator_init_data rx51_vsim = {
 
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
+	.consumer_supplies	= rx51_vdac_supply,
 };
 
 static struct regulator_init_data rx51_vio = {
-- 
1.7.2.3

