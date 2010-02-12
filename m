From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/19] omap_hsmmc: allow compile without regulator framework
Date: Thu, 11 Feb 2010 16:51:31 -0800
Message-ID: <20100212005131.24958.67879.stgit@baageli.muru.com>
References: <20100212004844.24958.29506.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51476 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757750Ab0BLAuu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 19:50:50 -0500
In-Reply-To: <20100212004844.24958.29506.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

From: Adrian Hunter <adrian.hunter@nokia.com>

It is still possible to use the omap_hsmmc module
without the regulator framework.  Accordingly, ifdef
out regulator-specific functions.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |  133 ++++++++++++++++++++++++-----------------
 1 files changed, 79 insertions(+), 54 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index af37477..83f0aff 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -236,6 +236,8 @@ static int omap_hsmmc_resume_cdirq(struct device *dev, int slot)
 
 #endif
 
+#ifdef CONFIG_REGULATOR
+
 static int omap_hsmmc_1_set_power(struct device *dev, int slot, int power_on,
 				  int vdd)
 {
@@ -357,59 +359,6 @@ static int omap_hsmmc_23_set_sleep(struct device *dev, int slot, int sleep,
 		return regulator_enable(host->vcc_aux);
 }
 
-static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
-{
-	int ret;
-
-	if (gpio_is_valid(pdata->slots[0].switch_pin)) {
-		pdata->suspend = omap_hsmmc_suspend_cdirq;
-		pdata->resume = omap_hsmmc_resume_cdirq;
-		if (pdata->slots[0].cover)
-			pdata->slots[0].get_cover_state =
-					omap_hsmmc_get_cover_state;
-		else
-			pdata->slots[0].card_detect = omap_hsmmc_card_detect;
-		pdata->slots[0].card_detect_irq =
-				gpio_to_irq(pdata->slots[0].switch_pin);
-		ret = gpio_request(pdata->slots[0].switch_pin, "mmc_cd");
-		if (ret)
-			return ret;
-		ret = gpio_direction_input(pdata->slots[0].switch_pin);
-		if (ret)
-			goto err_free_sp;
-	} else
-		pdata->slots[0].switch_pin = -EINVAL;
-
-	if (gpio_is_valid(pdata->slots[0].gpio_wp)) {
-		pdata->slots[0].get_ro = omap_hsmmc_get_wp;
-		ret = gpio_request(pdata->slots[0].gpio_wp, "mmc_wp");
-		if (ret)
-			goto err_free_cd;
-		ret = gpio_direction_input(pdata->slots[0].gpio_wp);
-		if (ret)
-			goto err_free_wp;
-	} else
-		pdata->slots[0].gpio_wp = -EINVAL;
-
-	return 0;
-
-err_free_wp:
-	gpio_free(pdata->slots[0].gpio_wp);
-err_free_cd:
-	if (gpio_is_valid(pdata->slots[0].switch_pin))
-err_free_sp:
-		gpio_free(pdata->slots[0].switch_pin);
-	return ret;
-}
-
-static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
-{
-	if (gpio_is_valid(pdata->slots[0].gpio_wp))
-		gpio_free(pdata->slots[0].gpio_wp);
-	if (gpio_is_valid(pdata->slots[0].switch_pin))
-		gpio_free(pdata->slots[0].switch_pin);
-}
-
 static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 {
 	struct regulator *reg;
@@ -488,6 +437,82 @@ static void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
 	mmc_slot(host).set_sleep = NULL;
 }
 
+static inline int omap_hsmmc_have_reg(void)
+{
+	return 1;
+}
+
+#else
+
+static inline int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
+{
+	return -EINVAL;
+}
+
+static inline void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
+{
+}
+
+static inline int omap_hsmmc_have_reg(void)
+{
+	return 0;
+}
+
+#endif
+
+static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
+{
+	int ret;
+
+	if (gpio_is_valid(pdata->slots[0].switch_pin)) {
+		pdata->suspend = omap_hsmmc_suspend_cdirq;
+		pdata->resume = omap_hsmmc_resume_cdirq;
+		if (pdata->slots[0].cover)
+			pdata->slots[0].get_cover_state =
+					omap_hsmmc_get_cover_state;
+		else
+			pdata->slots[0].card_detect = omap_hsmmc_card_detect;
+		pdata->slots[0].card_detect_irq =
+				gpio_to_irq(pdata->slots[0].switch_pin);
+		ret = gpio_request(pdata->slots[0].switch_pin, "mmc_cd");
+		if (ret)
+			return ret;
+		ret = gpio_direction_input(pdata->slots[0].switch_pin);
+		if (ret)
+			goto err_free_sp;
+	} else
+		pdata->slots[0].switch_pin = -EINVAL;
+
+	if (gpio_is_valid(pdata->slots[0].gpio_wp)) {
+		pdata->slots[0].get_ro = omap_hsmmc_get_wp;
+		ret = gpio_request(pdata->slots[0].gpio_wp, "mmc_wp");
+		if (ret)
+			goto err_free_cd;
+		ret = gpio_direction_input(pdata->slots[0].gpio_wp);
+		if (ret)
+			goto err_free_wp;
+	} else
+		pdata->slots[0].gpio_wp = -EINVAL;
+
+	return 0;
+
+err_free_wp:
+	gpio_free(pdata->slots[0].gpio_wp);
+err_free_cd:
+	if (gpio_is_valid(pdata->slots[0].switch_pin))
+err_free_sp:
+		gpio_free(pdata->slots[0].switch_pin);
+	return ret;
+}
+
+static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
+{
+	if (gpio_is_valid(pdata->slots[0].gpio_wp))
+		gpio_free(pdata->slots[0].gpio_wp);
+	if (gpio_is_valid(pdata->slots[0].switch_pin))
+		gpio_free(pdata->slots[0].switch_pin);
+}
+
 /*
  * Stop clock to the card
  */
@@ -2119,7 +2144,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (!mmc_slot(host).set_power) {
+	if (omap_hsmmc_have_reg() && !mmc_slot(host).set_power) {
 		ret = omap_hsmmc_reg_get(host);
 		if (ret)
 			goto err_reg;

