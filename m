From: Pavel Machek <pavel@ucw.cz>
Subject: Re: linux-next 2017-08-08 keyboard failure on Nokia N900
Date: Tue, 8 Aug 2017 13:12:43 +0200
Message-ID: <20170808111243.GA20328@amd>
References: <20170808101756.GA12922@amd>
 <20170808103444.GA18247@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170808103444.GA18247@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I tried today's linux-next. It boots on n900 (up to X), but then my
> > screen locks and I can't get back. Touchscreen worked, so my guess is
> > keyboard does not...? Ssh connection over usb still works.
>=20
> Confirmed, its the keyboard.
>=20
> Additionally, battery monitoring fails, because neither
>=20
> /sys/class/power_supply/{n900-,rx51-}battery/voltage_now
>=20
> exists.

And dmesg is helpful in this case:

[    0.675201] input: twl4030_pwrbutton as
/devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c:twl@4=
8:pwrbutton/input/input1
[    0.676635] input: TWL4030 Keypad as
/devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c:twl@4=
8:keypad/input/input2
[    0.679138] twl4030_keypad 48070000.i2c:twl@48:keypad: request_irq
failed for irq no=3D156: -13
[    0.679779] twl4030_keypad: probe of 48070000.i2c:twl@48:keypad
failed with error -13
[    0.682769] twl4030_madc 48070000.i2c:twl@48:madc: could not
request irq
[    0.684051] twl4030_madc: probe of 48070000.i2c:twl@48:madc failed
with error -13
[    0.685852] input: twl4030:vibrator as
/devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c:twl@4=
8:audio/twl4030-vibra/input/input3
[    0.768890] omap_i2c 48070000.i2c: bus 1 rev3.3 at 2200 kHz

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmJnKsACgkQMOfwapXb+vIopwCfV6ULHfXhwxi7royejHsIr3GM
HJcAoLN9JjjRADZr7+7FAuTiWCxoyH+i
=TRx2
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
