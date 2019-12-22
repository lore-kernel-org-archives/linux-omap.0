From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/9] memory: emif: convert to devm_platform_ioremap_resource
Date: Sun, 22 Dec 2019 18:50:26 +0000
Message-ID: <20191222185034.4665-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ssantosh@kernel.org, paul@crapouillou.net, matthias.bgg@gmail.com, rogerq@ti.com, tony@atomide.com, lukasz.luba@arm.com, kgene@kernel.org, krzk@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com, allison@lohutok.net, tglx@linutronix.de, yong.wu@mediatek.com, jroedel@suse.de, evgreen@chromium.org, rfontana@redhat.com, digetx@gmail.com, pdeschrijver@nvidia.com, john@phrozen.org, alexios.zavras@intel.com, sboyd@kernel.org, kstewart@linuxfoundation.org, info@metux.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-omap@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/memory/emif.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 9d9127bf2a59..9a8463716a54 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1537,7 +1537,6 @@ static struct emif_data *__init_or_module get_device_details(
 static int __init_or_module emif_probe(struct platform_device *pdev)
 {
 	struct emif_data	*emif;
-	struct resource		*res;
 	int			irq;
 
 	if (pdev->dev.of_node)
@@ -1557,8 +1556,7 @@ static int __init_or_module emif_probe(struct platform_device *pdev)
 	emif->dev = &pdev->dev;
 	platform_set_drvdata(pdev, emif);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	emif->base = devm_ioremap_resource(emif->dev, res);
+	emif->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emif->base))
 		goto error;
 
-- 
2.17.1
