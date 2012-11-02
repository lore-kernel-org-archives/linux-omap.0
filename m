From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 1/2] i2c: omap: Fix the revision register read
Date: Fri, 2 Nov 2012 16:09:44 +0530
Message-ID: <1351852785-16961-2-git-send-email-shubhrajyoti@ti.com>
References: <1351852785-16961-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41356 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150Ab2KBKki (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 06:40:38 -0400
In-Reply-To: <1351852785-16961-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

The revision register on OMAP4 is a 16-bit lo and a 16-bit
hi. Currently the driver reads only the lower 8-bits.
Fix the same by preventing the truncating of the rev register
for OMAP4.

Also use the scheme bit ie bit-14 of the hi register to know if it
is OMAP_I2C_IP_VERSION_2.

On platforms previous to OMAP4 the offset 0x04 is IE register whose
bit-14 reset value is 0, the code uses the same to its advantage.

Also since the omap_i2c_read_reg uses reg_map_ip_* a raw_readw is done
to fetch the revision register.

The dev->regs is populated after reading the rev_hi. A NULL check
has been added in the resume handler to prevent the access before
the setting of the regs.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   59 ++++++++++++++++++++++++++++++++---------
 1 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index db31eae..d8e7709 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -49,9 +49,10 @@
 #define OMAP_I2C_OMAP1_REV_2		0x20
 
 /* I2C controller revisions present on specific hardware */
-#define OMAP_I2C_REV_ON_2430		0x36
-#define OMAP_I2C_REV_ON_3430_3530	0x3C
-#define OMAP_I2C_REV_ON_3630_4430	0x40
+#define OMAP_I2C_REV_ON_2430		0x00000036
+#define OMAP_I2C_REV_ON_3430_3530	0x0000003C
+#define OMAP_I2C_REV_ON_3630		0x00000040
+#define OMAP_I2C_REV_ON_4430_PLUS	0x50400002
 
 /* timeout waiting for the controller to respond */
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
@@ -202,7 +203,7 @@ struct omap_i2c_dev {
 						 * fifo_size==0 implies no fifo
 						 * if set, should be trsh+1
 						 */
-	u8			rev;
+	u32			rev;
 	unsigned		b_hw:1;		/* bad h/w fixes */
 	unsigned		receiver:1;	/* true when we're in receiver mode */
 	u16			iestate;	/* Saved interrupt register */
@@ -490,7 +491,7 @@ static void omap_i2c_resize_fifo(struct omap_i2c_dev *dev, u8 size, bool is_rx)
 
 	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, buf);
 
-	if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
+	if (dev->rev < OMAP_I2C_REV_ON_3630)
 		dev->b_hw = 1; /* Enable hardware fixes */
 
 	/* calculate wakeup latency constraint for MPU */
@@ -1052,6 +1053,14 @@ static const struct of_device_id omap_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
 #endif
 
+#define OMAP_I2C_SCHEME(rev)		(rev & 0xc000) >> 14
+
+#define OMAP_I2C_REV_SCHEME_0_MAJOR(rev) (rev >> 4)
+#define OMAP_I2C_REV_SCHEME_0_MINOR(rev) (rev & 0xf)
+
+#define OMAP_I2C_REV_SCHEME_1_MAJOR(rev) ((rev & 0x0700) >> 7)
+#define OMAP_I2C_REV_SCHEME_1_MINOR(rev) (rev & 0x1f)
+
 static int __devinit
 omap_i2c_probe(struct platform_device *pdev)
 {
@@ -1064,6 +1073,8 @@ omap_i2c_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	int irq;
 	int r;
+	u32 rev;
+	u16 minor, major;
 
 	/* NOTE: driver uses the static register mapping */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1117,11 +1128,6 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	dev->reg_shift = (dev->flags >> OMAP_I2C_FLAG_BUS_SHIFT__SHIFT) & 3;
 
-	if (dev->dtrev == OMAP_I2C_IP_VERSION_2)
-		dev->regs = (u8 *)reg_map_ip_v2;
-	else
-		dev->regs = (u8 *)reg_map_ip_v1;
-
 	pm_runtime_enable(dev->dev);
 	pm_runtime_set_autosuspend_delay(dev->dev, OMAP_I2C_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(dev->dev);
@@ -1130,7 +1136,31 @@ omap_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR_VALUE(r))
 		goto err_free_mem;
 
-	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
+	/*
+	 * Read the Rev hi bit-[15:14] ie scheme this is 1 indicates ver2.
+	 * On omap3 Offset 4 is IE Reg the bit [15:14] is XDR_IE which is 0
+	 * at reset. Also since the omap_i2c_read_reg uses reg_map_ip_* a
+	 * raw_readw is done.
+	 */
+	rev = __raw_readw(dev->base + 0x04);
+
+	switch (OMAP_I2C_SCHEME(rev)) {
+	case 0:
+		dev->regs = (u8 *)reg_map_ip_v1;
+		dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
+		minor = OMAP_I2C_REV_SCHEME_0_MAJOR(dev->rev);
+		major = OMAP_I2C_REV_SCHEME_0_MAJOR(dev->rev);
+	break;
+	case 1:
+		/* FALLTHROUGH */
+	default:
+		dev->regs = (u8 *)reg_map_ip_v2;
+		rev = (rev << 16) |
+			omap_i2c_read_reg(dev, OMAP_I2C_IP_V2_REVNB_LO);
+		minor = OMAP_I2C_REV_SCHEME_1_MINOR(rev);
+		major = OMAP_I2C_REV_SCHEME_1_MAJOR(rev);
+		dev->rev = rev;
+	}
 
 	dev->errata = 0;
 
@@ -1155,7 +1185,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 		dev->fifo_size = (dev->fifo_size / 2);
 
-		if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
+		if (dev->rev < OMAP_I2C_REV_ON_3630)
 			dev->b_hw = 1; /* Enable hardware fixes */
 
 		/* calculate wakeup latency constraint for MPU */
@@ -1198,7 +1228,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	}
 
 	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", adap->nr,
-		 dev->dtrev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
+		 dev->dtrev, major, minor, dev->speed);
 
 	of_i2c_register_devices(adap);
 
@@ -1264,6 +1294,9 @@ static int omap_i2c_runtime_resume(struct device *dev)
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

