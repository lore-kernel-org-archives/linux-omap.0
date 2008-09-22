From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH]OMAP HDQ driver ioremap changes
Date: Mon, 22 Sep 2008 15:45:57 +0530 (IST)
Message-ID: <43198.192.168.10.89.1222078557.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51513 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbYIVKRh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Sep 2008 06:17:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: johnpol@2ka.mipt.ru

Hi Tony,

This patch provides the HDQ driver modifications to use ioremap for the base
address.

Regards,
Madhu
------------------------------------------------------------------
From: Madhusudhan Chikkature<madhu.cr@ti.com>

Modifications to the driver to use ioremap for the base address.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
---
 drivers/w1/masters/omap_hdq.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
===================================================================
--- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-08-18
14:48:26.000000000 +0530
+++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-22 14:56:28.000000000
+0530
@@ -53,7 +53,7 @@ DECLARE_WAIT_QUEUE_HEAD(hdq_wait_queue);
 int W1_ID;

 struct hdq_data {
-	resource_size_t		hdq_base;
+	void __iomem		*hdq_base;
 	struct	semaphore	hdq_semlock;
 	int			hdq_usecount;
 	struct	clk		*hdq_ick;
@@ -100,22 +100,22 @@ static struct w1_bus_master omap_w1_mast
 static inline u8
 hdq_reg_in(u32 offset)
 {
-	return omap_readb(hdq_data->hdq_base + offset);
+	return __raw_readb(hdq_data->hdq_base + offset);
 }

 static inline u8
 hdq_reg_out(u32 offset, u8 val)
 {
-	omap_writeb(val, hdq_data->hdq_base + offset);
+	__raw_writeb(val, hdq_data->hdq_base + offset);
 	return val;
 }

 static inline u8
 hdq_reg_merge(u32 offset, u8 val, u8 mask)
 {
-	u8 new_val = (omap_readb(hdq_data->hdq_base + offset) & ~mask)
+	u8 new_val = (__raw_readb(hdq_data->hdq_base + offset) & ~mask)
 			| (val & mask);
-	omap_writeb(new_val, hdq_data->hdq_base + offset);
+	__raw_writeb(new_val, hdq_data->hdq_base + offset);
 	return new_val;
 }

@@ -577,7 +577,7 @@ static int __init omap_hdq_probe(struct
 		return -ENXIO;
 	}

-	hdq_data->hdq_base = res->start;
+	hdq_data->hdq_base = ioremap(res->start, SZ_4K);

 	/* get interface & functional clock objects */
 	hdq_data->hdq_ick = clk_get(&pdev->dev, "hdq_ick");
@@ -588,12 +588,14 @@ static int __init omap_hdq_probe(struct
 		if (IS_ERR(hdq_data->hdq_ick)) {
 			ret = PTR_ERR(hdq_data->hdq_ick);
 			platform_set_drvdata(pdev, NULL);
+			iounmap(hdq_data->hdq_base);
 			kfree(hdq_data);
 			return ret;
 		}
 		if (IS_ERR(hdq_data->hdq_fck)) {
 			ret = PTR_ERR(hdq_data->hdq_fck);
 			platform_set_drvdata(pdev, NULL);
+			iounmap(hdq_data->hdq_base);
 			kfree(hdq_data);
 			return ret;
 		}
@@ -607,6 +609,7 @@ static int __init omap_hdq_probe(struct
 		clk_put(hdq_data->hdq_ick);
 		clk_put(hdq_data->hdq_fck);
 		platform_set_drvdata(pdev, NULL);
+		iounmap(hdq_data->hdq_base);
 		kfree(hdq_data);
 		return -ENODEV;
 	}
@@ -617,6 +620,7 @@ static int __init omap_hdq_probe(struct
 		clk_put(hdq_data->hdq_ick);
 		clk_put(hdq_data->hdq_fck);
 		platform_set_drvdata(pdev, NULL);
+		iounmap(hdq_data->hdq_base);
 		kfree(hdq_data);
 		return -ENODEV;
 	}
@@ -631,6 +635,7 @@ static int __init omap_hdq_probe(struct
 	irq = platform_get_irq(pdev, 0);
 	if (irq	< 0) {
 		platform_set_drvdata(pdev, NULL);
+		iounmap(hdq_data->hdq_base);
 		kfree(hdq_data);
 		return -ENXIO;
 	}
@@ -642,6 +647,7 @@ static int __init omap_hdq_probe(struct
 		clk_put(hdq_data->hdq_ick);
 		clk_put(hdq_data->hdq_fck);
 		platform_set_drvdata(pdev, NULL);
+		iounmap(hdq_data->hdq_base);
 		kfree(hdq_data);
 		return -ENODEV;
 	}
@@ -656,6 +662,7 @@ static int __init omap_hdq_probe(struct
 		clk_put(hdq_data->hdq_ick);
 		clk_put(hdq_data->hdq_fck);
 		platform_set_drvdata(pdev, NULL);
+		iounmap(hdq_data->hdq_base);
 		kfree(hdq_data);
 		return ret;
 	}
@@ -677,6 +684,7 @@ static int omap_hdq_remove(struct platfo
 	clk_put(hdq_data->hdq_fck);
 	free_irq(INT_24XX_HDQ_IRQ, &hdq_data->hdq_semlock);
 	platform_set_drvdata(pdev, NULL);
+	iounmap(hdq_data->hdq_base);
 	kfree(hdq_data);

 	return 0;


