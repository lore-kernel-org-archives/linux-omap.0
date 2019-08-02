From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] usb: dwc3: omap: use devm_platform_ioremap_resource() to simplify code
Date: Fri, 2 Aug 2019 21:06:16 +0800
Message-ID: <20190802130616.8516-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-omap@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 6f711d5..b9e25f5 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -446,7 +446,6 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	struct device_node	*node = pdev->dev.of_node;
 
 	struct dwc3_omap	*omap;
-	struct resource		*res;
 	struct device		*dev = &pdev->dev;
 	struct regulator	*vbus_reg = NULL;
 
@@ -472,8 +471,7 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.7.4
