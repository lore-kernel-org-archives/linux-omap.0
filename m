From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 7/8] ARM: OMAP: convert I2C driver to PM QoS for latency
 constraints
Date: Tue, 18 Sep 2012 11:53:16 +0300
Message-ID: <20120918085314.GB22993@arwen.pp.htv.fi>
References: <1347958332-2205-1-git-send-email-j-pihet@ti.com>
 <1347958332-2205-8-git-send-email-j-pihet@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:44439 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932168Ab2IRI6A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Sep 2012 04:58:00 -0400
Received: by lagy9 with SMTP id y9so4782622lag.19
        for <linux-omap@vger.kernel.org>; Tue, 18 Sep 2012 01:57:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1347958332-2205-8-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Jean Pihet <j-pihet@ti.com>, Shubhrajyoti Datta <shubhrajyoti@ti.com>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 18, 2012 at 10:52:11AM +0200, Jean Pihet wrote:
> Convert the driver from the outdated omap_pm_set_max_mpu_wakeup_lat
> API to the new PM QoS API.
> Since the constraint is on the MPU subsystem, use the PM_QOS_CPU_DMA_LATE=
NCY
> class of PM QoS. The resulting MPU constraints are used by cpuidle to
> decide the next power state of the MPU subsystem.
>=20
> The I2C device latency timing is derived from the FIFO size and the
> clock speed and so is applicable to all OMAP SoCs.
>=20
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

this needs to be rebased on top of Wolfram's i2c-next branch which has a
big series of patches on top of the i2c driver.

Also, please keep Shubhro in Cc for any i2c and spi patches ;-)

> ---
>  arch/arm/plat-omap/i2c.c      |   21 ---------------------
>  drivers/i2c/busses/i2c-omap.c |   28 +++++++++++++++++-----------
>  include/linux/i2c-omap.h      |    1 -
>  3 files changed, 17 insertions(+), 33 deletions(-)
>=20
> diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
> index db071bc..dba8338 100644
> --- a/arch/arm/plat-omap/i2c.c
> +++ b/arch/arm/plat-omap/i2c.c
> @@ -26,7 +26,6 @@
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c-omap.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/clk.h>
> @@ -34,7 +33,6 @@
>  #include <mach/irqs.h>
>  #include <plat/mux.h>
>  #include <plat/i2c.h>
> -#include <plat/omap-pm.h>
>  #include <plat/omap_device.h>
> =20
>  #define OMAP_I2C_SIZE		0x3f
> @@ -129,16 +127,6 @@ static inline int omap1_i2c_add_bus(int bus_id)
> =20
> =20
>  #ifdef CONFIG_ARCH_OMAP2PLUS
> -/*
> - * XXX This function is a temporary compatibility wrapper - only
> - * needed until the I2C driver can be converted to call
> - * omap_pm_set_max_dev_wakeup_lat() and handle a return code.
> - */
> -static void omap_pm_set_max_mpu_wakeup_lat_compat(struct device *dev, lo=
ng t)
> -{
> -	omap_pm_set_max_mpu_wakeup_lat(dev, t);
> -}
> -
>  static inline int omap2_i2c_add_bus(int bus_id)
>  {
>  	int l;
> @@ -170,15 +158,6 @@ static inline int omap2_i2c_add_bus(int bus_id)
>  	dev_attr =3D (struct omap_i2c_dev_attr *)oh->dev_attr;
>  	pdata->flags =3D dev_attr->flags;
> =20
> -	/*
> -	 * When waiting for completion of a i2c transfer, we need to
> -	 * set a wake up latency constraint for the MPU. This is to
> -	 * ensure quick enough wakeup from idle, when transfer
> -	 * completes.
> -	 * Only omap3 has support for constraints
> -	 */
> -	if (cpu_is_omap34xx())
> -		pdata->set_mpu_wkup_lat =3D omap_pm_set_max_mpu_wakeup_lat_compat;
>  	pdev =3D omap_device_build(name, bus_id, oh, pdata,
>  			sizeof(struct omap_i2c_bus_platform_data),
>  			NULL, 0, 0);
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 5d19a49..bd45cee 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -43,6 +43,7 @@
>  #include <linux/slab.h>
>  #include <linux/i2c-omap.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_qos.h>
> =20
>  /* I2C controller revisions */
>  #define OMAP_I2C_OMAP1_REV_2		0x20
> @@ -183,8 +184,7 @@ struct omap_i2c_dev {
>  	struct completion	cmd_complete;
>  	struct resource		*ioarea;
>  	u32			latency;	/* maximum mpu wkup latency */
> -	void			(*set_mpu_wkup_lat)(struct device *dev,
> -						    long latency);
> +	struct pm_qos_request	pm_qos_request;
>  	u32			speed;		/* Speed of bus in kHz */
>  	u32			dtrev;		/* extra revision from DT */
>  	u32			flags;
> @@ -590,8 +590,16 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_m=
sg msgs[], int num)
>  	if (r < 0)
>  		goto out;
> =20
> -	if (dev->set_mpu_wkup_lat !=3D NULL)
> -		dev->set_mpu_wkup_lat(dev->dev, dev->latency);
> +	/*
> +	 * When waiting for completion of a i2c transfer, we need to
> +	 * set a wake up latency constraint for the MPU. This is to
> +	 * ensure quick enough wakeup from idle, when transfer
> +	 * completes.
> +	 */
> +	if (dev->latency)
> +		pm_qos_add_request(&dev->pm_qos_request,
> +				   PM_QOS_CPU_DMA_LATENCY,
> +				   dev->latency);
> =20
>  	for (i =3D 0; i < num; i++) {
>  		r =3D omap_i2c_xfer_msg(adap, &msgs[i], (i =3D=3D (num - 1)));
> @@ -599,8 +607,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_ms=
g msgs[], int num)
>  			break;
>  	}
> =20
> -	if (dev->set_mpu_wkup_lat !=3D NULL)
> -		dev->set_mpu_wkup_lat(dev->dev, -1);
> +	if (dev->latency)
> +		pm_qos_remove_request(&dev->pm_qos_request);
> =20
>  	if (r =3D=3D 0)
>  		r =3D num;
> @@ -989,7 +997,6 @@ omap_i2c_probe(struct platform_device *pdev)
>  	} else if (pdata !=3D NULL) {
>  		dev->speed =3D pdata->clkrate;
>  		dev->flags =3D pdata->flags;
> -		dev->set_mpu_wkup_lat =3D pdata->set_mpu_wkup_lat;
>  		dev->dtrev =3D pdata->rev;
>  	}
> =20
> @@ -1046,10 +1053,9 @@ omap_i2c_probe(struct platform_device *pdev)
>  		else
>  			dev->b_hw =3D 1; /* Enable hardware fixes */
> =20
> -		/* calculate wakeup latency constraint for MPU */
> -		if (dev->set_mpu_wkup_lat !=3D NULL)
> -			dev->latency =3D (1000000 * dev->fifo_size) /
> -				       (1000 * dev->speed / 8);
> +		/* calculate wakeup latency constraint */
> +		dev->latency =3D (1000000 * dev->fifo_size) /
> +			       (1000 * dev->speed / 8);
>  	}
> =20
>  	/* reset ASAP, clearing any IRQs */
> diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
> index 92a0dc7..df804ba 100644
> --- a/include/linux/i2c-omap.h
> +++ b/include/linux/i2c-omap.h
> @@ -34,7 +34,6 @@ struct omap_i2c_bus_platform_data {
>  	u32		clkrate;
>  	u32		rev;
>  	u32		flags;
> -	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
>  };
> =20
>  #endif
> --=20
> 1.7.7.6
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQWDZ6AAoJEIaOsuA1yqREID8P/3OiDdVHAIDtB+jZ86CK8TYM
vylHkdBHMvWVAqhJzELaooylR7OpnPoRSJVek9x/44I3TixioeBUgs8/csGGu6qw
qHp0XY6t4lla/r2cLyUZ6AqsXxmvRt+Yb9undnc21L3ADUJiorQiddn89cEMQrOh
ay/KvifDQWpDG0B/olahN40wpPNp5nR9Ms1ytnuXSwEVdAhaewsUB9Aathq0l/Xg
oyjieS5R4i6pjGf3yoJaEr9osS3lDhQbcp5hWbOGbT8eSmCf36JhxrNFulX3e30T
NFPrBMw8ck0jD4ijCgJY/WeAVNgEU9tERL8gh9UBSwE9pU/STg0CASK7tahUrJfk
2sX3RZCNwipH+CAJW/G3+cnifR3k96vyuLsVnryt2/TBKhebWbSBK42wBaOjjup6
SC+2ri1GQueHEXnpGJrg5HlDNj6IsMooYRwuCwF8kKyGLKRPXKftWgixjwkndfow
l922WxRnrf+GdCXQXNZu1yr2S/ranBdziQzC/qzZA5ujEbIdiGLEwtvtuyDYZRGj
AP+JzAhb6Gu2h366gvyE7a493Pnl/LZZA6lRjDq30yaFu2D1brMSayz/ug1nJmrv
encIawmxbBGafxuyw3vCNwOhndr4pR8GWCONXkyVd/c83Mc6CiSX5622gU6G+SJ3
Pyms5PYyb1VX9YHe8LTA
=lbM0
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
