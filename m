From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 2/2 v2] pwm_bl: Add mandatory backlight enable regulator
Date: Wed, 13 Mar 2013 11:13:28 +0100
Message-ID: <20130313101328.GA28682@avionic-0098.mockup.avionic-design.de>
References: <1363126934-8754-1-git-send-email-achew@nvidia.com>
 <1363126934-8754-3-git-send-email-achew@nvidia.com>
 <51403F59.2090303@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60287 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755506Ab3CMKNl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Mar 2013 06:13:41 -0400
Content-Disposition: inline
In-Reply-To: <51403F59.2090303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Andrew Chew <achew@nvidia.com>, acourbot@nvidia.com, linux-omap@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2013 at 09:56:57AM +0100, Peter Ujfalusi wrote:
> On 03/12/2013 11:22 PM, Andrew Chew wrote:
[...]
> > +static void pwm_backlight_disable(struct backlight_device *bl)
> > +{
> > +	struct pwm_bl_data *pb =3D dev_get_drvdata(&bl->dev);
> > +
> > +	/* Bail if we are already disabled. */
> > +	if (!pb->enabled)
> > +		return;
> > +
> > +	if (regulator_disable(pb->enable_supply) !=3D 0)
> > +		dev_warn(&bl->dev, "Failed to disable regulator");
> > +
> > +	pwm_disable(pb->pwm);
> > +
> > +	pb->enabled =3D false;
> > +}
>=20
> Would it not be better to have some locking here since the code started t=
o use
> flag for state tracking?

I don't think that's necessary. The backlight core already uses the
ops_lock mutex to serial accesses. I just noticed that the documentation
mentions that update_lock is used for this purpose, but the code doesn't
use it after it is initialized. Still, the ops_lock should be enough.

Thierry

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRQFFIAAoJEN0jrNd/PrOhRGEP/1xY96WTzcOgmIu0OyUnNOoe
m4/Ah8inwCmuo21GUbCkt+STGEklnF7GUPmPkedt01V4HfdWMQQUj4IjZiWqult8
UaTWkphQjIY/E+ZPk8clXemv1q/FNkz11sMdJFKqGXpBj+EWqEOfMXU0lj0/pZo/
Q//Gvr+SkcmTV2hCLuysVK13cDvCNaEqXiOPOGrzhyTnW+bdduePe+U2UaXaFNF1
JU7SdGSGoFwEiJOdtYq+oYlrfIxBwJv1sLNQZRhhav06RiGh3/4mGPVnmKrGc0CY
APFUb0Hn5DEcFaKiB4wmoXvtdTp+dqOIDAGdsrPQ/p4+7IHR84SLCgBZnKJFm+se
nHuJESxsGaXVNf4oNdMXV3luQcw/XwD2uSOsrJ11UkDG7GBlCCazxYQYhz0VPhS8
qwOjWTBh/oSklm7IoaWzULvX58e18xXrCjkhbM4etrENtgF0Si7mg6zdmSmntEJ1
9vhEpUGO6rfEs2rC4/RdZKidkQy1L5vN5lmZsZTTpe0V9CmKtq6yVAp/WGu1CZ1A
Wo0c2LTfGAx/foSs6pCRWROng8lnVfwUHZD6apgA0VhoIkXGEIXY6a8o4XPlr3Zl
vgZb3RMGF2eUNCyBiXbgn5GKCB84lzWa9xKLKyDVl3mbh7Xf0yr4vSKqv/JPmCs/
ev7IpwWIL6k5W74PVspi
=WPc3
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
