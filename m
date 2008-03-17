From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] I2C: Fix unhandled fault in i2c-omap controller, take #2
Date: Mon, 17 Mar 2008 09:19:49 +0200
Message-ID: <20080317071949.GP11653@atomide.com>
References: <20080313155123.GI11653@atomide.com> <20080314185218.3fa69d19@hyperion.delvare> <20080317064619.GO11653@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="F8dlzb82+Fcn6AgP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:64525 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbYCQHU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 03:20:26 -0400
Content-Disposition: inline
In-Reply-To: <20080317064619.GO11653@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-omap@vger.kernel.org, i2c@lm-sensors.org


--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here's an updated version

Regards,

Tony


--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=i2c-clock-race-v2

commit 94a3ce6a20c3920e0e43991d38506134791e9d72
Author: Tony Lindgren <tony@atomide.com>
Date:   Mon Feb 18 20:16:00 2008 -0800

    I2C: Fix unhandled fault in i2c-omap controller
    
    If an I2C interrupt happens between disabling interface clock
    and functional clock, the interrupt handler will produce an
    external abort on non-linefetch error when trying to access
    driver registers while interface clock is disabled.
    
    This patch fixes the problem by saving and disabling i2c-omap
    interrupt before turning off the clocks. Also disable functional
    clock before the interface clock as suggested by Paul Walmsley.
    
    Patch also renames enable/disable_clocks functions to unidle/idle
    functions. Note that the driver is currently not taking advantage
    of the idle interrupts. To use the idle interrupts, driver would
    have to enable interface clock based on the idle interrupt
    and dev->idle flag.
    
    This patch has been tested in linux-omap tree with various omaps.
    
    Cc: linux-omap@vger.kernel.org
    Cc: Paul Walmsley <paul@pwsan.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index da66397..7ba3177 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -128,6 +128,8 @@ struct omap_i2c_dev {
 	size_t			buf_len;
 	struct i2c_adapter	adapter;
 	unsigned		rev1:1;
+	unsigned		idle:1;
+	u16			iestate;	/* Saved interrupt register */
 };
 
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
@@ -174,18 +176,30 @@ static void omap_i2c_put_clocks(struct omap_i2c_dev *dev)
 	}
 }
 
-static void omap_i2c_enable_clocks(struct omap_i2c_dev *dev)
+static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 {
 	if (dev->iclk != NULL)
 		clk_enable(dev->iclk);
 	clk_enable(dev->fclk);
+	if (dev->iestate)
+		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
+	dev->idle = 0;
 }
 
-static void omap_i2c_disable_clocks(struct omap_i2c_dev *dev)
+static void omap_i2c_idle(struct omap_i2c_dev *dev)
 {
+	u16 iv;
+
+	dev->idle = 1;
+	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
+	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
+	if (dev->rev1)
+		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);	/* Read clears */
+	else
+		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
+	clk_disable(dev->fclk);
 	if (dev->iclk != NULL)
 		clk_disable(dev->iclk);
-	clk_disable(dev->fclk);
 }
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)
@@ -360,7 +374,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	int i;
 	int r;
 
-	omap_i2c_enable_clocks(dev);
+	omap_i2c_unidle(dev);
 
 	if ((r = omap_i2c_wait_for_bb(dev)) < 0)
 		goto out;
@@ -374,7 +388,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	if (r == 0)
 		r = num;
 out:
-	omap_i2c_disable_clocks(dev);
+	omap_i2c_idle(dev);
 	return r;
 }
 
@@ -403,6 +417,9 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
 	struct omap_i2c_dev *dev = dev_id;
 	u16 iv, w;
 
+	if (dev->idle)
+		return IRQ_NONE;
+
 	iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);
 	switch (iv) {
 	case 0x00:	/* None */
@@ -457,6 +474,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
 	u16 stat, w;
 	int count = 0;
 
+	if (dev->idle)
+		return IRQ_NONE;
+
 	bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	while ((stat = (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG))) & bits) {
 		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
@@ -575,7 +595,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	if ((r = omap_i2c_get_clocks(dev)) != 0)
 		goto err_free_mem;
 
-	omap_i2c_enable_clocks(dev);
+	omap_i2c_unidle(dev);
 
 	if (cpu_is_omap15xx())
 		dev->rev1 = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) < 0x20;
@@ -610,7 +630,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_free_irq;
 	}
 
-	omap_i2c_disable_clocks(dev);
+	omap_i2c_idle(dev);
 
 	return 0;
 
@@ -618,7 +638,7 @@ err_free_irq:
 	free_irq(dev->irq, dev);
 err_unuse_clocks:
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
-	omap_i2c_disable_clocks(dev);
+	omap_i2c_idle(dev);
 	omap_i2c_put_clocks(dev);
 err_free_mem:
 	platform_set_drvdata(pdev, NULL);

--F8dlzb82+Fcn6AgP--
