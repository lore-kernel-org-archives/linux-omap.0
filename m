From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2 2/3] bq2415x_charger: Use power_supply notifier for automode
Date: Sun, 24 Nov 2013 20:01:23 +0100
Message-ID: <201311242001.23126@pali>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com> <1384856285-19593-3-git-send-email-pali.rohar@gmail.com> <CAOf5uwkrep0PhOn67+9PHmP2A2Jxrp9DNK3BRp9D_sYu_PYvvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1449561.x6WrYB2jlq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOf5uwkrep0PhOn67+9PHmP2A2Jxrp9DNK3BRp9D_sYu_PYvvw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz
List-Id: linux-omap@vger.kernel.org

--nextPart1449561.x6WrYB2jlq
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 24 November 2013 18:18:03 Michael Trimarchi wrote:
> Hi
>=20
> On Tue, Nov 19, 2013 at 11:18 AM, Pali Roh=C3=A1r=20
<pali.rohar@gmail.com> wrote:
> > This patch removing set_mode_hook function from board data
> > and replacing it with new string variable of notifier power
> > supply device. After this change it is possible to add DT
> > support because driver does not need specific board
> > function anymore. Only static data and name of power supply
> > device is required.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > ---
> >=20
> >  drivers/power/bq2415x_charger.c       |   77
> >  +++++++++++++++++++++++++--------
> >  include/linux/power/bq2415x_charger.h |   48
> >  +++----------------- 2 files changed, 65 insertions(+), 60
> >  deletions(-)
> >=20
=2E..
> >=20
> > -       struct bq2415x_device *bq =3D data;
> > +       struct bq2415x_device *bq =3D
> > +               container_of(nb, struct bq2415x_device, nb);
> > +       struct power_supply *psy =3D v;
> > +       enum bq2415x_mode mode;
> > +       union power_supply_propval prop;
> > +       int ret;
> > +       int mA;
> >=20
> > -       if (!bq)
> > -               return;
> > +       if (val !=3D PSY_EVENT_PROP_CHANGED)
> > +               return NOTIFY_OK;
> > +
> > +       if (strcmp(psy->name, bq->init_data.notify_device)
> > !=3D 0) +               return NOTIFY_OK;
> > +
> > +       dev_dbg(bq->dev, "notifier call was called\n");
> > +
> > +       ret =3D psy->get_property(psy,
> > POWER_SUPPLY_PROP_CURRENT_MAX, &prop); +       if (ret !=3D
> > 0)
> > +               return NOTIFY_OK;
>=20
> So you can read this value without any type of synchronization
> with the power_supply_core
> and sysfs implementation?
>=20
>=20
> Michael
>=20

I do not see reason why I cannot use it. When isp1704 driver send=20
PSY_EVENT_PROP_CHANGED then property=20
POWER_SUPPLY_PROP_CURRENT_MAX is already updated and can be read=20
by get_property function.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1449561.x6WrYB2jlq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlKSTQMACgkQi/DJPQPkQ1LjrgCfUFRly8YbpEyS/Y8FKxMRvgqK
OnAAoJsmTxhdxWU9r2g82/E/glUqKiSj
=1iDc
-----END PGP SIGNATURE-----

--nextPart1449561.x6WrYB2jlq--
