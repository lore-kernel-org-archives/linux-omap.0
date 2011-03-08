From: Andy Green <andy@warmcat.com>
Subject: [PATCH 2 17/18] I2C: OMAP2+: Convert omap I2C driver to use feature
 implementation flags from platform data
Date: Tue, 08 Mar 2011 11:09:27 +0000
Message-ID: <20110308110927.23531.12150.stgit@otae.warmcat.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52226 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878Ab1CHLJa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 06:09:30 -0500
Received: by mail-ww0-f44.google.com with SMTP id 36so951436wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 03:09:30 -0800 (PST)
In-Reply-To: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>

This patch eliminates all cpu_...() tests from the OMAP I2C driver.

Instead, it uses the functionality flags in the platform data to make
the decisions about product variations the driver needs to handle.

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 drivers/i2c/busses/i2c-omap.c |   40 +++++++++++++++++++++++-----------------
 1 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ecb48c7..c997c55 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -277,7 +277,7 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 
 	pm_runtime_get_sync(&pdev->dev);
 
-	if (cpu_is_omap34xx()) {
+	if (pdata->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 		omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
@@ -335,6 +335,11 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	unsigned long timeout;
 	unsigned long internal_clk = 0;
 	struct clk *fclk;
+	struct platform_device *pdev;
+	struct omap_i2c_bus_platform_data *pdata;
+
+	pdev = to_platform_device(dev->dev);
+	pdata = pdev->dev.platform_data;
 
 	if (dev->rev >= OMAP_I2C_OMAP1_REV_2) {
 		/* Disable I2C controller before soft reset */
@@ -386,7 +391,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	}
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 
-	if (cpu_class_is_omap1()) {
+	if (pdata->flags & OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK) {
 		/*
 		 * The I2C functional clock is the armxor_ck, so there's
 		 * no need to get "armxor_ck" separately.  Now, if OMAP2420
@@ -410,7 +415,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			psc = fclk_rate / 12000000;
 	}
 
-	if (!(cpu_class_is_omap1() || cpu_is_omap2420())) {
+	if (!(pdata->flags & OMAP_I2C_FLAG_SIMPLE_CLOCK)) {
 
 		/*
 		 * HSI2C controller internal clk rate should be 19.2 Mhz for
@@ -418,7 +423,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 		 * to get longer filter period for better noise suppression.
 		 * The filter is iclk (fclk for HS) period.
 		 */
-		if (dev->speed > 400 || cpu_is_omap2430())
+		if (dev->speed > 400 ||
+			       pdata->flags & OMAP_I2C_FLAG_FORCE_19200_INT_CLK)
 			internal_clk = 19200;
 		else if (dev->speed > 100)
 			internal_clk = 9600;
@@ -487,7 +493,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 
 	dev->errata = 0;
 
-	if (cpu_is_omap2430() || cpu_is_omap34xx())
+	if (pdata->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
 		dev->errata |= I2C_OMAP_ERRATA_I207;
 
 	/* Enable interrupts */
@@ -496,7 +502,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
 				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
-	if (cpu_is_omap34xx()) {
+	if (pdata->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
 		dev->pscstate = psc;
 		dev->scllstate = scll;
 		dev->sclhstate = sclh;
@@ -816,6 +822,11 @@ omap_i2c_isr(int this_irq, void *dev_id)
 	u16 bits;
 	u16 stat, w;
 	int err, count = 0;
+	struct platform_device *pdev;
+	struct omap_i2c_bus_platform_data *pdata;
+
+	pdev = to_platform_device(dev->dev);
+	pdata = pdev->dev.platform_data;
 
 	if (dev->idle)
 		return IRQ_NONE;
@@ -884,8 +895,8 @@ complete:
 					 * Data reg in 2430, omap3 and
 					 * omap4 is 8 bit wide
 					 */
-					if (cpu_class_is_omap1() ||
-							cpu_is_omap2420()) {
+					if (pdata->flags &
+						 OMAP_I2C_FLAG_16BIT_DATA_REG) {
 						if (dev->buf_len) {
 							*dev->buf++ = w >> 8;
 							dev->buf_len--;
@@ -927,8 +938,8 @@ complete:
 					 * Data reg in 2430, omap3 and
 					 * omap4 is 8 bit wide
 					 */
-					if (cpu_class_is_omap1() ||
-							cpu_is_omap2420()) {
+					if (pdata->flags &
+						 OMAP_I2C_FLAG_16BIT_DATA_REG) {
 						if (dev->buf_len) {
 							w |= *dev->buf++ << 8;
 							dev->buf_len--;
@@ -1030,12 +1041,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dev);
 
-	if (cpu_is_omap7xx())
-		dev->reg_shift = 1;
-	else if (cpu_is_omap44xx())
-		dev->reg_shift = 0;
-	else
-		dev->reg_shift = 2;
+	dev->reg_shift = (pdata->flags >> OMAP_I2C_FLAG_BUS_SHIFT__SHIFT) & 3;
 
 	if (pdata->rev == OMAP_I2C_IP_VERSION_2)
 		dev->regs = (u8 *)reg_map_ip_v2;
@@ -1050,7 +1056,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	if (dev->rev <= OMAP_I2C_REV_ON_3430)
 		dev->errata |= I2C_OMAP3_1P153;
 
-	if (!(cpu_class_is_omap1() || cpu_is_omap2420())) {
+	if (!(pdata->flags & OMAP_I2C_FLAG_NO_FIFO)) {
 		u16 s;
 
 		/* Set up the fifo size - Get total size */

