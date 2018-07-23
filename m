From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 04/12] i2c: omap: use core to detect 'no zero length' quirk
Date: Mon, 23 Jul 2018 22:26:08 +0200
Message-ID: <20180723202617.15230-5-wsa+renesas@sang-engineering.com>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

And don't reimplement in the driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Only build tested.

 drivers/i2c/busses/i2c-omap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 65d06a819307..b1086bfb0465 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -661,9 +661,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	dev_dbg(omap->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
 		msg->addr, msg->len, msg->flags, stop);
 
-	if (msg->len == 0)
-		return -EINVAL;
-
 	omap->receiver = !!(msg->flags & I2C_M_RD);
 	omap_i2c_resize_fifo(omap, msg->len, omap->receiver);
 
@@ -1179,6 +1176,10 @@ static const struct i2c_algorithm omap_i2c_algo = {
 	.functionality	= omap_i2c_func,
 };
 
+static const struct i2c_adapter_quirks omap_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 #ifdef CONFIG_OF
 static struct omap_i2c_bus_platform_data omap2420_pdata = {
 	.rev = OMAP_I2C_IP_VERSION_1,
@@ -1453,6 +1454,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	adap->class = I2C_CLASS_DEPRECATED;
 	strlcpy(adap->name, "OMAP I2C adapter", sizeof(adap->name));
 	adap->algo = &omap_i2c_algo;
+	adap->quirks = &omap_i2c_quirks;
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
 	adap->bus_recovery_info = &omap_i2c_bus_recovery_info;
-- 
2.11.0
