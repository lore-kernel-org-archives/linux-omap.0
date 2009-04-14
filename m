From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/11] ARM: OMAP1: Simplify board-h2 MMC setup
Date: Tue, 14 Apr 2009 14:53:01 -0700
Message-ID: <20090414215301.9878.67890.stgit@localhost>
References: <20090414214638.9878.17987.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64457 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755552AbZDNVxK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 17:53:10 -0400
In-Reply-To: <20090414214638.9878.17987.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>

From: Ladislav Michl <ladis@linux-mips.org>

Simplify board-h2 MMC setup

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-h2-mmc.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
index 44d4a96..46098f5 100644
--- a/arch/arm/mach-omap1/board-h2-mmc.c
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -26,19 +26,13 @@
 static int mmc_set_power(struct device *dev, int slot, int power_on,
 				int vdd)
 {
-	if (power_on)
-		gpio_direction_output(H2_TPS_GPIO_MMC_PWR_EN, 1);
-	else
-		gpio_direction_output(H2_TPS_GPIO_MMC_PWR_EN, 0);
-
+	gpio_set_value(H2_TPS_GPIO_MMC_PWR_EN, power_on);
 	return 0;
 }
 
 static int mmc_late_init(struct device *dev)
 {
-	int ret;
-
-	ret = gpio_request(H2_TPS_GPIO_MMC_PWR_EN, "MMC power");
+	int ret = gpio_request(H2_TPS_GPIO_MMC_PWR_EN, "MMC power");
 	if (ret < 0)
 		return ret;
 
@@ -47,7 +41,7 @@ static int mmc_late_init(struct device *dev)
 	return ret;
 }
 
-static void mmc_shutdown(struct device *dev)
+static void mmc_cleanup(struct device *dev)
 {
 	gpio_free(H2_TPS_GPIO_MMC_PWR_EN);
 }
@@ -60,7 +54,7 @@ static void mmc_shutdown(struct device *dev)
 static struct omap_mmc_platform_data mmc1_data = {
 	.nr_slots                       = 1,
 	.init				= mmc_late_init,
-	.shutdown			= mmc_shutdown,
+	.cleanup			= mmc_cleanup,
 	.dma_mask			= 0xffffffff,
 	.slots[0]       = {
 		.set_power              = mmc_set_power,

