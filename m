From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCHv2] OMAP4: PANDA, SDP: Fix EHCI regulator supply
Date: Mon, 27 Jun 2011 20:32:03 +0530
Message-ID: <1309186923-29192-1-git-send-email-jaswinder.singh@linaro.org>
References: <1308926240-13888-1-git-send-email-jaswinder.singh@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43278 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab1F0PCT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 11:02:19 -0400
Received: by pvg12 with SMTP id 12so2903557pvg.19
        for <linux-omap@vger.kernel.org>; Mon, 27 Jun 2011 08:02:18 -0700 (PDT)
In-Reply-To: <1308926240-13888-1-git-send-email-jaswinder.singh@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, patches@linaro.org, balbi@ti.com, tony@atomide.com, Jassi Brar <jaswinder.singh@linaro.org>

VUSB is a fixed level line and hence have no set_voltage
callback in regulator ops, but has apply_uV set to true.
As a result it fails to register with the regulator core.
Remove setting apply_uV.

Also, assign name to VUSB supply, without which regulator core
fails to find it and assigns the default 'dummy' regulator to
the ehci-omap device.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    7 ++++++-
 arch/arm/mach-omap2/board-omap4panda.c |    7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 63de2d3..9493cd3 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -504,16 +504,21 @@ static struct regulator_init_data sdp4430_vdac = {
 	},
 };
 
+static struct regulator_consumer_supply sdp4430_vusb_supply[] = {
+	REGULATOR_SUPPLY("hsusb0", "ehci-omap.0"),
+};
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
+	.num_consumer_supplies	= ARRAY_SIZE(sdp4430_vusb_supply),
+	.consumer_supplies	= sdp4430_vusb_supply,
 };
 
 static struct regulator_init_data sdp4430_clk32kg = {
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index d4f9879..2beb0d5 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -362,16 +362,21 @@ static struct regulator_init_data omap4_panda_vdac = {
 	},
 };
 
+static struct regulator_consumer_supply omap4_panda_vusb_supply[] = {
+	REGULATOR_SUPPLY("hsusb0", "ehci-omap.0"),
+};
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
+	.num_consumer_supplies	= ARRAY_SIZE(omap4_panda_vusb_supply),
+	.consumer_supplies	= omap4_panda_vusb_supply,
 };
 
 static struct regulator_init_data omap4_panda_clk32kg = {
-- 
1.7.4.1

