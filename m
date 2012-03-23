From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH 12/12] Add dummy smsc911x regulators to zoom-debugboard.
Date: Fri, 23 Mar 2012 02:21:44 -0700
Message-ID: <1332494504-10251-13-git-send-email-Russ.Dill@ti.com>
References: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63290 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620Ab2CWJWW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 05:22:22 -0400
Received: by mail-yx0-f174.google.com with SMTP id l12so2541715yen.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 02:22:22 -0700 (PDT)
In-Reply-To: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org, Russ Dill <Russ.Dill@ti.com>, Russ Dill <russ.dill@ti.com>

Signed-off-by: Russ Dill <russ.dill@ti.com>
---
 arch/arm/mach-omap2/board-zoom-debugboard.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index 369c2eb..f68b616 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -14,6 +14,9 @@
 #include <linux/smsc911x.h>
 #include <linux/interrupt.h>
 
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
+
 #include <plat/gpmc.h>
 #include <plat/gpmc-smsc911x.h>
 
@@ -116,11 +119,17 @@ static struct platform_device *zoom_devices[] __initdata = {
 	&zoom_debugboard_serial_device,
 };
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+};
+
 int __init zoom_debugboard_init(void)
 {
 	if (!omap_zoom_debugboard_detect())
 		return 0;
 
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	zoom_init_smsc911x();
 	zoom_init_quaduart();
 	return platform_add_devices(zoom_devices, ARRAY_SIZE(zoom_devices));
-- 
1.7.9.1

