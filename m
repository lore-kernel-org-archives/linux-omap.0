From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rft/rfc/patch-2.6.32-omap1+ 1/6] cbus: convert u32 base to void __iomem *base
Date: Wed, 16 Dec 2009 01:44:08 +0200
Message-ID: <1260920653-18503-2-git-send-email-felipe.balbi@nokia.com>
References: <1260920653-18503-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:19907 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993AbZLOXqp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 18:46:45 -0500
In-Reply-To: <1260920653-18503-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

to avoid casting later, pass the parameter of the
correct type already.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/cbus.c |   16 +++++++++-------
 drivers/cbus/cbus.h |   10 ++++++++--
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index 00c3c32..c0b4248 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -45,7 +45,8 @@ EXPORT_SYMBOL(cbus_host);
 #ifdef CONFIG_ARCH_OMAP1
 /* We use our own MPUIO functions to get closer to 1MHz bus speed */
 
-static inline void cbus_set_gpio_direction(u32 base, int mpuio, int is_input)
+static inline void cbus_set_gpio_direction(void __iomem *base,
+		int mpuio, int is_input)
 {
 	u16 w;
 
@@ -59,7 +60,8 @@ static inline void cbus_set_gpio_direction(u32 base, int mpuio, int is_input)
 
 }
 
-static inline void cbus_set_gpio_dataout(u32 base, int mpuio, int enable)
+static inline void cbus_set_gpio_dataout(void __iomem *base,
+		int mpuio, int enable)
 {
 	u16 w;
 
@@ -72,14 +74,14 @@ static inline void cbus_set_gpio_dataout(u32 base, int mpuio, int enable)
 	__raw_writew(w, base + OMAP_MPUIO_OUTPUT);
 }
 
-static inline int cbus_get_gpio_datain(u32 base, int mpuio)
+static inline int cbus_get_gpio_datain(void __iomem *base, int mpuio)
 {
 	mpuio &= 0x0f;
 
 	return (__raw_readw(base + OMAP_MPUIO_INPUT_LATCH) & (1 << mpuio)) != 0;
 }
 
-static void cbus_send_bit(struct cbus_host *host, u32 base, int bit,
+static void cbus_send_bit(struct cbus_host *host, void __iomem *base, int bit,
 			  int set_to_input)
 {
 	cbus_set_gpio_dataout(base, host->dat_gpio, bit ? 1 : 0);
@@ -92,7 +94,7 @@ static void cbus_send_bit(struct cbus_host *host, u32 base, int bit,
 	cbus_set_gpio_dataout(base, host->clk_gpio, 0);
 }
 
-static u8 cbus_receive_bit(struct cbus_host *host, u32 base)
+static u8 cbus_receive_bit(struct cbus_host *host, void __iomem *base)
 {
 	u8 ret;
 
@@ -144,12 +146,12 @@ static int cbus_transfer(struct cbus_host *host, int dev, int reg, int data)
 	int i;
 	int is_read = 0;
 	unsigned long flags;
-	u32 base;
+	void __iomem *base;
 
 #ifdef CONFIG_ARCH_OMAP1
 	base = OMAP1_IO_ADDRESS(OMAP1_MPUIO_BASE);
 #else
-	base = 0;
+	base = NULL;
 #endif
 
 	if (data < 0)
diff --git a/drivers/cbus/cbus.h b/drivers/cbus/cbus.h
index 957224c..90c7617 100644
--- a/drivers/cbus/cbus.h
+++ b/drivers/cbus/cbus.h
@@ -24,8 +24,14 @@
 #define __DRIVERS_CBUS_CBUS_H
 
 struct cbus_host {
-	int clk_gpio, dat_gpio, sel_gpio;
-        spinlock_t lock;
+	/* host lock */
+	spinlock_t lock;
+
+	void __iomem *base;
+
+	int	clk_gpio;
+	int	dat_gpio;
+	int	sel_gpio;
 };
 
 extern struct cbus_host *cbus_host;
-- 
1.6.6.rc0

