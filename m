From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c: omap: cleanup register definitions
Date: Fri, 21 Nov 2014 10:08:02 -0600
Message-ID: <20141121160802.GL7508@saruman>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com>
 <1416518925-20679-2-git-send-email-al.kochet@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O8/n5iBOhiUtMkxf"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416518925-20679-2-git-send-email-al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--O8/n5iBOhiUtMkxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2014 at 01:28:42AM +0400, Alexander Kochetkov wrote:
> Delete STAT_AD0 mask as unrelated to current IP (omap1?).
> Delete DEBUG conditional around SYSTEST masks group.
> Add SYSTEST functional mode masks for SCL and SDA.
> Add STAT_BF mask.
>=20
> Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Tested on BBB and AM437x Starter Kit

Tested-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  drivers/i2c/busses/i2c-omap.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 9af7095..a021733 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -102,7 +102,7 @@ enum {
>  #define OMAP_I2C_STAT_ROVR	(1 << 11)	/* Receive overrun */
>  #define OMAP_I2C_STAT_XUDF	(1 << 10)	/* Transmit underflow */
>  #define OMAP_I2C_STAT_AAS	(1 << 9)	/* Address as slave */
> -#define OMAP_I2C_STAT_AD0	(1 << 8)	/* Address zero */
> +#define OMAP_I2C_STAT_BF	(1 << 8)	/* Bus Free */
>  #define OMAP_I2C_STAT_XRDY	(1 << 4)	/* Transmit data ready */
>  #define OMAP_I2C_STAT_RRDY	(1 << 3)	/* Receive data ready */
>  #define OMAP_I2C_STAT_ARDY	(1 << 2)	/* Register access ready */
> @@ -150,16 +150,20 @@ enum {
>  #define OMAP_I2C_SCLH_HSSCLH	8
> =20
>  /* I2C System Test Register (OMAP_I2C_SYSTEST): */
> -#ifdef DEBUG
>  #define OMAP_I2C_SYSTEST_ST_EN		(1 << 15)	/* System test enable */
>  #define OMAP_I2C_SYSTEST_FREE		(1 << 14)	/* Free running mode */
>  #define OMAP_I2C_SYSTEST_TMODE_MASK	(3 << 12)	/* Test mode select */
>  #define OMAP_I2C_SYSTEST_TMODE_SHIFT	(12)		/* Test mode select */
> +/* Functional mode */
> +#define OMAP_I2C_SYSTEST_SCL_I_FUNC	(1 << 8)	/* SCL line input value */
> +#define OMAP_I2C_SYSTEST_SCL_O_FUNC	(1 << 7)	/* SCL line output value */
> +#define OMAP_I2C_SYSTEST_SDA_I_FUNC	(1 << 6)	/* SDA line input value */
> +#define OMAP_I2C_SYSTEST_SDA_O_FUNC	(1 << 5)	/* SDA line output value */
> +/* SDA/SCL IO mode */
>  #define OMAP_I2C_SYSTEST_SCL_I		(1 << 3)	/* SCL line sense in */
>  #define OMAP_I2C_SYSTEST_SCL_O		(1 << 2)	/* SCL line drive out */
>  #define OMAP_I2C_SYSTEST_SDA_I		(1 << 1)	/* SDA line sense in */
>  #define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */
> -#endif
> =20
>  /* OCP_SYSSTATUS bit definitions */
>  #define SYSS_RESETDONE_MASK		(1 << 0)
> --=20
> 1.7.9.5
>=20

--=20
balbi

--O8/n5iBOhiUtMkxf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUb2NiAAoJEIaOsuA1yqREBbcP/2WqHMLP5DcV2R4qU0qiLS12
WYJrwZQ6omjYBFbyPxn9yucTJVJfm64lfMuZhBQu0nxPPu/L6CYntGZtWWkKr3o9
3cw+8rrEUvLP/Qi5N5uwXQlrIWcBSh2rLvXcxwjaQjTi7wjcWD/7EiPGt5Fd4hml
3cwLpEoVD80r+LVTNASF3EgiOBBs2KGIO+xyY/6bLd33YvZHW0LdOI+Cv2UB1PRI
/c8L+4um64b1SawF4KUPBosffMigsoQoWQO7kU5pQ6j4KTOOoEW7tvu1isFORZJD
QBji5wzD93wEQknwK6tZKiRj+tltQMTrN470DpxazU6WjlfksxaMBs6KMN+dmpJX
YM5RSy6s4+wjTb1XBd5sDuBF2jhBExEiWDXk61NiWGv0zIuR2kTsqRYFTN4mVaRH
ASINFVOZ+iUEa2HgzHP64zTJ/37ojKzTSChRu1OM/9XGD4PVYumBgGYwkSOalZz/
mjaDSWhkQnqwti3VPgm+5rK91l9i8Syhj4yz0TonfUiD00okfMDEDgA3zMxicZr6
4PToiHOzPb7GjRJATkHznlufTxDxdo1peENvRjkztW3JzE+3CyiD15y5PLxHiDQk
+okNIv/a+Zw7V7J6Wv9uJ20GJMXe7bPIkPIqI6ufah4t04owQWP6KSe9BvJAWMVk
eegSjETnxL/E+En7dUGB
=jOuM
-----END PGP SIGNATURE-----

--O8/n5iBOhiUtMkxf--
