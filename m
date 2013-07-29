From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 1/3] Input: omap-keypad: Enable wakeup capability for
 keypad.
Date: Mon, 29 Jul 2013 22:13:24 +0300
Message-ID: <20130729191324.GA5767@radagast>
References: <1375116311-13999-1-git-send-email-illia.smyrnov@ti.com>
 <1375116311-13999-2-git-send-email-illia.smyrnov@ti.com>
 <20130729180441.GF4964@radagast>
 <7605900.g1IUvSbegi@dtor-d630.eng.vmware.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7605900.g1IUvSbegi@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: balbi@ti.com, Illia Smyrnov <illia.smyrnov@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 29, 2013 at 11:59:45AM -0700, Dmitry Torokhov wrote:
> > > @@ -439,12 +444,50 @@ static const struct of_device_id
> > > omap_keypad_dt_match[] =3D {>=20
> > >  MODULE_DEVICE_TABLE(of, omap_keypad_dt_match);
> > >  #endif
> > >=20
> > > +#ifdef CONFIG_PM_SLEEP
> > > +static int omap4_keypad_suspend(struct device *dev)
> > > +{
> > > +	struct platform_device *pdev =3D to_platform_device(dev);
> >=20
> > you don't need to access the platform_device...
> >=20
> > > +	struct omap4_keypad *keypad_data =3D platform_get_drvdata(pdev);
> >=20
> > ... since this can become:
> >=20
> > 	struct omap4_keypad *keypad_data =3D dev_get_drvdata(dev);
>=20
> No, please use correct accessors for the objects. Platform drivers deal
> with platform devices and I prefer using platform_get_drvdata() on them.

The argument to this function is a struct device, you prefer to do some
pointer math to find the containing pdev, then deref that back to dev,
then to struct device_private and further to driver_data ?

Sounds like a waste of time IMHO. You already have the device pointer
anyway, why would you go through the trouble of calculating the
offsets for the containing struct platform_device ?

--=20
balbi

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR9r7UAAoJEIaOsuA1yqREkggP/iiERtPLwunMhErndHzQqrNu
CIp+cZBCCn/2Iabixd++HZZFnvkevY+pOe87LOgX6a7sw2OpURQgIYxogZwglUpF
XkS0R8RQnc2+AZVxUPIG0POlahNh7oOOAWnms5k0yifVa350GckrFMiNbjuLwbdr
HdZiYttMqdTPAnbn8MzeoSaFfMixnOqQIY+0WDWEafLVLFYrFikWmzRWJN2ZnB1h
tr/bqCbvyxUVxFpxRegA4Y9MLB17J9Le1vlywuzHiiCEzytwRMROq16MxiBCNTdJ
7ZP5scAxzkSIrGxDEA66NarKWXS5MJJeFz+gDd7qeVxgeAcCGEo9sU0ilPasF/Mt
CTQFRuDzE5KkVAsYrupXgqPmSxXZmaVViFdXnVcGHoit/zMeTXk94XyRLsLjiBr6
CfOVtYvj8bjRS0mXlbFJiqHf79fC73B4Wau7hO1gWhnJ5Qj/fnUuOjOsyvguqPzT
Rk4lO1JVqSA6mBmeJj618UoQAWdsushSa8seTdlmlTUr7ZKc+S75fIZKWTcVFdlz
ZcXp9IDmob4ZWNTaCmQR2LDjV/Dgv65ZIzwxkjuP2ASoFHe9t6gI3jRVTzz4EPcP
AiQQJwMHsHaaXnyrW/NlStayDnREZ8/7aEDugWsQoZ/5x5Y0qQMcn2OOvUy5rPi1
nFV3N59npJklwg95kYNL
=VlHl
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
