From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] usb: musb: Call atomic_notifier_call_chain when status is changed
Date: Tue, 17 Sep 2013 18:05:15 +0200
Message-ID: <201309171805.15460@pali>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com> <1378630239-10006-2-git-send-email-pali.rohar@gmail.com> <20130917154917.GL15645@radagast>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3521054.9ahlkCbLIl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130917154917.GL15645@radagast>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, freemangordon-uiMcrn6V0Vs@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--nextPart3521054.9ahlkCbLIl
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 17 September 2013 17:48:59 you wrote:
> On Sun, Sep 08, 2013 at 10:50:36AM +0200, Pali Roh=C3=A1r wrote:
> > More power supply drivers depends on vbus events and without
> > it they not working. Power supply drivers using
> > usb_register_notifier, so to deliver events it is needed to
> > call atomic_notifier_call_chain.
> >=20
> > So without atomic notifier power supply driver isp1704 not
> > retrieving vbus status and reporting bogus values to
> > userspace and also to board platform data functions.
> > Without proper data charger drivers trying to charge
> > battery also when charger is disconnected or do not start
> > charging when wallcharger connects.
> >=20
> > Atomic notifier in musb driver was used before v3.5 and was
> > replaced with omap mailbox. This patch adding
> > atomic_notifier_call_chain call from function
> > omap_musb_set_mailbox.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >=20
> >  drivers/usb/musb/omap2430.c       |    3 +++
> >  drivers/usb/phy/phy-twl4030-usb.c |    2 ++
> >  2 files changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/usb/musb/omap2430.c
> > b/drivers/usb/musb/omap2430.c index f44e8b5..5c40252 100644
> > --- a/drivers/usb/musb/omap2430.c
> > +++ b/drivers/usb/musb/omap2430.c
> > @@ -305,6 +305,9 @@ static void omap_musb_set_mailbox(struct
> > omap2430_glue *glue)
> >=20
> >  	default:
> >  		dev_dbg(dev, "ID float\n");
> >  =09
> >  	}
> >=20
> > +
> > +	atomic_notifier_call_chain(&musb->xceiv->notifier,
> > +			musb->xceiv->last_event, NULL);
>=20
> let's add a wrapper for this:
>=20
> static inline int usb_phy_notify(struct usb phy *x, unsigned
> val, void *v) {
> 	return atomic_notifier_call_chain(&x->notifier, val, v);
> }

Where to add this wrapper? To omap2430.c? or some include file?

On Tuesday 17 September 2013 17:49:17 Felipe Balbi wrote:
> On Sun, Sep 08, 2013 at 10:50:36AM +0200, Pali Roh=C3=A1r wrote:
> > diff --git a/drivers/usb/phy/phy-twl4030-usb.c
> > b/drivers/usb/phy/phy-twl4030-usb.c index 8f78d2d..efe6155
> > 100644
> > --- a/drivers/usb/phy/phy-twl4030-usb.c
> > +++ b/drivers/usb/phy/phy-twl4030-usb.c
> > @@ -705,6 +705,8 @@ static int twl4030_usb_probe(struct
> > platform_device *pdev)
> >=20
> >  	if (device_create_file(&pdev->dev, &dev_attr_vbus))
> >  =09
> >  		dev_warn(&pdev->dev, "could not create sysfs file\n");
> >=20
> > +	ATOMIC_INIT_NOTIFIER_HEAD(&twl->phy.notifier);
>=20
> BTW, this is a bugfix, send separately.

What to send separately?

This full patch 1/4 is bugfix. And I did not understand what you=20
want. Maybe it could be easier for you to apply this small 3+2=20
lines patch how you need.

=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--nextPart3521054.9ahlkCbLIl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlI4fbsACgkQi/DJPQPkQ1LBlQCfdm0yG7OA1FB23ObD+iKqiOp+
D9YAoM3mLUw0xGvTUgATZhr8OHj37kt1
=mZnd
-----END PGP SIGNATURE-----

--nextPart3521054.9ahlkCbLIl--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
