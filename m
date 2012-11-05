From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2 3/7] i2c: omap: remove the dtrev
Date: Mon, 5 Nov 2012 11:05:17 +0200
Message-ID: <20121105090517.GB2913@arwen.pp.htv.fi>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-4-git-send-email-shubhrajyoti@ti.com>
 <20121105075320.GD32468@arwen.pp.htv.fi>
 <50977C80.8090000@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45207 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711Ab2KEJLl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 04:11:41 -0500
Content-Disposition: inline
In-Reply-To: <50977C80.8090000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, w.sang@pengutronix.de

--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 05, 2012 at 02:14:48PM +0530, Shubhrajyoti wrote:
> On Monday 05 November 2012 01:23 PM, Felipe Balbi wrote:
> > Hi,
> >
> > On Sun, Nov 04, 2012 at 04:14:29PM +0530, Shubhrajyoti D wrote:
> >> The dtrev is used only for the comments. Remove the same and use
> >> the scheme instead to know if it is version2.
> >>
> >> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > I would drop dtrev completely and not use scheme to "emulate" it.
> However for ver2 ie omap4plus and previous versions the
> register map is different.
>=20
> So the scheme may still be required.

fair enough, but drop it from debugging messages.

--=20
balbi

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl4FNAAoJEIaOsuA1yqRExbMP/3sqtevJtVmXDphwPhkvnPKm
vE+Rh+6Yal1iH+Web+9yOu48PKG8e322cx4HOk4FzPaLzS7OEX4HL+SrKO1n+6p/
WxRH4rkOXL7Tj6LmH9NQsDRxpcwkBqlipLM5BW85Glx4DEDoo92iwMHzWcs3AswS
YSbBvcQXVP+KBsjrIFVm7N22hMF84Xg97WYKTUqaHzT8jPEhYyR5egsUArdgwcjR
ZLJo3KmxtGk0/n7ZAZ9MDF0JKb8Cw53+6HIsJCs+0704MGG1y/lZ7bqu8VsMnoCI
IH/0u0LOrAHgouZuC+STc/2Q6YxDVt2gHYn9tHTVSana6IlB44MgbuY+IT/BCgTS
2VIBjXfD9JwfEomDtV4DiC8K4QqPIE+ZB/cZU1oWjIqbY4iNGuk3l1KFN08Mxde/
IoB9FPDDs0uZY6TqUa+dd5M6Ra6uM53OHi1bku4QqFjMjkR0vriyNgrsO1TuqoHg
dIw8h2yEjSRPyg6wvlXpsBOenSuKILy2C/cLHu3IpFCTR5LjQVhUaFZOEqfu3Kx6
5QnSanvaCEfFniO3sa0bSR1SKEQol4TRczTvfUxAc1AVE9EPJ/TCSAMMOhG6oURj
46O5RZ8xNJwj4FUMuNlTqbpCtShOqqn5cVFBvNxBcyMzyrKt3BpMja+SkTxnyTUm
YDawaKuV3IfuMsom+dcc
=gD2w
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
