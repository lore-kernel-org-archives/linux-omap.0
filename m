From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] mfd/omap-usb-tll: Delete two error messages for a failed
 memory allocation in usbtll_omap_probe()
Date: Mon, 15 Jan 2018 14:15:11 +0100
Message-ID: <7719b4e7-1081-6fa4-6f14-f45cf062482d@users.sourceforge.net>
References: <c048a681-70e4-ecdd-e0f8-48c8f1bb0ac4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <c048a681-70e4-ecdd-e0f8-48c8f1bb0ac4@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 15 Jan 2018 13:39:25 +0100

Omit extra messages for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mfd/omap-usb-tll.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 44a5d66314c6..7945efa0152e 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -222,10 +222,8 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
 
 	tll = devm_kzalloc(dev, sizeof(struct usbtll_omap), GFP_KERNEL);
-	if (!tll) {
-		dev_err(dev, "Memory allocation failed\n");
+	if (!tll)
 		return -ENOMEM;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	tll->base = devm_ioremap_resource(dev, res);
@@ -258,7 +256,6 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 						GFP_KERNEL);
 	if (!tll->ch_clk) {
 		ret = -ENOMEM;
-		dev_err(dev, "Couldn't allocate memory for channel clocks\n");
 		goto err_clk_alloc;
 	}
 
-- 
2.15.1

