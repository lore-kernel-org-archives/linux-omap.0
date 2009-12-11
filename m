From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/14] omap3: Zoom2/3: Update hsmmc board config params
Date: Fri, 11 Dec 2009 15:54:39 -0800
Message-ID: <20091211235439.3189.64256.stgit@localhost>
References: <20091211234919.3189.95607.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61235 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934041AbZLKXyd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 18:54:33 -0500
In-Reply-To: <20091211234919.3189.95607.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Madhusudhan Chikkature <madhu.cr@ti.com>

From: Madhusudhan Chikkature <madhu.cr@ti.com>

Update the hsmmc zoom peripheral configuration to support:
Power saving mode
mmc2 8-bit support
Configure mmc2 as non removable

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
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

