From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC] i2c: omap: Fix the revision register read
Date: Wed, 31 Oct 2012 14:29:19 +0530
Message-ID: <1351673959-5918-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The revision register on OMAP4 is a 16-bit lo and a 16-bit
hi. Currently the driver reads only the lower 8-bits.
Fix the same by preventing the truncating of the rev register
for OMAP4.

Also use the scheme bit ie bit-14 of the hi register to know if it
is OMAP_I2C_IP_VERSION_2.

On platforms previous to OMAP4 the offset 0x04 is IE register whose
bit-14 reset value is 0, the code uses the same to its advantage.

The dev->regs is populated after reading the rev_hi. A NULL check
has been added in the resume handler to prevent the access before
the setting of the regs.

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
todo: some of the flag checks can be removed in favour of revision check.

 drivers/i2c/busses/i2c-omap.c |   35 +++++++++++++++++++++++++----------
 1 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index db31eae..651a7f7 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -51,7 +51,8 @@
 /* I2C controller revisions present on specific hardware */
 #define OMAP_I2C_REV_ON_2430		0x36
 #define OMAP_I2C_REV_ON_3430_3530	0x3C
-#define OMAP_I2C_REV_ON_3630_4430	0x40
+#define OMAP_I2C_REV_ON_3630		0x40
+#define OMAP_I2C_REV_ON_4430_PLUS	0x5040
 
 /* timeout waiting for the controller to respond */
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
@@ -202,7 +203,7 @@ struct omap_i2c_dev {
 						 * fifo_size==0 implies no fifo
 						 * if set, should be trsh+1
 						 */
-	u8			rev;
+	u16			rev;
 	unsigned		b_hw:1;		/* bad h/w fixes */
 	unsigned		receiver:1;	/* true when we're in receiver mode */
 	u16			iestate;	/* Saved interrupt register */
@@ -490,7 +491,7 @@ static void omap_i2c_resize_fifo(struct omap_i2c_dev *dev, u8 size, bool is_rx)
 
 	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, buf);
 
-	if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
+	if (dev->rev < OMAP_I2C_REV_ON_3630)
 		dev->b_hw = 1; /* Enable hardware fixes */
 
 	/* calculate wakeup latency constraint for MPU */
@@ -1064,6 +1065,8 @@ omap_i2c_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	int irq;
 	int r;
+	u16 rev_lo;
+	u16 rev_hi;
 
 	/* NOTE: driver uses the static register mapping */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1117,11 +1120,6 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	dev->reg_shift = (dev->flags >> OMAP_I2C_FLAG_BUS_SHIFT__SHIFT) & 3;
 
-	if (dev->dtrev == OMAP_I2C_IP_VERSION_2)
-		dev->regs = (u8 *)reg_map_ip_v2;
-	else
-		dev->regs = (u8 *)reg_map_ip_v1;
-
 	pm_runtime_enable(dev->dev);
 	pm_runtime_set_autosuspend_delay(dev->dev, OMAP_I2C_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(dev->dev);
@@ -1130,7 +1128,21 @@ omap_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR_VALUE(r))
 		goto err_free_mem;
 
-	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
+	/* Read the Rev hi bit-14 ie scheme this is 1 indicates ver2 or
+	* highlander.
+	* On omap3 Offset 4 is IE Reg the bit 14 is XDR_IE which is 0 at reset.
+	*/
+	rev_hi = __raw_readw(dev->base + 0x04);
+
+	if (rev_hi & 0x4000) {/* If scheme 1*/
+		dev->regs = (u8 *)reg_map_ip_v2;
+		dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_IP_V2_REVNB_HI);
+		rev_lo = omap_i2c_read_reg(dev, OMAP_I2C_IP_V2_REVNB_LO);
+		dev_info(dev->dev, "the low rev %x\n", rev_lo);
+	} else {
+		dev->regs = (u8 *)reg_map_ip_v1;
+		dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
+	}
 
 	dev->errata = 0;
 
@@ -1155,7 +1167,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 		dev->fifo_size = (dev->fifo_size / 2);
 
-		if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
+		if (dev->rev < OMAP_I2C_REV_ON_3630)
 			dev->b_hw = 1; /* Enable hardware fixes */
 
 		/* calculate wakeup latency constraint for MPU */
@@ -1264,6 +1276,9 @@ static int omap_i2c_runtime_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
 
+	if (!_dev->regs)
+		return 0;
+
 	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
 		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);
 		omap_i2c_write_reg(_dev, OMAP_I2C_PSC_REG, _dev->pscstate);
-- 
1.7.5.4
