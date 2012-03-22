From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH 02/13] Fix possible stale smsc911x flags.
Date: Wed, 21 Mar 2012 22:19:43 -0700
Message-ID: <1332393594-23993-3-git-send-email-Russ.Dill@ti.com>
References: <20120321194133.GP9859@atomide.com>
 <1332393594-23993-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35468 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426Ab2CVFUS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 01:20:18 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so2617327iag.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 22:20:18 -0700 (PDT)
In-Reply-To: <1332393594-23993-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org, Russ Dill <Russ.Dill@ti.com>, Russ Dill <russ.dill@ti.com>

If this function is called the first time with flags set, and the
second time without flags set then the leftover flags from the first
called will be used rather than the desired default flags.

Signed-off-by: Russ Dill <russ.dill@ti.com>
---
 arch/arm/mach-omap2/gpmc-smsc911x.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index aa0c296..f9446ea 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -39,7 +39,6 @@ static struct smsc911x_platform_config gpmc_smsc911x_config = {
 	.phy_interface	= PHY_INTERFACE_MODE_MII,
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
 	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
-	.flags		= SMSC911X_USE_16BIT,
 };
 
 static struct regulator_consumer_supply gpmc_smsc911x_supply[] = {
@@ -135,8 +134,7 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *gpmc_cfg)
 		gpio_set_value(gpmc_cfg->gpio_reset, 1);
 	}
 
-	if (gpmc_cfg->flags)
-		gpmc_smsc911x_config.flags = gpmc_cfg->flags;
+	gpmc_smsc911x_config.flags = gpmc_cfg->flags ? : SMSC911X_USE_16BIT;
 
 	pdev = platform_device_register_resndata(NULL, "smsc911x", gpmc_cfg->id,
 		 gpmc_smsc911x_resources, ARRAY_SIZE(gpmc_smsc911x_resources),
-- 
1.7.9.1

