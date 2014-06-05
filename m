From: Mark Brown <broonie@kernel.org>
Subject: Re: mainline boot: 37 passed 4 failed
 (mainline/v3.15-rc8-4569-g3de0ef8) (palmas regression uEVM)
Date: Thu, 5 Jun 2014 12:42:07 +0100
Message-ID: <20140605114207.GW2520@sirena.org.uk>
References: <538e6a20.0168440a.7895.422b@mx.google.com>
 <CAOesGMg4ESoPVvCc4is7wpA8PVOOSDzh5=VZZ67NnJjD3jUzmw@mail.gmail.com>
 <20140604090111.GE2520@sirena.org.uk>
 <20140604193431.GB4858@kahuna>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8R/sMIKPJVD0CT2D"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55022 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbaFELmm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jun 2014 07:42:42 -0400
Content-Disposition: inline
In-Reply-To: <20140604193431.GB4858@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, kernel-build-reports@lists.linaro.org, Tony Lindgren <tony@atomide.com>, j-keerthy@ti.com, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--8R/sMIKPJVD0CT2D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 04, 2014 at 02:34:31PM -0500, Nishanth Menon wrote:

> Seems to help my OMAP5uevm.
> If this makes sense, I will repost it as a formal patch.

Actually I just went ahead and applied this - thanks!

--8R/sMIKPJVD0CT2D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkFeMAAoJELSic+t+oim9NzUP/073yOAShhg6MSGsf91I0ggF
Mb/g+TL4cpyzQ69WJ7W5nSga03orZxgyy7P9jkZWewUYN4EgLjtlvuwHPQyK9vli
t5ee7vbs9gsPNHh+dVHtgyuk+wh+Q+y/yoiOB2ZiqslNVnK6SP7lhvsdMT2ZskKk
sgMFINrMxp8lmD8MxjWKhnrnv6GLTlWd28YO5CESkzKRXlsnS2E9K42RplyUKdAL
IdCCF85yFmIvh2K96thyDyAQy16+m7nXVIkOPzE71HiL/I70Wofjkg0pUg642WF6
K5ey0uklELlz2vj0KuSo26nJ5DYKLiRMNem6VMyVYgBowEsx+1kPxCniwHSErLaN
Pf90UE56NXJwxnTQgIbQLdDm6JpU6dWc+OE9KkYsk1/waMFTR93zvcjMZq09XhUo
v5dGzObVDOm9bK5b5oVAr5d56nxwZf8uiO/mOezY4DQWqV1G4N81R3cHQoYN6Cpx
Z3rzH04dNwUQUGDoLsLTomUlVMNqc6UxEvDttE+IqLX9idchHgpCgfDYC3GRf6+0
NA7rwCtMAodRivJQpHmN2TRyNRnz/ejNw9ZPTTsGnEhO9U0A2YhOPc1UzLQlr5dq
0qHhP+MfeNFpA+SzVrEmgXCnxA+dB3PyJ8JlssM1CS8Rk/1E4xEijv2u1h5AgyyG
ym5GBD6Qgl2tg5eDiLS/
=e9GN
-----END PGP SIGNATURE-----

--8R/sMIKPJVD0CT2D--
