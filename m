From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/11] ARM: OMAP1: Fix mmc_set_power GPIO usage
Date: Tue, 14 Apr 2009 14:54:24 -0700
Message-ID: <20090414215424.9878.45067.stgit@localhost>
References: <20090414214638.9878.17987.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65491 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbZDNVy0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 17:54:26 -0400
In-Reply-To: <20090414214638.9878.17987.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>

From: Ladislav Michl <ladis@linux-mips.org>

Simple simplification...

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-h3-mmc.c   |    6 +-----
 arch/arm/mach-omap1/board-nokia770.c |    6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h3-mmc.c b/arch/arm/mach-omap1/board-h3-mmc.c
index 0d8a3c1..5e8877c 100644
--- a/arch/arm/mach-omap1/board-h3-mmc.c
+++ b/arch/arm/mach-omap1/board-h3-mmc.c
@@ -26,11 +26,7 @@
 static int mmc_set_power(struct device *dev, int slot, int power_on,
 				int vdd)
 {
-	if (power_on)
-		gpio_direction_output(H3_TPS_GPIO_MMC_PWR_EN, 1);
-	else
-		gpio_direction_output(H3_TPS_GPIO_MMC_PWR_EN, 0);
-
+	gpio_set_value(H3_TPS_GPIO_MMC_PWR_EN, power_on);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 7bc7a3c..d1ed136 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -181,11 +181,7 @@ static struct omap_usb_config nokia770_usb_config __initdata = {
 static int nokia770_mmc_set_power(struct device *dev, int slot, int power_on,
 				int vdd)
 {
-	if (power_on)
-		gpio_set_value(NOKIA770_GPIO_MMC_POWER, 1);
-	else
-		gpio_set_value(NOKIA770_GPIO_MMC_POWER, 0);
-
+	gpio_set_value(NOKIA770_GPIO_MMC_POWER, power_on);
 	return 0;
 }
 

