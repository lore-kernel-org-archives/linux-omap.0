From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/5] HSI: nokia-modem: kernel based PM
Date: Sun, 31 Jan 2016 19:00:09 +0100
Message-ID: <20160131180009.GB18175@earth>
References: <1454203187-688-1-git-send-email-sre@kernel.org>
 <1454203187-688-3-git-send-email-sre@kernel.org>
 <20160131172948.GC3721@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160131172948.GC3721@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 31, 2016 at 06:29:48PM +0100, Pavel Machek wrote:
> > So far power management had to be done in uerspace using exported
>=20
> "userspace"

Right, thanks.

> > This patch adds kernel based power management, which will bind the
> > modem's power state to the state of the phonet network interface.
>=20
> Ok, so I have ofonod that already does power management in
> userspace. What happens when power management is done twice?

I have patches for ofono, which add support for the in-kernel
power management. Currently ofono will not start with the new
method, since it wants the GPIOs for userspace based PM.

-- Sebastian

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWrkuoAAoJENju1/PIO/qaVi0QAIHH96ITL+rObC20mVH1OXud
vkhmZhT30DUGCkasM6sDX9JTLQgtCXZdid6OLarmsFMPrcU5Vj1bp3noOGRs2Pse
uvFbX40tueed/zz+DsT2vIC3e2wcHCe2WQoK+oQbupHvST2tNITvGJzgU4nuCEOR
O439QoXs/JV5p4IVFExPrB1HPOlTlzehhPIJyWp2I6B1tfCi/pFzifVKrnniyvBQ
H9SGNchEL0kS/lotd/+uhF1TWd9M74BuMXiYCpahzV0wcT3uzL3TaVEQ+vDXG3r1
lBRiMKxHfzYnb6lts0zQeenfgkn1lo+ivViZCaLx/XmQTQ0T/txRlrVIl/cUBufX
UM5s/SBEyd0HOvMGv43vaoeN+vg4mRJAVg+YCLYofjcs+CgTjEsSXO6GzCGBXki6
xDs8k36hZIluAfGE3iUlFtHC+Wx5cCKbCn3Rd3ZQbbkEC3dJT5BC+z+AVZmSGSAW
LQsD683F9SZ76l1KAlRoQNXgbt5ZzbJoBtGPX4ZkIDcpRUY4EasxjDrlgK//9cCm
d16c83OMoqGY6X+PZv/qJWvivnkckgt+F+nUKpzpUMU/qqSKqDdYc5cmCJ9ptZad
mpcSqd3EGsa7uQpn946c+JEknhAWvRBJyfobG+p3/h19cCko88i8CWnHDiwQTPEd
s+h2ynuqrA3wpZNLnjNc
=4dEZ
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
