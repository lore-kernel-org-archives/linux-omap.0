From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] Revert "mmc: host: omap_hsmmc: use regulator_is_enabled to find pbias status"
Date: Wed,  7 Oct 2015 06:22:24 -0700
Message-ID: <1444224145-24333-1-git-send-email-tony@atomide.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Nishanth Menon <nm@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

This reverts commit c55d7a0553643a7e8f120688b82b594471084d3c.

Without reverting this commit we get "unbalanced disables for pbias_mmc_omap4"
errors on omap4430. It seems that 4430 and 4460 behave in a different way for
the PBIAS regulator registers and until that has been debugged further we
cannot rely on the regulator status registers in hardare on 4430.

Fixes: 7d607f917008 ("mmc: host: omap_hsmmc: use
devm_regulator_get_optional() for vmmc")
Cc: Felipe Balbi <balbi@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 781e4db3..ae3a2b9 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -182,6 +182,7 @@ struct omap_hsmmc_host {
 	struct	clk		*fclk;
 	struct	clk		*dbclk;
 	struct	regulator	*pbias;
+	bool			pbias_enabled;
 	void	__iomem		*base;
 	int			vqmmc_enabled;
 	resource_size_t		mapbase;
@@ -328,20 +329,22 @@ static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on,
 			return ret;
 		}
 
-		if (!regulator_is_enabled(host->pbias)) {
+		if (host->pbias_enabled == 0) {
 			ret = regulator_enable(host->pbias);
 			if (ret) {
 				dev_err(host->dev, "pbias reg enable fail\n");
 				return ret;
 			}
+			host->pbias_enabled = 1;
 		}
 	} else {
-		if (regulator_is_enabled(host->pbias)) {
+		if (host->pbias_enabled == 1) {
 			ret = regulator_disable(host->pbias);
 			if (ret) {
 				dev_err(host->dev, "pbias reg disable fail\n");
 				return ret;
 			}
+			host->pbias_enabled = 0;
 		}
 	}
 
@@ -2053,6 +2056,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->base	= base + pdata->reg_offset;
 	host->power_mode = MMC_POWER_OFF;
 	host->next_data.cookie = 1;
+	host->pbias_enabled = 0;
 	host->vqmmc_enabled = 0;
 
 	ret = omap_hsmmc_gpio_init(mmc, host, pdata);
-- 
2.1.4

