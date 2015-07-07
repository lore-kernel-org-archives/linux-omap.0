From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] base: power: wakeirq: don't leak dev->power.wakeirq
Date: Tue, 7 Jul 2015 03:11:20 -0500
Message-ID: <20150707081120.GA15545@saruman.tx.rr.com>
References: <1436205678-31640-1-git-send-email-balbi@ti.com>
 <2783932.o7RC7vMDHB@vostro.rjw.lan>
 <20150707074053.GO10705@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150707074053.GO10705@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Felipe Balbi <balbi@ti.com>, linux-pm@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2015 at 12:40:53AM -0700, Tony Lindgren wrote:
> * Rafael J. Wysocki <rjw@rjwysocki.net> [150706 15:49]:
> > On Monday, July 06, 2015 01:01:18 PM Felipe Balbi wrote:
> > > on a first call to dev_pm_attach_wake_irq(), if it
> > > fails, it will leave dev->power.wakeirq set to a
> > > dangling pointer. Instead, let's clear it to make
> > > sure a subsequent call to dev_pm_attach_wake_irq()
> > > has chance to succeed.
> > >=20
> > > Cc: Tony Lindgren <tmlind@atomide.com>
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > >  drivers/base/power/wakeirq.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeir=
q.c
> > > index 7470004ca810..394d250a1ad8 100644
> > > --- a/drivers/base/power/wakeirq.c
> > > +++ b/drivers/base/power/wakeirq.c
> > > @@ -50,9 +50,16 @@ static int dev_pm_attach_wake_irq(struct device *d=
ev, int irq,
> > > =20
> > >  	err =3D device_wakeup_attach_irq(dev, wirq);
> > >  	if (err)
> > > -		return err;
> > > +		goto err_cleanup;
> > > =20
> > >  	return 0;
> > > +
> > > +err_cleanup:
> > > +	spin_lock_irqsave(&dev->power.lock, flags);
> > > +	dev->power.wakeirq =3D NULL;
> > > +	spin_unlock_irqrestore(&dev->power.lock, flags);
> > > +
> > > +	return err;
> > >  }
> >=20
> > Too many labels for me and the fact that acquiring of the lock again in=
 the error
> > patch doesn't look good.
> >=20
> > However, we can do the entire device_wakeup_attach_irq() under the lock=
 (after
> > removing the locking from it), because we're its only caller.
> >=20
> > So what about the below instead (build-tested only)?
>=20
> Nice, still works for me and simplifies things:
>=20
> Tested-by: Tony Lindgren <tony@atomide.com>

Cool, thanks for testing Tony. Rafael, I'm fine with your version too.
FWIW:

Reported-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVm4moAAoJEIaOsuA1yqRE2fEP+wZSTM0+SihTwWshSY5MpV8T
IQ7Elo6Ympip6QUq40Q7yLHFCtBDS0tv1wsBG9dJb1N8BH0cH4r1rSB85i+Yczpe
rAn6Lp0s2omprqRyCjO1Mu7EY1gIYnyuyfA/U5F+9ObItv5Bj9OoR7kBT1Qn4Vfp
rqKgYC1Oh/E+nSy2cod5rssnclL03kDCkSVvPlqGEO6yH9EAdC6BUx5qlxEsAS96
u6eRkITA+01zVuk9DbRiJzZvk0aofoktox/ggtH3a42TWsnmrI6F26VbMNXZwRPJ
nTK8RGw6MZu8/jBbPjVVNUW5jZdBTWqUFXPvqSo3Qa+3LgEbfqfEZqYW/5gX9AlG
ihbHAEUdKbND3WH9AL1NYXqTf6+Yzl2woCb9fASzoMd8PCz2ywXbRl/JiDPjK9Xh
ctJBEIqMrZaGau9V8zfrxwbSVJRKtd+s19Biy/CuUnU75+e9njErbbKBZOsHTyIc
FBJH7pZsx5hjLePgKRGY3hbgmuSJmVZ97mSqq7RVZUwPOBiVnpCGcB46pdvxlMYN
syBHa3mXWC0EY7MAolUrAssXzRfBwXC3bxavavAxLLiGCVuml/svhihwH0hFqOpd
/EQoxMq5THV34JVZJ6JvgK2E0atxki/idVshcFP0bVGkDa0Bg23biiMRNtCkT8EY
0KCAYmgAawhJfNw5vOwA
=Oira
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
