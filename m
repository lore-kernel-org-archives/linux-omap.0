From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 00/12] i2c: quirks: add zero length checks and update
 drivers
Date: Sat, 4 Aug 2018 23:23:14 +0200
Message-ID: <20180804212314.oelyhfqxclhatjev@ninjato>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7aewi4gtlzfrpl7f"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-soc@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--7aewi4gtlzfrpl7f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:26:04PM +0200, Wolfram Sang wrote:
> I had this idea for quite some time on my todo list but a soon to be
> implemented refactoring in the i2c-rcar driver now finally made me do it.=
 Add a
> 'can't do 0 length messages' quirk to the quirk infrastructure for and re=
move
> the manual handling from the drivers. This makes the quirk much more visi=
ble.
> (Quite some prominent vendors in that list) We also have a centralized pl=
ace to
> handle updates to the quirk detection if that is ever needed.
>=20
> I have tested this with the i2c-rcar and i2c-sh_mobile driver on a Renesas
> SalvatorXS board equipped with M3-N (r8a77965).
>=20
> A git branch can be found here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/quirk-no-=
zero-len
>=20
> Looking forward to comments, reviews, tests...

I applied all the patches which either got acks from the maintainers or
have no maintainers. I'll reply individually to which I applied. I will
wait some more for other acks before I'll resend next cycle.


--7aewi4gtlzfrpl7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltmGUIACgkQFA3kzBSg
KbarZw/+MqkSaLU5cZh0Ej4pjwuIe4JAPI/uPWDVkXNyeIEo6+WbzoIPFzkDd4ud
K07Rpa875ilzbCF4/arvTbuad4WCjckKF637IAiwL7iZFN8viwwqSTP14jskIp9r
Ikn4s/dKyNNBUyE46Kxl2myhL2KSLES6mHyOq03dEjcykqgAauC+y86iyGU8203N
66KiZQx9Bj5cY8PCOWFNn0xFCfA7EkBRi2bC1dp9w2KHbY1JTt3Iyj5sXzGCQbgw
bqwDq7ME1jtODtiPH/BlGyM6VEe1F06Jn0+meccy6831dJfFtTJgWxYQ91jB9jSg
HcurYXJGeRf89M71jvL7udcNu7SrUNydD3M3sADqDMq7qejhpk1BQ4N2JyIvFWoN
f4l3ZuXiAdwDVkEtJZ0fMV3ZnXYtESI41YqzxAPPXza3QAS3qGR8J0rJN+gOmfxC
wOuvgM7RQLqIh1Wye/6ac3PxJzlMoYiZXUcMsJ3ljHxRrqVagJb20UBij8ip5mJ/
mp+OrI/noPN15A4Cha5QJvcxTKeIyJD9HsVx4kndTQuoGTxqc3SfctDzyN/9BJ0V
FquyU4BUnHetzVdIpK5nLzKIYRyR8lCa7LTYcDJzOQ5Nh/D3O4DUvA/akYTrxeik
/hvcc90N4bvC6EUdceb1baqX0LFOcKZaKo5PGTdZs01kzGPXg5c=
=vEPg
-----END PGP SIGNATURE-----

--7aewi4gtlzfrpl7f--
