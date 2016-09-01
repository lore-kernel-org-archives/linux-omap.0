From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "regulator: tps65218: do not disable DCDC3 during
 poweroff on broken PMICs" to the regulator tree
Date: Thu, 1 Sep 2016 11:06:16 +0100
Message-ID: <20160901100616.GH5967@sirena.org.uk>
References: <1466412218-5906-9-git-send-email-j-keerthy@ti.com>
 <E1bXZja-0000XE-A6@debutante>
 <20160831150115.GP9415@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G44BJl3Aq1QbV/QL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160831150115.GP9415@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, russ.dill@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org


--G44BJl3Aq1QbV/QL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 31, 2016 at 04:01:15PM +0100, Lee Jones wrote:
> On Wed, 10 Aug 2016, Mark Brown wrote:

> > The patch

> >    regulator: tps65218: do not disable DCDC3 during poweroff on broken PMICs

> Looks like I also need this patch.

> Would you be kind enough to shoot me a pull-request please?

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/tps65218-dcdc3-workaround

for you to fetch changes up to 23a34f9d03a5d40a6234855bc069da370708cc9e:

  regulator: tps65218: do not disable DCDC3 during poweroff on broken PMICs (2016-08-10 18:21:55 +0100)

----------------------------------------------------------------
regulator: tps65218: Workaround for broken DCDC3 disable on some revisions

----------------------------------------------------------------
Tero Kristo (2):
      mfd: tps65218: add version check to the PMIC probe
      regulator: tps65218: do not disable DCDC3 during poweroff on broken PMICs

 drivers/mfd/tps65218.c                 | 9 +++++++++
 drivers/regulator/tps65218-regulator.c | 8 ++++++++
 include/linux/mfd/tps65218.h           | 6 ++++++
 3 files changed, 23 insertions(+)

--G44BJl3Aq1QbV/QL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXx/2XAAoJECTWi3JdVIfQ5p8H/1dMoqP+DukVRQFI0kS1ke7E
CxaWhdRm96082V/2vBuI7wrD+2h4nkQZnzG/tb23XHK/3oss9YR3GsX3KpY0IUtR
xLIcvbkihL1eFpDsIatIJZwpthVRGMK+Vak5Hp/r78DKE1nAn9172Dwd3/zcRBtW
AUb/sbl/ZEFzoRkLWnSC6bm8GHFuMDYPA+22yiN2eEjqgWJvB2zNUjFO94UwmYc5
CnehegI9mnoCpX6KVWiCvJxTUgUCQY/xAuPaVsFNKd+7XsJQbPiUnZUXTwd0U4O8
Xz20q1I8W3FCvN36159xD/2kl2MRDxv+hJZzRS0nlftDIhz4zn1xca+CjhOjOkE=
=NElR
-----END PGP SIGNATURE-----

--G44BJl3Aq1QbV/QL--
