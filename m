From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 9/9] memory: omap-gpmc: switch to platform_get_irq
Date: Sun, 22 Dec 2019 18:50:34 +0000
Message-ID: <20191222185034.4665-9-tiny.windzz@gmail.com>
References: <20191222185034.4665-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191222185034.4665-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ssantosh@kernel.org, paul@crapouillou.net, matthias.bgg@gmail.com, rogerq@ti.com, tony@atomide.com, lukasz.luba@arm.com, kgene@kernel.org, krzk@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com, allison@lohutok.net, tglx@linutronix.de, yong.wu@mediatek.com, jroedel@suse.de, evgreen@chromium.org, rfontana@redhat.com, digetx@gmail.com, pdeschrijver@nvidia.com, john@phrozen.org, alexios.zavras@intel.com, sboyd@kernel.org, kstewart@linuxfoundation.org, info@metux.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-omap@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ) is not recommended for
requesting IRQ's resources, as they can be not ready yet. Using
platform_get_irq() instead is preferred for getting IRQ even if it
was not retrieved earlier.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/memory/omap-gpmc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index eff26c1b1394..6dd19d168f75 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2366,13 +2366,9 @@ static int gpmc_probe(struct platform_device *pdev)
 	if (IS_ERR(gpmc_base))
 		return PTR_ERR(gpmc_base);
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get resource: irq\n");
-		return -ENOENT;
-	}
-
-	gpmc->irq = res->start;
+	gpmc->irq = platform_get_irq(pdev, 0);
+	if (gpmc->irq < 0)
+		return gpmc->irq;
 
 	gpmc_l3_clk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(gpmc_l3_clk)) {
-- 
2.17.1
