From: felipe.balbi@nokia.com
Subject: [RFC PATCH 12/37] cbus: introduce cbus_send/receive_data wrappers
Date: Wed,  7 Apr 2010 19:04:03 +0300
Message-ID: <1270656268-7034-13-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62328 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932823Ab0DGQFR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:17 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G56Aw007315
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 11:05:17 -0500
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

encapsulate the for loop on those wrappers and
make the code easier to follow.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/cbus.c |   96 +++++++++++++++++++++++++++++++--------------------
 1 files changed, 58 insertions(+), 38 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index 0791251..bae7b3e 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -58,7 +58,8 @@ struct cbus_host {
 
 static struct cbus_host *cbus_host;
 
-static int cbus_send_bit(struct cbus_host *host, int bit, int set_to_input)
+static int cbus_send_bit(struct cbus_host *host, unsigned bit,
+		unsigned input)
 {
 	int ret = 0;
 
@@ -66,7 +67,7 @@ static int cbus_send_bit(struct cbus_host *host, int bit, int set_to_input)
 	gpio_set_value(host->clk_gpio, 1);
 
 	/* The data bit is read on the rising edge of CLK */
-	if (set_to_input)
+	if (input)
 		ret = gpio_direction_input(host->dat_gpio);
 
 	gpio_set_value(host->clk_gpio, 0);
@@ -74,6 +75,23 @@ static int cbus_send_bit(struct cbus_host *host, int bit, int set_to_input)
 	return ret;
 }
 
+static int cbus_send_data(struct cbus_host *host, unsigned data, unsigned len,
+		unsigned input)
+{
+	int ret = 0;
+	int i;
+
+	for (i = len; i > 0; i--) {
+		ret = cbus_send_bit(host, data & (1 << (i - 1)),
+				input && (i == 1));
+		if (ret < 0)
+			goto out;
+	}
+
+out:
+	return ret;
+}
+
 static int cbus_receive_bit(struct cbus_host *host)
 {
 	int ret;
@@ -88,12 +106,31 @@ out:
 	return ret;
 }
 
+static int cbus_receive_data(struct cbus_host *host, unsigned len)
+{
+	int ret = 0;
+	int i;
+
+	for (i = 16; i > 0; i--) {
+		int bit = cbus_receive_bit(host);
+
+		if (bit < 0)
+			goto out;
+
+		if (bit)
+			ret |= 1 << (i - 1);
+	}
+
+out:
+	return ret;
+}
+
 static int cbus_transfer(struct cbus_host *host, unsigned rw, unsigned dev,
 		unsigned reg, unsigned data)
 {
 	unsigned long flags;
+	int input = 0;
 	int ret = 0;
-	int i;
 
 	/* We don't want interrupts disturbing our transfer */
 	spin_lock_irqsave(&host->lock, flags);
@@ -105,12 +142,10 @@ static int cbus_transfer(struct cbus_host *host, unsigned rw, unsigned dev,
 	gpio_direction_output(host->dat_gpio, 1);
 
 	/* Send the device address */
-	for (i = 3; i > 0; i--) {
-		ret = cbus_send_bit(host, dev & (1 << (i - 1)), 0);
-		if (ret < 0) {
-			dev_dbg(host->dev, "failed sending device addr\n");
-			goto out;
-		}
+	ret = cbus_send_data(host, dev, 3, 0);
+	if (ret < 0) {
+		dev_dbg(host->dev, "failed sending device addr\n");
+		goto out;
 	}
 
 	/* Send the rw flag */
@@ -121,44 +156,29 @@ static int cbus_transfer(struct cbus_host *host, unsigned rw, unsigned dev,
 	}
 
 	/* Send the register address */
-	for (i = 5; i > 0; i--) {
-		int set_to_input = 0;
-
-		if (rw && i == 1)
-			set_to_input = 1;
+	if (rw)
+		input = true;
 
-		ret = cbus_send_bit(host, reg & (1 << (i - 1)), set_to_input);
-		if (ret < 0) {
-			dev_dbg(host->dev, "failed sending register addr\n");
-			goto out;
-		}
+	ret = cbus_send_data(host, reg, 5, input);
+	if (ret < 0) {
+		dev_dbg(host->dev, "failed sending register addr\n");
+		goto out;
 	}
 
 	if (!rw) {
-		for (i = 16; i > 0; i--) {
-			ret = cbus_send_bit(host, data & (1 << (i - 1)), 0);
-			if (ret < 0) {
-				dev_dbg(host->dev, "failed sending data\n");
-				goto out;
-			}
+		ret = cbus_send_data(host, data, 16, 0);
+		if (ret < 0) {
+			dev_dbg(host->dev, "failed sending data\n");
+			goto out;
 		}
 	} else {
 		gpio_set_value(host->clk_gpio, 1);
 
-		for (i = 16; i > 0; i--) {
-			u8 bit = cbus_receive_bit(host);
-
-			if (bit < 0) {
-				dev_dbg(host->dev, "failed receiving data\n");
-				goto out;
-			}
-
-			if (bit)
-				data |= 1 << (i - 1);
+		ret = cbus_receive_data(host, 16);
+		if (ret < 0) {
+			dev_dbg(host->dev, "failed receiving data\n");
+			goto out;
 		}
-
-		/* return the data received */
-		ret = data;
 	}
 
 	/* Indicate end of transfer, SEL goes up until next transfer */
-- 
1.7.0.rc0.33.g7c3932

