From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH 2/10] HDQ driver: replace pr_debug with dev_dbg
Date: Thu, 25 Sep 2008 12:22:04 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC8EB1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42627 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715AbYIYGxF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 02:53:05 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "johnpol@2ka.mipt.ru" <johnpol@2ka.mipt.ru>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

From: Madhusudhan Chikkature <madhu.cr@ti.com>

Replace pr_debug with dev_dbg with device information added for
debug prints.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 drivers/w1/masters/omap_hdq.c |   54 +++++++++++++++++++++++-------------------
 1 files changed, 30 insertions(+), 24 deletions(-)

Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
===================================================================
--- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-09-23 12:39:19.000000000 +0530
+++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-23 17:04:50.000000000 +0530
@@ -53,6 +53,7 @@ DECLARE_WAIT_QUEUE_HEAD(hdq_wait_queue);
 int W1_ID;
 
 struct hdq_data {
+	struct device		*dev;
 	resource_size_t		hdq_base;
 	struct	semaphore	hdq_semlock;
 	int			hdq_usecount;
@@ -182,7 +183,7 @@ hdq_write_byte(struct hdq_data *hdq_data
 	ret = wait_event_interruptible_timeout(hdq_wait_queue,
 		hdq_data->hdq_irqstatus, OMAP_HDQ_TIMEOUT);
 	if (unlikely(ret < 0)) {
-		pr_debug("wait interrupted");
+		dev_dbg(hdq_data->dev, "wait interrupted");
 		return -EINTR;
 	}
 
@@ -191,8 +192,8 @@ hdq_write_byte(struct hdq_data *hdq_data
 	spin_unlock_irqrestore(&hdq_data->hdq_spinlock, irqflags);
 	/* check irqstatus */
 	if (!(*status & OMAP_HDQ_INT_STATUS_TXCOMPLETE)) {
-		pr_debug("timeout waiting for TXCOMPLETE/RXCOMPLETE, %x",
-			*status);
+		dev_dbg(hdq_data->dev, "timeout waiting for"
+			"TXCOMPLETE/RXCOMPLETE, %x", *status);
 		return -ETIMEDOUT;
 	}
 
@@ -201,8 +202,8 @@ hdq_write_byte(struct hdq_data *hdq_data
 			OMAP_HDQ_CTRL_STATUS_GO,
 			OMAP_HDQ_FLAG_CLEAR, &tmp_status);
 	if (ret) {
-		pr_debug("timeout waiting GO bit return to zero, %x",
-			tmp_status);
+		dev_dbg(hdq_data->dev, "timeout waiting GO bit"
+			"return to zero, %x", tmp_status);
 		return ret;
 	}
 
@@ -220,7 +221,7 @@ static irqreturn_t hdq_isr(int irq, void
 	spin_lock_irqsave(&hdq_data->hdq_spinlock, irqflags);
 	hdq_data->hdq_irqstatus = hdq_reg_in(hdq_data, OMAP_HDQ_INT_STATUS);
 	spin_unlock_irqrestore(&hdq_data->hdq_spinlock, irqflags);
-	pr_debug("hdq_isr: %x", hdq_data->hdq_irqstatus);
+	dev_dbg(hdq_data->dev, "hdq_isr: %x", hdq_data->hdq_irqstatus);
 
 	if (hdq_data->hdq_irqstatus &
 		(OMAP_HDQ_INT_STATUS_TXCOMPLETE | OMAP_HDQ_INT_STATUS_RXCOMPLETE
@@ -284,7 +285,8 @@ static int _omap_hdq_reset(struct hdq_da
 	ret = hdq_wait_for_flag(hdq_data, OMAP_HDQ_SYSSTATUS,
 		OMAP_HDQ_SYSSTATUS_RESETDONE, OMAP_HDQ_FLAG_SET, &tmp_status);
 	if (ret)
-		pr_debug("timeout waiting HDQ reset, %x", tmp_status);
+		dev_dbg(hdq_data->dev, "timeout waiting HDQ reset, %x",
+				tmp_status);
 	else {
 		hdq_reg_out(hdq_data, OMAP_HDQ_CTRL_STATUS,
 			OMAP_HDQ_CTRL_STATUS_CLOCKENABLE |
@@ -332,7 +334,7 @@ omap_hdq_break(struct hdq_data *hdq_data
 	ret = wait_event_interruptible_timeout(hdq_wait_queue,
 		hdq_data->hdq_irqstatus, OMAP_HDQ_TIMEOUT);
 	if (unlikely(ret < 0)) {
-		pr_debug("wait interrupted");
+		dev_dbg(hdq_data->dev, "wait interrupted");
 		up(&hdq_data->hdq_semlock);
 		return -EINTR;
 	}
@@ -342,7 +344,8 @@ omap_hdq_break(struct hdq_data *hdq_data
 	spin_unlock_irqrestore(&hdq_data->hdq_spinlock, irqflags);
 	/* check irqstatus */
 	if (!(tmp_status & OMAP_HDQ_INT_STATUS_TIMEOUT)) {
-		pr_debug("timeout waiting for TIMEOUT, %x", tmp_status);
+		dev_dbg(hdq_data->dev, "timeout waiting for TIMEOUT, %x",
+				tmp_status);
 		up(&hdq_data->hdq_semlock);
 		return -ETIMEDOUT;
 	}
@@ -355,8 +358,8 @@ omap_hdq_break(struct hdq_data *hdq_data
 			OMAP_HDQ_CTRL_STATUS_GO, OMAP_HDQ_FLAG_CLEAR,
 			&tmp_status);
 	if (ret)
-		pr_debug("timeout waiting INIT&GO bits return to zero, %x",
-			tmp_status);
+		dev_dbg(hdq_data->dev, "timeout waiting INIT&GO bits"
+			"return to zero, %x", tmp_status);
 
 	up(&hdq_data->hdq_semlock);
 	return ret;
@@ -402,7 +405,8 @@ static int hdq_read_byte(struct hdq_data
 		spin_unlock_irqrestore(&hdq_data->hdq_spinlock, irqflags);
 		/* check irqstatus */
 		if (!(status & OMAP_HDQ_INT_STATUS_RXCOMPLETE)) {
-			pr_debug("timeout waiting for RXCOMPLETE, %x", status);
+			dev_dbg(hdq_data->dev, "timeout waiting for"
+				"RXCOMPLETE, %x", status);
 			up(&hdq_data->hdq_semlock);
 			return -ETIMEDOUT;
 		}
@@ -428,7 +432,7 @@ omap_hdq_get(struct hdq_data *hdq_data)
 		return -EINTR;
 
 	if (OMAP_HDQ_MAX_USER == hdq_data->hdq_usecount) {
-		pr_debug("attempt to exceed the max use count");
+		dev_dbg(hdq_data->dev, "attempt to exceed the max use count");
 		up(&hdq_data->hdq_semlock);
 		ret = -EINVAL;
 	} else {
@@ -436,14 +440,14 @@ omap_hdq_get(struct hdq_data *hdq_data)
 		try_module_get(THIS_MODULE);
 		if (1 == hdq_data->hdq_usecount) {
 			if (clk_enable(hdq_data->hdq_ick)) {
-				pr_debug("Can not enable ick\n");
+				dev_dbg(hdq_data->dev, "Can not enable ick\n");
 				clk_put(hdq_data->hdq_ick);
 				clk_put(hdq_data->hdq_fck);
 				up(&hdq_data->hdq_semlock);
 				return -ENODEV;
 			}
 			if (clk_enable(hdq_data->hdq_fck)) {
-				pr_debug("Can not enable fck\n");
+				dev_dbg(hdq_data->dev, "Can not enable fck\n");
 				clk_put(hdq_data->hdq_ick);
 				clk_put(hdq_data->hdq_fck);
 				up(&hdq_data->hdq_semlock);
@@ -485,7 +489,8 @@ omap_hdq_put(struct hdq_data *hdq_data)
 		return -EINTR;
 
 	if (0 == hdq_data->hdq_usecount) {
-		pr_debug("attempt to decrement use count when it is zero");
+		dev_dbg(hdq_data->dev, "attempt to decrement use count"
+			"when it is zero");
 		ret = -EINVAL;
 	} else {
 		hdq_data->hdq_usecount--;
@@ -546,7 +551,7 @@ static void omap_w1_write_byte(void *_hd
 	init_trans++;
 
 	hdq_write_byte(hdq_data, byte, &status);
-	pr_debug("Ctrl status %x\n", status);
+	dev_dbg(hdq_data->dev, "Ctrl status %x\n", status);
 
 	/* Second write, data transfered. Release the module */
 	if (init_trans > 1) {
@@ -571,6 +576,7 @@ static int __init omap_hdq_probe(struct 
 	if (!hdq_data)
 		return -ENODEV;
 
+	hdq_data->dev = &pdev->dev;
 	platform_set_drvdata(pdev, hdq_data);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -587,7 +593,7 @@ static int __init omap_hdq_probe(struct 
 	hdq_data->hdq_fck = clk_get(&pdev->dev, "hdq_fck");
 
 	if (IS_ERR(hdq_data->hdq_ick) || IS_ERR(hdq_data->hdq_fck)) {
-		pr_debug("Can't get HDQ clock objects\n");
+		dev_dbg(&pdev->dev, "Can't get HDQ clock objects\n");
 		if (IS_ERR(hdq_data->hdq_ick)) {
 			ret = PTR_ERR(hdq_data->hdq_ick);
 			platform_set_drvdata(pdev, NULL);
@@ -606,7 +612,7 @@ static int __init omap_hdq_probe(struct 
 	sema_init(&hdq_data->hdq_semlock, 1);
 
 	if (clk_enable(hdq_data->hdq_ick)) {
-		pr_debug("Can not enable ick\n");
+		dev_dbg(&pdev->dev, "Can not enable ick\n");
 		clk_put(hdq_data->hdq_ick);
 		clk_put(hdq_data->hdq_fck);
 		platform_set_drvdata(pdev, NULL);
@@ -615,7 +621,7 @@ static int __init omap_hdq_probe(struct 
 	}
 
 	if (clk_enable(hdq_data->hdq_fck)) {
-		pr_debug("Can not enable fck\n");
+		dev_dbg(&pdev->dev, "Can not enable fck\n");
 		clk_disable(hdq_data->hdq_ick);
 		clk_put(hdq_data->hdq_ick);
 		clk_put(hdq_data->hdq_fck);
@@ -625,7 +631,7 @@ static int __init omap_hdq_probe(struct 
 	}
 
 	rev = hdq_reg_in(hdq_data, OMAP_HDQ_REVISION);
-	pr_info("OMAP HDQ Hardware Revision %c.%c. Driver in %s mode.\n",
+	dev_info(&pdev->dev, "OMAP HDQ Hardware Rev %c.%c. Driver in %s mode\n",
 		(rev >> 4) + '0', (rev & 0x0f) + '0', "Interrupt");
 
 	spin_lock_init(&hdq_data->hdq_spinlock);
@@ -640,7 +646,7 @@ static int __init omap_hdq_probe(struct 
 
 	if (request_irq(irq, hdq_isr, IRQF_DISABLED, "OMAP HDQ",
 		hdq_data)) {
-		pr_debug("request_irq failed\n");
+		dev_dbg(&pdev->dev, "request_irq failed\n");
 		clk_disable(hdq_data->hdq_ick);
 		clk_put(hdq_data->hdq_ick);
 		clk_put(hdq_data->hdq_fck);
@@ -657,7 +663,7 @@ static int __init omap_hdq_probe(struct 
 
 	ret = w1_add_master_device(&omap_w1_master);
 	if (ret) {
-		pr_debug("Failure in registering w1 master\n");
+		dev_dbg(&pdev->dev, "Failure in registering w1 master\n");
 		clk_put(hdq_data->hdq_ick);
 		clk_put(hdq_data->hdq_fck);
 		platform_set_drvdata(pdev, NULL);
@@ -674,7 +680,7 @@ static int omap_hdq_remove(struct platfo
 
 	down_interruptible(&hdq_data->hdq_semlock);
 	if (0 != hdq_data->hdq_usecount) {
-		pr_debug("removed when use count is not zero\n");
+		dev_dbg(&pdev->dev, "removed when use count is not zero\n");
 		return -EBUSY;
 	}
 	up(&hdq_data->hdq_semlock);