From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/2] regulator: Enable suspend configuration
Date: Wed, 10 Aug 2016 18:33:23 +0100
Message-ID: <20160810173323.GM9347@sirena.org.uk>
References: <1470831835-22352-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cGfB/trNgB3WtPHu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470831835-22352-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: lee.jones@linaro.org, tony@atomide.com, t-kristo@ti.com, russ.dill@ti.com, d-gerlach@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--cGfB/trNgB3WtPHu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 10, 2016 at 05:53:53PM +0530, Keerthy wrote:
> The series adds suspend configuration for tps65218 and tps65217 PMICs.
> Boot tested on am437x-gp-evm.

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/mfd-tps65218-rev-check

for you to fetch changes up to f11fa1796a4b4f8c6d4ced37e8824276ec57057d:

  mfd: tps65218: add version check to the PMIC probe (2016-08-10 18:21:55 +0100)

----------------------------------------------------------------
mfd: tps65218: Revision checking interface

This patch adds a revision checking inteface which is used by subsequent
regulator changes.

----------------------------------------------------------------
Tero Kristo (1):
      mfd: tps65218: add version check to the PMIC probe

 drivers/mfd/tps65218.c       | 9 +++++++++
 include/linux/mfd/tps65218.h | 1 +
 2 files changed, 10 insertions(+)

--cGfB/trNgB3WtPHu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXq2ViAAoJECTWi3JdVIfQyvwH/iQPtmC8Dij9lLO2DzzKi14a
u11VBHPZZnUOB4r7ZIYuPmkY9jA/O+4RCg44WBESWHJdlSWwuloqHJLTaVtdifxS
mxf2j6je98eeMHuuYU4OdG1OQeQAn1lNGvL6oy2uNRQ07Jjf6mnOC9EqEsiLvZJ2
VEyie97xJqE9kktMPPEI1nEus4N/NEs2lEWSXxprH7rovDoYrnZ66weQthOPzYgm
tDveA9wJqPaqgrprXjllBf2mBtQNiFyTuK9YKZQI0xLOYeU/LsRJ9Mc35vARpSko
Wx3NhqihZQyJWkvn5Xcc81zWu8ov/8PtLfMm+LSW6yaNWV/YDgM0Bi8aP0jEtRU=
=iu6J
-----END PGP SIGNATURE-----

--cGfB/trNgB3WtPHu--
