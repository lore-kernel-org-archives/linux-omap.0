From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 2/2] mmc: host: omap_hsmmc: remove unused platform callbacks
Date: Fri, 14 Jul 2017 18:16:44 +0530
Message-ID: <1500036404-5556-3-git-send-email-faiz_abbas@ti.com>
References: <1500036404-5556-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500036404-5556-1-git-send-email-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ulf.hansson@linaro.org
Cc: linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, rk@ti.com, nsekhar@ti.com, linus.walleij@linaro.org, hkallweit1@gmail.com, peter.ujfalusi@ti.com, Faiz Abbas <faiz_abbas@ti.com>
List-Id: linux-omap@vger.kernel.org

Remove unused callbacks in the omap_hsmmc_platform_data structure

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c            | 11 -----------
 include/linux/platform_data/hsmmc-omap.h | 10 ----------
 2 files changed, 21 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 7c12f37..04ff3c9 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -356,9 +356,6 @@ static int omap_hsmmc_set_power(struct omap_hsmmc_host *host, int power_on,
 	struct mmc_host *mmc = host->mmc;
 	int ret = 0;
 
-	if (mmc_pdata(host)->set_power)
-		return mmc_pdata(host)->set_power(host->dev, power_on, vdd);
-
 	/*
 	 * If we don't see a Vcc regulator, assume it's a fixed
 	 * voltage always-on regulator.
@@ -366,9 +363,6 @@ static int omap_hsmmc_set_power(struct omap_hsmmc_host *host, int power_on,
 	if (IS_ERR(mmc->supply.vmmc))
 		return 0;
 
-	if (mmc_pdata(host)->before_set_reg)
-		mmc_pdata(host)->before_set_reg(host->dev, power_on, vdd);
-
 	ret = omap_hsmmc_set_pbias(host, false, 0);
 	if (ret)
 		return ret;
@@ -400,9 +394,6 @@ static int omap_hsmmc_set_power(struct omap_hsmmc_host *host, int power_on,
 			return ret;
 	}
 
-	if (mmc_pdata(host)->after_set_reg)
-		mmc_pdata(host)->after_set_reg(host->dev, power_on, vdd);
-
 	return 0;
 
 err_set_voltage:
@@ -469,8 +460,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	int ret;
 	struct mmc_host *mmc = host->mmc;
 
-	if (mmc_pdata(host)->set_power)
-		return 0;
 
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret == -EPROBE_DEFER)
diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
index 8e981be..0ff1e0d 100644
--- a/include/linux/platform_data/hsmmc-omap.h
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -55,9 +55,6 @@ struct omap_hsmmc_platform_data {
 	u32 caps;	/* Used for the MMC driver on 2430 and later */
 	u32 pm_caps;	/* PM capabilities of the mmc */
 
-	/* use the internal clock */
-	unsigned internal_clock:1;
-
 	/* nonremovable e.g. eMMC */
 	unsigned nonremovable:1;
 
@@ -73,13 +70,6 @@ struct omap_hsmmc_platform_data {
 	int gpio_cd;			/* gpio (card detect) */
 	int gpio_cod;			/* gpio (cover detect) */
 	int gpio_wp;			/* gpio (write protect) */
-
-	int (*set_power)(struct device *dev, int power_on, int vdd);
-	void (*remux)(struct device *dev, int power_on);
-	/* Call back before enabling / disabling regulators */
-	void (*before_set_reg)(struct device *dev, int power_on, int vdd);
-	/* Call back after enabling / disabling regulators */
-	void (*after_set_reg)(struct device *dev, int power_on, int vdd);
 	/* if we have special card, init it using this callback */
 	void (*init_card)(struct mmc_card *card);
 
-- 
2.7.4
