From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 6/9] memory: ti-aemif: convert to devm_platform_ioremap_resource
Date: Sun, 22 Dec 2019 18:50:31 +0000
Message-ID: <20191222185034.4665-6-tiny.windzz@gmail.com>
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
 drivers/memory/ti-aemif.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index db526dbf71ee..6524229f634a 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -328,7 +328,6 @@ static int aemif_probe(struct platform_device *pdev)
 {
 	int i;
 	int ret = -ENODEV;
-	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct device_node *child_np;
@@ -362,8 +361,7 @@ static int aemif_probe(struct platform_device *pdev)
 	else if (pdata)
 		aemif->cs_offset = pdata->cs_offset;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	aemif->base = devm_ioremap_resource(dev, res);
+	aemif->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(aemif->base)) {
 		ret = PTR_ERR(aemif->base);
 		goto error;
-- 
2.17.1
