From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Vibrations on Droid 4?
Date: Tue, 10 Jul 2018 12:11:47 +0200
Message-ID: <20180710101147.lyu65ro4czvrs2da@earth.universe>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="juvchcpv4cmkcawe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180709220211.GA7760@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--juvchcpv4cmkcawe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 10, 2018 at 12:02:11AM +0200, Pavel Machek wrote:
> Hi!
>=20
> > > Do you have vibrations on d4 working?
> > > I believe I have required drivers enabled, but no luck:
> > >=20
> > > user@devuan:/sys/bus/platform/drivers$ ls pwm-vibrator/
> > > bind  uevent  unbind
> > > user@devuan:/sys/bus/platform/drivers$ ls omap-dmtimer-pwm/
> > > bind  uevent  unbind
> >=20
> > Have you checked probe deferrals?
>=20
> Not really. Is there easier way to do that than adding printks in the
> probe function? (I can go through dmesg tommorow).

Option 1: https://lkml.org/lkml/2018/7/8/63

Option 2: dynamic debug via kernel commandline (needs CONFIG_DYNAMIC_DEBUG)

dyndbg=3D"func deferred_probe_work_func +p; func driver_deferred_probe_add =
+p"

Option 3: use "initcall_debug" kernel commandline

-- Sebastian

--juvchcpv4cmkcawe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltEhmIACgkQ2O7X88g7
+prj7g//V3Ho7P3qPttPGD6pDS8+fT3L7m/pAdUDJgD6NlS+qYpo0K2T53ulbEQR
Gz8yXGO2Jc4dJde0TSecJ3x6RvsVh6pHIkuOjiKnFGY058gJAgvhB4Mdu5xIEUNQ
DQRGxEF/Z3DgGYT1cHvqhyB1f2cstKgnQYYj6C7IJON+zmhz/K8IZIAN2jc3oh+r
KRQkcz+VJAmE/rTvuLmpzRPJVkM3j1qha7k7YyKa3wQqhphGDqw+COFaKnvYtHrr
xxU6QwlfwHjsuP0+6BJnJxkTE3VB/aCY5JtKEA2WpZT0ilUHe5OQYT7t+nC5NsF9
J4rD3wrMP7kVyLiIZZ1HWxOTIz2vwFNd1M4P4VJojct0cxPp0/koAqxP7kAr+XcZ
9Z39Ga/xY88bdGEgKyIAf851qum7c14ZTuTgfT+R1K+pxXtZ/bgf8+zHJeH8ih3v
/qUScG/RUYASFYGolbZTQvH5wBokcZWaYSzJFn91Jyp4BgVnJuX2kcQGZuRdUVrz
LxXu1r3ZCHTjVCEtYb92a88P0gkEtymb+W8FXmCBGbyZ3M86Z3m8Ka820ESPLO8P
vVRMZkpRK+cZNKX+ctLH3ZYJz4owq6W3Xi5WKg71/svnuJwxeRfc3EWo4a5gXTTb
CknG2gypxgvMEqDiMe0eFuB1i4P8hFGNV9g2bIjR2iJZpu1GtVU=
=rcYl
-----END PGP SIGNATURE-----

--juvchcpv4cmkcawe--
