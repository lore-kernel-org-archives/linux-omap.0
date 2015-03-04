From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 11/15] twl4030_charger: enable manual enable/disable of
 usb charging.
Date: Wed, 4 Mar 2015 17:15:09 +1100
Message-ID: <20150304171509.2516f1ba@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
	<20150224043352.4243.543.stgit@notabene.brown>
	<20150302210342.GD13270@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/_BfoPYmBRT9.B2MMhGvH9Lu"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150302210342.GD13270@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/_BfoPYmBRT9.B2MMhGvH9Lu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2015 22:03:42 +0100 Pavel Machek <pavel@ucw.cz> wrote:

> On Tue 2015-02-24 15:33:52, NeilBrown wrote:
> > 'off' or 'auto' to
> >=20
> >  /sys/class/power/twl4030_usb/mode
> >=20
> > will now enable or disable charging from USB port.  Normally this is
> > enabled on 'plug' and disabled on 'unplug'.
> > Unplug will still disable charging.  'plug' will only enable it if
> > 'auto' if selected.
>=20
> This should go to Documentation/

You mean in Documentation/ABI/stable I guess??

That strikes me as a failed experiment - there is hardly anything there.

I'd be very happy to put the documentation with the code if there was some
mechanism to automatically extract it.  But I really see little value in
Documentation/ABI.

Or did you mean somewhere else?


>=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> >=20
> > Conflicts:
> > 	drivers/power/twl4030_charger.c
>=20
> Is it supposed to be here?

ah, no.  Gone now.  Thanks.


>=20
> > diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_ch=
arger.c
> > index 01090a440583..19e8dbb1303e 100644
> > --- a/drivers/power/twl4030_charger.c
> > +++ b/drivers/power/twl4030_charger.c
> > @@ -107,6 +107,9 @@ struct twl4030_bci {
> >  	int			ichg_eoc, ichg_lo, ichg_hi;
> >  	int			usb_cur, ac_cur;
> >  	bool			ac_is_active;
> > +	int			usb_mode; /* charging mode requested */
> > +#define	CHARGE_OFF	0
> > +#define	CHARGE_AUTO	1
> > =20
> >  	unsigned long		event;
> >  };
> > @@ -377,6 +380,8 @@ static int twl4030_charger_enable_usb(struct twl403=
0_bci *bci, bool enable)
> >  {
> >  	int ret;
> > =20
> n> +	if (bci->usb_mode =3D=3D CHARGE_OFF)
> > +		enable =3D false;
>=20
> Sometimes, you use =3D false and sometimes =3D 0 when assigning to bools.=
..

I found a fixed a few - thanks.


>=20
> > @@ -629,6 +634,54 @@ static int twl4030_bci_usb_ncb(struct notifier_blo=
ck *nb, unsigned long val,
> >  	return NOTIFY_OK;
> >  }
> > =20
> > +/*
> > + * sysfs charger enabled store
> > + */
> > +static char *modes[] =3D { "off", "auto" };
>=20
> I'd move this before the comment. Or better near struct twl4030_bci.

Makes sense.  Done.  Thanks.


>=20
> > +static DEVICE_ATTR(mode, 0644, twl4030_bci_mode_show,
> > +		   twl4030_bci_mode_store);
> > +
> >  static int twl4030_charger_get_current(void)
> >  {
> >  	int curr;
> > @@ -799,6 +852,7 @@ static int __init twl4030_bci_probe(struct platform=
_device *pdev)
> >  		bci->usb_cur =3D 500000;  /* 500mA */
> >  	else
> >  		bci->usb_cur =3D 100000;  /* 100mA */
> > +	bci->usb_mode =3D CHARGE_AUTO;
> > =20
> >  	bci->dev =3D &pdev->dev;
> >  	bci->irq_chg =3D platform_get_irq(pdev, 0);
> > @@ -885,6 +939,8 @@ static int __init twl4030_bci_probe(struct platform=
_device *pdev)
> >  	twl4030_charger_update_current(bci);
> >  	if (device_create_file(bci->usb.dev, &dev_attr_max_current))
> >  		dev_warn(&pdev->dev, "could not create sysfs file\n");
> > +	if (device_create_file(bci->usb.dev, &dev_attr_mode))
> > +		dev_warn(&pdev->dev, "could not create sysfs file\n");
> >  	if (device_create_file(bci->ac.dev, &dev_attr_max_current))
> >  		dev_warn(&pdev->dev, "could not create sysfs file\n");
> > =20
> > @@ -917,6 +973,7 @@ static int __exit twl4030_bci_remove(struct platfor=
m_device *pdev)
> > =20
> >  	device_remove_file(bci->usb.dev, &dev_attr_max_current);
> >  	device_remove_file(bci->ac.dev, &dev_attr_max_current);
> > +	device_remove_file(bci->usb.dev, &dev_attr_mode);
>=20
> move the line above for consistency with create?

Yep.

>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks a lot!

NeilBrown

--Sig_/_BfoPYmBRT9.B2MMhGvH9Lu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVPai7Tnsnt1WYoG5AQIgVxAAteUbWWhUw0vNL1znrmKJIuvU/Zs9X2o/
FaQHrVSOOZTfmleP5Bz4D42KnHoyl3Fn8u2vcOM++0Zo3DkAGLgrsQAngjo8v9x9
K18d1sveKp4UeQV42Z6VDcXl5pkb+De10GhWzUo5NGeHs3WE9MZ852aoL1mtFSNc
qZph8EOuzgqp7lZQdsVcZkysI65/W1S9x8aJ1Ye8Jp/j/OBa8+AquNW1pify1JAu
ABBnsyIL3NIncgrHSllEmItfyNxAOM8ygERNsdxwvcHXc3OvXDkHg0sf7R6qOZYk
Gj0AqcsLDo5LP9XJHtdf3NRTWmJvKGXL9xcvAC1IYh84q8EwtF2EEjvMMuHhSey/
ZTU0/Jj44iEPLHAVFQzjqNIsNsIPZDprEyB7r50jkEcP6Nt3vIMfFYBBDij9ksjA
LAH7hURy/j5+TL16q058ENEx9m8cZwmQQ83JX/9P3uY8+STkKJOtUSE1mjvz06mw
XeOc/nRoo5/vT/lgzOP7FYS/q87xPuOfgRvuZQQ+puYR50l11m+qef9HGJIXDUwK
keyS/EUGezDEuuZ4E8kR4Ip4CruigHkOo7RrPWTE54V4E9bKyehCieWvrN7RwNxE
pFMrz2YRAptXx6LVxpDCeLVotWmUwMjmjiGLlNH6YJXsoVbIpxG2dcYeMC5Rhl9o
cl9JP+Jdn6Y=
=HK+u
-----END PGP SIGNATURE-----

--Sig_/_BfoPYmBRT9.B2MMhGvH9Lu--
