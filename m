From: Sebastian Reichel <sre@kernel.org>
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Date: Tue, 29 Jan 2019 18:18:44 +0100
Message-ID: <20190129171844.n6wflw4ehfdy3izs@earth.universe>
References: <20190129164813.GA5720@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nxdsms3oudxktwtr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129164813.GA5720@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Douglas Anderson <dianders@chromium.org>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--nxdsms3oudxktwtr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 29, 2019 at 08:48:13AM -0800, Tony Lindgren wrote:
> Looks like commit 5451781dadf8 ("regulator: core: Only count load for
> enabled consumers") started showing new warnings with v5.0-rc cycle:
>=20
> regulator-dummy: Underflow of regulator enable count
>=20
> I'm seeing this at least with my pwm-vibra test case:
>=20
> # rumble-test /dev/input/by-path/platform-vibrator-event 0xffff
> pwm-vibrator vibrator: vibrator supply vcc not found, using dummy regulat=
or
> input: pwm-vibrator as /devices/platform/vibrator/input/input4
> regulator-dummy: Underflow of regulator enable count
> Upload rumble effect... id=3D0
> regulator-dummy: Underflow of regulator enable count
>=20
> Are these bogus warnings for dummy regulator or do we have
> real unpaired regulator calls or somewhere?

There are real unpaired regulator calls in the pwm-vibrator driver,
that I did not notice when I wrote the driver :(. Good news is, that
Pawe=C5=82 Chmiel and Jonathan Bakker are already working on fixing my mess:

https://lore.kernel.org/patchwork/patch/1032759/

On Droid 4 it's a dummy regulator, since I did not know what
regulator is being used to supply the vibrator. Probably directly
=66rom the battery.

-- Sebastian

--nxdsms3oudxktwtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxQivIACgkQ2O7X88g7
+prOCw/+OTUVuiiDL1E9MnpFholjz2hyATTT2hLR5GIbulVgaypDSmK9lj/D+3Lh
m6XSToHBxskFyx4ZEbxmijxtF15l7wIzBzhDUzoFjzkAiAiSFoRVzfxG638lGULs
2X+ZOVpKv2fURtknjO2OUA7XavVl/XQLY5Ry3gCHYQm3W0V8gC/6fEtNBOvE4/nw
SJ3Y3cIzZ7OktP5sVp7bfXuPuHmc5XqnBR4GUMtjkds4fdRonyPW8rEPQkMxkIT6
kAGxT2v8bElbCb4DWz4CD+eYbX286ino5gjcOIOeJd0lVjaDZzT3vKy+Q9oTyhhr
OY2KRiuYxTJbz8qCAgK+DCnAIy/ev1t6wJRdH5SGfqHk6/Sp5WWi7fOLkzCclolp
qWOD0fG7fKVD5/PCwi7HjHuCa5A6QSJkB3eBu4YIayQF2x5miBDlIpmu3pISWaxc
3LX5pUDxrUW3qbM33uVTMPO++tm3ZxauYTkJSZTMnogYOeNtthh/9AkuTkJpPBhn
Rnve1dkHLNZrKA/3JtJWj6JVVP6Sy3j/2NXkeX2xnreYYYqcN19OQMchD19ogPVn
3rdvfuoOMDpB4RjoN87D7bIgbsBVWJJIvLtvtvdy09u0qn6ztgpq0SX7f4Z01tg2
rEjKoeBi54HCEr38Ti6uxAPh3rl83BmgWJ4qDVnd0tMhBUOCNiQ=
=l1E0
-----END PGP SIGNATURE-----

--nxdsms3oudxktwtr--
