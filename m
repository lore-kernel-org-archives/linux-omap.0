From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/8] i2c: omap: Fix missing device tree flags for omap2
Date: Wed, 13 Nov 2013 18:35:33 -0800
Message-ID: <1384396537-3486-5-git-send-email-tony@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384396537-3486-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

As we claim to support device tree for mach-omap2, we
should have the necessary flags in the driver to make it
usable.

Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---

If this looks OK, I'd like to merge this as a fix via arm-soc tree
along with the other patches in this series as my later patches
depend on patches in this series.

---
 drivers/i2c/busses/i2c-omap.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9967a6f..f04afd1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1037,6 +1037,20 @@ static const struct i2c_algorithm omap_i2c_algo = {
 };
 
 #ifdef CONFIG_OF
+static struct omap_i2c_bus_platform_data omap2420_pdata = {
+	.rev = OMAP_I2C_IP_VERSION_1,
+	.flags = OMAP_I2C_FLAG_NO_FIFO |
+			OMAP_I2C_FLAG_SIMPLE_CLOCK |
+			OMAP_I2C_FLAG_16BIT_DATA_REG |
+			OMAP_I2C_FLAG_BUS_SHIFT_2,
+};
+
+static struct omap_i2c_bus_platform_data omap2430_pdata = {
+	.rev = OMAP_I2C_IP_VERSION_1,
+	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2 |
+			OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
+};
+
 static struct omap_i2c_bus_platform_data omap3_pdata = {
 	.rev = OMAP_I2C_IP_VERSION_1,
 	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2,
@@ -1055,6 +1069,14 @@ static const struct of_device_id omap_i2c_of_match[] = {
 		.compatible = "ti,omap3-i2c",
 		.data = &omap3_pdata,
 	},
+	{
+		.compatible = "ti,omap2430-i2c",
+		.data = &omap2430_pdata,
+	},
+	{
+		.compatible = "ti,omap2420-i2c",
+		.data = &omap2420_pdata,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
-- 
1.8.1.1
