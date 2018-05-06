From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Handling lm3559 flash on Motorola Droid 4 and others
Date: Sun, 6 May 2018 09:31:18 +0200
Message-ID: <20180506073118.GA6811@amd>
References: <20180505213951.GA4530@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180505213951.GA4530@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> It seems lm3559 flash driver is available on github (
> https://github.com/ZenfoneArea/android_kernel_asus_zenfone5/tree/master/l=
inux/modules/camera/drivers/media/i2c
> ) but there'll be some fun getting it cleaned up and merged.
>=20
> Did anyone start doing anything in that area? Is there possibly better
> source to start from?

It turned out to be easier than expected. Of course, using flash w/o
v4l will not be easy, but that's generic problem.

									Pavel

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/o=
map4-droid4-xt894.dts
index bdf73cb..45305e8 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -271,6 +271,34 @@
 	};
 };
=20
+&i2c3 {
+      rearcam: camera@36 {
+            compatible =3D "micron,ov8820";
+	    reg =3D <0x36>;
+	    clocks =3D <&auxclk1_ck>;
+	    clock-names =3D "xvclk";
+	    clock-frequency =3D <24000000>;
+	    power-gpios =3D <&gpio2 16 GPIO_ACTIVE_HIGH>, // gpio48
+	    		  <&gpio3 19 GPIO_ACTIVE_HIGH>, // gpio83
+			  <&gpio5 23 GPIO_ACTIVE_HIGH>; // gpio151
+      };
+      frontcam: camera@48 {
+       		compatible =3D "ovti,mt9m114";
+		reg =3D <0x48>;
+		clocks =3D <&auxclk2_ck>;
+		clock-names =3D "extclk";
+		clock-frequency =3D <24000000>;
+		power-gpios =3D <&gpio6 11 GPIO_ACTIVE_HIGH>, // gpio171
+			      <&gpio2 5 GPIO_ACTIVE_HIGH>; // gpio37
+		};
+	flashlight: flash@53 {
+ 	    compatible =3D "ti,lm3559";
+	    reg =3D <0x53>;
+	};
+};
+
+
+
 &keypad {
 	keypad,num-rows =3D <8>;
 	keypad,num-columns =3D <8>;
diff --git a/drivers/media/i2c/lm3560.c b/drivers/media/i2c/lm3560.c
index b600e03a..a9b2ba2 100644
--- a/drivers/media/i2c/lm3560.c
+++ b/drivers/media/i2c/lm3560.c
@@ -17,6 +17,8 @@
  * General Public License for more details.
  */
=20
+// Probably compatible with lm3559, too.
+
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
@@ -395,6 +397,22 @@ static int lm3560_init_device(struct lm3560_flash *fla=
sh)
 		return rval;
 	/* reset faults */
 	rval =3D regmap_read(flash->regmap, REG_FLAG, &reg_val);
+
+	printk("lm3560: Device initialized\n");
+
+	flash->led_mode =3D V4L2_FLASH_LED_MODE_TORCH;
+	rval =3D lm3560_mode_ctrl(flash);
+	rval =3D lm3560_torch_brt_ctrl(flash, 0, LM3560_TORCH_BRT_MIN);
+	rval =3D lm3560_torch_brt_ctrl(flash, 1, LM3560_TORCH_BRT_MIN);	=09
+
+	mdelay(1000);
+
+	rval =3D lm3560_torch_brt_ctrl(flash, 0, 0);
+	rval =3D lm3560_torch_brt_ctrl(flash, 1, 0);	=09
+=09
+	flash->led_mode =3D V4L2_FLASH_LED_MODE_NONE;
+	rval =3D lm3560_mode_ctrl(flash);
+=09
 	return rval;
 }
=20
@@ -405,6 +423,8 @@ static int lm3560_probe(struct i2c_client *client,
 	struct lm3560_platform_data *pdata =3D dev_get_platdata(&client->dev);
 	int rval;
=20
+	printk("3560: probe\n");
+
 	flash =3D devm_kzalloc(&client->dev, sizeof(*flash), GFP_KERNEL);
 	if (flash =3D=3D NULL)
 		return -ENOMEM;
@@ -417,17 +437,19 @@ static int lm3560_probe(struct i2c_client *client,
=20
 	/* if there is no platform data, use chip default value */
 	if (pdata =3D=3D NULL) {
+		printk("3560: no pdata\n");
+	=09
 		pdata =3D devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
 		if (pdata =3D=3D NULL)
 			return -ENODEV;
-		pdata->peak =3D LM3560_PEAK_3600mA;
-		pdata->max_flash_timeout =3D LM3560_FLASH_TOUT_MAX;
+		pdata->peak =3D LM3560_PEAK_1600mA;
+		pdata->max_flash_timeout =3D LM3560_FLASH_TOUT_MIN;
 		/* led 1 */
-		pdata->max_flash_brt[LM3560_LED0] =3D LM3560_FLASH_BRT_MAX;
-		pdata->max_torch_brt[LM3560_LED0] =3D LM3560_TORCH_BRT_MAX;
+		pdata->max_flash_brt[LM3560_LED0] =3D LM3560_FLASH_BRT_MIN;
+		pdata->max_torch_brt[LM3560_LED0] =3D LM3560_TORCH_BRT_MIN;
 		/* led 2 */
-		pdata->max_flash_brt[LM3560_LED1] =3D LM3560_FLASH_BRT_MAX;
-		pdata->max_torch_brt[LM3560_LED1] =3D LM3560_TORCH_BRT_MAX;
+		pdata->max_flash_brt[LM3560_LED1] =3D LM3560_FLASH_BRT_MIN;
+		pdata->max_torch_brt[LM3560_LED1] =3D LM3560_TORCH_BRT_MIN;
 	}
 	flash->pdata =3D pdata;
 	flash->dev =3D &client->dev;
@@ -466,6 +488,8 @@ static int lm3560_remove(struct i2c_client *client)
=20
 static const struct i2c_device_id lm3560_id_table[] =3D {
 	{LM3560_NAME, 0},
+	{"lm3559", 0},
+	{"ti,lm3559", 0},
 	{}
 };
=20



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrur0YACgkQMOfwapXb+vK2EwCeIGRJVP3ijtYcAvGnVTqdrKrb
McAAn1j5AeBXV6ql7EwjGYdIMPP6ZT/Q
=rlk1
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
