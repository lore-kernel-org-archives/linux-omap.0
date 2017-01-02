From: joerg Reisenweber <joerg@openmoko.org>
Subject: Re: Nokia N900 sound driver and ECI GPIOs
Date: Mon, 02 Jan 2017 17:07:13 +0100
Message-ID: <18543398.ETO0VDvrVl@saturn>
References: <201701012054.54505@pali> <20170101223639.GA13868@amd> <4f150265-aa9b-c1f3-4634-9df8b320836b@bitmer.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7167287.n4IWvJcAoY"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4f150265-aa9b-c1f3-4634-9df8b320836b@bitmer.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Pavel Machek <pavel@ucw.cz>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Eduardo Valentin <edubezval@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--nextPart7167287.n4IWvJcAoY
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Mon 02 January 2017 11:01:48 Jarkko Nikula wrote:
> Hi
>=20
> On 01/02/2017 12:36 AM, Pavel Machek wrote:
> >> Jarkko, you are listed as original author of that driver. Do you (=
or
> >> anybody else) remember what that rx51_set_eci_switches() function =
is
> >> doing? And what gpio 178 controls? I was even not able to find gpi=
o 178
> >> in RX-51 Schematics [6].
> >>=20
> >> And do you know something about Nokia ECI headsets supports for No=
kia
> >> N900. Looks like there is already some kernel code but support for=
 ECI
> >> bus or multibuttons headset is missing.
>=20
> Multibutton ECI headset support using GPIO was planned during early i=
n
> HW design phase but wasn't implemented for the actual product. I don'=
t
> remember was it due no actual product requirement for it or GPIO base=
d
> implementation was not reliable. If I remember correctly ECI protocol=

> carries information by shorting mic bias to ground at some 1 kHz rate=
 so
> trying to detect those pulses by SW won't work too well without hard
> real-time OS.

I think it's perfectly feasible with an IRQ handler that detects inboun=
d ECI=20
data from edges on ECI0 pin (slightly out of spec for ECI, the Schmitt =
Trigger=20
has threshold 0.5V, for ECI it ideally had 1.1V). The IRQ handler needs=
 to=20
push timestamps onto a stack for a worker thread to analyze and decode,=
 and=20
provide data to userland. Even an *occasional* glitch in data is not ex=
actly a=20
catastrophic failure, user can press same button again to make the inte=
nded=20
action happen.
ECI data-send to be implemented via TVOUT_EN while TVOUT at 0. You coul=
d even=20
lock IRQs during the short (only a few milliseconds) data bursts, to ac=
hieve=20
accurate timing.

http://neo900.org/stuff/joerg/ECI/

cheers
jOERG


>=20
> Even ECI is not implemented in final product the production HW still =
has
> two switches to route mic bias to voltage detection circuit, tv-out o=
r
> codec. One of the switches is statically driven because only codec or=

> tv-out route is needed. See commit 31164c7cf119 ("ASoC: omap: rx51: A=
dd
> headset support")
>=20
> > I'd like to get detection of headset button presses to work in rece=
nt
> > kernels, but could not figure it out :-(.
>=20
> My vague memory doesn't tell how basic button press detection was
> implemented in Maemo kernel. Was it codec, same voltage detection
> circuit than ECI or some another GPIO? I don't even remember did we
> implement it for the MeeGo N900 developer edition :-(

=2D-=20
()  ascii ribbon campaign
/\ =20
against html e-mail - against proprietary attachments
http://www.georgedillon.com/web/html_email_is_evil.shtml         =20
http://www.nonhtmlmail.org/campaign.html
http://www.georgedillon.com/web/html_email_is_evil_still.shtml   =20
http://www.gerstbach.at/2004/ascii/ (German)

--nextPart7167287.n4IWvJcAoY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlhqercACgkQ7Xtwhpk1UgzT7wCeLfHnl/RU8PfepcjcRFZcLlM7
O4oAoInrgqc52pblkqbS2ef9KrOygU2K
=S/oZ
-----END PGP SIGNATURE-----

--nextPart7167287.n4IWvJcAoY--
