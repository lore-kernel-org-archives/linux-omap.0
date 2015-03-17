From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] regulator: TPS659038: Fixes for REGEN2 and REGEN3
Date: Tue, 17 Mar 2015 12:21:57 +0000
Message-ID: <20150317122157.GK28806@sirena.org.uk>
References: <1426587965-23553-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aVF5wPVC5Z7LhB4n"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426587965-23553-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--aVF5wPVC5Z7LhB4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2015 at 03:56:03PM +0530, Keerthy wrote:
> The series fixes couple of issues in the driver w.r.t TPS659038 PMICs.
> 1) Correcting the REGEN2_CTRL address.
> 2) REGEN3 is not present hence adding a check not to register for TPS6590=
38.

Applied both, thanks. =20

>   regulator: palmas: Correct TPS659038 register definition for REGEN2
>   regulator: Palmas: Add has_regen3 check for TPS659038

Please try to keep the style of the subject lines consistent...

--aVF5wPVC5Z7LhB4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCBxlAAoJECTWi3JdVIfQNdsH/AgstvLT/Bwu/ld33j4tZ1be
Ej2h+6XfVU2j0Vs7d8j+Mx2lHTBcDQIdNhLFNXDXglqgCCsFZJVqFTcguAZK1WK/
sBrChmfaa8tCN/2p8hD8yy6W2hIY6dPrCDMoKX70KJXgjI8NmQrxEzCXVIgo3mF7
CoCF1LvtlygQmLePxV+Md4KxELpPnpbWRpAqA5wl7w4MedHTf/HoOvbzscJ6hvQq
R9hkaSJbzW3moZEJMBHtpF3RhMdJpRq4wo45QjZY3bcWA1btijhPhZ+c/Qwj5rXn
YKqSNISeXMmIzXv1ySYCGyTYdvjtG7LibHyE2a0Kov5xEFytdUJaRt0aNRQiS38=
=BzMI
-----END PGP SIGNATURE-----

--aVF5wPVC5Z7LhB4n--
