From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH 3/9]HDQ driver: modify probe fn exit points
Date: Wed, 24 Sep 2008 16:54:27 +0530 (IST)
Message-ID: <48542.192.168.10.89.1222255467.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33878 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbYIXLZT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 07:25:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: johnpol@2ka.mipt.ru, felipe.balbi@nokia.com, linux-omap@vger.kernel.org

From: Madhusudhan Chikkature<madhu.cr@ti.com>

This patch fix the exit paths in the probe function.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
---
 drivers/w1/masters/omap_hdq.c |   85 ++++++++++++++++++++++--------------------
 1 files changed, 45 insertions(+), 40 deletions(-)

Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
===================================================================
--- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-09-23
17:04:50.000000000 +0530
+++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-24 09:33:39.000000000
+0530
@@ -573,17 +573,20 @@ static int __init omap_hdq_probe(struct
 		return -ENODEV;

 	hdq_data = kmalloc(sizeof(*hdq_data), GFP_KERNEL);
-	if (!hdq_data)
-		return -ENODEV;
+	if (!hdq_data) {
+		dev_dbg(&pdev->dev, "unable to allocate memory\n");
+		ret = -ENODEV;
+		goto err_kmalloc;
+	}

 	hdq_data->dev = &pdev->dev;
 	platform_set_drvdata(pdev, hdq_data);

 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		platform_set_drvdata(pdev, NULL);
-		kfree(hdq_data);
-		return -ENXIO;
+	if (!res) {
+		dev_dbg(&pdev->dev, "unable to get resource\n");
+		ret = ENXIO;
+		goto err_resource;
 	}

 	hdq_data->hdq_base = res->start;
@@ -596,15 +599,12 @@ static int __init omap_hdq_probe(struct
 		dev_dbg(&pdev->dev, "Can't get HDQ clock objects\n");
 		if (IS_ERR(hdq_data->hdq_ick)) {
 			ret = PTR_ERR(hdq_data->hdq_ick);
-			platform_set_drvdata(pdev, NULL);
-			kfree(hdq_data);
-			return ret;
+			goto err_clk;
 		}
 		if (IS_ERR(hdq_data->hdq_fck)) {
 			ret = PTR_ERR(hdq_data->hdq_fck);
-			platform_set_drvdata(pdev, NULL);
-			kfree(hdq_data);
-			return ret;
+			clk_put(hdq_data->hdq_ick);
+			goto err_clk;
 		}
 	}

@@ -613,21 +613,14 @@ static int __init omap_hdq_probe(struct

 	if (clk_enable(hdq_data->hdq_ick)) {
 		dev_dbg(&pdev->dev, "Can not enable ick\n");
-		clk_put(hdq_data->hdq_ick);
-		clk_put(hdq_data->hdq_fck);
-		platform_set_drvdata(pdev, NULL);
-		kfree(hdq_data);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_ick;
 	}

 	if (clk_enable(hdq_data->hdq_fck)) {
 		dev_dbg(&pdev->dev, "Can not enable fck\n");
-		clk_disable(hdq_data->hdq_ick);
-		clk_put(hdq_data->hdq_ick);
-		clk_put(hdq_data->hdq_fck);
-		platform_set_drvdata(pdev, NULL);
-		kfree(hdq_data);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_fck;
 	}

 	rev = hdq_reg_in(hdq_data, OMAP_HDQ_REVISION);
@@ -639,20 +632,14 @@ static int __init omap_hdq_probe(struct

 	irq = platform_get_irq(pdev, 0);
 	if (irq	< 0) {
-		platform_set_drvdata(pdev, NULL);
-		kfree(hdq_data);
-		return -ENXIO;
+		ret = -ENXIO;
+		goto err_irq;
 	}

-	if (request_irq(irq, hdq_isr, IRQF_DISABLED, "OMAP HDQ",
-		hdq_data)) {
-		dev_dbg(&pdev->dev, "request_irq failed\n");
-		clk_disable(hdq_data->hdq_ick);
-		clk_put(hdq_data->hdq_ick);
-		clk_put(hdq_data->hdq_fck);
-		platform_set_drvdata(pdev, NULL);
-		kfree(hdq_data);
-		return -ENODEV;
+	ret = request_irq(irq, hdq_isr, IRQF_DISABLED, "omap_hdq", hdq_data);
+	if (ret < 0) {
+		dev_dbg(&pdev->dev, "could not request irq\n");
+		goto err_irq;
 	}

 	/* don't clock the HDQ until it is needed */
@@ -664,14 +651,32 @@ static int __init omap_hdq_probe(struct
 	ret = w1_add_master_device(&omap_w1_master);
 	if (ret) {
 		dev_dbg(&pdev->dev, "Failure in registering w1 master\n");
-		clk_put(hdq_data->hdq_ick);
-		clk_put(hdq_data->hdq_fck);
-		platform_set_drvdata(pdev, NULL);
-		kfree(hdq_data);
-		return ret;
+		goto err_w1;
 	}

 	return 0;
+
+err_w1:
+err_irq:
+	clk_disable(hdq_data->hdq_fck);
+
+err_fck:
+	clk_disable(hdq_data->hdq_ick);
+
+err_ick:
+	clk_put(hdq_data->hdq_ick);
+	clk_put(hdq_data->hdq_fck);
+
+err_clk:
+	hdq_data->hdq_base = NULL;
+
+err_resource:
+	platform_set_drvdata(pdev, NULL);
+	kfree(hdq_data);
+
+err_kmalloc:
+	return ret;
+
 }

 static int omap_hdq_remove(struct platform_device *pdev)


