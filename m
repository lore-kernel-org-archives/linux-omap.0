From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH] OMAP4: PANDA, SDP: Fix EHCI regulator supply
Date: Fri, 24 Jun 2011 20:07:20 +0530
Message-ID: <1308926240-13888-1-git-send-email-jaswinder.singh@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56238 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758105Ab1FXOhd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 10:37:33 -0400
Received: by pzk9 with SMTP id 9so1811197pzk.19
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 07:37:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, balbi@ti.com, tony@atomide.com, Jassi Brar <jaswinder.singh@linaro.org>

VUSB is a fixed level line and hence have no set_voltage
callback in regulator ops, but has apply_uV set to true.
As a result it fails to register with the regulator core.
Remove setting apply_uV.

Also, assign name to VUSB supply, without which regulator core
fails to find it and assigns the default 'dummy' regulator to
the ehci-omap device.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    6 +++++-
 arch/arm/mach-omap2/board-omap4panda.c |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 63de2d3..1ec60be 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -504,16 +504,20 @@ static struct regulator_init_data sdp4430_vdac = {
 	},
 };
 
+static struct regulator_consumer_supply sdp4430_vusb_supply =
+	REGULATOR_SUPPLY("hsusb0", "ehci-omap.0");
+
 static struct regulator_init_data sdp4430_vusb = {
 	.constraints = {
 		.min_uV			= 3300000,
 		.max_uV			= 3300000,
-		.apply_uV		= true,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask	 =	REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &sdp4430_vusb_supply,
 };
 
 static struct regulator_init_data sdp4430_clk32kg = {
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index d4f9879..7429f7e 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -362,16 +362,20 @@ static struct regulator_init_data omap4_panda_vdac = {
 	},
 };
 
+static struct regulator_consumer_supply omap4_panda_vusb_supply =
+	REGULATOR_SUPPLY("hsusb0", "ehci-omap.0");
+
 static struct regulator_init_data omap4_panda_vusb = {
 	.constraints = {
 		.min_uV			= 3300000,
 		.max_uV			= 3300000,
-		.apply_uV		= true,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask	 =	REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &omap4_panda_vusb_supply,
 };
 
 static struct regulator_init_data omap4_panda_clk32kg = {
-- 
1.7.4.1

