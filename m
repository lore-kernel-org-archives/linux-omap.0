From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/7] i2c: clean up include/linux/i2c-*
Date: Thu, 17 May 2018 16:32:03 +0200
Message-ID: <20180517143202.vzwmqkemlqxj2xgu@ninjato>
References: <20180419200015.15095-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2am76ftu5fuftxje"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180419200015.15095-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-mips@linux-mips.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--2am76ftu5fuftxje
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 10:00:06PM +0200, Wolfram Sang wrote:
> Move all plain platform_data includes to the platform_data-dir
> (except for i2c-pnx which can be moved into the driver itself).
>=20
> My preference is to take these patches via the i2c tree. I can provide an
> immutable branch if needed. But we can also discuss those going in via
> arch-trees if dependencies are against us.

All applied to for-next!

The immutable branch is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/platform_da=
ta-immutable

Thanks,

   Wolfram


--2am76ftu5fuftxje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr9kmIACgkQFA3kzBSg
KbZKxw/+JSU2lxyogS2eTiaKLZ+5KEMXeB/xFcc1vSljvMU6dkspqQUo7QJHZW8Q
AsIJtMO1XLfKODlsmidF4yhhOy2cninfK+MQbmZOsuReUF5eEf9DnUxs6YE1YKmJ
3MuoIHqmKXDEYUjL+0xJeU5g8lsPbXVyML+AJ+96THHEDkUf0MeAFApESAoplIWa
/+B+A465tDedkI1MCSrNNtwiNUUfkMFyS9G6UFIT3ovjbofNN8xoyNP+5aYqwd2S
DtVRPNaBg8kYzZur7na3n9+ARxGHGFPOLpx+Z5E67IEfJlS5uYLFuZBhQyXyKLBx
qhhOB6/lHP5hW7vU2EyUjHvpHS55SP0kIQltV85krPlOvmrV3aBp+ucL87NM2BfQ
OTIUTLZdo49bY1gmPo2FfKtPuPgK9T6t82LOrO/IBx7PkaXSNxhw9HL6+kRyxHBI
ELISIMIDIrUG27qhrbBT5ttdTJkAKDvviW/e7vy5VHcEHztrK3L0oz/PMDmlzIvL
YFts1pN6v61jRyr/J7Dv3MYk1bk+B/n94kuZgnTrUws+6Zbv9MBw5l28kOClOp3N
grELJFSGl5PPSiGp7lntGVSt46iEhJToQzwNRbJHL2Ks19rFPlzBbQCRxY3VtJAj
jZ7YVZnaWnmDyRUvedNP+YeiTW351d6OQeJAeK6s+9iCz0GjpX4=
=vxpG
-----END PGP SIGNATURE-----

--2am76ftu5fuftxje--
