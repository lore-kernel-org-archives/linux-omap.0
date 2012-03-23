From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH 10/12] Add dummy smsc911x regulators to omap3stalker.
Date: Fri, 23 Mar 2012 02:21:42 -0700
Message-ID: <1332494504-10251-11-git-send-email-Russ.Dill@ti.com>
References: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33277 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756058Ab2CWJWQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 05:22:16 -0400
Received: by mail-ob0-f174.google.com with SMTP id eh20so2248046obb.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 02:22:16 -0700 (PDT)
In-Reply-To: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org, Russ Dill <Russ.Dill@ti.com>, Russ Dill <russ.dill@ti.com>

Signed-off-by: Russ Dill <russ.dill@ti.com>
---
 arch/arm/mach-omap2/board-omap3stalker.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index de95352..4dffc95 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -24,6 +24,7 @@
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
 #include <linux/mmc/host.h>
@@ -410,8 +411,14 @@ static struct omap_board_mux board_mux[] __initdata = {
 };
 #endif
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+};
+
 static void __init omap3_stalker_init(void)
 {
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
 	omap_board_config = omap3_stalker_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_stalker_config);
-- 
1.7.9.1

