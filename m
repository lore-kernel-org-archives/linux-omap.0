From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 4/4] usb: phy: twl4030: test ID resistance to see if
 charger is present.
Date: Wed, 4 Mar 2015 17:40:17 +1100
Message-ID: <20150304174017.681f4f8a@notabene.brown>
References: <20150224033730.31400.78200.stgit@notabene.brown>
	<20150224034037.31400.48003.stgit@notabene.brown>
	<20150302210444.GI13270@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/MqCefpqXOYmiaj/JM0KEIOJ"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150302210444.GI13270@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

--Sig_/MqCefpqXOYmiaj/JM0KEIOJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2015 22:04:44 +0100 Pavel Machek <pavel@ucw.cz> wrote:

> On Tue 2015-02-24 14:40:37, NeilBrown wrote:
> > If an 'A' plug is inserted, ID should be pulled to ground.
> > If a 'B' plug, then ID should be floating.
> >=20
> > If an Accessory Charger Adapter is inserted, then ID will
> > be neither grounded nor floating.  In this case tell the
> > USB subsystem that it is an A plug, and the battery
> > charging subsystem that it is a charger.
>=20
> > Fortunately, this will treat the Openmoko charger (and
> > other similar chargers) as a charger.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
>=20
> I guess signed-off-by should be "real name", so I'd add a space..

This is how I always sign-off my name (2858 times in "git log") so I don't
think I'll change it now.

>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks.

>=20
> > --- a/drivers/phy/phy-twl4030-usb.c
> > +++ b/drivers/phy/phy-twl4030-usb.c
> > @@ -596,9 +596,31 @@ static irqreturn_t twl4030_usb_irq(int irq, void *=
_twl)
> >  	struct twl4030_usb *twl =3D _twl;
> >  	enum omap_musb_vbus_id_status status;
> >  	bool status_changed =3D false;
> > +	bool found_charger =3D false;
> > =20
> >  	status =3D twl4030_usb_linkstat(twl);
> > =20
> > +	if (status =3D=3D OMAP_MUSB_ID_GROUND ||
> > +	    status =3D=3D OMAP_MUSB_VBUS_VALID) {
> > +		/* We should check the resistance on the ID pin.
> > +		 * If not a Ground or Floating, then this is
> > +		 * likely a charger
>=20
> "charger.", and I guess kernel comments should have /* on separate line.

Yep.

>=20
> So it will draw .5A from the charger? 1A? 2A?
>=20
> 									Pavel

That is up to the charger driver.  The phy just detects what is there, it
doesn't decide what to do with it.

Thanks,
NeilBrown

--Sig_/MqCefpqXOYmiaj/JM0KEIOJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVPao0Tnsnt1WYoG5AQLfLg/+OmhvKr6kmvyWd0uYBTHhHOICmIoDyCDl
6jjXYC2E2zkVxipP3fjl0N4PX+/w5sFPeynIYohIiCNdkcfk2eYg7evHkcIAgQ9T
bEhelxyAcbxVqXFyDodaBTp+fZsGhovci3LviE1ClEfxGHo1eDXYP3WoH6E/xdQk
jLpcILtQvRJuXFtfXcuVwztmD/J+2kFvt2MI0toZIoY5ezzaAlNRFr2mHTP89fVt
GLiO8AHrqGrEi3jICX9uR70Z/aK81DJWmmWBDzOJOBhSGGTm7Wc1AXFBzvFkfJLM
Tr/6foPozn8qF3320mDYNcAOzRwUP/f3SWTVzc67nYUlxpo9KbWaXgioawJNq01K
UPZg0WZph8wcvfp2d+kPoO7Ywz53GrB7dB/+azqo44z3jgayg0mBMzzxHVZvKRJ0
S20x8ff/LJAN1ZiGYqXMZCzJ46J7sb1um6did/Qk8QCKqioi0C6Az3CjVXAF3cHa
ooOIMCVCjbmv2zrQS78s5ET0oUC5nh8m91uetlaiQPm+owF0EJ1zLGZ1FvemdPhF
ybqe1yVs6robawLMpBmL0SidMtkl4SpCEwLdXEtZzOOMUK0b6Pg5AhVqmedxttzD
ODo4GkoUNez2Z4DuDsgcN6+FDVhy93emwI4gs5rwE6hE5+GnkOj1vkcsIPBzwXVP
FtN69JRceoI=
=hUUc
-----END PGP SIGNATURE-----

--Sig_/MqCefpqXOYmiaj/JM0KEIOJ--
