From: Aaro Koskinen <Aaro.Koskinen@nokia.com>
Subject: [PATCH 1/2] twl4030-madc: Convert ioctl to unlocked
Date: Fri, 20 Feb 2009 16:13:54 +0200
Message-ID: <1235139235-25838-1-git-send-email-Aaro.Koskinen@nokia.com>
References: <499EB9EB.4050008@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:22199 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbZBTOO4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 09:14:56 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1KEEgxC010949
	for <linux-omap@vger.kernel.org>; Fri, 20 Feb 2009 16:14:53 +0200
Received: from localhost.localdomain (esdhcp043221.research.nokia.com [172.21.43.221])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n1KEDuh2008912
	for <linux-omap@vger.kernel.org>; Fri, 20 Feb 2009 16:13:56 +0200
In-Reply-To: <499EB9EB.4050008@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Use unlocked ioctl instead of taking the BKL for an operation that can
take some milliseconds. The driver mutex is now taken before the active
status check, so that the concurrent users of this ioctl won't start
seeing EBUSY (previously guaranteed by the BKL).

Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
---
 drivers/i2c/chips/twl4030-madc.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-madc.c b/drivers/i2c/chips/twl4030-madc.c
index 19dacf5..8997381 100644
--- a/drivers/i2c/chips/twl4030-madc.c
+++ b/drivers/i2c/chips/twl4030-madc.c
@@ -269,17 +269,19 @@ int twl4030_madc_conversion(struct twl4030_madc_request *req)
 	if (unlikely(!req))
 		return -EINVAL;
 
+	mutex_lock(&the_madc->lock);
+
 	/* Do we have a conversion request ongoing */
-	if (the_madc->requests[req->method].active)
-		return -EBUSY;
+	if (the_madc->requests[req->method].active) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	ch_msb = (req->channels >> 8) & 0xff;
 	ch_lsb = req->channels & 0xff;
 
 	method = &twl4030_conversion_methods[req->method];
 
-	mutex_lock(&the_madc->lock);
-
 	/* Select channels to be converted */
 	twl4030_madc_write(the_madc, method->sel + 1, ch_msb);
 	twl4030_madc_write(the_madc, method->sel, ch_lsb);
@@ -366,8 +368,8 @@ static int twl4030_madc_set_power(struct twl4030_madc_data *madc, int on)
 	return 0;
 }
 
-static int twl4030_madc_ioctl(struct inode *inode, struct file *filp,
-			      unsigned int cmd, unsigned long arg)
+static long twl4030_madc_ioctl(struct file *filp, unsigned int cmd,
+			       unsigned long arg)
 {
 	struct twl4030_madc_user_parms par;
 	int val, ret;
@@ -413,7 +415,7 @@ static int twl4030_madc_ioctl(struct inode *inode, struct file *filp,
 
 static struct file_operations twl4030_madc_fileops = {
 	.owner = THIS_MODULE,
-	.ioctl = twl4030_madc_ioctl
+	.unlocked_ioctl = twl4030_madc_ioctl
 };
 
 static struct miscdevice twl4030_madc_device = {
-- 
1.5.4.3

