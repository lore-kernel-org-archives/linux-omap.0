From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v4 09/11] mmc: sdhci-omap: Add ti,needs-special-reset property
Date: Mon, 6 Jan 2020 16:31:31 +0530
Message-ID: <20200106110133.13791-10-faiz_abbas@ti.com>
References: <20200106110133.13791-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200106110133.13791-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: kishon@ti.com, adrian.hunter@intel.com, mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org, tony@atomide.com, faiz_abbas@ti.com
List-Id: linux-omap@vger.kernel.org

Some omap controllers need software to monitor a 0->1->0 for software
reset. Add a ti,needs-special-reset property to indicate this and use
the special_reset member to indicate when a controller needs this.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 1f05c8e98d62..34df30edd450 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -107,6 +107,7 @@ struct sdhci_omap_host {
 	struct pinctrl		*pinctrl;
 	struct pinctrl_state	**pinctrl_state;
 	bool			is_tuning;
+	bool			special_reset;
 };
 
 static void sdhci_omap_start_clock(struct sdhci_omap_host *omap_host);
@@ -779,15 +780,35 @@ static void sdhci_omap_set_uhs_signaling(struct sdhci_host *host,
 	sdhci_omap_start_clock(omap_host);
 }
 
+#define MMC_TIMEOUT_US		20000		/* 20000 micro Sec */
 static void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
+	unsigned long limit = MMC_TIMEOUT_US;
+	unsigned long i = 0;
 
 	/* Don't reset data lines during tuning operation */
 	if (omap_host->is_tuning)
 		mask &= ~SDHCI_RESET_DATA;
 
+	if (omap_host->special_reset) {
+		sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
+		while ((!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask)) &&
+		       (i++ < limit))
+			udelay(1);
+		i = 0;
+		while ((sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) &&
+		       (i++ < limit))
+			udelay(1);
+
+		if (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask)
+			dev_err(mmc_dev(host->mmc),
+				"Timeout waiting on controller reset in %s\n",
+				__func__);
+		return;
+	}
+
 	sdhci_reset(host, mask);
 }
 
@@ -1107,6 +1128,9 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	if (!mmc_can_gpio_ro(mmc))
 		mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
 
+	if (of_find_property(dev->of_node, "ti,needs-special-reset", NULL))
+		omap_host->special_reset = true;
+
 	pltfm_host->clk = devm_clk_get(dev, "fck");
 	if (IS_ERR(pltfm_host->clk)) {
 		ret = PTR_ERR(pltfm_host->clk);
-- 
2.19.2
