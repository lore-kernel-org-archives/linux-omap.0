From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] base: power: wakeirq: don't leak dev->power.wakeirq
Date: Mon, 6 Jul 2015 13:09:21 -0500
Message-ID: <20150706180921.GF20779@saruman.tx.rr.com>
References: <1436205678-31640-1-git-send-email-balbi@ti.com>
 <CAOf5uwnj=0m99E96k-+AYu68yE_UnX1WVU-=6y7OvJnfXKh8+g@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOf5uwnj=0m99E96k-+AYu68yE_UnX1WVU-=6y7OvJnfXKh8+g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, rjw@rjwysocki.net, Tony Lindgren <tmlind@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2015 at 08:06:17PM +0200, Michael Trimarchi wrote:
> Hi
>=20
> On Jul 6, 2015 8:01 PM, "Felipe Balbi" <balbi@ti.com> wrote:
> >
> > on a first call to dev_pm_attach_wake_irq(), if it
> > fails, it will leave dev->power.wakeirq set to a
> > dangling pointer. Instead, let's clear it to make
> > sure a subsequent call to dev_pm_attach_wake_irq()
> > has chance to succeed.
> >
> > Cc: Tony Lindgren <tmlind@atomide.com>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/base/power/wakeirq.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> > index 7470004ca810..394d250a1ad8 100644
> > --- a/drivers/base/power/wakeirq.c
> > +++ b/drivers/base/power/wakeirq.c
> > @@ -50,9 +50,16 @@ static int dev_pm_attach_wake_irq(struct device *dev,
> int irq,
> >
> >         err =3D device_wakeup_attach_irq(dev, wirq);
> >         if (err)
> > -               return err;
> > +               goto err_cleanup;
> >
> >         return 0;
> > +
> > +err_cleanup:
> > +       spin_lock_irqsave(&dev->power.lock, flags);
> > +       dev->power.wakeirq =3D NULL;
> > +       spin_unlock_irqrestore(&dev->power.lock, flags);
> > +
>=20
> Why here and not in the fuction that return the error?

because the field was set here, why would I clear it elsewhere ?

--=20
balbi

--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVmsRRAAoJEIaOsuA1yqREdfQP/RjW1X7z4DQUe/VmwskYs8or
QZ2D+a0F9j1kvji34ab+kx0qNrI9LPaESFo3wZVsCunN5oeGEYM4Ro6LVyIWuGib
gemGqb6TzZSkdBzT7IAj0gaqkcz+lXUDUu+UdOl8HuxkNkI54JmgaIUs7wE7UN/x
i670J/xgIGHQMntMMvGnTJi4FUzVadB+1fgVNXLlAY+Z14iTS7Yuu0blAHvrvy0v
//JRdu1z9XijD0kFvVgMXczeua6xWxlSFS1YMofjFpKbnlg/DTKKFFd4rlpUo+5Z
qGDCQ2LCYY5sQzBAhlJPg556lPoedbsuObezQjXcfIkDh99fL+dzTHwsld7rgbeP
yNJ4GVUdJSpOyVAPYTphdeEH0baqm4eokUdIi9TL/LB8UNnvetzKbjBXCkxB0R7d
rmOf3P+RSI1jYbK0/ugGyHsNEp/hCdDD1MjxmgFnKFRiUtyddE/sszlnRWVehrix
SpPsWifHkhOMOnOdHaHyLaOXZBHnFRhStYfxnfJJgD7Oa/9iMERfQdW+b05tl3md
1pgt0S2lTwgMWuzyk4ULOn+7yhRyCSOmi6lcMpiP4bUq80jsDwZeYEpLc3EV58qq
D0Xi1iBpxMbP+dT6zWa9LODyZMdSrW1qFbXxcxW1FTjQcKabgFDB6qZaWehDxJsX
e/R6cVHLxvAzqM0+9ib4
=DPPe
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--
