From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.16-rc5 on Motorola Droid 4
Date: Wed, 21 Mar 2018 23:13:47 +0100
Message-ID: <20180321221346.GA18313@amd>
References: <20180318220418.GA22880@amd>
 <20180320140322.GU5799@atomide.com>
 <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
 <20180321203137.GA23637@amd>
 <20180321215733.GE5799@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180321215733.GE5799@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net
List-Id: linux-omap@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-03-21 14:57:33, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180321 20:32]:
> > Hi!
> >=20
> > > > Maybe get somebody to help you locally with the debug cable
> > > > soldering? :)
> > >=20
> > > I suppose people from your hackerspace can help you. It's really
> > > easy to do. Soldering can be avoided btw. You can just use a pair
> > > of scissors to cut a USB -> Micro USB cable and use a knife to remove
> > > isolation. Then screw each of the 4 wires into a terminal strip.
> > > There are USB-TTL adapters available, that have an attached cable.
> > > If you also cut the connector from such a cable and connect it to
> > > the other side of the terminal strip you are done. No soldering
> > > involved ;)
> >=20
> > Hm. How big no-no is connecting USB-TTL adapter to D+/D- pins? Because
> > that's what I could do "easily" and seems to work ;-).
>=20
> Well if the VBUS line is not connected the PMIC is muxed
> to USB carkit mode so the lines go to the UART on the SoC
> through some level shifter. If it works it should not cause
> any issues, the symptoms I saw earlier was corrupted UART
> console and noticed that what worked best for me was 3.3V
> ftdi based devices out of the collection of random pl2303
> and ftdi cables I had around.

So.. I do have some fun on the UART (^@ inserted).

> I guess somebody could try to measure the uart lines with
> a scope with nothing connected and sending out data from
> droid 4. Or look at the carkit spec for the UART voltage
> levels.

Voltmeter says Droid4 transmits at 3.3V.

Anyway, it now works for me well enough that I can attempt to debug
the .config file :-).
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqy2RoACgkQMOfwapXb+vJjUgCeKqb8hCT+VU9+XoIVeX3IIx53
1+MAn0jVnKsQ146uVvv5qelbCybwD4rh
=kaaR
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
