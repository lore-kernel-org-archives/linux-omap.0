From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rft/rfc/patch-2.6.32-omap1+ 5/6] cbus: rely on gpiolib
Date: Wed, 16 Dec 2009 01:44:12 +0200
Message-ID: <1260920653-18503-6-git-send-email-felipe.balbi@nokia.com>
References: <1260920653-18503-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37289 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760711AbZLOXqq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 18:46:46 -0500
In-Reply-To: <1260920653-18503-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

don't define our own concurrent accesses to gpio banks
if we already have gpiolib to handle that.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/cbus.c |  109 ++++++--------------------------------------------
 drivers/cbus/cbus.h |    2 -
 2 files changed, 13 insertions(+), 98 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index c976f49..615f447 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -41,78 +41,7 @@
 
 static struct cbus_host *cbus_host;
 
-#ifdef CONFIG_ARCH_OMAP1
-/* We use our own MPUIO functions to get closer to 1MHz bus speed */
-
-static inline void cbus_set_gpio_direction(void __iomem *base,
-		int mpuio, int is_input)
-{
-	u16 w;
-
-	mpuio &= 0x0f;
-	w = __raw_readw(base + OMAP_MPUIO_IO_CNTL);
-	if (is_input)
-		w |= 1 << mpuio;
-	else
-		w &= ~(1 << mpuio);
-	__raw_writew(w, base + OMAP_MPUIO_IO_CNTL);
-
-}
-
-static inline void cbus_set_gpio_dataout(void __iomem *base,
-		int mpuio, int enable)
-{
-	u16 w;
-
-	mpuio &= 0x0f;
-	w = __raw_readw(base + OMAP_MPUIO_OUTPUT);
-	if (enable)
-		w |= 1 << mpuio;
-	else
-		w &= ~(1 << mpuio);
-	__raw_writew(w, base + OMAP_MPUIO_OUTPUT);
-}
-
-static inline int cbus_get_gpio_datain(void __iomem *base, int mpuio)
-{
-	mpuio &= 0x0f;
-
-	return (__raw_readw(base + OMAP_MPUIO_INPUT_LATCH) & (1 << mpuio)) != 0;
-}
-
-static void cbus_send_bit(struct cbus_host *host, void __iomem *base, int bit,
-			  int set_to_input)
-{
-	cbus_set_gpio_dataout(base, host->dat_gpio, bit ? 1 : 0);
-	cbus_set_gpio_dataout(base, host->clk_gpio, 1);
-
-	/* The data bit is read on the rising edge of CLK */
-	if (set_to_input)
-		cbus_set_gpio_direction(base, host->dat_gpio, 1);
-
-	cbus_set_gpio_dataout(base, host->clk_gpio, 0);
-}
-
-static u8 cbus_receive_bit(struct cbus_host *host, void __iomem *base)
-{
-	u8 ret;
-
-	cbus_set_gpio_dataout(base, host->clk_gpio, 1);
-	ret = cbus_get_gpio_datain(base, host->dat_gpio);
-	cbus_set_gpio_dataout(base, host->clk_gpio, 0);
-
-	return ret;
-}
-
-#define cbus_output(base, gpio, val)	cbus_set_gpio_direction(base, gpio, 0)
-
-#else
-
-#define cbus_output(base, gpio, val)	gpio_direction_output(gpio, val)
-#define cbus_set_gpio_dataout(base, gpio, enable) gpio_set_value(gpio, enable)
-#define cbus_get_gpio_datain(base, int, gpio) gpio_get_value(gpio)
-
-static void _cbus_send_bit(struct cbus_host *host, int bit, int set_to_input)
+static void cbus_send_bit(struct cbus_host *host, int bit, int set_to_input)
 {
 	gpio_set_value(host->dat_gpio, bit ? 1 : 0);
 	gpio_set_value(host->clk_gpio, 1);
@@ -124,7 +53,7 @@ static void _cbus_send_bit(struct cbus_host *host, int bit, int set_to_input)
 	gpio_set_value(host->clk_gpio, 0);
 }
 
-static u8 _cbus_receive_bit(struct cbus_host *host)
+static u8 cbus_receive_bit(struct cbus_host *host)
 {
 	u8 ret;
 
@@ -135,23 +64,11 @@ static u8 _cbus_receive_bit(struct cbus_host *host)
 	return ret;
 }
 
-#define cbus_send_bit(h, b, bit, i) _cbus_send_bit(h, bit, i)
-#define cbus_receive_bit(host, base) _cbus_receive_bit(host)
-
-#endif
-
 static int cbus_transfer(struct cbus_host *host, int dev, int reg, int data)
 {
 	int i;
 	int is_read = 0;
 	unsigned long flags;
-	void __iomem *base;
-
-#ifdef CONFIG_ARCH_OMAP1
-	base = OMAP1_IO_ADDRESS(OMAP1_MPUIO_BASE);
-#else
-	base = NULL;
-#endif
 
 	if (data < 0)
 		is_read = 1;
@@ -160,17 +77,17 @@ static int cbus_transfer(struct cbus_host *host, int dev, int reg, int data)
 	spin_lock_irqsave(&host->lock, flags);
 
 	/* Reset state and start of transfer, SEL stays down during transfer */
-	cbus_set_gpio_dataout(base, host->sel_gpio, 0);
+	gpio_set_value(host->sel_gpio, 0);
 
 	/* Set the DAT pin to output */
-	cbus_output(base, host->dat_gpio, 1);
+	gpio_direction_output(host->dat_gpio, 1);
 
 	/* Send the device address */
 	for (i = 3; i > 0; i--)
-		cbus_send_bit(host, base, dev & (1 << (i - 1)), 0);
+		cbus_send_bit(host, dev & (1 << (i - 1)), 0);
 
 	/* Send the rw flag */
-	cbus_send_bit(host, base, is_read, 0);
+	cbus_send_bit(host, is_read, 0);
 
 	/* Send the register address */
 	for (i = 5; i > 0; i--) {
@@ -179,18 +96,18 @@ static int cbus_transfer(struct cbus_host *host, int dev, int reg, int data)
 		if (is_read && i == 1)
 			set_to_input = 1;
 
-		cbus_send_bit(host, base, reg & (1 << (i - 1)), set_to_input);
+		cbus_send_bit(host, reg & (1 << (i - 1)), set_to_input);
 	}
 
 	if (!is_read) {
 		for (i = 16; i > 0; i--)
-			cbus_send_bit(host, base, data & (1 << (i - 1)), 0);
+			cbus_send_bit(host, data & (1 << (i - 1)), 0);
 	} else {
-		cbus_set_gpio_dataout(base, host->clk_gpio, 1);
+		gpio_set_value(host->clk_gpio, 1);
 		data = 0;
 
 		for (i = 16; i > 0; i--) {
-			u8 bit = cbus_receive_bit(host, base);
+			u8 bit = cbus_receive_bit(host);
 
 			if (bit)
 				data |= 1 << (i - 1);
@@ -198,9 +115,9 @@ static int cbus_transfer(struct cbus_host *host, int dev, int reg, int data)
 	}
 
 	/* Indicate end of transfer, SEL goes up until next transfer */
-	cbus_set_gpio_dataout(base, host->sel_gpio, 1);
-	cbus_set_gpio_dataout(base, host->clk_gpio, 1);
-	cbus_set_gpio_dataout(base, host->clk_gpio, 0);
+	gpio_set_value(host->sel_gpio, 1);
+	gpio_set_value(host->clk_gpio, 1);
+	gpio_set_value(host->clk_gpio, 0);
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
diff --git a/drivers/cbus/cbus.h b/drivers/cbus/cbus.h
index 4cd68fd..fbaca09 100644
--- a/drivers/cbus/cbus.h
+++ b/drivers/cbus/cbus.h
@@ -27,8 +27,6 @@ struct cbus_host {
 	/* host lock */
 	spinlock_t lock;
 
-	void __iomem *base;
-
 	int	clk_gpio;
 	int	dat_gpio;
 	int	sel_gpio;
-- 
1.6.6.rc0

