From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/12] i2c-omap: Add support for omap34xx
Date: Fri, 28 Nov 2008 17:28:42 -0800
Message-ID: <20081129012842.13042.97762.stgit@localhost>
References: <20081129012612.13042.12283.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53882 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbYK2B2l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:28:41 -0500
In-Reply-To: <20081129012612.13042.12283.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: i2c-linux@vger.kernel.org, ben-linux@fluff.org
Cc: linux-omap@vger.kernel.org, chandra shekhar <x0044955@ti.com>

From: Chandra shekhar <x0044955@ti.com>

Add support for omap34xx

Signed-off-by: chandra shekhar <x0044955@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9ae4b74..3f7726a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -156,7 +156,7 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 
 static int omap_i2c_get_clocks(struct omap_i2c_dev *dev)
 {
-	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
+	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		dev->iclk = clk_get(dev->dev, "i2c_ick");
 		if (IS_ERR(dev->iclk)) {
 			dev->iclk = NULL;
@@ -266,7 +266,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			psc = fclk_rate / 12000000;
 	}
 
-	if (cpu_is_omap2430()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 
 		/* HSI2C controller internal clk rate should be 19.2 Mhz */
 		internal_clk = 19200;
@@ -608,7 +608,8 @@ omap_i2c_isr(int this_irq, void *dev_id)
 					*dev->buf++ = w;
 					dev->buf_len--;
 					/* Data reg from 2430 is 8 bit wide */
-					if (!cpu_is_omap2430()) {
+					if (!cpu_is_omap2430() &&
+							!cpu_is_omap34xx()) {
 						if (dev->buf_len) {
 							*dev->buf++ = w >> 8;
 							dev->buf_len--;
@@ -646,7 +647,8 @@ omap_i2c_isr(int this_irq, void *dev_id)
 					w = *dev->buf++;
 					dev->buf_len--;
 					/* Data reg from  2430 is 8 bit wide */
-					if (!cpu_is_omap2430()) {
+					if (!cpu_is_omap2430() &&
+							!cpu_is_omap34xx()) {
 						if (dev->buf_len) {
 							w |= *dev->buf++ << 8;
 							dev->buf_len--;
@@ -694,7 +696,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	struct i2c_adapter	*adap;
 	struct resource		*mem, *irq, *ioarea;
 	int r;
-	u32 *speed = NULL;
+	u32 speed = 0;
 
 	/* NOTE: driver uses the static register mapping */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -722,11 +724,11 @@ omap_i2c_probe(struct platform_device *pdev)
 	}
 
 	if (pdev->dev.platform_data != NULL)
-		speed = (u32 *) pdev->dev.platform_data;
+		speed = *(u32 *)pdev->dev.platform_data;
 	else
-		*speed = 100; /* Defualt speed */
+		speed = 100;	/* Defualt speed */
 
-	dev->speed = *speed;
+	dev->speed = speed;
 	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
 	dev->base = ioremap(mem->start, mem->end - mem->start + 1);
@@ -745,7 +747,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	if (cpu_is_omap15xx())
 		dev->rev1 = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) < 0x20;
 
-	if (cpu_is_omap2430()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 		u16 s;
 
 		/* Set up the fifo size - Get total size */

