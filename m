From: Roger Quadros <roger.quadros@nokia.com>
Subject: [PATCH 2/5] OMAP: RX51: Add "vdds_sdi" supply voltage for SDI
Date: Tue, 23 Mar 2010 11:56:28 +0200
Message-ID: <1269338191-10734-3-git-send-email-roger.quadros@nokia.com>
References: <1269338191-10734-1-git-send-email-roger.quadros@nokia.com>
 <1269338191-10734-2-git-send-email-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18642 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432Ab0CWJ5Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 05:57:16 -0400
In-Reply-To: <1269338191-10734-2-git-send-email-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: Tomi.Valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

From: Roger Quadros <roger.quadros@nokia.com>

The SDI Display subsystem needs access to the vdds_sdi supply
regulator. This is TWL4030's VAUX1 supply on RX-51.

Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index f404537..3ef805e 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -300,6 +300,19 @@ static struct regulator_consumer_supply rx51_vsim_supply = {
 	.dev_name = "mmci-omap-hs.1",
 };
 
+#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
+extern struct platform_device rx51_display_device;
+#endif
+
+static struct regulator_consumer_supply rx51_vaux1_consumers[] = {
+#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
+	{
+		.supply	= "vdds_sdi",
+		.dev	= &rx51_display_device.dev,
+	},
+#endif
+};
+
 static struct regulator_init_data rx51_vaux1 = {
 	.constraints = {
 		.name			= "V28",
@@ -310,6 +323,8 @@ static struct regulator_init_data rx51_vaux1 = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= ARRAY_SIZE(rx51_vaux1_consumers),
+	.consumer_supplies	= rx51_vaux1_consumers,
 };
 
 static struct regulator_init_data rx51_vaux2 = {
-- 
1.6.0.4

