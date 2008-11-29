From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 09/12] i2c-omap: fix I2C timeouts due to recursive
	omap_i2c_{un, }idle()
Date: Fri, 28 Nov 2008 17:34:50 -0800
Message-ID: <20081129013450.13428.84626.stgit@localhost>
References: <20081129013318.13428.88465.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081129013318.13428.88465.stgit@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard Woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>

omap_i2c_unidle() and omap_i2c_idle() are called recursively during
omap_i2c_probe().  This is evidently unexpected and will wipe
out the I2C interrupt enable register the second time that
omap_i2c_idle() is called consecutively.  Any I2C transactions
following a probe of a bus with at least one device on it will then
time out.

Fix by moving omap_i2c_idle() further up in omap_i2c_probe().  Ensure
the I2C controller is marked as idle before the probe starts.  Also
attempt to catch future reappearances of this bug early in development
by warning in omap_i2c_{un,}idle() when they are called recursively.

Problem reported by David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>.

Tested on 3430SDP and 2430SDP.

Signed-off-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Richard Woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
Acked-by; Steve Sakoman <steve-4Uf0gMDude1BDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 4aeebad..40a1e4b 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -191,6 +191,8 @@ static void omap_i2c_put_clocks(struct omap_i2c_dev *dev)
 
 static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 {
+	WARN_ON(!dev->idle);
+
 	if (dev->iclk != NULL)
 		clk_enable(dev->iclk);
 	clk_enable(dev->fclk);
@@ -203,6 +205,8 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 {
 	u16 iv;
 
+	WARN_ON(dev->idle);
+
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 	if (dev->rev1) {
@@ -740,6 +744,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		speed = 100;	/* Defualt speed */
 
 	dev->speed = speed;
+	dev->idle = 1;
 	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
 	dev->base = ioremap(mem->start, mem->end - mem->start + 1);
@@ -788,6 +793,8 @@ omap_i2c_probe(struct platform_device *pdev)
 	dev_info(dev->dev, "bus %d rev%d.%d at %d kHz\n",
 		 pdev->id, r >> 4, r & 0xf, dev->speed);
 
+	omap_i2c_idle(dev);
+
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
@@ -804,8 +811,6 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_free_irq;
 	}
 
-	omap_i2c_idle(dev);
-
 	return 0;
 
 err_free_irq:
