From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Fri, 23 Nov 2012 12:38:17 +0200
Message-ID: <20121123103817.GC29585@arwen.pp.htv.fi>
References: <20121122201549.GA24320@arwen.pp.htv.fi>
 <Pine.LNX.4.44L0.1211222130340.8245-100000@netrider.rowland.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51851 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456Ab2KWKow (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Nov 2012 05:44:52 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1211222130340.8245-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@ti.com>, Andy Green <andy.green@linaro.org>, Roger Quadros <rogerq@ti.com>, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 22, 2012 at 09:35:06PM -0500, Alan Stern wrote:
> On Thu, 22 Nov 2012, Felipe Balbi wrote:
>=20
> > > The latter, more or less.  For example, maybe we can tell usbcore
> > > somehow that regulator X is in control of a device attached to host
> > > controller Y (not sure how we would express X and Y though).  Then wh=
en
> > > usb_add_hcd() sees that the host controller being added is Y, it will
> > > know to turn on regulator X.  Similarly for usb_remove_hcd().
> >=20
> > that'd look very nice indeed. Perhaps we could even take care of such
> > details for the roothub, even. Maybe some systems might show up where
> > roothub need external regulators provided by e.g. PMIC ?!?
>=20
> As far as I can see, that ought to work provided the controller's=20
> platform driver is careful not to access the controller hardware before=
=20
> calling usb_add_hcd().
>=20
> And maybe the same sort of scheme could be used for clocks, although I=20
> don't know how to do it in a generic way that will work on all=20
> platforms.

perhaps making use of pm_clk_add() and letting PM layer do the rest for
us ? If that doesn't work then it means PM layer's clk handling could be
improved, I suppose.

--=20
balbi

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQr1IYAAoJEIaOsuA1yqRENSwQAJtcPp6ptJBF569Xl+yH4xET
3T+3vexqcykJ8Pnh2AakdpO5sBlxbvcb8vp8U6+sy0uxukrY5pmvj9Otzr+k1Dtt
TT271CXhhM0+0bQrb7vV3gd3MkTwqAXs8cNdTkP5VBBGDrxRWX/s1svW2wMf7Lgg
R49S9Xy4YlYnKL9zQ+V+u0oU4MJgUFe/Omvh/zm7UYjAnsMMPY6j4L+Dh3wHiF/A
oV6oAy1mcPCJ+JnD6YIKb7hRgfFCe/cG3RaFqmrqSeh5mAxgW71x2I6KltpFQYPR
SHak7JKnMnadMk205ZrE8ZyEePWq6CtpJKbbnCAHVi7vBZvUVHTZhBN6j/wQyqRR
SG4/B/cKOgV7ZTqBmEzIlw7NFHyMdmRELipSiegA3Ndw2TseYnh0ByMClfrQexmf
JdcjlP5L7Q7046LAehiQ60iPz66KdaOTKyaxry15TJ0VgrLrSQTjd2sxXma0Rnzp
1YCIL11TDx24na9vEKfYsllV9FYnj3onFgAAIM+Ybd7o9ATfWQ1pq/slk1I2X3rq
/YpggUv72BCYuhI5CXFbbnXO9orRztAezKUM3NwwrOl3oE+TY0kynZ+XVdUcy18m
t921JdCmHv8HvrDDxRUoQpcpgnIcxHIHOH6Iw8tZUWN8gfClIS+GlG9AmJWxa0n1
xPQFEsgOMEtXtO2cyhTV
=SaUK
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
