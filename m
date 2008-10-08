From: David Brownell <david-b@pacbell.net>
Subject: [PATCH 2.6.27-rc9-omap] i2c-omap: timeouts begone
Date: Wed, 8 Oct 2008 14:36:05 -0700
Message-ID: <200810081436.06810.david-b@pacbell.net>
References: <A24693684029E5489D1D202277BE8944123692F2@dlee02.ent.ti.com> <20081008183808.GA31385@atomide.com> <200810081236.48940.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:44309 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754954AbYJHVi0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 17:38:26 -0400
In-Reply-To: <200810081236.48940.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I can tell someone's going to want a fix that's a
lot more power-aware ... ;)

This seems to remove the need for the "hack" patch.


--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -202,6 +202,9 @@ static void omap_i2c_put_clocks(struct omap_i2c_dev *dev)
 
 static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 {
+	if (1)
+		return;
+
 	if (dev->iclk != NULL)
 		clk_enable(dev->iclk);
 	clk_enable(dev->fclk);
@@ -214,6 +217,9 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 {
 	u16 iv;
 
+	if (1)
+		return;
+
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 	if (dev->rev1)
