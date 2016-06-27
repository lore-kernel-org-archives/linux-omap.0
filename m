From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 5/5] regulator: tps65218: do not disable DCDC3 during
 poweroff on broken PMICs
Date: Mon, 27 Jun 2016 17:59:30 +0100
Message-ID: <20160627165930.GC17217@sirena.org.uk>
References: <1466756892-17015-1-git-send-email-j-keerthy@ti.com>
 <1466756892-17015-5-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466756892-17015-5-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: lee.jones@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 24, 2016 at 01:58:11PM +0530, Keerthy wrote:
> From: Tero Kristo <t-kristo@ti.com>
>=20
> Some versions of tps65218 do not seem to support poweroff modes properly
> if DCDC3 regulator is shut-down. Thus, keep it enabled even during
> poweroff if the version info matches the broken silicon revision.

This is fine but depends on the MFD bit so needs to wait for that to be
reviewed.

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXcVtwAAoJECTWi3JdVIfQTQIH+QEwK/ay4gusnCJA7HQU4fPs
7OW0bB/mPFR7maTwV+qPG9wxsuEMfHD+Sb31t0Ul7nD1vUOcVbxe/dlkqFMMo33h
1goj2tWiuUgiRf/9KXXGLt/7WZf/cIqMnCSX5mzcLHVxVyiUSdyJgFi+l2gYDE33
tOkqde29bQi4fhqORaMO1JJBFvEW3hAOUbBv789swtljKhzNBBIRgcqTRADfzV+D
LlL8HaKUO73auh746TWTpWmnI9MQ9UOWSNtM8UmWvTJK2WS4wbSs0MNVbKdCd8FD
Ib58f2dqT+geXr/sIsccz2oeLbpe7VEURRZXya0AAOgS+f7SdY/T4qSPRGrUTpo=
=KuGt
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
