From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 3/7] i2c: omap: remove the dtrev
Date: Sun, 4 Nov 2012 16:14:29 +0530
Message-ID: <1352025873-27492-4-git-send-email-shubhrajyoti@ti.com>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352025873-27492-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The dtrev is used only for the comments. Remove the same and use
the scheme instead to know if it is version2.

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index e009985..b62cd9d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -191,7 +191,6 @@ struct omap_i2c_dev {
 	u32			latency;	/* maximum MPU wkup latency */
 	struct pm_qos_request	pm_qos_request;
 	u32			speed;		/* Speed of bus in kHz */
-	u32			dtrev;		/* extra revision from DT */
 	u32			flags;
 	u16			cmd_err;
 	u8			*buf;
@@ -1076,7 +1075,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	int irq;
 	int r;
 	u32 rev;
-	u16 minor, major;
+	u16 minor, major, scheme;
 
 	/* NOTE: driver uses the static register mapping */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1108,7 +1107,6 @@ omap_i2c_probe(struct platform_device *pdev)
 		u32 freq = 100000; /* default to 100000 Hz */
 
 		pdata = match->data;
-		dev->dtrev = pdata->rev;
 		dev->flags = pdata->flags;
 
 		of_property_read_u32(node, "clock-frequency", &freq);
@@ -1117,7 +1115,6 @@ omap_i2c_probe(struct platform_device *pdev)
 	} else if (pdata != NULL) {
 		dev->speed = pdata->clkrate;
 		dev->flags = pdata->flags;
-		dev->dtrev = pdata->rev;
 	}
 
 	dev->dev = &pdev->dev;
@@ -1146,7 +1143,8 @@ omap_i2c_probe(struct platform_device *pdev)
 	 */
 	rev = __raw_readw(dev->base + 0x04);
 
-	switch (OMAP_I2C_SCHEME(rev)) {
+	scheme = OMAP_I2C_SCHEME(rev);
+	switch (scheme) {
 	case OMAP_I2C_SCHEME_0:
 		dev->regs = (u8 *)reg_map_ip_v1;
 		dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
@@ -1231,7 +1229,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	}
 
 	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", adap->nr,
-		 dev->dtrev, major, minor, dev->speed);
+		 scheme, major, minor, dev->speed);
 
 	of_i2c_register_devices(adap);
 
-- 
1.7.5.4
