From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] mfd/omap-usb-tll: Return an error code only as a constant
 in usbtll_omap_probe()
Date: Mon, 15 Jan 2018 14:17:26 +0100
Message-ID: <367e77d8-3a65-2c12-5e79-75a626b65f41@users.sourceforge.net>
References: <c048a681-70e4-ecdd-e0f8-48c8f1bb0ac4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c048a681-70e4-ecdd-e0f8-48c8f1bb0ac4@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 15 Jan 2018 14:00:45 +0100

* Return an error code without storing it in an intermediate variable.

* Delete the label "err_clk_alloc" and local variable "ret"
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mfd/omap-usb-tll.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index c8b4ad40910a..6c0be886fd87 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -216,7 +216,6 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 	struct device				*dev =  &pdev->dev;
 	struct resource				*res;
 	struct usbtll_omap			*tll;
-	int					ret = 0;
 	int					i, ver;
 
 	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
@@ -254,8 +253,9 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 	tll->ch_clk = devm_kzalloc(dev, sizeof(struct clk *) * tll->nch,
 						GFP_KERNEL);
 	if (!tll->ch_clk) {
-		ret = -ENOMEM;
-		goto err_clk_alloc;
+		pm_runtime_put_sync(dev);
+		pm_runtime_disable(dev);
+		return -ENOMEM;
 	}
 
 	for (i = 0; i < tll->nch; i++) {
@@ -278,12 +278,6 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 	spin_unlock(&tll_lock);
 
 	return 0;
-
-err_clk_alloc:
-	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
-
-	return ret;
 }
 
 /**
-- 
2.15.1
