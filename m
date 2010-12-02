From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 1/2] arm: mach-omap2: n8x0: clean up dummy onenand init
Date: Thu,  2 Dec 2010 17:51:23 +0200
Message-ID: <1291305084-9159-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:43324 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517Ab0LBPus (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Dec 2010 10:50:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

When OneNAND support is disabled, the platform code defines NULL
board_onenand_data and empty init function for us. By utilizing this we
can avoid cluttering board files with dummy definitions/wrappers.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/board-n8x0.c |   26 +++++++++-----------------
 1 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index dd353ff..0a4bc77 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -184,23 +184,15 @@ static struct mtd_partition onenand_partitions[] = {
 	},
 };
 
-static struct omap_onenand_platform_data board_onenand_data = {
-	.cs		= 0,
-	.gpio_irq	= 26,
-	.parts		= onenand_partitions,
-	.nr_parts	= ARRAY_SIZE(onenand_partitions),
-	.flags		= ONENAND_SYNC_READ,
+static struct omap_onenand_platform_data board_onenand_data[] = {
+	{
+		.cs		= 0,
+		.gpio_irq	= 26,
+		.parts		= onenand_partitions,
+		.nr_parts	= ARRAY_SIZE(onenand_partitions),
+		.flags		= ONENAND_SYNC_READ,
+	}
 };
-
-static void __init n8x0_onenand_init(void)
-{
-	gpmc_onenand_init(&board_onenand_data);
-}
-
-#else
-
-static void __init n8x0_onenand_init(void) {}
-
 #endif
 
 #if defined(CONFIG_MENELAUS) &&						\
@@ -669,7 +661,7 @@ static void __init n8x0_init_machine(void)
 					ARRAY_SIZE(n810_i2c_board_info_2));
 
 	omap_serial_init();
-	n8x0_onenand_init();
+	gpmc_onenand_init(board_onenand_data);
 	n8x0_mmc_init();
 	n8x0_usb_init();
 }
-- 
1.5.6.5

