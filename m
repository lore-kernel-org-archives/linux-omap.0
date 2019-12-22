From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 7/9] memory: samsung: exynos5422-dmc: convert to devm_platform_ioremap_resource
Date: Sun, 22 Dec 2019 18:50:32 +0000
Message-ID: <20191222185034.4665-7-tiny.windzz@gmail.com>
References: <20191222185034.4665-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191222185034.4665-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ssantosh@kernel.org, paul@crapouillou.net, matthias.bgg@gmail.com, rogerq@ti.com, tony@atomide.com, lukasz.luba@arm.com, kgene@kernel.org, krzk@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com, allison@lohutok.net, tglx@linutronix.de, yong.wu@mediatek.com, jroedel@suse.de, evgreen@chromium.org, rfontana@redhat.com, digetx@gmail.com, pdeschrijver@nvidia.com, john@phrozen.org, alexios.zavras@intel.com, sboyd@kernel.org, kstewart@linuxfoundation.org, info@metux.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-omap@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 47dbf6d1789f..81a1b1d01683 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1374,7 +1374,6 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct exynos5_dmc *dmc;
-	struct resource *res;
 	int irq[2];
 
 	dmc = devm_kzalloc(dev, sizeof(*dmc), GFP_KERNEL);
@@ -1386,13 +1385,11 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
 	dmc->dev = dev;
 	platform_set_drvdata(pdev, dmc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dmc->base_drexi0 = devm_ioremap_resource(dev, res);
+	dmc->base_drexi0 = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dmc->base_drexi0))
 		return PTR_ERR(dmc->base_drexi0);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	dmc->base_drexi1 = devm_ioremap_resource(dev, res);
+	dmc->base_drexi1 = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(dmc->base_drexi1))
 		return PTR_ERR(dmc->base_drexi1);
 
-- 
2.17.1
