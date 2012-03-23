From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH 09/12] Add dummy smsc911x regulators to omap3logic.
Date: Fri, 23 Mar 2012 02:21:41 -0700
Message-ID: <1332494504-10251-10-git-send-email-Russ.Dill@ti.com>
References: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33277 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116Ab2CWJWO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 05:22:14 -0400
Received: by mail-ob0-f174.google.com with SMTP id eh20so2248046obb.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 02:22:13 -0700 (PDT)
In-Reply-To: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org, Russ Dill <Russ.Dill@ti.com>, Russ Dill <russ.dill@ti.com>

Signed-off-by: Russ Dill <russ.dill@ti.com>
---
 arch/arm/mach-omap2/board-omap3logic.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 4a7d8c8..9b3c141 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 
 #include <linux/i2c/twl.h>
@@ -188,8 +189,14 @@ static struct omap_board_mux board_mux[] __initdata = {
 };
 #endif
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+};
+
 static void __init omap3logic_init(void)
 {
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3torpedo_fix_pbias_voltage();
 	omap3logic_i2c_init();
-- 
1.7.9.1

