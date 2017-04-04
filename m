From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: [PATCH v4 2/8] mfd: retu: Drop -mfd suffix from I2C device ID name
Date: Tue,  4 Apr 2017 11:30:30 -0400
Message-ID: <20170404153036.6651-3-javier@osg.samsung.com>
References: <20170404153036.6651-1-javier@osg.samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170404153036.6651-1-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

It's not correct to encode the subsystem in the I2C device name, so
drop the -mfd suffix. To maintain bisect-ability, change driver and
platform code / DTS users in the same patch.

Suggested-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 4 ++--
 arch/arm/mach-omap1/board-nokia770.c        | 4 ++--
 drivers/mfd/retu-mfd.c                      | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
index 7e5ffc583c90..1b06430c8013 100644
--- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
+++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
@@ -15,8 +15,8 @@
 				>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			retu_mfd: retu@1 {
-				compatible = "retu-mfd";
+			retu: retu@1 {
+				compatible = "retu";
 				interrupt-parent = <&gpio4>;
 				interrupts = <12 IRQ_TYPE_EDGE_RISING>;
 				reg = <0x1>;
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index ee8d9f553db4..06243c0b12d2 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -233,10 +233,10 @@ static struct platform_device nokia770_cbus_device = {
 
 static struct i2c_board_info nokia770_i2c_board_info_2[] __initdata = {
 	{
-		I2C_BOARD_INFO("retu-mfd", 0x01),
+		I2C_BOARD_INFO("retu", 0x01),
 	},
 	{
-		I2C_BOARD_INFO("tahvo-mfd", 0x02),
+		I2C_BOARD_INFO("tahvo", 0x02),
 	},
 };
 
diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
index d4c114abeb75..53e1d386d2c0 100644
--- a/drivers/mfd/retu-mfd.c
+++ b/drivers/mfd/retu-mfd.c
@@ -302,8 +302,8 @@ static int retu_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id retu_id[] = {
-	{ "retu-mfd", 0 },
-	{ "tahvo-mfd", 0 },
+	{ "retu", 0 },
+	{ "tahvo", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, retu_id);
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
