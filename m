From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 2/2] OMAP4: add clk32kg data to omap4panda and blaze board file
Date: Wed,  9 Feb 2011 21:07:31 +0530
Message-ID: <1297265851-21999-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41777 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291Ab1BIPfY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Feb 2011 10:35:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, sameo@linux.intel.com, Balaji T K <balajitk@ti.com>

In Blaze and Panda, 32KHz clock - CLK32KG to WLAN is supplied
from Phoenix TWL6030.
Add CLK32KG platform data to blaze and omap4panda board file.

This patch has dependency on :-
[PATCH 1/2] regulator: twl: add clk32kg to twl-regulator

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |   10 ++++++++++
 arch/arm/mach-omap2/board-omap4panda.c |   10 ++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 1b16525..0c52901 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -475,6 +475,15 @@ static struct regulator_init_data sdp4430_vusb = {
 	},
 };
 
+static struct regulator_init_data sdp4430_clk32kg = {
+	.constraints = {
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
 static struct twl4030_platform_data sdp4430_twldata = {
 	.irq_base	= TWL6030_IRQ_BASE,
 	.irq_end	= TWL6030_IRQ_END,
@@ -490,6 +499,7 @@ static struct twl4030_platform_data sdp4430_twldata = {
 	.vaux1		= &sdp4430_vaux1,
 	.vaux2		= &sdp4430_vaux2,
 	.vaux3		= &sdp4430_vaux3,
+	.clk32kg	= &sdp4430_clk32kg,
 	.usb		= &omap4_usbphy_data
 };
 
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 3686533..4c38b16 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -346,6 +346,15 @@ static struct regulator_init_data omap4_panda_vusb = {
 	},
 };
 
+static struct regulator_init_data omap4_panda_clk32kg = {
+	.constraints = {
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
 static struct twl4030_platform_data omap4_panda_twldata = {
 	.irq_base	= TWL6030_IRQ_BASE,
 	.irq_end	= TWL6030_IRQ_END,
@@ -361,6 +370,7 @@ static struct twl4030_platform_data omap4_panda_twldata = {
 	.vaux1		= &omap4_panda_vaux1,
 	.vaux2		= &omap4_panda_vaux2,
 	.vaux3		= &omap4_panda_vaux3,
+	.clk32kg	= &omap4_panda_clk32kg,
 	.usb		= &omap4_usbphy_data,
 };
 
-- 
1.7.0.4

