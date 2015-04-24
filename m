From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3] watchdog: omap: put struct watchdog_device into
 driver data
Date: Fri, 24 Apr 2015 09:44:48 -0500
Message-ID: <20150424144448.GC5692@saruman.tx.rr.com>
References: <1429868913-24049-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1429868913-24049-3-git-send-email-u.kleine-koenig@pengutronix.de>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429868913-24049-3-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 11:48:32AM +0200, Uwe Kleine-K=F6nig wrote:
> This way only a single allocation is needed (per device). Also this
> stops making use of watchdog_{set,get}_drvdata.

And this is better because ... ?

Nothing against it, just feels like this commit log needs a little more
verbosity

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/watchdog/omap_wdt.c | 55 ++++++++++++++++++++-------------------=
------
>  1 file changed, 24 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 0eb9ca04e672..479e7c8e44f5 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -53,7 +53,10 @@ static unsigned timer_margin;
>  module_param(timer_margin, uint, 0);
>  MODULE_PARM_DESC(timer_margin, "initial watchdog timeout (in seconds)");
> =20
> +#define to_omap_wdt_dev(_wdog)	container_of(_wdog, struct omap_wdt_dev, =
wdog)
> +
>  struct omap_wdt_dev {
> +	struct watchdog_device wdog;
>  	void __iomem    *base;          /* physical */
>  	struct device   *dev;
>  	bool		omap_wdt_users;
> @@ -123,7 +126,7 @@ static void omap_wdt_set_timer(struct omap_wdt_dev *w=
dev,
> =20
>  static int omap_wdt_start(struct watchdog_device *wdog)
>  {
> -	struct omap_wdt_dev *wdev =3D watchdog_get_drvdata(wdog);
> +	struct omap_wdt_dev *wdev =3D to_omap_wdt_dev(wdog);
>  	void __iomem *base =3D wdev->base;
> =20
>  	mutex_lock(&wdev->lock);
> @@ -151,7 +154,7 @@ static int omap_wdt_start(struct watchdog_device *wdo=
g)
> =20
>  static int omap_wdt_stop(struct watchdog_device *wdog)
>  {
> -	struct omap_wdt_dev *wdev =3D watchdog_get_drvdata(wdog);
> +	struct omap_wdt_dev *wdev =3D to_omap_wdt_dev(wdog);
> =20
>  	mutex_lock(&wdev->lock);
>  	omap_wdt_disable(wdev);
> @@ -163,7 +166,7 @@ static int omap_wdt_stop(struct watchdog_device *wdog)
> =20
>  static int omap_wdt_ping(struct watchdog_device *wdog)
>  {
> -	struct omap_wdt_dev *wdev =3D watchdog_get_drvdata(wdog);
> +	struct omap_wdt_dev *wdev =3D to_omap_wdt_dev(wdog);
> =20
>  	mutex_lock(&wdev->lock);
>  	omap_wdt_reload(wdev);
> @@ -175,7 +178,7 @@ static int omap_wdt_ping(struct watchdog_device *wdog)
>  static int omap_wdt_set_timeout(struct watchdog_device *wdog,
>  				unsigned int timeout)
>  {
> -	struct omap_wdt_dev *wdev =3D watchdog_get_drvdata(wdog);
> +	struct omap_wdt_dev *wdev =3D to_omap_wdt_dev(wdog);
> =20
>  	mutex_lock(&wdev->lock);
>  	omap_wdt_disable(wdev);
> @@ -204,16 +207,11 @@ static const struct watchdog_ops omap_wdt_ops =3D {
>  static int omap_wdt_probe(struct platform_device *pdev)
>  {
>  	struct omap_wd_timer_platform_data *pdata =3D dev_get_platdata(&pdev->d=
ev);
> -	struct watchdog_device *omap_wdt;
>  	struct resource *res;
>  	struct omap_wdt_dev *wdev;
>  	u32 rs;
>  	int ret;
> =20
> -	omap_wdt =3D devm_kzalloc(&pdev->dev, sizeof(*omap_wdt), GFP_KERNEL);
> -	if (!omap_wdt)
> -		return -ENOMEM;
> -
>  	wdev =3D devm_kzalloc(&pdev->dev, sizeof(*wdev), GFP_KERNEL);
>  	if (!wdev)
>  		return -ENOMEM;
> @@ -229,18 +227,17 @@ static int omap_wdt_probe(struct platform_device *p=
dev)
>  	if (IS_ERR(wdev->base))
>  		return PTR_ERR(wdev->base);
> =20
> -	omap_wdt->info	      =3D &omap_wdt_info;
> -	omap_wdt->ops	      =3D &omap_wdt_ops;
> -	omap_wdt->min_timeout =3D TIMER_MARGIN_MIN;
> -	omap_wdt->max_timeout =3D TIMER_MARGIN_MAX;
> +	wdev->wdog.info =3D &omap_wdt_info;
> +	wdev->wdog.ops =3D &omap_wdt_ops;
> +	wdev->wdog.min_timeout =3D TIMER_MARGIN_MIN;
> +	wdev->wdog.max_timeout =3D TIMER_MARGIN_MAX;
> =20
> -	if (watchdog_init_timeout(omap_wdt, timer_margin, &pdev->dev) < 0)
> -		omap_wdt->timeout =3D TIMER_MARGIN_DEFAULT;
> +	if (watchdog_init_timeout(&wdev->wdog, timer_margin, &pdev->dev) < 0)
> +		wdev->wdog.timeout =3D TIMER_MARGIN_DEFAULT;
> =20
> -	watchdog_set_drvdata(omap_wdt, wdev);
> -	watchdog_set_nowayout(omap_wdt, nowayout);
> +	watchdog_set_nowayout(&wdev->wdog, nowayout);
> =20
> -	platform_set_drvdata(pdev, omap_wdt);
> +	platform_set_drvdata(pdev, wdev);
> =20
>  	pm_runtime_enable(wdev->dev);
>  	pm_runtime_get_sync(wdev->dev);
> @@ -249,12 +246,12 @@ static int omap_wdt_probe(struct platform_device *p=
dev)
>  		rs =3D pdata->read_reset_sources();
>  	else
>  		rs =3D 0;
> -	omap_wdt->bootstatus =3D (rs & (1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT)) ?
> -				WDIOF_CARDRESET : 0;
> +	wdev->wdog.bootstatus =3D (rs & (1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT)) ?
> +		WDIOF_CARDRESET : 0;
> =20
>  	omap_wdt_disable(wdev);
> =20
> -	ret =3D watchdog_register_device(omap_wdt);
> +	ret =3D watchdog_register_device(&wdev->wdog);
>  	if (ret) {
>  		pm_runtime_disable(wdev->dev);
>  		return ret;
> @@ -262,7 +259,7 @@ static int omap_wdt_probe(struct platform_device *pde=
v)
> =20
>  	pr_info("OMAP Watchdog Timer Rev 0x%02x: initial timeout %d sec\n",
>  		readl_relaxed(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
> -		omap_wdt->timeout);
> +		wdev->wdog.timeout);
> =20
>  	pm_runtime_put_sync(wdev->dev);
> =20
> @@ -271,8 +268,7 @@ static int omap_wdt_probe(struct platform_device *pde=
v)
> =20
>  static void omap_wdt_shutdown(struct platform_device *pdev)
>  {
> -	struct watchdog_device *wdog =3D platform_get_drvdata(pdev);
> -	struct omap_wdt_dev *wdev =3D watchdog_get_drvdata(wdog);
> +	struct omap_wdt_dev *wdev =3D platform_get_drvdata(pdev);
> =20
>  	mutex_lock(&wdev->lock);
>  	if (wdev->omap_wdt_users) {
> @@ -284,11 +280,10 @@ static void omap_wdt_shutdown(struct platform_devic=
e *pdev)
> =20
>  static int omap_wdt_remove(struct platform_device *pdev)
>  {
> -	struct watchdog_device *wdog =3D platform_get_drvdata(pdev);
> -	struct omap_wdt_dev *wdev =3D watchdog_get_drvdata(wdog);
> +	struct omap_wdt_dev *wdev =3D platform_get_drvdata(pdev);
> =20
>  	pm_runtime_disable(wdev->dev);
> -	watchdog_unregister_device(wdog);
> +	watchdog_unregister_device(&wdev->wdog);
> =20
>  	return 0;
>  }
> @@ -303,8 +298,7 @@ static int omap_wdt_remove(struct platform_device *pd=
ev)
> =20
>  static int omap_wdt_suspend(struct platform_device *pdev, pm_message_t s=
tate)
>  {
> -	struct watchdog_device *wdog =3D platform_get_drvdata(pdev);
> -	struct omap_wdt_dev *wdev =3D watchdog_get_drvdata(wdog);
> +	struct omap_wdt_dev *wdev =3D platform_get_drvdata(pdev);
> =20
>  	mutex_lock(&wdev->lock);
>  	if (wdev->omap_wdt_users) {
> @@ -318,8 +312,7 @@ static int omap_wdt_suspend(struct platform_device *p=
dev, pm_message_t state)
> =20
>  static int omap_wdt_resume(struct platform_device *pdev)
>  {
> -	struct watchdog_device *wdog =3D platform_get_drvdata(pdev);
> -	struct omap_wdt_dev *wdev =3D watchdog_get_drvdata(wdog);
> +	struct omap_wdt_dev *wdev =3D platform_get_drvdata(pdev);
> =20
>  	mutex_lock(&wdev->lock);
>  	if (wdev->omap_wdt_users) {
> --=20
> 2.1.4
>=20

--=20
balbi

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVOlbgAAoJEIaOsuA1yqREu3QP/AwZabspyLLJTPHbRxV4ypzH
KUbBkf2EpgvbAIgPXkrg3cMYImiXQ4gikODJMjW2O4xTE35QU9VggQoqs7r6CqC1
zCGvp+SyOwhTBv5izzr8a+sthc5x0i1f2H0b2vUsClLwDwFawMY/lh5RdFkxjYVR
NJ5nqYw3SbDofyNOxZNFqi9QEeNqcXMgNnDDamepkngjpBYTpno/XFNmrivBrdH4
eJndgOKErWbV4FnOF2PdA+sZhJApT4KSrOVBN9+++0/iBeRXehoYZ1HjP3hyE/Bv
HpMYMJuEWREJ2288nViP55pJ6i46adUBEZxE+Rim5Nu7liELPaaEAHwP/416hwbv
3q1exaellTydxl8jGvH1bHCaEFjp82pmaxS19HIf3dkd3yO5dxg8ZS7Ma6bC98gs
juB2fVXxi85qeeu2K/lfy2C+K0t0T5AixIqFdTmDHtPPIYWcepyUYUH0kl3dljcl
b7gVBOjRagu8FNXKkTCBauqf+/yR3pXhO5o4YxsNPgHjwGx2uinB9dHKnm3kWoNK
XMrLbyHyVkem9fAMLANokNypM9R/NLxg9ndXrEMn+50pkpGLeWmgCU4QL6EnowMc
hIagJBiid4H6mOq2qTUyav6I1w49ZhzRYKKP6J6+xIiMb3dHhUwYozDL5g9B4ZW0
Ia92yTVpyqEFLtkMcgDN
=o9Ug
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
