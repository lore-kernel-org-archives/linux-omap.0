From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 2/5] omap mmc: Add better MMC low-level init
Date: Sun, 11 Jan 2009 00:03:40 +0100
Message-ID: <20090110230340.GB10758@michl.2n.cz>
References: <20081207213617.10456.43951.stgit@localhost> <20081207214747.10456.34844.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ex.2n.cz ([213.29.92.11]:52982 "EHLO ex.2n.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754372AbZAJXFE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Jan 2009 18:05:04 -0500
Content-Disposition: inline
In-Reply-To: <20081207214747.10456.34844.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Sun, Dec 07, 2008 at 01:47:47PM -0800, Tony Lindgren wrote:
> This will simplify the MMC low-level init, and make it more
> flexible to add support for a newer MMC controller in the
> following patches.

Simple simplification...

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

diff --git a/arch/arm/mach-omap1/board-h3-mmc.c b/arch/arm/mach-omap1/board-h3-mmc.c
index fdfe793..d7f40f9 100644
--- a/arch/arm/mach-omap1/board-h3-mmc.c
+++ b/arch/arm/mach-omap1/board-h3-mmc.c
@@ -24,11 +24,7 @@
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
index 7fdb725..4de55c7 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -223,11 +223,7 @@ static struct omap_usb_config nokia770_usb_config __initdata = {
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
 

