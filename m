From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 4/6] ARM: OMAP3: Mark only those mmc devices which use gpio_cd, as deferred
Date: Fri, 24 Feb 2012 15:28:55 +0530
Message-ID: <1330077537-19618-5-git-send-email-rnayak@ti.com>
References: <1330077537-19618-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58197 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab2BXJ7O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 04:59:14 -0500
In-Reply-To: <1330077537-19618-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

mmc devices which actually do not depend on twl4030-gpio for
gpio_cd should not be maked as deferred.

Also on overo, since none of the mmc devices need to be deferred,
get rid of omap_hsmmc_late_init() altogether.

Reported-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-cm-t35.c           |    1 -
 arch/arm/mach-omap2/board-igep0020.c         |    1 -
 arch/arm/mach-omap2/board-omap3evm.c         |    1 -
 arch/arm/mach-omap2/board-omap3pandora.c     |    1 -
 arch/arm/mach-omap2/board-overo.c            |    4 ----
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 --
 6 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 8eaed63..49e6405 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -422,7 +422,6 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.ocr_mask	= 0x00100000,	/* 3.3V */
-		.deferred	= true,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index ac1de09..e558800 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -303,7 +303,6 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
-		.deferred	= true,
 	},
 #endif
 	{}      /* Terminator */
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 0f9a983..6b77ad9 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -327,7 +327,6 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_wp	= -EINVAL,
 		.gpio_cd	= -EINVAL,
 		.nonremovable	= true,
-		.deferred	= true,
 	},
 #endif
 	{}	/* Terminator */
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 84c83c8..ace466b 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -290,7 +290,6 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.init_card	= pandora_wl1251_init_card,
-		.deferred	= true,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 1fc5f7a..668533e 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -301,7 +301,6 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
-		.deferred	= true,
 	},
 	{
 		.mmc		= 2,
@@ -310,7 +309,6 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_wp	= -EINVAL,
 		.transceiver	= true,
 		.ocr_mask	= 0x00100000,	/* 3.3V */
-		.deferred	= true,
 	},
 	{}	/* Terminator */
 };
@@ -409,8 +407,6 @@ static inline void __init overo_init_keys(void) { return; }
 static int overo_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	omap_hsmmc_late_init(mmc);
-
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 82a0f7c..3d39cdb 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -215,7 +215,6 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_wp	= -EINVAL,
 		.nonremovable	= true,
 		.power_saving	= true,
-		.deferred	= true,
 	},
 	{
 		.name		= "wl1271",
@@ -224,7 +223,6 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_wp	= -EINVAL,
 		.gpio_cd	= -EINVAL,
 		.nonremovable	= true,
-		.deferred	= true,
 	},
 	{}      /* Terminator */
 };
-- 
1.7.1

