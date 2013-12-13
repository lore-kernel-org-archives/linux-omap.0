From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 7/7] usb: dwc3: exynos: add pm_runtime support
Date: Fri, 13 Dec 2013 14:18:31 -0600
Message-ID: <20131213201831.GJ5292@saruman.home>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
 <1386884325-11440-8-git-send-email-balbi@ti.com>
 <000301cef7c0$640c1ce0$2c2456a0$%tikhomirov@samsung.com>
 <20131213195618.GG5292@saruman.home>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/0U0QBNx7JIUZLHm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42257 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796Ab3LMUT2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Dec 2013 15:19:28 -0500
Content-Disposition: inline
In-Reply-To: <20131213195618.GG5292@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Anton Tikhomirov <av.tikhomirov@samsung.com>, 'Linux USB Mailing List' <linux-usb@vger.kernel.org>, kgene.kim@samsung.com, 'Linux ARM Kernel Mailing List' <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, 'Linux OMAP Mailing List' <linux-omap@vger.kernel.org>, w-kwok2@ti.com, 'Santosh Shilimkar' <santosh.shilimkar@ti.com>

--/0U0QBNx7JIUZLHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2013 at 01:56:18PM -0600, Felipe Balbi wrote:
> On Fri, Dec 13, 2013 at 02:01:32PM +0900, Anton Tikhomirov wrote:
> > Hi Felipe,
> >=20
> > > -static int dwc3_exynos_suspend(struct device *dev)
> > > +static int __dwc3_exynos_suspend(struct dwc3_exynos *exynos)
> > >  {
> > > -	struct dwc3_exynos *exynos =3D dev_get_drvdata(dev);
> > > -
> > >  	clk_disable(exynos->clk);
> > >=20
> > >  	return 0;
> > >  }
> > >=20
> > > +static int __dwc3_exynos_resume(struct dwc3_exynos *exynos)
> > > +{
> > > +	return clk_enable(exynos->clk);
> > > +}
> > > +
> > > +static int dwc3_exynos_suspend(struct device *dev)
> > > +{
> > > +	struct dwc3_exynos *exynos =3D dev_get_drvdata(dev);
> > > +
> > > +	return __dwc3_exynos_suspend(exynos);
> >=20
> > If dwc3-exynos is runtime suspended, the clock will be disabled
> > second time here (unbalanced clk_enable/clk_disable).
>=20
> I don't get what you mean but there is something that probably needs
> fixing, I guess below makes it better:
>=20
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exyno=
s.c
> index c93919a..1e5720a 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -218,6 +218,9 @@ static int dwc3_exynos_suspend(struct device *dev)
>  {
>  	struct dwc3_exynos *exynos =3D dev_get_drvdata(dev);
> =20
> +	if (pm_runtime_suspended(dev))
> +		return 0;
> +
>  	return __dwc3_exynos_suspend(exynos);
>  }
> =20
>=20
> Is that what you meant ?

note, however, that this is *not* a case where we would fall today. See
that we pm_runtime_get() in probe and only pm_runtime_put() during
remove. So there would never be a case where we would try system suspend
while device was already runtime suspended.

I have fixed all patches in my testing/next branch anyway, just to make
sure we're "idiot-proof" when it comes to implementing real runtime pm
later on :-)

cheers

--=20
balbi

--/0U0QBNx7JIUZLHm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSq2uXAAoJEIaOsuA1yqREqH8P/Rny+20i268VWDejKoA6iw7t
jpDtGP85v05bxSPsnIytVgLyhb4HQTm+5OY5BhEC7pBVu4TCKMxbp5zVnpmmVDWK
69AWI0+7+6FgD3RBxuuS/h3kV942GuHstIFqwBAHqU5PlpYLf8efstGzrvTDZdrX
+gscjl4W4BEV21QD7yYtBJmFqUZs8eW5tEr4Rnz63mTAw7tN5/895QhbcCpH/z8g
yiGtwUJyeZPwao8svUhiz8JCjLF1wslf2eH76++jtMVMnRoTtVqfmBvtyEcWlQar
yjEiJErfZFdMkvH/gkAfXM4VH7PrpUqDdXDH+aXgS1K0ORneRLnULp0ZxEqfK1o9
pNaUdjW6igJmij5aYWTGE8PrMai0U2E2XHHscCkMuTPm/N591zK2FYrTgCzlAOmh
VaDA7yHImMgPLl89AYhbZv9qeCNijQJZ9CDYAeLo8AJC+1x7teOI9M375K0iarBW
Xut6HhcLiENV2r+b1xp0Ow2TOj/8zesu0nx12NlwGZKUT6MLSNt5y9aQCFfFizmQ
YrP+8Ku4vdbA2CENMhYgvSh7/cJU1cenSxRSS8iHBRs9LutsMHTJ2vbIY+DreTyU
M4ODWASTd0V2RoW/wlI1lO3gDXXz5N3StCjprrnx8w5VlJ/yAOQai3aQcVDxfQgr
bjTPoCmk00nHjJo7623e
=yFsK
-----END PGP SIGNATURE-----

--/0U0QBNx7JIUZLHm--
