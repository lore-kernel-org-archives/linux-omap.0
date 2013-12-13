From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 7/7] usb: dwc3: exynos: add pm_runtime support
Date: Fri, 13 Dec 2013 13:56:18 -0600
Message-ID: <20131213195618.GG5292@saruman.home>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
 <1386884325-11440-8-git-send-email-balbi@ti.com>
 <000301cef7c0$640c1ce0$2c2456a0$%tikhomirov@samsung.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000301cef7c0$640c1ce0$2c2456a0$%tikhomirov@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Anton Tikhomirov <av.tikhomirov@samsung.com>
Cc: 'Felipe Balbi' <balbi@ti.com>, 'Linux USB Mailing List' <linux-usb@vger.kernel.org>, kgene.kim@samsung.com, 'Linux ARM Kernel Mailing List' <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, 'Linux OMAP Mailing List' <linux-omap@vger.kernel.org>, w-kwok2@ti.com, 'Santosh Shilimkar' <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2013 at 02:01:32PM +0900, Anton Tikhomirov wrote:
> Hi Felipe,
>=20
> > -static int dwc3_exynos_suspend(struct device *dev)
> > +static int __dwc3_exynos_suspend(struct dwc3_exynos *exynos)
> >  {
> > -	struct dwc3_exynos *exynos =3D dev_get_drvdata(dev);
> > -
> >  	clk_disable(exynos->clk);
> >=20
> >  	return 0;
> >  }
> >=20
> > +static int __dwc3_exynos_resume(struct dwc3_exynos *exynos)
> > +{
> > +	return clk_enable(exynos->clk);
> > +}
> > +
> > +static int dwc3_exynos_suspend(struct device *dev)
> > +{
> > +	struct dwc3_exynos *exynos =3D dev_get_drvdata(dev);
> > +
> > +	return __dwc3_exynos_suspend(exynos);
>=20
> If dwc3-exynos is runtime suspended, the clock will be disabled
> second time here (unbalanced clk_enable/clk_disable).

I don't get what you mean but there is something that probably needs
fixing, I guess below makes it better:

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index c93919a..1e5720a 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -218,6 +218,9 @@ static int dwc3_exynos_suspend(struct device *dev)
 {
 	struct dwc3_exynos *exynos =3D dev_get_drvdata(dev);
=20
+	if (pm_runtime_suspended(dev))
+		return 0;
+
 	return __dwc3_exynos_suspend(exynos);
 }
=20

Is that what you meant ?

--=20
balbi

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSq2ZiAAoJEIaOsuA1yqREYz0P/A13JjQgvKviMCxABNmxA/Ax
7c8jy717JmFktBBlnzeyK34CZ05V4UEg133C6OBNARnEDgfa17UUbvRwvOAF45dw
JV8ipQq1is4EyxWO3x6wyHHrx+UPL7ZAtow93xlUZ0qFQ6xx5uVxKBXI9POpDeKE
fb0uZNA87pLkOdG9PfaXBvFKGkACIDY9dOkbN21Qa1LTGAoKM0xI3V0PRxlMd/Ye
ctKs7HfyacWC9+Zl11E8JwsArbA7m2HKj2U+dUN5sUC/tYY1E5R/Sk0PEhxWvkbx
K0VaNoTyV+evIzQtAiAUE+bghPBVMwXJBPbyTWUnhLBGr2bOVuv5GiFESAxoVKE1
d1FD6SuWz5dLkEyz4nFDaoOdzZ5fqHQI6xlADl1980RCy1FU29aXhEU6f6FXG7HS
o+NnEmByFyQ0RPF25NJXsfhV+hXkyBGhA8wUhIpLbu/9xv5PBSoQ1rPgGEnz16nJ
Vsue6mtTVjJHslHpTktVMCGbxErHnOjRBkrAgMWvxPjQy0oHIz0eoyv0svpJ3Gnb
e4fnRb+oev95+/dtFrXRd+2jbjPirkn3HIoSwBQ2xpyhaxkR3iQwJ3d0G39prC7q
4tFuA3hD2iUHs2BOauCpTNwcQn/PCcldtRsygpJ8w/PveCnIqPSpKlJQL5+9L37t
A080d4GwnaSkvfs3Ua/t
=Sk3T
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--
