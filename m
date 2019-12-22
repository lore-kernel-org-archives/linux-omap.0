From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 3/9] memory: mvebu-devbus: convert to devm_platform_ioremap_resource
Date: Sun, 22 Dec 2019 18:50:28 +0000
Message-ID: <20191222185034.4665-3-tiny.windzz@gmail.com>
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
 drivers/memory/mvebu-devbus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
index 095f8a3b2cfc..886aea587276 100644
--- a/drivers/memory/mvebu-devbus.c
+++ b/drivers/memory/mvebu-devbus.c
@@ -267,7 +267,6 @@ static int mvebu_devbus_probe(struct platform_device *pdev)
 	struct devbus_read_params r;
 	struct devbus_write_params w;
 	struct devbus *devbus;
-	struct resource *res;
 	struct clk *clk;
 	unsigned long rate;
 	int err;
@@ -277,8 +276,7 @@ static int mvebu_devbus_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	devbus->dev = dev;
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	devbus->base = devm_ioremap_resource(&pdev->dev, res);
+	devbus->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(devbus->base))
 		return PTR_ERR(devbus->base);
 
-- 
2.17.1
