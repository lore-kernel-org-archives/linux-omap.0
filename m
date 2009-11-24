From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH] Zoom2/3:Update hsmmc board config params
Date: Wed, 25 Nov 2009 02:45:45 +0530 (IST)
Message-ID: <57430.192.168.10.88.1259097345.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39345 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934162AbZKXVPl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 16:15:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org

From: Madhusudhan Chikkature <madhu.cr@ti.com>
Subject: [PATCH] Zoom2/3:Update hsmmc board config params.

Update the hsmmc zoom peripheral configuration to support:
Power saving mode
mmc2 8-bit support
Configure mmc2 as non removable

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 221a8e3..258794d 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -152,14 +152,20 @@ static struct regulator_init_data zoom_vsim = {

 static struct twl4030_hsmmc_info mmc[] __initdata = {
 	{
+		.name		= "external",
 		.mmc		= 1,
 		.wires		= 4,
 		.gpio_wp	= -EINVAL,
+		.power_saving	= true,
 	},
 	{
+		.name		= "internal",
 		.mmc		= 2,
-		.wires		= 4,
+		.wires		= 8,
+		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.nonremovable	= true,
+		.power_saving	= true,
 	},
 	{}      /* Terminator */
 };
@@ -167,11 +173,8 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
 static int zoom_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	/* gpio + 0 is "mmc0_cd" (input/IRQ),
-	 * gpio + 1 is "mmc1_cd" (input/IRQ)
-	 */
+	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	mmc[1].gpio_cd = gpio + 1;
 	twl4030_mmc_init(mmc);

 	/* link regulators to MMC adapters ... we "know" the
-- 
1.6.0.4



