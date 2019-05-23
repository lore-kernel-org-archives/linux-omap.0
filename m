From: Sebastian Reichel <sre@kernel.org>
Subject: Re: 5.2-rc1 on droid4: spi crash
Date: Thu, 23 May 2019 11:33:25 +0200
Message-ID: <20190523093325.6si5jpvrvyktpax6@earth.universe>
References: <20190523090926.GA9106@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ungvfzrp4zeutewo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190523090926.GA9106@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--ungvfzrp4zeutewo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 23, 2019 at 11:09:26AM +0200, Pavel Machek wrote:
> This was greeting me overnight... I don't yet know how reproducible it
> is, it happened once so far.

Please pipe the stacktrace into ./scripts/decode_stacktrace.sh
to get a readable stacktrace, otherwise this is pretty much useless.
FWIW the only SPI device in the Droid 4 is the PMIC.

-- Sebastian

> root@devuan:/sys/class/leds#
> Message from syslogd@devuan at May 23 00:11:31 ...
>  kernel:[14889.641143] Internal error: Oops: 5 [#1] SMP ARM
>=20
> Message from syslogd@devuan at May 23 00:11:51 ...
>  kernel:[14909.638275] Process spi0 (pid: 100, stack limit =3D
>  0x97305d31)
>=20
> Message from syslogd@devuan at May 23 00:11:51 ...
>  kernel:[14909.650238] Stack: (0xedee7ed0 to 0xedee8000)
>=20
> Message from syslogd@devuan at May 23 00:11:51 ...
>  kernel:[14909.652069] 7ec0:
>  00000000 00000000 eba35c14 eba35c50
>=20
> Message from syslogd@devuan at May 23 00:11:51 ...
>  kernel:[14909.662841] 7ee0: edd93000 edd93360 ede3da50 c052683c
>  ffffffff edadcc10 edadcc9c 00000004
>=20
> Message from syslogd@devuan at May 23 00:11:51 ...
>  kernel:[14909.671051] 7f00: 00000000 ede3d800 600f0013 edd93000
>  eba35c14 eba35c50 edadcc10 edadcc10
>=20
> Message from syslogd@devuan at May 23 00:11:51 ...
>  kernel:[14909.679260] 7f20: 00000002 00000001 edd9322c c0526cb4
>  edd932a4 edb34600 edd932a0 edd932a4
>=20
> Message from syslogd@devuan at May 23 00:11:51 ...
>  kernel:[14909.687499] 7f40: 00000000 edd932d0 edd932a0 edd932a4
>  00000000 00000001 c0e82d14 edd932b4
>=20
> Message from syslogd@devuan at May 23 00:11:51 ...
>  kernel:[14909.695709] 7f60: c0e82d14 c0148f40 00000000 edca5580
>  00000000 ede39400 edca55a8 edd932a0
>=20
> Message from syslogd@devuan at May 23 00:11:51 ...
>  kernel:[14909.703918] 7f80: ed88dd48 c0148e74 00000000 c01491ec
>  ede39400 c01490dc 00000000 00000000
>=20
> Message from syslogd@devuan at May 23 00:11:51 ...
>  kernel:[14909.708251] 7fa0: 00000000 00000000 00000000 c01010e8
>  00000000 00000000 00000000 00000000
>=20
> Message from syslogd@devuan at May 23 00:11:51 ...
>  kernel:[14909.720367] 7fc0: 00000000 00000000 00000000 00000000
>  00000000 00000000 00000000 00000000
>=20
> Message from syslogd@devuan at May 23 00:11:51 ...
>  kernel:[14909.724334] 7fe0: 00000000 00000000 00000000 00000000
>  00000013 00000000 00000000 00000000
>=20
> Message from syslogd@devuan at May 23 00:11:51 ...
>  kernel:[14909.807312] Code: e3a08c02 e5954034 e1a01005 e1a00007
>  (e5943008)
>  Write failed: Broken pipe
>  pavel@duo:/data/l/k$
> =20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html



--ungvfzrp4zeutewo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzmaN8ACgkQ2O7X88g7
+pqvEw/9GaGTkn2sdHP4E/nBVDOskOXymv3VuTAymJjFtLO14SxcogFTV5NXoyiw
o8Mcu5Yq+aFehyzelPPHYRBxM795P+r+r5pGzDLkwxHFIJ9NPGmXs/LT6ByTIDjv
HD0lqG0zL8TUI/+xhlVHcDqYCk8DMh9Jnu8YN3dovQBIF9AEl2zxfnTLcY1JTl93
pAaXBcfwQ8vq++0vSIX4zYDh9UDUwHW6u2TR0vK0fM67/XD3WmM5YESelVtIxk7S
NuRtYGKePQ+A+LvR+IXDg4p9o9IHZZ+a9WkiWfNa7r/rrWijYN1qN33FQmWBzGmd
gFN6VO6SMsjO8PDn1/xDrDMvih4lc5YuhTI29uQTBzTFe8aPdYGFMu8JBr28XQKB
3np8vxbB6Zp1dNngl9so9XjUba4UrQ3f+emh9seY/s8OVHNp2WOSItp9js25pNoV
7ch1PIlAdSCZ30eWrFoVarj67Hv9/NV477jCwMqU27cbTyNYr3B4sb+O99H1IWAI
s+U4DukAZftmepJlsftiosUZrNiwMASDiBfevBx3Y8nCI/W1HQ9L+//WfE84VVDt
L4mCd2rFSswvXMKaPpWXFdLkNhNqyqA3ZYVaXt8IQdHZzy8RW125kenxiJOV1zz0
05COfbMVDrAZYxCpcZWXJ7JXgVtxfHeSgvF8pGgpQAbUi1OcKxA=
=Gk9g
-----END PGP SIGNATURE-----

--ungvfzrp4zeutewo--
