From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH] i2c: tea5761: New-style i2c driver
Date: Fri, 28 Mar 2008 08:04:09 -0400
Message-ID: <1206705849-9645-2-git-send-email-edubezval@gmail.com>
References: <20080328133820.5a35eca0.jarkko.nikula@nokia.com>
 <1206705849-9645-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:39736 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694AbYC1MEQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 08:04:16 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2SC49cb023557
	for <linux-omap@vger.kernel.org>; Fri, 28 Mar 2008 14:04:13 +0200
In-Reply-To: <1206705849-9645-1-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

=46rom: Eduardo Valentin <eduardo.valentin@indt.org.br>

This patch updates the fm radio driver for tea5761 chip.
It also moves board dependent code to its correct board
file place.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 arch/arm/mach-omap2/board-n800.c    |   33 ++++++++
 drivers/media/radio/radio-tea5761.c |  140 ++-------------------------=
-------
 2 files changed, 42 insertions(+), 131 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/boa=
rd-n800.c
index 34f1c37..758e2c1 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -258,6 +258,33 @@ static void tsc2301_dev_init(void)
 	}
 }
=20
+static int __init tea5761_dev_init(void)
+{
+	const struct omap_tea5761_config *info;
+	int enable_gpio =3D 0;
+
+	info =3D omap_get_config(OMAP_TAG_TEA5761, struct omap_tea5761_config=
);
+	if (info)
+		enable_gpio =3D info->enable_gpio;
+
+	if (enable_gpio) {
+		pr_debug("Enabling tea5761 at GPIO %d\n",
+			 enable_gpio);
+
+		if (omap_request_gpio(enable_gpio) < 0) {
+			printk(KERN_ERR "Can't request GPIO %d\n",
+			       enable_gpio);
+			return -ENODEV;
+		}
+
+		omap_set_gpio_direction(enable_gpio, 0);
+		udelay(50);
+		omap_set_gpio_dataout(enable_gpio, 1);
+	}
+
+	return 0;
+}
+
 static struct omap2_mcspi_device_config tsc2301_mcspi_config =3D {
 	.turbo_mode	=3D 0,
 	.single_channel =3D 1,
@@ -470,6 +497,11 @@ static struct i2c_board_info __initdata n800_i2c_b=
oard_info_2[] =3D {
 		.platform_data =3D &n800_tcm825x_platform_data,
 	},
 #endif
+#if defined(CONFIG_RADIO_TEA5761) || defined(CONFIG_RADIO_TEA5761_MODU=
LE)
+	{
+		I2C_BOARD_INFO("tea5761", 0x10),
+	},
+#endif
 };
=20
 void __init nokia_n800_common_init(void)
@@ -500,6 +532,7 @@ static void __init nokia_n800_init(void)
 	n800_audio_init(&tsc2301_config);
 	n800_ts_set_config();
 	tsc2301_dev_init();
+	tea5761_dev_init();
 	omap_register_gpio_switches(n800_gpio_switches,
 				    ARRAY_SIZE(n800_gpio_switches));
 }
diff --git a/drivers/media/radio/radio-tea5761.c b/drivers/media/radio/=
radio-tea5761.c
index ac0f621..0fb0cdc 100644
--- a/drivers/media/radio/radio-tea5761.c
+++ b/drivers/media/radio/radio-tea5761.c
@@ -23,8 +23,6 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <media/v4l2-common.h>
-#include <asm/arch/gpio.h>
-#include <asm/arch/board.h>
=20
 #define DRIVER_NAME "tea5761"
=20
@@ -74,14 +72,6 @@
 #define TEA5761_FREQ_LOW	87500
 #define TEA5761_FREQ_HIGH	108000
=20
-/* Probe for TEA5761 twice since the version N4B seems to be
- * broken and needs two probes to be found */
-static unsigned short normal_i2c[] =3D {
-	TEA5761_I2C_ADDR, TEA5761_I2C_ADDR, I2C_CLIENT_END
-};
-
-I2C_CLIENT_INSMOD;
-
 struct tea5761_regs {
 	u16 intreg;
 	u16 frqset;
@@ -423,67 +413,22 @@ static struct video_device tea5761_video_device =3D=
 {
 	.release       =3D video_device_release
 };
=20
-static int tea5761_probe(struct i2c_adapter *adapter, int address,
-			  int kind)
+static int tea5761_i2c_driver_probe(struct i2c_client *client)
 {
-	struct i2c_client *client;
 	struct video_device *video_dev;
 	int err =3D 0;
-	static const char *client_name =3D "TEA5761 FM-Radio";
 	struct tea5761_device *tea =3D &tea5761;
-	struct tea5761_regs   *r =3D &tea->regs;
=20
 	mutex_init(&tea->mutex);
-        /* I2C detection and initialization */
-	client =3D kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
-	if (client =3D=3D NULL) {
-		dev_err(&adapter->dev, DRIVER_NAME
-			": couldn't allocate memory\n");
-		return -ENOMEM;
-	}
-	tea->i2c_dev =3D client;
=20
-	client->addr =3D address;
-	client->adapter =3D adapter;
-	client->driver =3D &tea5761_driver;
-	client->dev.driver =3D &tea5761_driver.driver;
-	client->flags =3D 0;
-	strlcpy(client->name, client_name, I2C_NAME_SIZE);
-
-	if (kind < 0) {
-		if (tea5761_read_regs(tea) < 0) {
-			dev_info(&client->dev,
-				 "chip read failed for %d-%04x\n",
-				 adapter->nr, address);
-			goto err_tea_dev;
-		}
-		if (r->chipid !=3D TEA5761_CHIPID) {
-			dev_info(&client->dev,
-				 "bad chipid (0x%04x) at %d-%04x\n",
-				 r->chipid, adapter->nr, address);
-			goto err_tea_dev;
-		}
-		if ((r->manid & 0x0fff) !=3D TEA5761_MANID) {
-			dev_info(&client->dev,
-				 "bad manid (0x%04x) at %d-%04x\n",
-				 r->manid, adapter->nr, address);
-			goto err_tea_dev;
-		}
-	}
-
-	err =3D i2c_attach_client(client);
-	if (err) {
-		dev_err(&client->dev, "couldn't attach to address %d-%04x\n",
-		        adapter->nr, address);
-		goto err_tea_dev;
-	}
+	tea->i2c_dev =3D client;
=20
 	/* V4L initialization */
 	video_dev =3D video_device_alloc();
 	if (video_dev =3D=3D NULL) {
 		dev_err(&client->dev, "couldn't allocate memory\n");
 		err =3D -ENOMEM;
-		goto err_i2c_attach;
+		goto exit;
 	}
 	tea->video_dev =3D video_dev;
=20
@@ -506,105 +451,39 @@ static int tea5761_probe(struct i2c_adapter *ada=
pter, int address,
 		goto err_video_alloc;
 	}
=20
-	dev_info(&client->dev, "tea5761 (version %d) detected at %d-%04x\n",
-		(tea->regs.manid >> 12) & 0xf, adapter->nr, address);
+	dev_info(&client->dev, "tea5761 (version %d) detected\n",
+		(tea->regs.manid >> 12) & 0xf);
=20
 	return 0;
=20
 err_video_alloc:
 	video_device_release(video_dev);
-err_i2c_attach:
-	i2c_detach_client(client);
-err_tea_dev:
+exit:
 	kfree(client);
 	return err;
 }
=20
-static int tea5761_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C))
-		return -EINVAL;
-
-	return i2c_probe(adapter, &addr_data, tea5761_probe);
-}
-
-static int tea5761_detach_client(struct i2c_client *client)
+static int tea5761_i2c_driver_remove(struct i2c_client *client)
 {
 	struct video_device *vd =3D i2c_get_clientdata(client);
=20
-	i2c_detach_client(client);
 	video_unregister_device(vd);
-	kfree(client);
=20
 	return 0;
 }
=20
 static struct i2c_driver tea5761_driver =3D {
-	.id		=3D I2C_DRIVERID_TUNER,
 	.driver =3D {
 		.name	=3D DRIVER_NAME,
 	},
-	.attach_adapter	=3D tea5761_attach_adapter,
-	.detach_client	=3D tea5761_detach_client,
+	.probe	=3D tea5761_i2c_driver_probe,
+	.remove =3D tea5761_i2c_driver_remove,
 };
=20
-#if CONFIG_ARCH_OMAP
-/* No way to pass platform device data. Enable here all the TEA5761
- * devices, since I2C address scanning will need them to respond.
- */
-static int enable_gpio;
-
-static int __init tea5761_dev_init(void)
-{
-	const struct omap_tea5761_config *info;
-
-	info =3D omap_get_config(OMAP_TAG_TEA5761, struct omap_tea5761_config=
);
-	if (info) {
-		enable_gpio =3D info->enable_gpio;
-	}
-
-	if (enable_gpio) {
-		pr_debug(DRIVER_NAME ": enabling tea5761 at GPIO %d\n",
-			 enable_gpio);
-
-		if (omap_request_gpio(enable_gpio) < 0) {
-			printk(KERN_ERR DRIVER_NAME ": can't request GPIO %d\n",
-			       enable_gpio);
-			return -ENODEV;
-		}
-
-		omap_set_gpio_direction(enable_gpio, 0);
-		udelay(50);
-		omap_set_gpio_dataout(enable_gpio, 1);
-	}
-
-	return 0;
-}
-
-static void __exit tea5761_dev_exit(void)
-{
-	if (enable_gpio) {
-		omap_set_gpio_dataout(enable_gpio, 0);
-		omap_free_gpio(enable_gpio);
-	}
-}
-#else
-static int __init tea5761_dev_init(void)
-{
-}
-
-static void __exit tea5761_dev_exit(void)
-{
-}
-#endif
-
 static int __init tea5761_init(void)
 {
 	int res;
=20
-	if ((res =3D tea5761_dev_init()) < 0)
-		return res;
-
 	if ((res =3D i2c_add_driver(&tea5761_driver))) {
 		printk(KERN_ERR DRIVER_NAME ": driver registration failed\n");
 		return res;
@@ -616,7 +495,6 @@ static int __init tea5761_init(void)
 static void __exit tea5761_exit(void)
 {
 	i2c_del_driver(&tea5761_driver);
-	tea5761_dev_exit();
 }
=20
 MODULE_AUTHOR("Timo Ter=E4s");
--=20
1.5.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
