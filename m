From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 10/16] mfd: omap-usb-host: Intialize all available ports
Date: Tue, 27 Nov 2012 15:28:27 +0200
Message-ID: <20121127132827.GC22556@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-11-git-send-email-rogerq@ti.com>
 <20121121135246.GL10216@arwen.pp.htv.fi>
 <50B4ADCA.5000909@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56368 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689Ab2K0NfI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Nov 2012 08:35:08 -0500
Content-Disposition: inline
In-Reply-To: <50B4ADCA.5000909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 27, 2012 at 02:10:50PM +0200, Roger Quadros wrote:
> > in fact, I would convert this construct into a switch which would look
> > like:
> >=20
> > reg &=3D ~(OMAP4_P1_MODE_MASK << i * 2);
> >=20
> > switch (port_mode[i]) {
> > case OMAP4_P1_MODE_TLL:
> > 	reg |=3D OMAP4_P1_MODE_TLL << i * 2;
> > 	break;
> > case OMAP_P1_MODE_HSIC:
> > 	reg |=3D OMAP4_P1_MODE_HSIC << i * 2;
> > 	break;
> > }
> >=20
>=20
> Just realized that is_ohci_port() takes care of 10 cases, so I'll leave
> it the way it was with if statement.

fair enough.

> > Also, it looks like the whoel for loop with port mode settings could be
> > re-factored to a separate function to aid readability.
> >=20
>=20
> it seems that the purpose of omap_usbhs_init() is to initialize
> HOSTCONFIG so I see no point in adding another function for it. I can
> clean it up for better readability though.

when functions get too big, it starts to become a little difficult to
see bugs. Re-factoring parts of a bigger function, into smaller
functions helps with that as long as the new functions are
self-contained and logical. At the end of the day, GCC will inline the
new smaller functions anyway.

cheers

--=20
balbi

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQtL/7AAoJEIaOsuA1yqRE1pgP/0jTTw8XJ7Z6GPVcvif5+Pkw
ffzOivSnGImPo63QY6Jp+wj/Xi16qR2wkxdK4/IoqFSSc+GUn6+xR/50OlVyU4ke
nLs1NWFKIt5lW0vSS9iyLDSSIkbkABmL9GltuC444f2OWhs+Wc+3+04EsB14B5sa
Q4kchvJLPoFjUwhX0w8v+7EhHGKfS0bT3366eQgd6sob3vrnihHBNAK1zddFVT9P
Y1/uH+9gYyM63cz4Kags+Zbe4Zgfbat7H43y4aD5FjhEA/SNVPaCkP953YYvTYml
WgewN57wS1BOfobsB+8hVR2ZHWS1U2iN0uHsYADG7LL8IcfOORhew1+0sYtfazte
N2mmxpRLsfmR8T3zyCfvjaethfXv72B5OBr4gRghBaK8G35PG7+VEaDkRuwWQ+5z
OyfNjW49gDi9XznLZRbTL2RFoSwJ+6qXwC385nC5YrDzHdUvSkkK3lpOJJD3AX8Q
IrzT24mh2+LOHmUqCXhRMRu8jW27fQEAnkinhNOX6RSsOWqagZkO0B0aRqwL3OMb
GA+7RgS2R+n3E49EVVdlzivbo2xT5MsBL8t5vnJ8BqojtkNwAsnMQUeTpa44k58w
LuQsLK+bXbarImu4i8WSncRaxmU15ECLLeEJ4Sicv81BaNquWi7JcWiJoJn/vbCq
5ghXsE4V4lM3Wnbu5dIy
=jHj1
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
