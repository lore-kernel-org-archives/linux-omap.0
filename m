From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v1 2/8] usb: otg: palmas-usb: use devres API to allocate
 resources
Date: Fri, 25 Jan 2013 08:42:25 +0530
Message-ID: <1359083551-8524-3-git-send-email-kishon@ti.com>
References: <1359083551-8524-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1359083551-8524-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, s-guiriec-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

used devres API while allocating resources so that these resources are
released automatically on driver detach.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/otg/palmas-usb.c |   47 ++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/otg/palmas-usb.c b/drivers/usb/otg/palmas-usb.c
index 76240ef..f063350 100644
--- a/drivers/usb/otg/palmas-usb.c
+++ b/drivers/usb/otg/palmas-usb.c
@@ -278,7 +278,7 @@ static int palmas_usb_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -EINVAL;
 
-	palmas_usb = kzalloc(sizeof(*palmas_usb), GFP_KERNEL);
+	palmas_usb = devm_kzalloc(&pdev->dev, sizeof(*palmas_usb), GFP_KERNEL);
 	if (!palmas_usb)
 		return -ENOMEM;
 
@@ -311,11 +311,10 @@ static int palmas_usb_probe(struct platform_device *pdev)
 	spin_lock_init(&palmas_usb->lock);
 
 	if (!pdata->no_control_vbus) {
-		palmas_usb->vbus_reg = regulator_get(palmas->dev,
+		palmas_usb->vbus_reg = devm_regulator_get(palmas->dev,
 								"vbus");
 		if (IS_ERR(palmas_usb->vbus_reg)) {
 			dev_err(&pdev->dev, "vbus init failed\n");
-			kfree(palmas_usb);
 			return PTR_ERR(palmas_usb->vbus_reg);
 		}
 	}
@@ -330,44 +329,44 @@ static int palmas_usb_probe(struct platform_device *pdev)
 
 	INIT_WORK(&palmas_usb->set_vbus_work, palmas_set_vbus_work);
 
-	status = request_threaded_irq(palmas_usb->irq1, NULL,
-				palmas_id_irq,
+	status = devm_request_threaded_irq(palmas_usb->dev, palmas_usb->irq1,
+				NULL, palmas_id_irq,
 				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 				"palmas_usb", palmas_usb);
 	if (status < 0) {
 		dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
 					palmas_usb->irq1, status);
-		goto fail_irq1;
+		goto fail_irq;
 	}
 
-	status = request_threaded_irq(palmas_usb->irq2, NULL,
-			palmas_id_wakeup_irq,
+	status = devm_request_threaded_irq(palmas_usb->dev, palmas_usb->irq2,
+			NULL, palmas_id_wakeup_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 			"palmas_usb", palmas_usb);
 	if (status < 0) {
 		dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
 					palmas_usb->irq2, status);
-		goto fail_irq2;
+		goto fail_irq;
 	}
 
-	status = request_threaded_irq(palmas_usb->irq3, NULL,
-			palmas_vbus_irq,
+	status = devm_request_threaded_irq(palmas_usb->dev, palmas_usb->irq3,
+			NULL, palmas_vbus_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 			"palmas_usb", palmas_usb);
 	if (status < 0) {
 		dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
 					palmas_usb->irq3, status);
-		goto fail_irq3;
+		goto fail_irq;
 	}
 
-	status = request_threaded_irq(palmas_usb->irq4, NULL,
-			palmas_vbus_wakeup_irq,
+	status = devm_request_threaded_irq(palmas_usb->dev, palmas_usb->irq4,
+			NULL, palmas_vbus_wakeup_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 			"palmas_usb", palmas_usb);
 	if (status < 0) {
 		dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
 					palmas_usb->irq4, status);
-		goto fail_irq4;
+		goto fail_irq;
 	}
 
 	dev_info(&pdev->dev, "Initialized Palmas USB module\n");
@@ -376,19 +375,9 @@ static int palmas_usb_probe(struct platform_device *pdev)
 
 	return 0;
 
-fail_irq4:
-	free_irq(palmas_usb->irq3, palmas_usb);
-
-fail_irq3:
-	free_irq(palmas_usb->irq2, palmas_usb);
-
-fail_irq2:
-	free_irq(palmas_usb->irq1, palmas_usb);
-
-fail_irq1:
+fail_irq:
 	cancel_work_sync(&palmas_usb->set_vbus_work);
 	device_remove_file(palmas_usb->dev, &dev_attr_vbus);
-	kfree(palmas_usb);
 
 	return status;
 }
@@ -397,14 +386,8 @@ static int palmas_usb_remove(struct platform_device *pdev)
 {
 	struct palmas_usb *palmas_usb = platform_get_drvdata(pdev);
 
-	free_irq(palmas_usb->irq1, palmas_usb);
-	free_irq(palmas_usb->irq2, palmas_usb);
-	free_irq(palmas_usb->irq3, palmas_usb);
-	free_irq(palmas_usb->irq4, palmas_usb);
-	regulator_put(palmas_usb->vbus_reg);
 	device_remove_file(palmas_usb->dev, &dev_attr_vbus);
 	cancel_work_sync(&palmas_usb->set_vbus_work);
-	kfree(palmas_usb);
 
 	return 0;
 }
-- 
1.7.9.5
