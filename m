From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAPFB: panel-sony-acx565akm: fix bad unlock balance
Date: Mon, 11 Nov 2013 15:37:37 +0200
Message-ID: <5280DDA1.304@ti.com>
References: <1383773070-15114-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="awI1fkDkr69ApOfIR6Aw8NIK3NtIcSTsj"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1383773070-15114-1-git-send-email-aaro.koskinen@iki.fi>
Sender: stable-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--awI1fkDkr69ApOfIR6Aw8NIK3NtIcSTsj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-11-06 23:24, Aaro Koskinen wrote:
> When booting Nokia N900 smartphone with v3.12 + omap2plus_defconfig
> (LOCKDEP enabled) and CONFIG_DISPLAY_PANEL_SONY_ACX565AKM enabled,
> the following BUG is seen during the boot:
>=20
> [    7.302154] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    7.307128] [ BUG: bad unlock balance detected! ]
> [    7.312103] 3.12.0-los.git-2093492-00120-g5e01dc7 #3 Not tainted
> [    7.318450] -------------------------------------
> [    7.323425] kworker/u2:1/12 is trying to release lock (&ddata->mutex=
) at:
> [    7.330657] [<c031b760>] acx565akm_enable+0x12c/0x18c
> [    7.335998] but there are no more locks to release!
>=20
> Fix by removing the extra mutex_unlock().
>=20
> Reported-by: Eduardo Valentin <eduardo.valentin@ti.com>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: stable@vger.kernel.org
> ---
>  drivers/video/omap2/displays-new/panel-sony-acx565akm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c b/=
drivers/video/omap2/displays-new/panel-sony-acx565akm.c
> index e6d56f7..72fe2a8 100644
> --- a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
> +++ b/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
> @@ -616,7 +616,7 @@ static int acx565akm_enable(struct omap_dss_device =
*dssdev)
> =20
>  	mutex_lock(&ddata->mutex);
>  	r =3D acx565akm_panel_power_on(dssdev);
> -	mutex_unlock(&ddata->mutex);
> +	/* NOTE: acx565akm_panel_power_on() will unlock the mutex. */
> =20
>  	if (r)
>  		return r;
>=20

Hm why would you fix it like this? Why not remove the mutex_unlock from
acx565akm_panel_power_on()? Looks to me like that one is the buggy one.

 Tomi



--awI1fkDkr69ApOfIR6Aw8NIK3NtIcSTsj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSgN2hAAoJEPo9qoy8lh71gLYP/iBZOiEpbDmNn69QwGFpufDb
l77JHgGgYpNrJTiGVVuhUl60AbeHZ8JA3IsE9DmClF59MvqemKSJIkDSAwyFS5c+
n8kR3Q5uxJ6ZY0TZrbD+lWgAIhgW9YHYRuBY1HPKYzCpnW3U1oHKb6K+XW1GJY5x
ktemJ6xRbNzLtTaohE+X5O2rGWOi77MwtYoYSkvx5FiBMuTRdmtnf79Q2Ez+UvMT
FY5+3stP64pYbUf4N5R3dWK5fC2dEAZUefqCdOjjgZRzbUB4lBFLhN5pVwNEPNaD
nCEvxHPymkvRXztKRlYkkjyYqSppqZUPRGRsZl/Mok7T1NjNXifRxkOzDCpV9k/N
Mo6ibsvriXoidER/dqodBToezPOfXx1idk93C25aunbOul4MpgQe5cdulQ53w3bM
7dqSHj4G32Jz5sig/NJeZkUIJ5J86TpyCx2Bmus1p1giRWG7qpvpEtSR1cHMxyv0
TU3zxIR5YaZ+TtLTOmwgkSnKinYRe4a9IIKxtYLsAsS0vxtx4qzG+RcFnMwkvzZn
3uy5ije8quUDntbV8Cqm6wdxqY5d/X0cGXB3Ul0RNEQR9Tay8J556a4EKEJYzfeE
qtWDLs0/ePFjCnW0QBYFzNpsunJFDiVbaCgRLs39a6sjE2/zRBOOwhXswrpc5JRA
1QWbZRJbXnVWsyF71EuS
=BLQS
-----END PGP SIGNATURE-----

--awI1fkDkr69ApOfIR6Aw8NIK3NtIcSTsj--
