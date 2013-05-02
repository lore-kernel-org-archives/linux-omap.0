From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP-USB: Fix possible memory leak
Date: Thu, 2 May 2013 19:40:58 +0300
Message-ID: <20130502164058.GC8577@arwen.pp.htv.fi>
References: <1367510596-27780-1-git-send-email-shc_work@mail.ru>
 <20130502162433.GA10016@kahuna>
 <1367512124.978518915@f372.mail.ru>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56810 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758913Ab3EBQlb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 May 2013 12:41:31 -0400
Content-Disposition: inline
In-Reply-To: <1367512124.978518915@f372.mail.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org

--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 02, 2013 at 08:28:44PM +0400, Alexander Shiyan wrote:
> > On 20:03-20130502, Alexander Shiyan wrote:
> > >=20
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > ---
> > >  arch/arm/mach-omap2/usb-host.c | 21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb=
-host.c
> > > index aa27d7f..8d17a0d 100644
> > > --- a/arch/arm/mach-omap2/usb-host.c
> > > +++ b/arch/arm/mach-omap2/usb-host.c
> > > @@ -570,8 +570,10 @@ static int usbhs_add_regulator(char *name, char =
*dev_id, char *dev_supply,
> > >  	supplies->dev_name =3D dev_id;
> > > =20
> > >  	reg_data =3D kzalloc(sizeof(*reg_data), GFP_KERNEL);
> > > -	if (!reg_data)
> > > +	if (!reg_data) {
> > > +		kfree(supplies);
> > >  		return -ENOMEM;
> > > +	}
> > > =20
> > >  	reg_data->constraints.valid_ops_mask =3D REGULATOR_CHANGE_STATUS;
> > >  	reg_data->consumer_supplies =3D supplies;
> > > @@ -579,8 +581,11 @@ static int usbhs_add_regulator(char *name, char =
*dev_id, char *dev_supply,
> > > =20
> > >  	config =3D kmemdup(&hsusb_reg_config, sizeof(hsusb_reg_config),
> > >  			GFP_KERNEL);
> > > -	if (!config)
> > > +	if (!config) {
> > > +		kfree(supplies);
> > > +		kfree(reg_data);
> > >  		return -ENOMEM;
> > > +	}
> > > =20
> > >  	config->supply_name =3D name;
> > >  	config->gpio =3D gpio;
> > > @@ -589,17 +594,25 @@ static int usbhs_add_regulator(char *name, char=
 *dev_id, char *dev_supply,
> > > =20
> > >  	/* create a regulator device */
> > >  	pdev =3D kzalloc(sizeof(*pdev), GFP_KERNEL);
> > > -	if (!pdev)
> > > +	if (!pdev) {
> > > +		kfree(supplies);
> > > +		kfree(reg_data);
> > > +		kfree(config);
> > >  		return -ENOMEM;
> > > +	}
> > > =20
> > >  	pdev->id =3D PLATFORM_DEVID_AUTO;
> > >  	pdev->name =3D reg_name;
> > >  	pdev->dev.platform_data =3D config;
> > > =20
> > >  	ret =3D platform_device_register(pdev);
> > > -	if (ret)
> > > +	if (ret) {
> > >  		pr_err("%s: Failed registering regulator %s for %s\n",
> > >  				__func__, name, dev_id);
> > > +		kfree(supplies);
> > > +		kfree(reg_data);
> > > +		kfree(config);
> > > +	}
> >=20
> > Might be better to switch to devm_XXX managed functions?

I don't think it makes sense since the platform_device hasn't been
registered yet.

Still, patch can be improved with proper goto labels instead of
sprinkling different kfree() calls in every single error branch.

> If anyone can rewrite driver to use devm_xx, it would have been better.
> I'm not going to redo the patch yet, let it be so, I just showed a point
> for OMAP-developers.

fair enough.

--=20
balbi

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRgpcaAAoJEIaOsuA1yqREUTkQAJ74Ftx6VhF7DSdeTmqzH8pC
XP5IVzXSUIU/TjUtqW4o+HnZsZNgCA7bho60nq/HF+7RNtjd1mkpguD33Ez5FLW5
OaUcNZPLzXUJP1Cllq6KV8Zr70jcenpa4oflwGxTF9yrUoyfg7MZUP+lif22IfyJ
KPiBJlJS/oN6zItMdz+yGn0GuH20hMvKBcT73dU1oXJzI6BzDcMgSOyMBFo/VVMK
lsvuOtMgJ5HVQy2Yfpb2Mp10f0wSDGDrsr+E9Q/1wQ6sE5KVMCqFeSvIljhGGyuR
4ykmk+W6m+ygxyW8S2DxNAhlo6tXg+4cbFH+WREGtMwh+8Km+T+l+OMRVVaVk59F
8ehFuU0QvSdTUGa6gE+H6N1VVJln2EdOTnoqTjcPdMI0FrDl1tUCJXdi3TLS84uq
17dLBkKiR9EvNkp+NOMJ9Mvuy7tGV5G1LnWbYXjtqNkIuzsrAVTHulfrXorO+QZ7
ZDFdEZtcIBj+pqjx+bvAU+pFDvxl++TDEV9k08yOuE4acOa+Kthz0MVtuTZ0FVQr
q6hLa8pXm4Pq6BUqmfVpZTq3trkqZhJgo1OnWzQzzMCV2EyQ+XWy/N4NJ5hU4x0p
hP7kBosteWL54vLCDGrI5VpJXZVovBf+5s3awxwmfo+DLZnjscWMEWPqxTmG1DNK
J1oJ/tX5FDEFmR12pZo1
=wzP9
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
