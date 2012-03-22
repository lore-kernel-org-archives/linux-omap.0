From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH 13/13] Add dummy smsc911x regulators to zoom-debugboard.
Date: Wed, 21 Mar 2012 22:19:54 -0700
Message-ID: <1332393594-23993-14-git-send-email-Russ.Dill@ti.com>
References: <20120321194133.GP9859@atomide.com>
 <1332393594-23993-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:65308 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426Ab2CVFUu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 01:20:50 -0400
Received: by mail-ob0-f174.google.com with SMTP id eh20so1236214obb.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 22:20:50 -0700 (PDT)
In-Reply-To: <1332393594-23993-1-git-send-email-Russ.Dill@ti.com>
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

