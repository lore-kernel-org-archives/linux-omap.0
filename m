From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 2/2] OMAP4: add clk32kg data to omap4panda and blaze board file
Date: Thu, 10 Feb 2011 18:45:26 +0530
Message-ID: <1297343726-4603-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38458 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180Ab1BJNNS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 08:13:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, sameo@linux.intel.com, Balaji T K <balajitk@ti.com>

In Blaze and Panda, 32KHz clock - CLK32KG to WLAN is supplied
from Phoenix TWL6030.
Add CLK32KG platform data to blaze and omap4panda board file.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
This patch has dependency on :-
regulator: twl: add clk32kg to twl-regulator

v2 changes:
remove CHANGE_MODE settings

 arch/arm/mach-omap2/board-4430sdp.c    |    7 +++++++
 arch/arm/mach-omap2/board-omap4panda.c |    7 +++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 07d1b20..99ae380 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -478,6 +478,12 @@ static struct regulator_init_data sdp4430_vusb = {
 	},
 };
 
+static struct regulator_init_data sdp4430_clk32kg = {
+	.constraints = {
+		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
+	},
+};
+
 static struct twl4030_platform_data sdp4430_twldata = {
 	.irq_base	= TWL6030_IRQ_BASE,
 	.irq_end	= TWL6030_IRQ_END,
@@ -493,6 +499,7 @@ static struct twl4030_platform_data sdp4430_twldata = {
 	.vaux1		= &sdp4430_vaux1,
 	.vaux2		= &sdp4430_vaux2,
 	.vaux3		= &sdp4430_vaux3,
+	.clk32kg	= &sdp4430_clk32kg,
 	.usb		= &omap4_usbphy_data
 };
 
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index e944025..c86e450 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -349,6 +349,12 @@ static struct regulator_init_data omap4_panda_vusb = {
 	},
 };
 
+static struct regulator_init_data omap4_panda_clk32kg = {
+	.constraints = {
+		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
+	},
+};
+
 static struct twl4030_platform_data omap4_panda_twldata = {
 	.irq_base	= TWL6030_IRQ_BASE,
 	.irq_end	= TWL6030_IRQ_END,
@@ -364,6 +370,7 @@ static struct twl4030_platform_data omap4_panda_twldata = {
 	.vaux1		= &omap4_panda_vaux1,
 	.vaux2		= &omap4_panda_vaux2,
 	.vaux3		= &omap4_panda_vaux3,
+	.clk32kg	= &omap4_panda_clk32kg,
 	.usb		= &omap4_usbphy_data,
 };
 
-- 
1.7.0.4

