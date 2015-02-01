From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: bq2415x_charger.c: battery is discharged (fast, 224mA) when it should be charged
Date: Sun, 1 Feb 2015 11:08:16 +0100
Message-ID: <201502011108.16071@pali>
References: <20150201094702.GA21628@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1750516.xogtbURvkl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150201094702.GA21628@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com
List-Id: linux-omap@vger.kernel.org

--nextPart1750516.xogtbURvkl
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sunday 01 February 2015 10:47:02 Pavel Machek wrote:
> Hi!
>=20
> I connected N900 with full battery using USB. For some reason,
> charge limit was set to 100mA, battery was "full" and was
> discharging:
>=20

Make sure you have loaded some usb gadget. Without it battery=20
charging via dedicated wallcharger (and probably also usb host=20
charger) does not working. g_nokia should be OK.

Try also compiling kernel with CONFIG_USB_GADGET_VBUS_DRAW=3D500

Also for charger autodetection you need to have loaded=20
isp1704_charer.ko module (or compiled into kernel).

And make sure that isp1704_charger is loaded before module=20
bq2415x_charger (there is some probe defer, no idea if it works=20
as excepted).

> root@n900:/my/tui/ofone# ./tefone
> Ready.
> Battery  4.017 V  4.039 V  81 %  0 %  0 / 0 / 2056 mAh  Full
> -242.224 / 550 / 100  mA
>=20
> I adjusted the current limit, but got no change, battery is
> still discharging, fast:
>=20
> root@n900:/my/tui/ofone# echo 500 >
> /sys/class/power_supply/bq24150a-0/current_limit

You can try to write "host" to sysfs entry "mode". Another value=20
is "dedicated" for wallchargers.

> root@n900:/my/tui/ofone# ./tefone
> Ready.
> Battery  3.994 V  4.034 V  78 %  0 %  0 / 0 / 2056 mAh  Full =20
> -251.506 / 550 / 500  mA Battery  4.0 V  4.037 V  79 %  0 %=20
> 0 / 0 / 2056 mAh  Full   -223.125 / 550 / 500  mA Battery=20
> 4.005 V  4.037 V  79 %  0 %  0 / 0 / 2056 mAh  Full   -224.91
> / 550 / 500  mA Battery  3.994 V  4.037 V  78 %  0 %  0 / 0 /
> 2056 mAh  Full   -224.91 / 550 / 500  mA Battery  4.023 V=20
> 4.037 V  81 %  0 %  0 / 0 / 2056 mAh  Full   -224.91 / 550 /
> 500  mA Battery  4.011 V  4.037 V  80 %  0 %  0 / 0 / 2056
> mAh  Full   -224.91 / 550 / 500  mA Battery  3.994 V  4.031 V
>  78 %  0 %  0 / 0 / 2056 mAh  Full   -256.504 / 550 / 500  mA
> Battery  3.994 V  4.029 V  78 %  0 %  0 / 0 / 2056 mAh  Full=20
>  -224.017 / 550 / 500  mA Battery  3.988 V  4.029 V  77 %  0
> %  0 / 0 / 2056 mAh  Full   -224.731 / 550 / 500  mA Battery=20
> 4.005 V  4.023 V  79 %  0 %  0 / 0 / 2056 mAh  Full   -223.66
> / 550 / 500  mA
>=20
> I'm getting a lot of
>=20
> [  208.037719] bq27x00-battery 2-0055: battery is not
> calibrated! ignoring capacity values [  238.038024]
> bq27x00-battery 2-0055: battery is not calibrated! ignoring
> capacity values
>=20

Message is print every time when somebody try to read those=20
properties. I think that printing it only one time should be=20
enough. Change to WARN_ONCE?

Also design capacity from bq27x00_battery is incorrect (2056) on=20
all N900 devices. It comes from some EEPROM memory stored in N900=20
and without HW hacking it is not possible to rewrite.

I would suggest to add support for bq27x00_battery module to do=20
not report design capacity. Maybe in N900 DT file can be property=20
which tell driver to ignore it.

> messages, that's why all the 0s in battery information dump.
>=20
> Any ideas?
>=20
> Thanks,
> 									Pavel

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1750516.xogtbURvkl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTN+xAACgkQi/DJPQPkQ1K21QCcDG+g8bst0zJYQJf4ymMDh7x/
TYsAnRAgwQAu9qDEYYo68Wm9r4gbLwtJ
=6vIo
-----END PGP SIGNATURE-----

--nextPart1750516.xogtbURvkl--
