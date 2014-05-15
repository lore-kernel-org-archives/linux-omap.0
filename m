From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] ARM: OMAP: SX1: remove check for CONFIG_SX1_OLD_FLASH
Date: Thu, 15 May 2014 21:41:42 +0200
Message-ID: <1400182902.11786.21.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

A check for CONFIG_SX1_OLD_FLASH was added in v2.6.24. But the related
Kconfig symbol was never part of the tree. So we can remove some dead
code.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Also untested.

 arch/arm/mach-omap1/board-sx1.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 0a8d3349149c..29e526235dc2 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -266,31 +266,6 @@ static struct physmap_flash_data sx1_flash_data = {
 	.nr_parts	= ARRAY_SIZE(sx1_partitions),
 };
 
-#ifdef CONFIG_SX1_OLD_FLASH
-/* MTD Intel StrataFlash - old flashes */
-static struct resource sx1_old_flash_resource[] = {
-	[0] = {
-		.start	= OMAP_CS0_PHYS,	/* Physical */
-		.end	= OMAP_CS0_PHYS + SZ_16M - 1,,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= OMAP_CS1_PHYS,
-		.end	= OMAP_CS1_PHYS + SZ_8M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device sx1_flash_device = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &sx1_flash_data,
-	},
-	.num_resources	= 2,
-	.resource	= &sx1_old_flash_resource,
-};
-#else
 /* MTD Intel 4000 flash - new flashes */
 static struct resource sx1_new_flash_resource = {
 	.start		= OMAP_CS0_PHYS,
@@ -307,7 +282,6 @@ static struct platform_device sx1_flash_device = {
 	.num_resources	= 1,
 	.resource	= &sx1_new_flash_resource,
 };
-#endif
 
 /*----------- USB -------------------------*/
 
-- 
1.9.0
