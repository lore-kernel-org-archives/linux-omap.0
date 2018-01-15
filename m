From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] mfd/omap-usb-tll: Improve a size determination in
 usbtll_omap_probe()
Date: Mon, 15 Jan 2018 14:16:17 +0100
Message-ID: <49a9d036-ab90-4342-90a8-db63e027017e@users.sourceforge.net>
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
Date: Mon, 15 Jan 2018 13:43:53 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mfd/omap-usb-tll.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 7945efa0152e..c8b4ad40910a 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -220,8 +220,7 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 	int					i, ver;
 
 	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
-
-	tll = devm_kzalloc(dev, sizeof(struct usbtll_omap), GFP_KERNEL);
+	tll = devm_kzalloc(dev, sizeof(*tll), GFP_KERNEL);
 	if (!tll)
 		return -ENOMEM;
 
-- 
2.15.1
