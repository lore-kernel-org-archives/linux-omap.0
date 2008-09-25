From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/8] i2c-omap: Add support on 34xx
Date: Thu, 25 Sep 2008 10:53:51 +0300
Message-ID: <1222329234-31473-6-git-send-email-tony@atomide.com>
References: <1222329234-31473-1-git-send-email-tony@atomide.com>
 <1222329234-31473-2-git-send-email-tony@atomide.com>
 <1222329234-31473-3-git-send-email-tony@atomide.com>
 <1222329234-31473-4-git-send-email-tony@atomide.com>
 <1222329234-31473-5-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61018 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbYIYHyS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 03:54:18 -0400
In-Reply-To: <1222329234-31473-5-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: i2c@lm-sensors.org
Cc: linux-omap@vger.kernel.org, Chandra shekhar <x0044955@ti.com>, Tony Lindgren <tony@atomide.com>

From: Chandra shekhar <x0044955@ti.com>

Signed-off-by: chandra shekhar <x0044955@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ded4636..b41431a 100644
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
@@ -279,7 +279,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			psc = fclk_rate / 12000000;
 	}
 
-	if (cpu_is_omap2430()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 
 		/* HSI2C controller internal clk rate should be 19.2 Mhz */
 		internal_clk = 19200;
@@ -616,7 +616,8 @@ omap_i2c_isr(int this_irq, void *dev_id)
 					*dev->buf++ = w;
 					dev->buf_len--;
 					/* Data reg from 2430 is 8 bit wide */
-					if (!cpu_is_omap2430()) {
+					if (!cpu_is_omap2430() &&
+							!cpu_is_omap34xx()) {
 						if (dev->buf_len) {
 							*dev->buf++ = w >> 8;
 							dev->buf_len--;
@@ -654,7 +655,8 @@ omap_i2c_isr(int this_irq, void *dev_id)
 					w = *dev->buf++;
 					dev->buf_len--;
 					/* Data reg from  2430 is 8 bit wide */
-					if (!cpu_is_omap2430()) {
+					if (!cpu_is_omap2430() &&
+							!cpu_is_omap34xx()) {
 						if (dev->buf_len) {
 							w |= *dev->buf++ << 8;
 							dev->buf_len--;
@@ -748,7 +750,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	if (cpu_is_omap15xx())
 		dev->rev1 = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) < 0x20;
 
-	if (cpu_is_omap2430()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 		u16 s;
 
 		/* Set up the fifo size - Get total size */
-- 
1.5.6.rc3.21.g8c6b5

