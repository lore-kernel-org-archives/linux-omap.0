From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] mfd: tps65010: fix init when the driver is built-in
Date: Tue, 12 Jan 2016 07:42:18 +0000
Message-ID: <20160112074218.GL19803@x1>
References: <1452541609-30689-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452541609-30689-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 11 Jan 2016, Aaro Koskinen wrote:

> tps65010 driver's initcall cannot succeed when the driver is built-in=
,
> because it expects that the I2C probe is completed at initcall time;
> this cannot happen as MFD is initialized before I2C. Also on systems
> where the chip is not present there is unnecessary 30 ms delay during
> the boot.
>=20
> Instead of waiting for probe to finish, just register the I2C device.
> If some boards need retry mechanism for startup glitches, that should=
 be
> done in the actual probe function. Also delete the driver banner mess=
age.
>=20
> The patch allows to use tps65010 again with OMAP1 (where it's require=
d
> to be built-in) and enables e.g. USB and LED functionality on OMAP591=
2 OSK.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>=20
> 	v2: Delete the banner message.
>=20
> 	v1: http://marc.info/?t=3D145220586400001&r=3D1&w=3D2
>=20
>  drivers/mfd/tps65010.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)

Corrected the subject line and applied.

> diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
> index 448f0a1..e40f8e6 100644
> --- a/drivers/mfd/tps65010.c
> +++ b/drivers/mfd/tps65010.c
> @@ -1059,26 +1059,7 @@ EXPORT_SYMBOL(tps65013_set_low_pwr);
> =20
>  static int __init tps_init(void)
>  {
> -	u32	tries =3D 3;
> -	int	status =3D -ENODEV;
> -
> -	printk(KERN_INFO "%s: version %s\n", DRIVER_NAME, DRIVER_VERSION);
> -
> -	/* some boards have startup glitches */
> -	while (tries--) {
> -		status =3D i2c_add_driver(&tps65010_driver);
> -		if (the_tps)
> -			break;
> -		i2c_del_driver(&tps65010_driver);
> -		if (!tries) {
> -			printk(KERN_ERR "%s: no chip?\n", DRIVER_NAME);
> -			return -ENODEV;
> -		}
> -		pr_debug("%s: re-probe ...\n", DRIVER_NAME);
> -		msleep(10);
> -	}
> -
> -	return status;
> +	return i2c_add_driver(&tps65010_driver);
>  }
>  /* NOTE:  this MUST be initialized before the other parts of the sys=
tem
>   * that rely on it ... but after the i2c bus on which this relies.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
