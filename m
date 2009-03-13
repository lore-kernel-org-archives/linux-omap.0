From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] Bugfix to RX51 flash support: this board has no NOR flash,
Date: Fri, 13 Mar 2009 11:03:47 -0700
Message-ID: <20090313180347.1548.57426.stgit@localhost>
References: <20090313180123.1548.1188.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62076 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbZCMSDs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 14:03:48 -0400
In-Reply-To: <20090313180123.1548.1188.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Lauri Leukkunen <lauri.leukkunen@nokia.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Acked-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-flash.c |   37 +-------------------------------
 1 files changed, 1 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-flash.c b/arch/arm/mach-omap2/board-rx51-flash.c
index cd030a6..39b0659 100644
--- a/arch/arm/mach-omap2/board-rx51-flash.c
+++ b/arch/arm/mach-omap2/board-rx51-flash.c
@@ -10,46 +10,12 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
-#include <asm/mach/flash.h>
-
-#include <mach/onenand.h>
+#include <linux/errno.h>
 
 #include "mmc-twl4030.h"
 
-#define	RX51_FLASH_CS	0
-
-extern struct mtd_partition n800_partitions[ONENAND_MAX_PARTITIONS];
-extern int n800_onenand_setup(void __iomem *onenand_base, int freq);
 extern void __init n800_flash_init(void);
 
-static struct flash_platform_data rx51_flash_data = {
-	.map_name	= "cfi_probe",
-	.width		= 2,
-	.parts		= n800_partitions,
-	.nr_parts	= ARRAY_SIZE(n800_partitions),
-};
-
-static struct resource rx51_flash_resource = {
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device rx51_flash_device = {
-	.name		= "omapflash",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &rx51_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &rx51_flash_resource,
-};
-
-static struct platform_device *rx51_flash_devices[] = {
-	&rx51_flash_device,
-};
-
 static struct twl4030_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "external",
@@ -71,7 +37,6 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
 
 void __init rx51_flash_init(void)
 {
-	platform_add_devices(rx51_flash_devices, ARRAY_SIZE(rx51_flash_devices));
 	n800_flash_init();
 	twl4030_mmc_init(mmc);
 }

