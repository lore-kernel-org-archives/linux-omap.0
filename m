From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 2/2] arm: mach-omap2: rx51: clean up dummy onenand init
Date: Thu,  2 Dec 2010 17:51:24 +0200
Message-ID: <1291305084-9159-2-git-send-email-aaro.koskinen@nokia.com>
References: <1291305084-9159-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:43342 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754668Ab0LBPus (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Dec 2010 10:50:48 -0500
In-Reply-To: <1291305084-9159-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

When OneNAND support is disabled, the platform code defines NULL
board_onenand_data and empty init function for us. By utilizing this we
can avoid cluttering board files with dummy definitions/wrappers.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   28 ++++++++-----------------
 1 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 3fec4d6..14a6fbd 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -815,25 +815,15 @@ static struct mtd_partition onenand_partitions[] = {
 	},
 };
 
-static struct omap_onenand_platform_data board_onenand_data = {
-	.cs		= 0,
-	.gpio_irq	= 65,
-	.parts		= onenand_partitions,
-	.nr_parts	= ARRAY_SIZE(onenand_partitions),
-	.flags		= ONENAND_SYNC_READWRITE,
+static struct omap_onenand_platform_data board_onenand_data[] = {
+	{
+		.cs		= 0,
+		.gpio_irq	= 65,
+		.parts		= onenand_partitions,
+		.nr_parts	= ARRAY_SIZE(onenand_partitions),
+		.flags		= ONENAND_SYNC_READWRITE,
+	}
 };
-
-static void __init board_onenand_init(void)
-{
-	gpmc_onenand_init(&board_onenand_data);
-}
-
-#else
-
-static inline void board_onenand_init(void)
-{
-}
-
 #endif
 
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
@@ -916,7 +906,7 @@ error:
 void __init rx51_peripherals_init(void)
 {
 	rx51_i2c_init();
-	board_onenand_init();
+	gpmc_onenand_init(board_onenand_data);
 	board_smc91x_init();
 	rx51_add_gpio_keys();
 	rx51_init_wl1251();
-- 
1.5.6.5

