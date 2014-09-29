From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v2 5/9] omap_hsmmc: remove unused get_context_loss_count callback
Date: Mon, 29 Sep 2014 11:32:55 +0200
Message-ID: <1411983179-28677-6-git-send-email-afenkart@gmail.com>
References: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:50977 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbaI2JdR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2014 05:33:17 -0400
In-Reply-To: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>

trigger of this callback has been removed in 0a82e06e6183

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 1c10402..312f13d 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -32,17 +32,6 @@ static u16 control_devconf1_offset;
 
 #define HSMMC_NAME_LEN	9
 
-#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
-
-static int hsmmc_get_context_loss(struct device *dev)
-{
-	return omap_pm_get_dev_context_loss_count(dev);
-}
-
-#else
-#define hsmmc_get_context_loss NULL
-#endif
-
 static void omap_hsmmc1_before_set_reg(struct device *dev, int slot,
 				  int power_on, int vdd)
 {
@@ -264,7 +253,6 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	mmc->slots[0].caps = c->caps;
 	mmc->slots[0].internal_clock = !c->ext_clock;
 	mmc->reg_offset = 0;
-	mmc->get_context_loss_count = hsmmc_get_context_loss;
 
 	mmc->slots[0].switch_pin = c->gpio_cd;
 	mmc->slots[0].gpio_wp = c->gpio_wp;
diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
index 2807786..dc44dfb 100644
--- a/include/linux/platform_data/hsmmc-omap.h
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -49,9 +49,6 @@ struct omap_hsmmc_platform_data {
 	int (*suspend)(struct device *dev, int slot);
 	int (*resume)(struct device *dev, int slot);
 
-	/* Return context loss count due to PM states changing */
-	int (*get_context_loss_count)(struct device *dev);
-
 	/* Integrating attributes from the omap_hwmod layer */
 	u8 controller_flags;
 
-- 
2.1.0

