From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: [PATCH - OMAPZOOM] I2C: fix OMAP3430 errata 1.11
Date: Wed, 1 Oct 2008 15:19:55 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB028C45E8E9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51226 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbYJAJuE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 05:50:04 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m919nvku029204
	for <linux-omap@vger.kernel.org>; Wed, 1 Oct 2008 04:50:03 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id m919nuci025800
	for <linux-omap@vger.kernel.org>; Wed, 1 Oct 2008 15:19:56 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

Following patch taken over the omapzoom.org tree fixes OMAP 3430
errata 1.11 for I2C: if the I2C module is configured as slave,
in autoidle mode (I2C_SYSC.AUTOIDLE=1) and the ARDY (I2C.I2C_STAT[2])
condition and the START condition are detected in the module at the
same time, internal clock gating will be wrongly applied. This will
cause the I2C to NACK (I2C.I2C_STAT[1])the transfer for which the
START (I2C.I2C_STAT[6]) condition was received. Next transfers will
be ACKed as expected.

Fix disables AUTO_IDLE from the start of a transaction, in slave
mode, till the end of it.

Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
Index: 34+_master/drivers/i2c/busses/i2c-omap.c
===================================================================
--- 34+_master.orig/drivers/i2c/busses/i2c-omap.c	2008-09-29 18:18:35.000000000 +0530
+++ 34+_master/drivers/i2c/busses/i2c-omap.c	2008-10-01 13:12:29.299298673 +0530
@@ -544,6 +544,16 @@ omap_i2c_slave_xfer_msg(struct i2c_adapt
 	if (!(msg->flags & I2C_M_RD))
 		dev->slave_tx = 1;
 
+	/* As per OMAP3430 silicon errata 1.11, I2C in slave mode
+	 * with AUTO_IDLE enabled can lead to race conditions. So disabling
+	 * AUTO_IDLE for transactions in slave mode.
+	 */
+	if (cpu_is_omap3430()) {
+		w = omap_i2c_read_reg(dev, OMAP_I2C_SYSC_REG);
+		w &= ~1;
+		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, w);
+	}
+
 	dev->cmd_err = 0;
 	w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
 	w &= ~OMAP_I2C_CON_MST;
@@ -597,6 +607,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, 
 	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
 	int i;
 	int r;
+	u16 val;
 
 	omap_i2c_enable_clocks(dev);
 
@@ -632,6 +643,22 @@ omap_i2c_xfer(struct i2c_adapter *adap, 
 #endif
 out:
 	disable_irq(dev->irq);
+
+	/* Switching to master mode */
+	val = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
+	val |= OMAP_I2C_CON_MST;
+	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, val);
+
+	/* As per OMAP3430 silicon errata 1.11, I2C in slave mode
+	 * with AUTO_IDLE enabled can lead to race conditions. The AUTO_IDLE
+	 * disabled at the beginning of a slave transaction is enabled back.
+	 */
+	if (cpu_is_omap3430()) {
+		val = omap_i2c_read_reg(dev, OMAP_I2C_SYSC_REG);
+		val |= 1;
+		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, val);
+	}
+
 	omap_i2c_disable_clocks(dev);
 	/* Default master mode */
 	dev->mode = OMAP_I2C_MASTER_MODE;
--
With Regards,
Jagadeesh Bhaskar P
 
----------------------------
Some men see things as they are and say why - I dream things that never were and say why not.
- George Bernard Shaw
-------------------

