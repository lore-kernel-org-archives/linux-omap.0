From: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Subject: [PATCH] This patch fixes "scheduling while atomic" bug when driver is unloaded.
Date: Tue, 10 Jun 2008 15:16:36 +0300
Message-ID: <1213100196-28474-1-git-send-email-roman.tereshonkov@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:54543 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbYFJMQw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2008 08:16:52 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5ACGdOM025300
	for <linux-omap@vger.kernel.org>; Tue, 10 Jun 2008 15:16:49 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Roman Tereshonkov <roman.tereshonkov@nokia.com>


Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
---
 drivers/input/touchscreen/tsc2005.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index fa01799..408caf0 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -661,11 +661,10 @@ err1:
 static int __devexit tsc2005_remove(struct spi_device *spi)
 {
 	struct tsc2005 *ts = dev_get_drvdata(&spi->dev);
-	unsigned long flags;
 
-	spin_lock_irqsave(&ts->lock, flags);
+	mutex_lock(&ts->mutex);
 	tsc2005_disable(ts);
-	spin_unlock_irqrestore(&ts->lock, flags);
+	mutex_unlock(&ts->mutex);
 
 	device_remove_file(&ts->spi->dev, &dev_attr_disable_ts);
 	device_remove_file(&ts->spi->dev, &dev_attr_pen_down);
-- 
1.5.5.1

