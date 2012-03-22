From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH 06/13] Add dummy smsc911x regulators to cm-t35.
Date: Wed, 21 Mar 2012 22:19:47 -0700
Message-ID: <1332393594-23993-7-git-send-email-Russ.Dill@ti.com>
References: <20120321194133.GP9859@atomide.com>
 <1332393594-23993-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35468 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611Ab2CVFU3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 01:20:29 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so2617327iag.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 22:20:28 -0700 (PDT)
In-Reply-To: <1332393594-23993-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org, Russ Dill <Russ.Dill@ti.com>, Russ Dill <russ.dill@ti.com>

Signed-off-by: Russ Dill <russ.dill@ti.com>
---
 arch/arm/mach-omap2/board-cm-t35.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 41b0a2f..289ded3 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -26,6 +26,7 @@
 
 #include <linux/i2c/at24.h>
 #include <linux/i2c/twl.h>
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/mmc/host.h>
 
@@ -630,10 +631,18 @@ static inline void cm_t3730_init_mux(void) {}
 static struct omap_board_config_kernel cm_t35_config[] __initdata = {
 };
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+	REGULATOR_SUPPLY("vddvario", "smsc911x.1"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.1"),
+};
+
 static void __init cm_t3x_common_init(void)
 {
 	omap_board_config = cm_t35_config;
 	omap_board_config_size = ARRAY_SIZE(cm_t35_config);
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
 	omap_serial_init();
 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
-- 
1.7.9.1

