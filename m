From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 sound driver and ECI GPIOs
Date: Wed, 4 Jan 2017 23:41:37 +0100
Message-ID: <201701042341.37944@pali>
References: <201701012054.54505@pali> <2036063.jAbaHqGlp2@saturn> <20170104222749.4xmyws6zcifeicz5@raspberrypi-2.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8948303.7JE7sSu3do";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170104222749.4xmyws6zcifeicz5@raspberrypi-2.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: joerg Reisenweber <joerg@openmoko.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart8948303.7JE7sSu3do
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 04 January 2017 23:27:49 Aaro Koskinen wrote:
> Hi,
>=20
> On Mon, Jan 02, 2017 at 10:05:39PM +0100, joerg Reisenweber wrote:
> > On Mon 02 January 2017 21:01:01 Pali Roh=C3=A1r wrote:
> > > On Monday 02 January 2017 19:49:45 Aaro Koskinen wrote:
> > > > The schematic shows ECI(5:0), but only 3 are connected/used.
> > > > There were 3 other GPIOs reserved but not used in the final
> > > > product.
> > >=20
> > > Are you sure that this is truth (maybe you have some
> > > information)? Or you just looked at schematic and deduced this
> > > observation (as other people too)?
> > >=20
> > > Joerg already told us that RX51 schematic does not 100% match
> > > production N900 and e.g. there is missing UART3 pins...
> >=20
> > We found this, see https://irclog.whitequark.org/neo900/2017-01-01
> > (has a lot of possibly useful references/links)
> > The question is if pin AA3 aka GPIO_178 is actually NotConnected in
> > N900 or it's just an omission in schematics and there's actually
> > some more 'stealth hardware' in N900 that doesn't show up in docs,
> > just like the testpoint UART console
> > http://wiki.maemo.org/N900_Hardware_Hacking#Debug_ports which also
> > are missing in schematics.
> >=20
> > > What we know that gpio 178 is *already* controlled and changed by
> > > production Nokia kernel running on production N900 devices (as I
> > > wrote in first email).
> >=20
> > I could use one of the unpopulated N900 PCB and solder a wire to
> > the OMAP AA3 pad, then try to make sure it's not connected to
> > anything, or if it is then find out about the details of this.
> > But I'm reluctant to do this, since it's an error prone and (in
> > case of N/C) not verifiable procedure, so I'd appreciate any
> > further info, whether from historical anecdote or from sourcecode
> > review and conclusions, regarding that.
>=20
> Even if the published production kernel source controls GPIO 178, it
> does not mean the production device has it connected, as the same
> kernel also supported many older in-house prototype versions of the
> hardware (and some of those had it connected).

Yes, seems reasonable. Also in production kernel source there is on some=20
places check for prototype hw revision and acts differently...

> Probably the easiest test would be to take the final published
> source, and then comment out all the GPIO 178 related code and build
> and run the kernel on the production device. Then see if you can
> observe any difference in behaviour.

Current mainline kernel does not control GPIO 178, so looks like audio=20
somehow working... Jarkko sent driver to mainline so I asked in this=20
thread if does not know something... But A/V cable detection is not in=20
mainline (yet).

We can do that test to verify if production Maemo system is working as=20
before. But result "nothing visible" does not prove that GPIO does not=20
control anything. With this test we can just prove if system stops=20
working as before.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart8948303.7JE7sSu3do
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhteiEACgkQi/DJPQPkQ1LN2ACgzG5erLDHS226n7TyCAQ8Ed12
UYAAnijKbbPynxDvRfvYORVn9z1y/wRz
=ivmS
-----END PGP SIGNATURE-----

--nextPart8948303.7JE7sSu3do--
