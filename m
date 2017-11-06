From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv1 00/14] omapdrm: DSI command mode panel support
Date: Mon, 6 Nov 2017 11:29:53 +0100
Message-ID: <20171106102953.GA8056@amd>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
 <20170929132649.63dy7mzjgknaevoa@earth>
 <b66ec006-e998-b8c6-8ef1-5bf19208c100@ti.com>
 <20171013171207.GO4394@atomide.com>
 <20171023220100.cso5sbxcx7itcj5r@earth>
 <d96752eb-45a0-9766-0022-7eb1594761af@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d96752eb-45a0-9766-0022-7eb1594761af@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > P.S.: I got asked by different people about the status of this
> > patchset, which is required for display support on N9, N950 and
> > Droid 4. It's not just me and Tony, that are interested in this :)
>=20
> Ok. If you agree to help with the DSI part in the future, I have no
> problems applying these (after review and testing, of course).
>=20
> My worry is not only with complicating Laurent's work towards common DRM
> drivers, but also with the maintenance burden this brings. Keeping DSI
> working in the future may be challenging due to the lack of users and
> (easy to use) boards. I do have a N950 and OMAP4 Blaze Tablet, though,
> so I'm able to test both command and video modes. But getting those boot
> up is not always trivial, especially for the blaze tablet.

Well... Yes, they are challenging to boot, because without working
display, debugging them is hard/impossible. Very few people have
serial cables for those, but at least the N9 is pretty common.

PostmarketOS is interested in using it as a target. I'm interested in
keeping it going. With working display, I'm pretty sure I can prevent
regressions... and there could be even some improvements :-).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloAOaAACgkQMOfwapXb+vLjiQCghDPjhplSDZZ7aOGUiqIIRqEw
uqsAn2y6kNk4hx2yV1DNPXdbn3BHO/xy
=gLuT
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
