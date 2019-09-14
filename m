From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/7] hwrng: omap3-rom - Use devm hwrng and runtime PM
Date: Sat, 14 Sep 2019 14:03:00 -0700
Message-ID: <20190914210300.15836-8-tony@atomide.com>
References: <20190914210300.15836-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190914210300.15836-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This allows us to simplify things more for probe and exit.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Adam Ford <aford173@gmail.com>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Suggested-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/char/hw_random/omap3-rom-rng.c | 42 ++++++++++----------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/char/hw_random/omap3-rom-rng.c b/drivers/char/hw_random/omap3-rom-rng.c
--- a/drivers/char/hw_random/omap3-rom-rng.c
+++ b/drivers/char/hw_random/omap3-rom-rng.c
@@ -100,6 +100,14 @@ static int omap_rom_rng_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static void omap_rom_rng_finish(void *data)
+{
+	struct omap_rom_rng *ddata = data;
+
+	pm_runtime_dont_use_autosuspend(ddata->dev);
+	pm_runtime_disable(ddata->dev);
+}
+
 static int omap3_rom_rng_probe(struct platform_device *pdev)
 {
 	struct omap_rom_rng *ddata;
@@ -133,33 +141,16 @@ static int omap3_rom_rng_probe(struct platform_device *pdev)
 		return PTR_ERR(ddata->clk);
 	}
 
-	pm_runtime_enable(ddata->dev);
-
-	ret = hwrng_register(&ddata->ops);
-	if (!ret)
-		goto err_disable;
-
-	pm_runtime_set_autosuspend_delay(ddata->dev, 500);
-	pm_runtime_use_autosuspend(ddata->dev);
-
-	return 0;
-
-err_disable:
-	pm_runtime_disable(ddata->dev);
-
-	return ret;
-}
-
-static int omap3_rom_rng_remove(struct platform_device *pdev)
-{
-	struct omap_rom_rng *ddata;
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
+	pm_runtime_use_autosuspend(&pdev->dev);
 
-	ddata = dev_get_drvdata(&pdev->dev);
-	hwrng_unregister(&ddata->ops);
-	pm_runtime_dont_use_autosuspend(ddata->dev);
-	pm_runtime_disable(ddata->dev);
+	ret = devm_add_action_or_reset(ddata->dev, omap_rom_rng_finish,
+				       ddata);
+	if (ret)
+		return ret;
 
-	return 0;
+	return devm_hwrng_register(ddata->dev, &ddata->ops);
 }
 
 static const struct of_device_id omap_rom_rng_match[] = {
@@ -180,7 +171,6 @@ static struct platform_driver omap3_rom_rng_driver = {
 		.pm = &omap_rom_rng_pm_ops,
 	},
 	.probe		= omap3_rom_rng_probe,
-	.remove		= omap3_rom_rng_remove,
 };
 
 module_platform_driver(omap3_rom_rng_driver);
-- 
2.23.0
