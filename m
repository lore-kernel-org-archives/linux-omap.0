From: Pavel Machek <pavel@ucw.cz>
Subject: Re: device tree bindings for lp5523 leds on N950?
Date: Fri, 3 Nov 2017 22:28:13 +0100
Message-ID: <20171103212812.GA15026@amd>
References: <20170814133816.GA24493@amd>
 <20170815131518.jt4xff6qv4whebul@earth>
 <20170822102214.pmag4k2dxz4fdvq5@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170822102214.pmag4k2dxz4fdvq5@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Tue, Aug 15, 2017 at 09:15:28AM -0400, Sebastian Reichel wrote:
> > Hi Pavel,
> >=20
> > On Mon, Aug 14, 2017 at 03:38:16PM +0200, Pavel Machek wrote:
> > > I'm (still) trying to debug "N950 not booting" situation. I'm stuck
> > > with black screen, so I thought it would be cool to use RGB led for
> > > debugging...
> > >=20
> > > Unfortunately, I don't see required dts bindings in the mainline.
> > >=20
> > > Does anyone have that working?
> >=20
> > I have some N950 DTS patches lying around, I think RGB led was one
> > of them. I'm currently in Canda for a company event without my N950,
> > but I should be able to send something tested before the weekend.
>=20
> Below is a DTS snippet for N950, that has been tested by me
> on top of 4.13-rc6. The left and right keyboard LEDs are
> also debug LEDs for cpu idle modes, so they will be lit
> without being enabled in lp5523. The status LED of N950 is
> not RGB, but just white. Also you need this to get the driver
> loading. Otherwise detection after reset fails even after
> quite increases waiting times. Looks like the lp5523 reset
> (which is not properly Ack'd by the device) breaks the omap-i2c
> state horribly.

Thanks a lot, LED now works. It took me a while, but I now have n950
usable with nfsroot. (For a while, anyway.)

N9 is usable too. Hardware is similar enough than it could be possible
to debug without serial cable.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAln832wACgkQMOfwapXb+vLUGQCgp9LEU5anqwjXbBfauKR22vBR
k5UAn1yCtf+iN7c4sTct7gUM0siqy9Wj
=TIvh
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
