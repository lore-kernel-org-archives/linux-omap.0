From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv10 5/7] I2C: OMAP: Remove the definition of
 SYSS_RESETDONE_MASK
Date: Mon, 25 Jun 2012 15:34:20 +0300
Message-ID: <20120625123419.GD30463@arwen.pp.htv.fi>
References: <1340622702-21622-1-git-send-email-shubhrajyoti@ti.com>
 <1340622702-21622-6-git-send-email-shubhrajyoti@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1340622702-21622-6-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 25, 2012 at 04:41:40PM +0530, Shubhrajyoti D wrote:
> Remove the definition of SYSS_RESETDONE_MASK and use the
> one in omap_hwmod.h.
>=20
> Also fixes the warning
>  CC      drivers/i2c/busses/i2c-omap.o
> drivers/i2c/busses/i2c-omap.c:163: warning: "SYSS_RESETDONE_MASK" redefin=
ed
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  drivers/i2c/busses/i2c-omap.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index f1109f4..8344ad030 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -159,9 +159,6 @@ enum {
>  #define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */
>  #endif
> =20
> -/* OCP_SYSSTATUS bit definitions */
> -#define SYSS_RESETDONE_MASK		(1 << 0)
> -
>  /* OCP_SYSCONFIG bit definitions */
>  #define SYSC_CLOCKACTIVITY_MASK		(0x3 << 8)
>  #define SYSC_SIDLEMODE_MASK		(0x3 << 3)
> --=20
> 1.7.5.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6FrLAAoJEIaOsuA1yqREGtcP/AwKPNBc/SN6190cOyRBPUIr
M+I91uRRBPkicvbEuwHqaiasy4YqcEGb/c07IsmtkFuPcfo7nvXQ1zcZ0RHi5Pvc
1PsnPT6FMU7ZljpIYLUgW9rS+nFAkXSn8+7rfb0xON0BhrTdV6TkrTUH4OqTD/fy
ply+pzitdmPkLk3nUPj7LYln7zeY2N5ksan6/YxZQLDY0I+oBM3bfDPHGzJfjwu6
k+ttdt1WnR+T2ls8PvwnodKVHRU/RXkYiWK+UfILyFE8uxj11/6cYPUzL4Djygkt
GOY+0sTwdNHPpOUnJSlXx0TAVNh8CfxUu1FDOVeIrr/wIZ9IRSPc5y3YMhzPbQ3p
rO8ZEK739LVS6eysp7+RekXzk62lFPWvItR0RCegV6Hi+KCwU0VYIN26Ticv+uEo
24pFufdsqek//Rz77GONA6Cv18M+pGoA26ihj63ueHNc6oZaggWRsmRLiAhxuWtX
RJnAh2WFelBXDJBKKHBtzdvtMCrjq+5UbR74Je3g2TMqmCcG/VpjEmpt0RVr154l
j4GPhqYclvIwEEAIWHR/QYDNiEErtRfa9mjPwT+x9O5GJNv0ZE7ssuzsQsdgwIPC
wRcwsPADowmfpoRlDeDpWZ4gJyoyBNi23XaA4I2fzcUpfmjdZY9SdQyIPg2KypLF
vYPS/ZyDsxCdib31dnSe
=/Gna
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
