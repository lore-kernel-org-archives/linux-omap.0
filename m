From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] hsi / OMAP / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Wed, 3 Dec 2014 02:57:16 +0100
Message-ID: <20141203015716.GA29215@earth.universe>
References: <6319344.XVfdONE5DJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6319344.XVfdONE5DJ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 03, 2014 at 03:02:24AM +0100, Rafael J. Wysocki wrote:
> After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
> depending on CONFIG_PM_RUNTIME may now be changed to depend on
> CONFIG_PM.
>=20
> Do that for the omap_ssi driver.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUfm37AAoJENju1/PIO/qaZBQP/1W0BOz17Rq63nUFxXXBqJUo
8/Xr5Jteme/iS7VbjK30ya1Dv7bogM2gTJOo+BNILVhb3L8rZQilsC+CyPNUubtd
lmccFgtSeusC0X956oZ5w7N9C+mN+qYrOXlby+/5qvLUuxTHBHKVS6tJPJOBPFGh
WsCKFDWte1P/Yzqh8baxXdjLa6ul4FEF+U7eBcfqyf/2va/6xPvG6q1zIBuX1O+j
fO7nsO1biGvyFXgTLsuwU2CKETdULlzjI/SAJgRfifwCdtoQ+U9hNI/aYovrbkpy
ys/KjBhDlzL6BP+R1zxpS4QBOThLf8+9UXceuCuxIF5s3qamBDyI+MN6+HgHVl7n
Kxb8/HcCWgYclB/RHPBMl7nFqnbhhmdw7kDWqaekVOYGHjkEJa5DTKHN2ubqXHmX
K5HrPs6gpuD4BcXnana52hgVSrBCdh+jPlQz5SDzJtlR+daFzTuIt/T08yBXkpkT
o2mDsMIxshHxlhr2DNJM5reN/nmQdv+WPJ7kB7B7hlLRpTskXo+O+q3YVsbjvu4U
E0ZaxUmQD5uyZK9R1w3+rKh56r5Hh/Y1LdbId66zLxQ5DXCWv2Iq+eblSdSaQ9q6
fIAY9M+ZW2U24ux7dVF8vr6GC579Lx85nrKeondrW1evc/YxXE82JXXf8zScJJFv
NAzsH0mA64IWOLBCTOHX
=jA9Q
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
