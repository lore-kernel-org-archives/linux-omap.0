From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH 11/12] Add dummy smsc911x regulators to overo.
Date: Fri, 23 Mar 2012 02:21:43 -0700
Message-ID: <1332494504-10251-12-git-send-email-Russ.Dill@ti.com>
References: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33277 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620Ab2CWJWT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 05:22:19 -0400
Received: by mail-ob0-f174.google.com with SMTP id eh20so2248046obb.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 02:22:19 -0700 (PDT)
In-Reply-To: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org, Russ Dill <Russ.Dill@ti.com>, Russ Dill <russ.dill@ti.com>

Signed-off-by: Russ Dill <russ.dill@ti.com>
---
 arch/arm/mach-omap2/board-overo.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 668533e..33aa391 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -498,10 +498,18 @@ static struct gpio overo_bt_gpios[] __initdata = {
 	{ OVERO_GPIO_BT_NRESET, GPIOF_OUT_INIT_HIGH,	"lcd bl enable" },
 };
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+	REGULATOR_SUPPLY("vddvario", "smsc911x.1"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.1"),
+};
+
 static void __init overo_init(void)
 {
 	int ret;
 
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_hsmmc_init(mmc);
 	overo_i2c_init();
-- 
1.7.9.1

