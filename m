From: felipe.balbi@nokia.com
Subject: [RFC PATCH 11/37] cbus: handle possible errors on cbus_send/receive_bit
Date: Wed,  7 Apr 2010 19:04:02 +0300
Message-ID: <1270656268-7034-12-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58415 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570Ab0DGQE7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:04:59 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G4kbv004699
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:04:57 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

gpio_direction_input might fail and we have
to handle that possibility. While at that,
also add the device pointer to struct cbus_host
and use that for printing debugging messages and
make cbus_receive_bit return int.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/cbus.c |   68 +++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index 285bf23..0791251 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -47,35 +47,44 @@
 
 struct cbus_host {
 	/* host lock */
-	spinlock_t lock;
+	spinlock_t	lock;
 
-	int	clk_gpio;
-	int	dat_gpio;
-	int	sel_gpio;
+	struct device	*dev;
+
+	int		clk_gpio;
+	int		dat_gpio;
+	int		sel_gpio;
 };
 
 static struct cbus_host *cbus_host;
 
-static void cbus_send_bit(struct cbus_host *host, int bit, int set_to_input)
+static int cbus_send_bit(struct cbus_host *host, int bit, int set_to_input)
 {
+	int ret = 0;
+
 	gpio_set_value(host->dat_gpio, bit ? 1 : 0);
 	gpio_set_value(host->clk_gpio, 1);
 
 	/* The data bit is read on the rising edge of CLK */
 	if (set_to_input)
-		gpio_direction_input(host->dat_gpio);
+		ret = gpio_direction_input(host->dat_gpio);
 
 	gpio_set_value(host->clk_gpio, 0);
+
+	return ret;
 }
 
-static u8 cbus_receive_bit(struct cbus_host *host)
+static int cbus_receive_bit(struct cbus_host *host)
 {
-	u8 ret;
+	int ret;
 
 	gpio_set_value(host->clk_gpio, 1);
 	ret = gpio_get_value(host->dat_gpio);
+	if (ret < 0)
+		goto out;
 	gpio_set_value(host->clk_gpio, 0);
 
+out:
 	return ret;
 }
 
@@ -83,6 +92,7 @@ static int cbus_transfer(struct cbus_host *host, unsigned rw, unsigned dev,
 		unsigned reg, unsigned data)
 {
 	unsigned long flags;
+	int ret = 0;
 	int i;
 
 	/* We don't want interrupts disturbing our transfer */
@@ -95,11 +105,20 @@ static int cbus_transfer(struct cbus_host *host, unsigned rw, unsigned dev,
 	gpio_direction_output(host->dat_gpio, 1);
 
 	/* Send the device address */
-	for (i = 3; i > 0; i--)
-		cbus_send_bit(host, dev & (1 << (i - 1)), 0);
+	for (i = 3; i > 0; i--) {
+		ret = cbus_send_bit(host, dev & (1 << (i - 1)), 0);
+		if (ret < 0) {
+			dev_dbg(host->dev, "failed sending device addr\n");
+			goto out;
+		}
+	}
 
 	/* Send the rw flag */
-	cbus_send_bit(host, rw, 0);
+	ret = cbus_send_bit(host, rw, 0);
+	if (ret < 0) {
+		dev_dbg(host->dev, "failed sending read/write flag\n");
+		goto out;
+	}
 
 	/* Send the register address */
 	for (i = 5; i > 0; i--) {
@@ -108,21 +127,38 @@ static int cbus_transfer(struct cbus_host *host, unsigned rw, unsigned dev,
 		if (rw && i == 1)
 			set_to_input = 1;
 
-		cbus_send_bit(host, reg & (1 << (i - 1)), set_to_input);
+		ret = cbus_send_bit(host, reg & (1 << (i - 1)), set_to_input);
+		if (ret < 0) {
+			dev_dbg(host->dev, "failed sending register addr\n");
+			goto out;
+		}
 	}
 
 	if (!rw) {
-		for (i = 16; i > 0; i--)
-			cbus_send_bit(host, data & (1 << (i - 1)), 0);
+		for (i = 16; i > 0; i--) {
+			ret = cbus_send_bit(host, data & (1 << (i - 1)), 0);
+			if (ret < 0) {
+				dev_dbg(host->dev, "failed sending data\n");
+				goto out;
+			}
+		}
 	} else {
 		gpio_set_value(host->clk_gpio, 1);
 
 		for (i = 16; i > 0; i--) {
 			u8 bit = cbus_receive_bit(host);
 
+			if (bit < 0) {
+				dev_dbg(host->dev, "failed receiving data\n");
+				goto out;
+			}
+
 			if (bit)
 				data |= 1 << (i - 1);
 		}
+
+		/* return the data received */
+		ret = data;
 	}
 
 	/* Indicate end of transfer, SEL goes up until next transfer */
@@ -130,9 +166,10 @@ static int cbus_transfer(struct cbus_host *host, unsigned rw, unsigned dev,
 	gpio_set_value(host->clk_gpio, 1);
 	gpio_set_value(host->clk_gpio, 0);
 
+out:
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	return data;
+	return ret;
 }
 
 /*
@@ -168,6 +205,7 @@ static int __init cbus_bus_probe(struct platform_device *pdev)
 	chost->clk_gpio = pdata->clk_gpio;
 	chost->dat_gpio = pdata->dat_gpio;
 	chost->sel_gpio = pdata->sel_gpio;
+	chost->dev = &pdev->dev;
 
 	ret = gpio_request(chost->clk_gpio, "CBUS clk");
 	if (ret < 0)
-- 
1.7.0.rc0.33.g7c3932

