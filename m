From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] OMAP: I2C: convert 'rev1' flag to generic 'rev' u8
Date: Tue, 14 Oct 2008 06:19:26 -0600
Message-ID: <20081014121921.1210.54222.stgit@localhost.localdomain>
References: <20081014121031.1210.96214.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38057 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205AbYJNMVb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 08:21:31 -0400
In-Reply-To: <20081014121031.1210.96214.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

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
---
 drivers/i2c/busses/i2c-omap.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a999606..12bdb69 100644
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
@@ -220,7 +227,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
-	if (dev->rev1)
+	if (dev->rev < OMAP_I2C_REV_2)
 		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
 	else
 		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
@@ -244,7 +251,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	unsigned long timeout;
 	unsigned long internal_clk = 0;
 
-	if (!dev->rev1) {
+	if (dev->rev >= OMAP_I2C_REV_2) {
 		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, OMAP_I2C_SYSC_SRST);
 		/* For some reason we need to set the EN bit before the
 		 * reset done bit gets set. */
@@ -718,6 +725,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	struct omap_i2c_dev	*dev;
 	struct i2c_adapter	*adap;
 	struct resource		*mem, *irq, *ioarea;
+	void *isr;
 	int r;
 	u32 *speed = NULL;
 
@@ -769,8 +777,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	omap_i2c_unidle(dev);
 
-	if (cpu_is_omap15xx())
-		dev->rev1 = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) < 0x20;
+	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 		u16 s;
@@ -791,16 +798,16 @@ omap_i2c_probe(struct platform_device *pdev)
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
 


