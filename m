From: joerg Reisenweber <joerg@openmoko.org>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Thu, 21 Jan 2016 19:44:22 +0100
Message-ID: <3690314.8jDXSUDcRZ@saturn>
References: <201601091616.04193@pali> <2300247.VhtcKLq8UC@saturn> <20160121174146.GK19432@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23471318.CzODpfyRGr"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160121174146.GK19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org


--nextPart23471318.CzODpfyRGr
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Thu 21 January 2016 09:41:46 Tony Lindgren wrote:
> Then for supporting the USB host mode.. We should add regulator suppo=
rt
> to the USB PHY driver so if the ID pin is grounded, the PHY driver en=
ables
> the VBUS regulator. That too seems to need some coordination between =
the
> drivers/phy/phy-twl4030-usb.c and 1707 driver if the ID pin interrupt=
 is
> only detected in drivers/phy/phy-twl4030-usb.c.

Note that, while this is probably a good thing to do, it needs to be=20=

sufficiently loose coupling to allow user to 'intercept' this VBOOS reg=
ulator=20
enabling and instead allow device charging while in externally powered=20=

hostmode. There's even a spec for this in USB-docs-foo iirc, something =
along a=20
certain resistor value on ID to GND - alas I guess the twl4030 is not c=
apable=20
to detect such sophisticated signaling, and anyway it's always desirabl=
e to=20
allow user to manually override the VBOOST and enable VBUS-charging whi=
le in=20
hostmode.

On N900 the situation is even more complex since the 1707 doesn't suppo=
rt=20
genuine ID detection, neither does it support emulated ID grounding. An=
d=20
there's no other method than a ID=3DGND message from PHY to musb core t=
o make=20
the musb core state engine transfer into proper hostmode. Thus my H-E-N=
=20
hostmode botch abuses debug flags to force the musb core into a "emulat=
ed"=20
hostmode and this mode doesn't support USB speed detection. Thus speed=20=

settings are forced onto musb core and PHY by software, and the musb co=
re=20
speed bits are only effective before session enabled.=20
Bottom line: you need VBUS to try and negotiate speed with the attached=
 device=20
in hostmode, but to actually set this speed you detected by software me=
ans,=20
you need to disable and discharge VBUS again, or musb core won't care a=
bout=20
the speed you set. To be utterly clear: unconditional enabling of VBUS =
in=20
ID=3DGND won't work.

This is quite complex and it's questionable if it could get handled rea=
sonably =20
in kernel space. *Very* N900 specific niche solution, I'd not think it'=
s suited=20
for upstreaming.

/jOERG
=2D-=20
()  ascii ribbon campaign
/\ =20
against html e-mail - against proprietary attachments
http://www.georgedillon.com/web/html_email_is_evil.shtml         =20
http://www.nonhtmlmail.org/campaign.html
http://www.georgedillon.com/web/html_email_is_evil_still.shtml   =20
http://www.gerstbach.at/2004/ascii/ (German)

--nextPart23471318.CzODpfyRGr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlahJwoACgkQ7Xtwhpk1UgzPPQCgnRVhJMrYBUfYTNmgHKYePjFj
Fs4An3+tx0yQReh4SFfkspHRSPp7hDZy
=3GZ3
-----END PGP SIGNATURE-----

--nextPart23471318.CzODpfyRGr--
