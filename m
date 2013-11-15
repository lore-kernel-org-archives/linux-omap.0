From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/11] ARM: OMAP2+: Make n8x0 behave better with device tree based booting
Date: Thu, 14 Nov 2013 16:09:52 -0800
Message-ID: <1384474198-20756-6-git-send-email-tony@atomide.com>
References: <1384474198-20756-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42233 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930Ab3KOAKG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Nov 2013 19:10:06 -0500
In-Reply-To: <1384474198-20756-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Initialize some devices using a late_initcall and test for
the device tree based booting for some devices.

This way we can keep things working for legacy platform
devices when booted with device tree.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-n8x0.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index d61a00d..c9eef2b 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -32,7 +32,7 @@
 
 #include "common.h"
 #include "mmc.h"
-
+#include "soc.h"
 #include "mux.h"
 #include "gpmc-onenand.h"
 
@@ -597,7 +597,8 @@ static void __init n8x0_mmc_init(void)
 	}
 
 	mmc_data[0] = &mmc1_data;
-	omap242x_init_mmc(mmc_data);
+	if (!of_have_populated_dt())
+		omap242x_init_mmc(mmc_data);
 }
 #else
 
@@ -730,6 +731,21 @@ static inline void board_serial_init(void)
 
 #endif
 
+static int __init n8x0_late_initcall(void)
+{
+	if (!board_caps)
+		return -ENODEV;
+
+	gpmc_onenand_init(board_onenand_data);
+	n8x0_mmc_init();
+	n8x0_usb_init();
+	if (!of_have_populated_dt())
+		n8x0_cbus_init();
+
+	return 0;
+}
+omap_late_initcall(n8x0_late_initcall);
+
 static void __init n8x0_init_machine(void)
 {
 	board_check_revision();
@@ -743,12 +759,10 @@ static void __init n8x0_init_machine(void)
 	if (board_is_n810())
 		i2c_register_board_info(2, n810_i2c_board_info_2,
 					ARRAY_SIZE(n810_i2c_board_info_2));
-	board_serial_init();
-	omap_sdrc_init(NULL, NULL);
-	gpmc_onenand_init(board_onenand_data);
-	n8x0_mmc_init();
-	n8x0_usb_init();
-	n8x0_cbus_init();
+	if (!of_have_populated_dt()) {
+		board_serial_init();
+		omap_sdrc_init(NULL, NULL);
+	}
 }
 
 MACHINE_START(NOKIA_N800, "Nokia N800")
-- 
1.8.1.1

