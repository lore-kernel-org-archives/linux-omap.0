From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] usb: musb: Call atomic_notifier_call_chain when
 status is changed
Date: Tue, 17 Sep 2013 11:08:35 -0500
Message-ID: <20130917160835.GS15645@radagast>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1378630239-10006-2-git-send-email-pali.rohar@gmail.com>
 <20130917154917.GL15645@radagast> <201309171805.15460@pali>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1220597992020711777=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201309171805.15460@pali>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-usb@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, aaro.koskinen@iki.fi, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Anton Vorontsov <anton@enomsg.org>, linux-kernel@vger.kernel.org, balbi@ti.com, freemangordon@abv.bg, pavel@ucw.cz, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============1220597992020711777==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LtN0I0gXzHUftVCi"
Content-Disposition: inline

--LtN0I0gXzHUftVCi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2013 at 06:05:15PM +0200, Pali Roh=E1r wrote:
> On Tuesday 17 September 2013 17:48:59 you wrote:
> > On Sun, Sep 08, 2013 at 10:50:36AM +0200, Pali Roh=E1r wrote:
> > > More power supply drivers depends on vbus events and without
> > > it they not working. Power supply drivers using
> > > usb_register_notifier, so to deliver events it is needed to
> > > call atomic_notifier_call_chain.
> > >=20
> > > So without atomic notifier power supply driver isp1704 not
> > > retrieving vbus status and reporting bogus values to
> > > userspace and also to board platform data functions.
> > > Without proper data charger drivers trying to charge
> > > battery also when charger is disconnected or do not start
> > > charging when wallcharger connects.
> > >=20
> > > Atomic notifier in musb driver was used before v3.5 and was
> > > replaced with omap mailbox. This patch adding
> > > atomic_notifier_call_chain call from function
> > > omap_musb_set_mailbox.
> > >=20
> > > Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> > > ---
> > >=20
> > >  drivers/usb/musb/omap2430.c       |    3 +++
> > >  drivers/usb/phy/phy-twl4030-usb.c |    2 ++
> > >  2 files changed, 5 insertions(+)
> > >=20
> > > diff --git a/drivers/usb/musb/omap2430.c
> > > b/drivers/usb/musb/omap2430.c index f44e8b5..5c40252 100644
> > > --- a/drivers/usb/musb/omap2430.c
> > > +++ b/drivers/usb/musb/omap2430.c
> > > @@ -305,6 +305,9 @@ static void omap_musb_set_mailbox(struct
> > > omap2430_glue *glue)
> > >=20
> > >  	default:
> > >  		dev_dbg(dev, "ID float\n");
> > >  =09
> > >  	}
> > >=20
> > > +
> > > +	atomic_notifier_call_chain(&musb->xceiv->notifier,
> > > +			musb->xceiv->last_event, NULL);
> >=20
> > let's add a wrapper for this:
> >=20
> > static inline int usb_phy_notify(struct usb phy *x, unsigned
> > val, void *v) {
> > 	return atomic_notifier_call_chain(&x->notifier, val, v);
> > }
>=20
> Where to add this wrapper? To omap2430.c? or some include file?

<linux/usb/phy.h>

> On Tuesday 17 September 2013 17:49:17 Felipe Balbi wrote:
> > On Sun, Sep 08, 2013 at 10:50:36AM +0200, Pali Roh=E1r wrote:
> > > diff --git a/drivers/usb/phy/phy-twl4030-usb.c
> > > b/drivers/usb/phy/phy-twl4030-usb.c index 8f78d2d..efe6155
> > > 100644
> > > --- a/drivers/usb/phy/phy-twl4030-usb.c
> > > +++ b/drivers/usb/phy/phy-twl4030-usb.c
> > > @@ -705,6 +705,8 @@ static int twl4030_usb_probe(struct
> > > platform_device *pdev)
> > >=20
> > >  	if (device_create_file(&pdev->dev, &dev_attr_vbus))
> > >  =09
> > >  		dev_warn(&pdev->dev, "could not create sysfs file\n");
> > >=20
> > > +	ATOMIC_INIT_NOTIFIER_HEAD(&twl->phy.notifier);
> >=20
> > BTW, this is a bugfix, send separately.
>=20
> What to send separately?
>=20
> This full patch 1/4 is bugfix. And I did not understand what you=20
> want. Maybe it could be easier for you to apply this small 3+2=20
> lines patch how you need.

This hunk here (initializaing notifier head) is a separate bug fix and
needs its own patch.

--=20
balbi

--LtN0I0gXzHUftVCi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSOH6DAAoJEIaOsuA1yqRE6fsP/1HZxWb/VlwBvRGFR9ChrlgJ
RuMTDLnOgw5V+1GpF+CqPLt5NGTrkQCDmWodD8E0e5q9P+hnNtYAio+x8HfNHPsE
rjylpMIaBBxuKYad0+s3+SNojvzsdJYHDKrJmVrUQIcKOvwKvvcgX/DVd8t2trk+
GH3DGUJxOGoz9i/fXmQRyw9nFVqNMlqxEfyNPwX/LceTOT/MdWeszLvyyy/rJxQh
nzyeUGpXv/K0RLH9QOe5mcLVwbTC1vdetgbEwtfbk5ZarmTOMT7h83NI5PFAr6HX
rW2kO2GB01OtSsruL7G3gFCh7szpeljfXwJwO6vVxl/wC3wgUXwg27j8dXc3vjbJ
X5gLKx7wJSLQeoSmw6an9BdCN+pEaMx9fB7nEJVnYWOp0FOUe35bYYntDWO22Bd4
2hvu2xeFNnGfzqEMm+w9bfvFzb7XwQVn1kU2shc91kJw9CB79Vimuhg/7jjtcODp
XBdCz1A/QO7RKjNKwhuhsD3waBxrRQWOkNFIGHzMAtyiPtXs8kbmAk1j72jveqV5
rOull+Nh3mfD7twqR0RF4ot9kvGTjfrkzrTMtJTccLoJhfxM3opyCSdshzqsjPYT
+deRW4N3pVqFyIYdu8SW9J+5JQobOmeqFDNo0O9r8oGzygHDWMox++S7rToK9/M6
VX7qIqw11jGXivDD2VAy
=CsOG
-----END PGP SIGNATURE-----

--LtN0I0gXzHUftVCi--


--===============1220597992020711777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1220597992020711777==--
