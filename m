From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v5 04/11] usb: otg: nop: add support for multiple
 tranceiver
Date: Thu, 26 Jul 2012 11:24:02 +0300
Message-ID: <20120726082402.GO29029@arwen.pp.htv.fi>
References: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
 <1343218049-29917-5-git-send-email-ajay.gupta@ti.com>
 <20120726073621.GG29029@arwen.pp.htv.fi>
 <47CEF8C4B26E8C44B22B028A650E0EA93EAEF6F7@DBDE01.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9kDAZ2EyO0AcRYa"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:54483 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751011Ab2GZI1Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jul 2012 04:27:16 -0400
Received: by lahd3 with SMTP id d3so1211345lah.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 01:27:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <47CEF8C4B26E8C44B22B028A650E0EA93EAEF6F7@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>


--s9kDAZ2EyO0AcRYa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 26, 2012 at 08:22:35AM +0000, Gupta, Ajay Kumar wrote:
> > > @@ -408,7 +408,7 @@ static int am35x_musb_exit(struct musb *musb)
> > >  		data->set_phy_power(0);
> > >
> > >  	usb_put_phy(musb->xceiv);
> > > -	usb_nop_xceiv_unregister();
> > > +	usb_nop_xceiv_unregister(musb->xceiv);
> >=20
> > Dude, this is so wrong... You don't know if there are other users of the
> > nop xceiv in the system. If there are other users which already have
> > claimed id 0, you will try to create duplicated directories under sysfs.
> > MUSB's ID has nothing to do with NOP's ID.
>=20
> I could not understood this comment as I am not using id. Please clarify.

sorry, my bad. I put the comment on the wrong hunk:

> > > @@ -364,7 +364,7 @@ static int am35x_musb_init(struct musb *musb)
> > >  	if (!rev)
> > >  		return -ENODEV;
> > >
> > > -	usb_nop_xceiv_register();
> > > +	usb_nop_xceiv_register(musb->id);
> > >  	musb->xceiv =3D usb_get_phy(USB_PHY_TYPE_USB2);
> > >  	if (IS_ERR_OR_NULL(musb->xceiv))
> > >  		return -ENODEV;

here. You pass musb->id to become NOP's ID.

--=20
balbi

--s9kDAZ2EyO0AcRYa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQEP6iAAoJEIaOsuA1yqRE/r8P/26o6hLwrIdtp8qbbULGz8gK
sjJwxzpuWNPkRPr1MaElWunWmN4HSpgPi/GlCUtSGDnDY4XL9r2WwOMDZt4sm3PF
CiJSzF7l/f4t2tfBlmU7Nu/KqLLAyCca+10Qt3GIesJqZQ20PtDGTe1kx4/l7Vqn
wea7+yB6DRBqhHqPJESx0fOiLPbuOUFvvBHiF6Bb3cvGTC67leH3WmHTu892uDTu
wQ/Q+1shWWyvPYDdMuJhtRxorvoew8wtCmH4kXN6ZPyqJilQ4TUN3WHOnBTi6ElN
quMyY3bQt7nKGUGw/WoZxBnwfa71EO8573bWGpKmDttCgAKvoH6C816qCyDJnlhu
b95u1Byon3wKur3YYCf9gEQdLz8WCXa5QpZY1lUZo09ohw9NCQmR3jyeKy/vsKR3
vWXeuYfCvElhZPutQb/Ic8nvVNt2rR+hNqrFsLZFxPsItqKkqsA8j7xYxuaHYERv
F+3NQjd0Qx9JhOZj7ETXK50T0CCCSN1ErmnqXrVfkjJCOtiPWESFwqgdRg6cIEev
O/haxcV6Dkiw8NZtDWM+sA5HCXdGdsuiJ42VLx3f66v8NoWOF3CZKG/czjpht4Ew
UKLEd5xHhau/iXR39qCiEXgtyR6pq4+95qYTSGx18waokhxN3MgloZxsDIuJ/I8r
mEhq2I05Eda0ebwKoRzH
=Wi9c
-----END PGP SIGNATURE-----

--s9kDAZ2EyO0AcRYa--
