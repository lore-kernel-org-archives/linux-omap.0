From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 4/7] ARM: i2c: omap: Remove the i207 errata flag
Date: Mon, 5 Nov 2012 09:53:51 +0200
Message-ID: <20121105075351.GE32468@arwen.pp.htv.fi>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-5-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352025873-27492-5-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2012 at 04:14:30PM +0530, Shubhrajyoti D wrote:
> The commit [i2c: omap: use revision check for OMAP_I2C_FLAG_APPLY_ERRATA_=
I207]
> uses the revision id instead of the flag. So the flag can be safely remov=
ed.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |    3 +--
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    9 +++------
>  drivers/i2c/busses/i2c-omap.c              |    3 +--
>  include/linux/i2c-omap.h                   |    1 -
>  4 files changed, 5 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-o=
map2/omap_hwmod_2430_data.c
> index c455e41..b79ccf6 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -76,8 +76,7 @@ static struct omap_hwmod_class i2c_class =3D {
> =20
>  static struct omap_i2c_dev_attr i2c_dev_attr =3D {
>  	.fifo_depth	=3D 8, /* bytes */
> -	.flags		=3D OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
> -			  OMAP_I2C_FLAG_BUS_SHIFT_2 |
> +	.flags		=3D OMAP_I2C_FLAG_BUS_SHIFT_2 |
>  			  OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
>  };
> =20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_3xxx_data.c
> index f67b7ee..943222c4 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -791,8 +791,7 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod =3D {
>  /* I2C1 */
>  static struct omap_i2c_dev_attr i2c1_dev_attr =3D {
>  	.fifo_depth	=3D 8, /* bytes */
> -	.flags		=3D OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
> -			  OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
> +	.flags		=3D OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
>  			  OMAP_I2C_FLAG_BUS_SHIFT_2,
>  };
> =20
> @@ -818,8 +817,7 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod =3D {
>  /* I2C2 */
>  static struct omap_i2c_dev_attr i2c2_dev_attr =3D {
>  	.fifo_depth	=3D 8, /* bytes */
> -	.flags =3D OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
> -		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
> +	.flags =3D OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
>  		 OMAP_I2C_FLAG_BUS_SHIFT_2,
>  };
> =20
> @@ -845,8 +843,7 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod =3D {
>  /* I2C3 */
>  static struct omap_i2c_dev_attr i2c3_dev_attr =3D {
>  	.fifo_depth	=3D 64, /* bytes */
> -	.flags =3D OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
> -		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
> +	.flags =3D OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
>  		 OMAP_I2C_FLAG_BUS_SHIFT_2,
>  };
> =20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index b62cd9d..8a54efc 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1029,8 +1029,7 @@ static const struct i2c_algorithm omap_i2c_algo =3D=
 {
>  #ifdef CONFIG_OF
>  static struct omap_i2c_bus_platform_data omap3_pdata =3D {
>  	.rev =3D OMAP_I2C_IP_VERSION_1,
> -	.flags =3D OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
> -		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
> +	.flags =3D OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
>  		 OMAP_I2C_FLAG_BUS_SHIFT_2,
>  };
> =20
> diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
> index df804ba..5c88187 100644
> --- a/include/linux/i2c-omap.h
> +++ b/include/linux/i2c-omap.h
> @@ -21,7 +21,6 @@
>  #define OMAP_I2C_FLAG_SIMPLE_CLOCK		BIT(1)
>  #define OMAP_I2C_FLAG_16BIT_DATA_REG		BIT(2)
>  #define OMAP_I2C_FLAG_RESET_REGS_POSTIDLE	BIT(3)
> -#define OMAP_I2C_FLAG_APPLY_ERRATA_I207	BIT(4)
>  #define OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK	BIT(5)
>  #define OMAP_I2C_FLAG_FORCE_19200_INT_CLK	BIT(6)
>  /* how the CPU address bus must be translated for I2C unit access */
> --=20
> 1.7.5.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl3CPAAoJEIaOsuA1yqREuRsQAK1fXrZcXfKb4gNfqpbBoUkh
ryZPEUBH9fRl3mQNx6VFe855CdfNqHR7e18Ag97P+ADv6qEFxjCSUfPb4fjmIYd2
/Wl6664EZpf0DK3VavAJGWnJk8LJOICmI8T+MJbar/McprrAUlxCKx2vsq6v+gNR
rrSgejacVSaQOq2hxA0oTlO1r4O9qm1PRWr+e3YjZsmZILP5v1frXA9TZul8AO4f
wzMj7q4Pkui/hvwkFK4pRpLU22xbsA5wFDgHBU4Ton6vDaFgkz2WT1dSCJuCahJ0
VNUxW8XlUoHiAxLwyT/ZW/UwmQqc1BsdvZL6mI5GcAu6sdZfbzOxEjr/fVtV3KE+
1qcUk8DIVF4GAm+OR8SR7WimGiPtWa3TTcOuGw1CP824dBTyU1FLAYgHPiiDPRcK
RP3ASiHts0AAhFcYX2zS48kb2qt+7kb4FOc8zn+KVfpumy1kDPRro5urMojStVy7
9eOlITWx151ehutc5armHT3ZWDyE3rSwWygOIbSUdgUMtHoeBE0ZHJH9bcILuuxF
8xLLvMokZ1V/2GbKjSB8WIu2QZRNyLYNF+S+mR8SBN8Qw2+j6hXo1EK0VNtmSSz3
2NY433Jyz6x78xe6IrxBrMmXAmf5XOigwuEREYCHDI4T74QPIER5nGoqLvlelWhv
Wvy+bzBfrA3wS+oghzSJ
=6mpD
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
