From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/3] watchdog: omap: simplify assignment of bootstatus
Date: Fri, 24 Apr 2015 09:45:32 -0500
Message-ID: <20150424144532.GD5692@saruman.tx.rr.com>
References: <1429868913-24049-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1429868913-24049-4-git-send-email-u.kleine-koenig@pengutronix.de>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429868913-24049-4-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 11:48:33AM +0200, Uwe Kleine-K=F6nig wrote:
> Instead of using an over-long expression involving the ?: operator use
> an if and intead of an else branch rely on the fact that the data
> structure was allocated using devm_kzalloc. This also allows to put the
> used helper variable into a more local scope.
>=20
> There is no functional change.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

looks good to me

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  drivers/watchdog/omap_wdt.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 479e7c8e44f5..0421c06a6cf0 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -209,7 +209,6 @@ static int omap_wdt_probe(struct platform_device *pde=
v)
>  	struct omap_wd_timer_platform_data *pdata =3D dev_get_platdata(&pdev->d=
ev);
>  	struct resource *res;
>  	struct omap_wdt_dev *wdev;
> -	u32 rs;
>  	int ret;
> =20
>  	wdev =3D devm_kzalloc(&pdev->dev, sizeof(*wdev), GFP_KERNEL);
> @@ -242,12 +241,11 @@ static int omap_wdt_probe(struct platform_device *p=
dev)
>  	pm_runtime_enable(wdev->dev);
>  	pm_runtime_get_sync(wdev->dev);
> =20
> -	if (pdata && pdata->read_reset_sources)
> -		rs =3D pdata->read_reset_sources();
> -	else
> -		rs =3D 0;
> -	wdev->wdog.bootstatus =3D (rs & (1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT)) ?
> -		WDIOF_CARDRESET : 0;
> +	if (pdata && pdata->read_reset_sources) {
> +		u32 rs =3D pdata->read_reset_sources();
> +		if (rs & (1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT))
> +			wdev->wdog.bootstatus =3D WDIOF_CARDRESET;
> +	}
> =20
>  	omap_wdt_disable(wdev);
> =20
> --=20
> 2.1.4
>=20

--=20
balbi

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVOlcMAAoJEIaOsuA1yqREOOAP/ja66r5RnDczZGDrHQqtuseq
T54b33cf4v/urnAer2lV+YwPrlsS3fsRweCeLb3C7WwYSUEw1eX93pzx87D1VSJK
dGlXm++Jm7B/Pa7LD0Oev/AD0qOaPK1Xf1oe1T1mxqIvvagc65//GPhbE8i9uxVK
QBnkmuLPnY7sFR0maKB/Fc+AM2+WPweYP2tDOKfmebrX1OfPUHqEz0uMKaz6YhpP
PP0J9FViuQ0L1uM9j80Zyo1Ma8h0FKylZmeCNg2NsNH7Mn4tBemEIhTc1AS1OrPD
UTHe5ilNwNGa0GvyJK7ie/OMpNo1nV3bMdzBx5aMjfiQ7ib81Rl52gda2PSo16gl
yDGGz0guDnx8YpAn8hxmpAYqLQYgLxBaTkvUzhPXy4h7sk1VmRIb8G9NxoRofB2n
wsD+6dP0tcMhTBwuMss825Wjiai+nIu0dbup2Yf8/2EzhUQGBoVFsIIl/4BGAVaM
59mvxrkusDoKMmSL3nvrrZi30KjAvMj2kElW6EegW9jEkrXrMHMaMBJCmRhDH+wD
m/qQ/2ijeOsm3Dr899djO6+sc1I+0VDK37x0WdDk7EFPswWY+aZfoXaCh3n++H2q
BJB2kWDUBxtxc8k8B4jfa3MWLHPwF9nnwEvYfqhvnQOrK84lDtsXOCiETdJ1nSX/
nvTiuPYYHqCg8398OBKj
=IPiQ
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
