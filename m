From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v1 7/8] usb: otg: palmas-usb: pass the correct dev ptr in regulator get
Date: Fri, 25 Jan 2013 08:42:30 +0530
Message-ID: <1359083551-8524-8-git-send-email-kishon@ti.com>
References: <1359083551-8524-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359083551-8524-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rob.herring@calxeda.com, rob@landley.net, balbi@ti.com, sameo@linux.intel.com, gg@slimlogic.co.uk, s-guiriec@ti.com, broonie@opensource.wolfsonmicro.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: grant.likely@secretlab.ca, gregkh@linuxfoundation.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

regulator_get is passing the device pointer of the parent (palmas)
instead of the child (palmas-usb). It's been fixed here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/otg/palmas-usb.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/otg/palmas-usb.c b/drivers/usb/otg/palmas-usb.c
index 442f09c..07629cd 100644
--- a/drivers/usb/otg/palmas-usb.c
+++ b/drivers/usb/otg/palmas-usb.c
@@ -303,8 +303,7 @@ static int palmas_usb_probe(struct platform_device *pdev)
 	spin_lock_init(&palmas_usb->lock);
 
 	if (!pdata->no_control_vbus) {
-		palmas_usb->vbus_reg = devm_regulator_get(palmas->dev,
-								"vbus");
+		palmas_usb->vbus_reg = devm_regulator_get(&pdev->dev, "vbus");
 		if (IS_ERR(palmas_usb->vbus_reg)) {
 			dev_err(&pdev->dev, "vbus init failed\n");
 			return PTR_ERR(palmas_usb->vbus_reg);
-- 
1.7.9.5
