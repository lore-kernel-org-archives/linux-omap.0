From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/12] i2c-omap: convert 'rev1' flag to generic 'rev' u8
Date: Fri, 28 Nov 2008 17:29:17 -0800
Message-ID: <20081129012917.13042.19711.stgit@localhost>
References: <20081129012612.13042.12283.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54332 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbYK2B3Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:29:16 -0500
In-Reply-To: <20081129012612.13042.12283.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: i2c-linux@vger.kernel.org, ben-linux@fluff.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

i2c-omap discriminates only between "revision 1" or "greater than
revision 1."  A following patch introduces code that must also
discriminate between rev2.x, rev3.6, and rev3.12 controllers.  Support
this by storing the full revision data from the I2C_REV register, rather
than just a single bit.

The revision definitions may need to be extended for other ES levels
that aren't currently available here.  rev3.6 is what's present on the
2430SDP here (unknown ES revision); rev3.12 is used on the 3430ES2
here.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 40a1e4b..3ac510d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -38,6 +38,13 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+/* I2C controller revisions */
+#define OMAP_I2C_REV_2			0x20
+
+/* I2C controller revisions present on specific hardware */
+#define OMAP_I2C_REV_ON_2430		0x36
+#define OMAP_I2C_REV_ON_3430		0x3C
+
 /* timeout waiting for the controller to respond */
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
 
@@ -139,7 +146,7 @@ struct omap_i2c_dev {
 						 * fifo_size==0 implies no fifo
 						 * if set, should be trsh+1
 						 */
-	unsigned		rev1:1;
+	u8			rev;
 	unsigned		b_hw:1;		/* bad h/w fixes */
 	unsigned		idle:1;
 	u16			iestate;	/* Saved interrupt register */
@@ -209,7 +216,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
-	if (dev->rev1) {
+	if (dev->rev < OMAP_I2C_REV_2) {
 		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
 	} else {
 		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
@@ -231,7 +238,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	unsigned long timeout;
 	unsigned long internal_clk = 0;
 
-	if (!dev->rev1) {
+	if (dev->rev >= OMAP_I2C_REV_2) {
 		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, OMAP_I2C_SYSC_SRST);
 		/* For some reason we need to set the EN bit before the
 		 * reset done bit gets set. */
@@ -710,6 +717,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	struct omap_i2c_dev	*dev;
 	struct i2c_adapter	*adap;
 	struct resource		*mem, *irq, *ioarea;
+	void *isr;
 	int r;
 	u32 speed = 0;
 
@@ -760,8 +768,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	omap_i2c_unidle(dev);
 
-	if (cpu_is_omap15xx())
-		dev->rev1 = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) < 0x20;
+	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 		u16 s;
@@ -782,16 +789,16 @@ omap_i2c_probe(struct platform_device *pdev)
 	/* reset ASAP, clearing any IRQs */
 	omap_i2c_init(dev);
 
-	r = request_irq(dev->irq, dev->rev1 ? omap_i2c_rev1_isr : omap_i2c_isr,
-			0, pdev->name, dev);
+	isr = (dev->rev < OMAP_I2C_REV_2) ? omap_i2c_rev1_isr : omap_i2c_isr;
+	r = request_irq(dev->irq, isr, 0, pdev->name, dev);
 
 	if (r) {
 		dev_err(dev->dev, "failure requesting irq %i\n", dev->irq);
 		goto err_unuse_clocks;
 	}
-	r = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
+
 	dev_info(dev->dev, "bus %d rev%d.%d at %d kHz\n",
-		 pdev->id, r >> 4, r & 0xf, dev->speed);
+		 pdev->id, dev->rev >> 4, dev->rev & 0xf, dev->speed);
 
 	omap_i2c_idle(dev);
 

