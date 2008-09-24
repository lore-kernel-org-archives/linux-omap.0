From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH 8/9]HDQ driver:protect the shared flag
Date: Wed, 24 Sep 2008 17:03:44 +0530 (IST)
Message-ID: <58896.192.168.10.89.1222256024.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46584 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922AbYIXLeK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Sep 2008 07:34:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: johnpol@2ka.mipt.ru, felipe.balbi@nokia.com, linux-omap@vger.kernel.org

From: Madhusudhan Chikkature<madhu.cr@ti.com>

This patch moves the shared variable into the local structure and protects its
updation.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
---
 drivers/w1/masters/omap_hdq.c |   52 ++++++++++++++++++++++++++++++------------
 1 files changed, 38 insertions(+), 14 deletions(-)

Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
===================================================================
--- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-09-24
11:49:45.000000000 +0530
+++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-24 14:41:43.000000000
+0530
@@ -61,6 +61,12 @@ struct hdq_data {
 	struct	clk		*hdq_fck;
 	u8			hdq_irqstatus;
 	spinlock_t		hdq_spinlock;
+	/*
+	 * Used to control the call to omap_hdq_get and omap_hdq_put.
+	 * HDQ Protocol: Write the CMD|REG_address first, followed by
+	 * the data wrire or read.
+	 */
+	int			init_trans;
 };

 static int omap_hdq_get(struct hdq_data *hdq_data);
@@ -505,13 +511,6 @@ omap_hdq_put(struct hdq_data *hdq_data)
 }

 /*
- * Used to control the call to omap_hdq_get and omap_hdq_put.
- * HDQ Protocol: Write the CMD|REG_address first, followed by
- * the data wrire or read.
- */
-static int init_trans;
-
-/*
  * Read a byte of data from the device.
  */
 static u8 omap_w1_read_byte(void *_hdq)
@@ -522,14 +521,26 @@ static u8 omap_w1_read_byte(void *_hdq)

 	ret = hdq_read_byte(hdq_data, &val);
 	if (ret) {
-		init_trans = 0;
+		ret = mutex_lock_interruptible(&hdq_data->hdq_mutex);
+		if (ret < 0) {
+			dev_dbg(hdq_data->dev, "Could not acquire mutex\n");
+			return -EINTR;
+		}
+		hdq_data->init_trans = 0;
+		mutex_unlock(&hdq_data->hdq_mutex);
 		omap_hdq_put(hdq_data);
 		return -1;
 	}

 	/* Write followed by a read, release the module */
-	if (init_trans) {
-		init_trans = 0;
+	if (hdq_data->init_trans) {
+		ret = mutex_lock_interruptible(&hdq_data->hdq_mutex);
+		if (ret < 0) {
+			dev_dbg(hdq_data->dev, "Could not acquire mutex\n");
+			return -EINTR;
+		}
+		hdq_data->init_trans = 0;
+		mutex_unlock(&hdq_data->hdq_mutex);
 		omap_hdq_put(hdq_data);
 	}

@@ -542,21 +553,34 @@ static u8 omap_w1_read_byte(void *_hdq)
 static void omap_w1_write_byte(void *_hdq, u8 byte)
 {
 	struct hdq_data *hdq_data = _hdq;
+	int ret;
 	u8 status;

 	/* First write to initialize the transfer */
-	if (init_trans == 0)
+	if (hdq_data->init_trans == 0)
 		omap_hdq_get(hdq_data);

-	init_trans++;
+	ret = mutex_lock_interruptible(&hdq_data->hdq_mutex);
+	if (ret < 0) {
+		dev_dbg(hdq_data->dev, "Could not acquire mutex\n");
+		return;
+	}
+	hdq_data->init_trans++;
+	mutex_unlock(&hdq_data->hdq_mutex);

 	hdq_write_byte(hdq_data, byte, &status);
 	dev_dbg(hdq_data->dev, "Ctrl status %x\n", status);

 	/* Second write, data transfered. Release the module */
-	if (init_trans > 1) {
+	if (hdq_data->init_trans > 1) {
 		omap_hdq_put(hdq_data);
-		init_trans = 0;
+		ret = mutex_lock_interruptible(&hdq_data->hdq_mutex);
+		if (ret < 0) {
+			dev_dbg(hdq_data->dev, "Could not acquire mutex\n");
+			return;
+		}
+		hdq_data->init_trans = 0;
+		mutex_unlock(&hdq_data->hdq_mutex);
 	}

 	return;


