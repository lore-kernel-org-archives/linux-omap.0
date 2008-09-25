From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH 7/10] HDQ driver:replace semaphore with mutex
Date: Thu, 25 Sep 2008 12:27:23 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC8EBD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46412 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbYIYG6H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 02:58:07 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "johnpol@2ka.mipt.ru" <johnpol@2ka.mipt.ru>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

From: Madhusudhan Chikkature <madhu.cr@ti.com>

This patch replaces the usage of semaphore by mutex.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 drivers/w1/masters/omap_hdq.c |   42 ++++++++++++++++++++++--------------------
 1 files changed, 22 insertions(+), 20 deletions(-)

Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
===================================================================
--- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-09-24 11:13:12.000000000 +0530
+++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-24 11:49:45.000000000 +0530
@@ -55,7 +55,7 @@ static int w1_id;
 struct hdq_data {
 	struct device		*dev;
 	void __iomem		*hdq_base;
-	struct	semaphore	hdq_semlock;
+	struct  mutex		hdq_mutex;
 	int			hdq_usecount;
 	struct	clk		*hdq_ick;
 	struct	clk		*hdq_fck;
@@ -308,12 +308,12 @@ omap_hdq_break(struct hdq_data *hdq_data
 	u8 tmp_status;
 	unsigned long irqflags;
 
-	ret = down_interruptible(&hdq_data->hdq_semlock);
+	ret = mutex_lock_interruptible(&hdq_data->hdq_mutex);
 	if (ret < 0)
 		return -EINTR;
 
 	if (!hdq_data->hdq_usecount) {
-		up(&hdq_data->hdq_semlock);
+		mutex_unlock(&hdq_data->hdq_mutex);
 		return -EINVAL;
 	}
 
@@ -335,7 +335,7 @@ omap_hdq_break(struct hdq_data *hdq_data
 		hdq_data->hdq_irqstatus, OMAP_HDQ_TIMEOUT);
 	if (ret < 0) {
 		dev_dbg(hdq_data->dev, "wait interrupted");
-		up(&hdq_data->hdq_semlock);
+		mutex_unlock(&hdq_data->hdq_mutex);
 		return -EINTR;
 	}
 
@@ -346,7 +346,7 @@ omap_hdq_break(struct hdq_data *hdq_data
 	if (!(tmp_status & OMAP_HDQ_INT_STATUS_TIMEOUT)) {
 		dev_dbg(hdq_data->dev, "timeout waiting for TIMEOUT, %x",
 				tmp_status);
-		up(&hdq_data->hdq_semlock);
+		mutex_unlock(&hdq_data->hdq_mutex);
 		return -ETIMEDOUT;
 	}
 	/*
@@ -361,7 +361,7 @@ omap_hdq_break(struct hdq_data *hdq_data
 		dev_dbg(hdq_data->dev, "timeout waiting INIT&GO bits"
 			"return to zero, %x", tmp_status);
 
-	up(&hdq_data->hdq_semlock);
+	mutex_unlock(&hdq_data->hdq_mutex);
 	return ret;
 }
 
@@ -371,12 +371,12 @@ static int hdq_read_byte(struct hdq_data
 	u8 status;
 	unsigned long irqflags;
 
-	ret = down_interruptible(&hdq_data->hdq_semlock);
+	ret = mutex_lock_interruptible(&hdq_data->hdq_mutex);
 	if (ret < 0)
 		return -EINTR;
 
 	if (!hdq_data->hdq_usecount) {
-		up(&hdq_data->hdq_semlock);
+		mutex_unlock(&hdq_data->hdq_mutex);
 		return -EINVAL;
 	}
 
@@ -407,13 +407,13 @@ static int hdq_read_byte(struct hdq_data
 		if (!(status & OMAP_HDQ_INT_STATUS_RXCOMPLETE)) {
 			dev_dbg(hdq_data->dev, "timeout waiting for"
 				"RXCOMPLETE, %x", status);
-			up(&hdq_data->hdq_semlock);
+			mutex_unlock(&hdq_data->hdq_mutex);
 			return -ETIMEDOUT;
 		}
 	}
 	/* the data is ready. Read it in! */
 	*val = hdq_reg_in(hdq_data, OMAP_HDQ_RX_DATA);
-	up(&hdq_data->hdq_semlock);
+	mutex_unlock(&hdq_data->hdq_mutex);
 
 	return 0;
 
@@ -427,13 +427,13 @@ omap_hdq_get(struct hdq_data *hdq_data)
 {
 	int ret = 0;
 
-	ret = down_interruptible(&hdq_data->hdq_semlock);
+	ret = mutex_lock_interruptible(&hdq_data->hdq_mutex);
 	if (ret < 0)
 		return -EINTR;
 
 	if (OMAP_HDQ_MAX_USER == hdq_data->hdq_usecount) {
 		dev_dbg(hdq_data->dev, "attempt to exceed the max use count");
-		up(&hdq_data->hdq_semlock);
+		mutex_unlock(&hdq_data->hdq_mutex);
 		ret = -EINVAL;
 	} else {
 		hdq_data->hdq_usecount++;
@@ -443,14 +443,14 @@ omap_hdq_get(struct hdq_data *hdq_data)
 				dev_dbg(hdq_data->dev, "Can not enable ick\n");
 				clk_put(hdq_data->hdq_ick);
 				clk_put(hdq_data->hdq_fck);
-				up(&hdq_data->hdq_semlock);
+				mutex_unlock(&hdq_data->hdq_mutex);
 				return -ENODEV;
 			}
 			if (clk_enable(hdq_data->hdq_fck)) {
 				dev_dbg(hdq_data->dev, "Can not enable fck\n");
 				clk_put(hdq_data->hdq_ick);
 				clk_put(hdq_data->hdq_fck);
-				up(&hdq_data->hdq_semlock);
+				mutex_unlock(&hdq_data->hdq_mutex);
 				return -ENODEV;
 			}
 
@@ -472,7 +472,7 @@ omap_hdq_get(struct hdq_data *hdq_data)
 			}
 		}
 	}
-	up(&hdq_data->hdq_semlock);
+	mutex_unlock(&hdq_data->hdq_mutex);
 	return ret;
 }
 
@@ -484,7 +484,7 @@ omap_hdq_put(struct hdq_data *hdq_data)
 {
 	int ret = 0;
 
-	ret = down_interruptible(&hdq_data->hdq_semlock);
+	ret = mutex_lock_interruptible(&hdq_data->hdq_mutex);
 	if (ret < 0)
 		return -EINTR;
 
@@ -500,7 +500,7 @@ omap_hdq_put(struct hdq_data *hdq_data)
 			clk_disable(hdq_data->hdq_fck);
 		}
 	}
-	up(&hdq_data->hdq_semlock);
+	mutex_unlock(&hdq_data->hdq_mutex);
 	return ret;
 }
 
@@ -614,7 +614,7 @@ static int __init omap_hdq_probe(struct 
 	}
 
 	hdq_data->hdq_usecount = 0;
-	sema_init(&hdq_data->hdq_semlock, 1);
+	mutex_init(&hdq_data->hdq_mutex);
 
 	if (clk_enable(hdq_data->hdq_ick)) {
 		dev_dbg(&pdev->dev, "Can not enable ick\n");
@@ -689,12 +689,14 @@ static int omap_hdq_remove(struct platfo
 {
 	struct hdq_data *hdq_data = platform_get_drvdata(pdev);
 
-	down_interruptible(&hdq_data->hdq_semlock);
+	mutex_lock(&hdq_data->hdq_mutex);
+
 	if (0 != hdq_data->hdq_usecount) {
 		dev_dbg(&pdev->dev, "removed when use count is not zero\n");
 		return -EBUSY;
 	}
-	up(&hdq_data->hdq_semlock);
+
+	mutex_unlock(&hdq_data->hdq_mutex);
 
 	/* remove module dependency */
 	clk_put(hdq_data->hdq_ick);