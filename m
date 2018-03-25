From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Mon, 26 Mar 2018 00:55:56 +0200
Message-ID: <20180325225556.GA18141@amd>
References: <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
 <20180323105455.GB21644@amd>
 <20180323113521.45va72bhzis6ym6m@earth.universe>
 <20180323201343.GC23658@amd>
 <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
 <20180324142517.GA94954@atomide.com>
 <20180324200224.GA17857@amd>
 <20180325154512.GC5700@atomide.com>
 <20180325185857.GA7582@amd>
 <20180325205232.GD5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180325205232.GD5700@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dan Williams <dcbw@redhat.com>, Sebastian Reichel <sre@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Hmm. Interesting. Anyway, for me ttyUSB4 is interesting, as it seems
> > > > to react to AT commands, and in particular reacts to ADT123; (; is
> > > > important).
> > >=20
> > > Is that to dial a voice call?
> >=20
> > Yes. And it is ATD123; not ATD.
>=20
> Strange, no semicolon is needed when using /dev/gsmtty to
> dial a voice call with my current pile of pending changes,
> just doing ATD123 dials..

Interesting. Maybe I made some mistake in experiment.

> Anyways, looks like qmi_wwan needs to be loaded before
> qcserial module, otherwise we get nine ttyUSB instances
> and ModemManager can't find any modems.
>=20
> With qcserial module loaded after qmi_wwan, it still takes
> a long time for ModemManager to find the modem.
>=20
> Then unrelated to the qcserial module, also looks like I can
> no longer use the GPS with ModemManager:
>=20
> $ mmcli -m 0 --enable
> $ mmcli -m 0 --location-enable-gps-raw
>=20
> And then chmod a+r /dev/cdc-wdm0 and pointing gpsd to use
> /dev/cdc-wdm0 used to work, but now it seems that gpsd
> can no longer read it. Trying to start gpsd manually produces:

Thanks for hints, it would not be bad to get gps working. But .. voice
calls. Those are important :-).

> # gpsd -b -n -N /dev/cdc-wdm0
> gpsd:ERROR: SER: /dev/cdc-wdm0 already opened by another process
> gpsd:ERROR: initial GPS device /dev/cdc-wdm0 open failed
> gpsd:ERROR: can't run with neither control socket nor devices open
>=20
> And lsof shows /usr/libexec/qmi-proxy having it open.
>=20
> Anybody know what I might be doing wrong? Sounds like something
> now needs to be done with qmi-proxy to get access to GPS?

Maybe kill the proxy and then look at cdc-wdm0 by hand? NMEA can be
parsed by hand... quite easily.

Good night,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq4KPwACgkQMOfwapXb+vLlXQCfW69Yooxx1KfGR/ikR+B4U4Rr
KHAAnjdk+rTRZRKE4r7qSkPmUV9MZpI8
=U8HG
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
