From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 2/4] usb: phy: twl4030: allow charger to see usb current
 draw limits.
Date: Wed, 4 Mar 2015 17:17:47 +1100
Message-ID: <20150304171747.5b5586b0@notabene.brown>
References: <20150224033730.31400.78200.stgit@notabene.brown>
	<20150224034037.31400.26595.stgit@notabene.brown>
	<20150302210355.GF13270@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/qg6FkBLo2EuoAgnbI8w.GJs"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39040 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932885AbbCDGR5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Mar 2015 01:17:57 -0500
In-Reply-To: <20150302210355.GF13270@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>

--Sig_/qg6FkBLo2EuoAgnbI8w.GJs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2015 22:03:55 +0100 Pavel Machek <pavel@ucw.cz> wrote:

> On Tue 2015-02-24 14:40:37, NeilBrown wrote:
> > The charger needs to know when a USB gadget has been enumerated
> > and what the agreed maximum current was so that it can adjust
> > charging accordingly.
> >=20
> > So define a "set_power()" function to record the permitted
> > draw, and pass a pointer to that when sending USB_EVENT_ENUMERATED
> > notification.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  drivers/phy/phy-twl4030-usb.c |   27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-us=
b.c
> > index 97c59074233f..023fe150c7a1 100644
> > --- a/drivers/phy/phy-twl4030-usb.c
> > +++ b/drivers/phy/phy-twl4030-usb.c
> > @@ -163,6 +163,11 @@ struct twl4030_usb {
> >  	enum omap_musb_vbus_id_status linkstat;
> >  	bool			vbus_supplied;
> > =20
> > +	/* Permitted vbus draw - only meaningful after
>=20
> add "in mA"?
>=20
> > +	 * USB_EVENT_ENUMERATED
> > +	 */
> > +	unsigned		vbus_draw;
> > +
> >  	struct delayed_work	id_workaround_work;
>=20

Yes.  I make it 'unsigned int' too.

Thanks,
NeilBrown

--Sig_/qg6FkBLo2EuoAgnbI8w.GJs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVPajiznsnt1WYoG5AQIt7Q//bs9bnytuPb0rS4BVF5L1oRcLbnkFIxGr
TTrsSK6zz3LYQ7KukSd/mfRSL29fIbWVL0oxg8qECTnqBL7vGvzQsuAcNbwsEshl
yeq4PJuxBued/EpYukApxjpZhvGiEYVPcRO1QKIOGJkJxZlHem4HDWsgUp1iV96T
FQ+Nlfx86lCNp5KR49Bm0z5YWHIA1Rnrp3m/aGAZ7jZ420KCi8gAqLJtLbX2PQxY
4T6HV+NB/QxI9KiFjwwIz+qVouB6sGITStavzjnHBHZE2Brbosb93gt7UG+Y+PBg
hUkyp1H41w5ouc9lrMjuMI5EyFJKdpF24Ai9/TXBZUd8eEJR6b6SCGjBbOf+jdo7
D+x3UzJnQ7ZrPsVtIEzRjJ1+nK+aihTbIvZbJ2j5NHZp/uvvquC1aNRxlmvq4sRl
gDJTlROoxACV4128pSLJQEQNYwNNraYQLZaMT4+1jnifLKGvv2PPQz+EoPr9mk1G
wo7vDSpCztvy+fCEsLiZTXDJtBLjHap75E+QNa/9azJWcfXVjMs/SGWV9MLvwgS4
dPMT0GGyFUZo2aKX6cJRkIslxlhUwLSleJnLwnmO8UNwGz3KfDnG3J3PS9e65dh3
sRpMLOi5UC5NL9uOPpRb4HbHitgBdtcSQaM76Ln0QWfTBdv51mrk4pUM3mwt40oz
DNK225NSBx4=
=NBjb
-----END PGP SIGNATURE-----

--Sig_/qg6FkBLo2EuoAgnbI8w.GJs--
