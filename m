From: Pavel Machek <pavel@ucw.cz>
Subject: Re: droid 4: connection refused from voltage_now
Date: Wed, 4 Jul 2018 21:52:38 +0200
Message-ID: <20180704195238.GA13932@amd>
References: <20180704171156.GA3158@amd>
 <20180704194556.GA9189@lenoch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180704194556.GA9189@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-07-04 21:45:56, Ladislav Michl wrote:
> On Wed, Jul 04, 2018 at 07:11:56PM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > I started to use droid 4 as my primary phone... so I have battery
> > monitor running for hours... Once every few days it dies with
> > "connection refused" error reading battery's "voltage_now". I restart
> > it and it continues working...
>=20
> Ha! What exactly that "connection refused" means? Is it ECONNREFUSED (111=
)?
> I have custom at91 based board here with few custom power supply drivers
> and it sometimes ends with voltage_now of my driver being unreadable.
> (I modified userspace code and waiting what's in errno in case
> reading fails)

It seems to be -110:
Jul  4 11:48:29 devuan kernel: [ 2908.602600] cpcap_adc cpcap_adc.0:
error reading ADC: -110
Jul  4 11:48:29 devuan kernel: [ 2908.608123] cpcap_battery
cpcap_battery.0: cpcap_battery_get_current failed: -110
Jul  4 11:48:30 devuan kernel: [ 2908.922576] cpcap_adc cpcap_adc.0:
error reading ADC: -110
Jul  4 11:48:30 devuan kernel: [ 2908.928100] cpcap_battery
cpcap_battery.0: cpcap_charger_battery_temperature failed: -110
Jul  4 11:48:30 devuan kernel: [ 2908.936340] power_supply battery:
driver failed to report `voltage_now' property: -110

> Adding linux-pm@vger.kernel.org as it seems to be subsytem, specific.

Good idea. Thanks!
									pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls9JYYACgkQMOfwapXb+vIBdwCfbj4nu3YHaW3iY6DJSonTbMSi
eN4AoK8RudLJUGz1umI+ETLc1jelA/xn
=6BUt
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
