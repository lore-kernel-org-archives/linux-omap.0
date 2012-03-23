From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH 07/12] Add dummy smsc911x regulators to ldp.
Date: Fri, 23 Mar 2012 02:21:39 -0700
Message-ID: <1332494504-10251-8-git-send-email-Russ.Dill@ti.com>
References: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63290 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116Ab2CWJWJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 05:22:09 -0400
Received: by yenl12 with SMTP id l12so2541715yen.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 02:22:09 -0700 (PDT)
In-Reply-To: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org, Russ Dill <Russ.Dill@ti.com>, Russ Dill <russ.dill@ti.com>

Signed-off-by: Russ Dill <russ.dill@ti.com>
---
 arch/arm/mach-omap2/board-ldp.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index d50a562a..1b60495 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -22,6 +22,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
 #include <linux/io.h>
@@ -410,8 +411,14 @@ static struct mtd_partition ldp_nand_partitions[] = {
 
 };
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+};
+
 static void __init omap_ldp_init(void)
 {
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	ldp_init_smsc911x();
 	omap_i2c_init();
-- 
1.7.9.1

