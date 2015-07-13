From: Sebastian Reichel <sre@kernel.org>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Mon, 13 Jul 2015 17:51:39 +0200
Message-ID: <20150713155139.GA17362@earth>
References: <201507111405.06048@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201507111405.06048@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 11, 2015 at 02:05:05PM +0200, Pali Roh=E1r wrote:
> now I tested 4.2-rc1 release on Nokia N900 and couple of drivers are
> broken and cause kernel oops...
>=20
> Basically wifi, touchscreen and rtc drivers not working...

I just tried 4.2-rc2 and I can't see any of the problems you have:

[    2.473968] twl_rtc 48070000.i2c:twl@48:rtc: Power up reset detected.
[    2.481170] twl_rtc 48070000.i2c:twl@48:rtc: Enabling TWL-RTC
[    2.492095] twl_rtc 48070000.i2c:twl@48:rtc: rtc core: registered 480700=
00.i2c:twl@48 as rtc0
=2E..
[    3.017028] wl1251: loaded
[    3.022430] wl1251: initialized
=2E..
[    3.065490] input: TSC2005 touchscreen as /devices/platform/68000000.ocp=
/48098000.spi/spi_master/spi1/spi1.0/input/input5
=2E..

The only thing I noticed is, that the display is not working.
For some reason it is not enabled:

root@n900:/sys/class/drm/card0-Unknown-2# cat status
connected
root@n900:/sys/class/drm/card0-Unknown-2# cat modes
800x480
root@n900:/sys/class/drm/card0-Unknown-2# cat enabled
disabled

-- Sebastian

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVo96IAAoJENju1/PIO/qaN9AQAIv0d/XuK61srbra9eEQNVrb
stDiWMUJzw3YzU5j0K75JS/28hLF1COcDhwrNqZsaEbdA1CEq5MNn9t5naREYzNn
Rz8PSnr5RQo3SE5kwMeiKDPpbTd9qBeSadv4pt6q2bWUCF6VMDOerSS+edE9/emc
wE0K0BCuq+X+ochomK/tg22pDrI+8VKGAqknV01f2PaGuUFIN4lsoCEQIE140BC7
qHtdJ2LZwphCl0gQJH5kQZjsRFjz2vqiU79t6bM4kETlUkOrPI4OfoUg9+Msxd4g
MZgsPIpAZrozMfodRhdyQH69Yl/VtVrjrUL31APC0rWFEzJSBAyo/lyjCtQOmmUh
FAm0OXqSG3h9ku/KGDwFv3GlKyzCHLT+NH8K367FjQ6KZ/qHtheGRTLDfrw9IxD0
9O25O2ezpjFwxuUSMRMq7wIr/QvMjpK5+QarnBW1J4jrUh7w8Ry1q2URZlER0/jL
TVw75OiHuk9zh2gYlwdqUUGHDyo7MDMR4i8vjbK5rV/GzB5KJa13CsL6kPfgVTA6
aBcTiAUYj7z3sZAao4v8fdhVRH3kWaro1+zAZu18D8dR1jKZHCuPgYfPUbxw7W8T
Q0ICKxmyHXEuE5JRNl+xHyi8lYthaGihYKh2XOq9+jThfY112/NBhesu6XQO8+C4
mSDjJiWYzIWodQHjjnqQ
=bHdA
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
