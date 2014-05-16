From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: some PRCM cleanup patches for v3.16
Date: Fri, 16 May 2014 04:48:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1405160445440.29738@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36266 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbaEPEsG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 00:48:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git for-v3.16/prcm-cleanup-a

for you to fetch changes up to 70fcebf1965b66d73bd8ae7955bd663ab8012c56:

  ARM: OMAP4: PRCM: remove references to cm-regbits-44xx.h from PRCM core files (2014-05-15 22:35:10 -0600)

- ----------------------------------------------------------------
Some OMAP PRCM cleanup patches.  These help prepare to convert the PRCM
code into drivers.

Basic build, boot, and PM test results are available here:

http://www.pwsan.com/omap/testlogs/prcm-cleanup-v3.16/20140515213244/

- ----------------------------------------------------------------
Tero Kristo (10):
      ARM: OMAP3: CM: remove a few OMAP34XX_CM_REGADDR defines
      ARM: OMAP2+: prcm: add omap_test_timeout to prcm-common.h
      ARM: OMAP2/3: CM: remove some external dependencies
      ARM: OMAP4: CM: use cm_base* in register address calculations
      ARM: OMAP2+: PRCM: cleanup some header includes
      ARM: OMAP2+: PRM: remove unnecessary cpu_is_XXX calls from prm_init / exit
      ARM: OMAP3/4: PRM: provide io chain reconfig function through irq setup
      ARM: OMAP3/OMAP4: PRM: add prm_features flags and add IO wakeup under it
      ARM: OMAP3/4: PRM: add support of late_init call to prm_ll_ops
      ARM: OMAP4: PRCM: remove references to cm-regbits-44xx.h from PRCM core files

 arch/arm/mach-omap2/clockdomain.h                  |  3 ++-
 arch/arm/mach-omap2/cm2xxx.c                       | 15 ++-----------
 arch/arm/mach-omap2/cm33xx.h                       |  3 ---
 arch/arm/mach-omap2/cm3xxx.c                       | 25 ++++++++--------------
 arch/arm/mach-omap2/cm3xxx.h                       |  5 ++---
 arch/arm/mach-omap2/cm44xx.c                       | 11 ++++------
 arch/arm/mach-omap2/cm_common.c                    |  2 +-
 arch/arm/mach-omap2/cminst44xx.c                   | 10 ++++++---
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  1 +
 arch/arm/mach-omap2/powerdomain-common.c           |  1 -
 arch/arm/mach-omap2/powerdomain.c                  |  1 +
 arch/arm/mach-omap2/powerdomain.h                  |  3 +--
 arch/arm/mach-omap2/prcm-common.h                  | 24 +++++++++++++++++++++
 arch/arm/mach-omap2/prcm_mpu44xx.h                 |  1 -
 arch/arm/mach-omap2/prm.h                          | 10 +++++++++
 arch/arm/mach-omap2/prm2xxx.c                      | 13 +----------
 arch/arm/mach-omap2/prm2xxx_3xxx.c                 |  1 -
 arch/arm/mach-omap2/prm33xx.c                      |  1 -
 arch/arm/mach-omap2/prm3xxx.c                      | 20 ++++++++---------
 arch/arm/mach-omap2/prm44xx.c                      | 18 +++++++---------
 arch/arm/mach-omap2/prm_common.c                   | 17 +++++++++------
 21 files changed, 93 insertions(+), 92 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdZg7AAoJEMePsQ0LvSpLvYYP/1QjKttZU9isMb2/WRR3tGay
PKLkTu0OxHn7PznzdML+vpucD0ouQoD2wuDxpVrUQ1xzrk3yu2nAMm7hCWt3oPC0
jXzY/b6Ikf0SBk1HQ2ZqcBhYwhqAva8FwyZ6eUbztspnxPl5DIKWZ/0bEi1+3bLD
Pp2kBX6bexssCOH26x+I4n3zVprlH9U1RgYhO/OaQ+rDaucOqTf30WyOxltCy1dI
T/g2Q+obbTw8XGvP90T8Jognf6HgUpq8FuyX4WM6ypJ03bvlb/dNXUHj/MTcfUG0
MWz3I2LtgtYnhh4B3Rv77bVBCRPOyEBfDTXd+Lm3n3mc3dPgSrBoeZUoJNTVKeUG
KJbm3qxjps5/iyGJyuif+opriey8IeQrAQhQSFB7oFw0Kl++L13Cm4HKCgx9QkBc
TFNKK8N3oNHJPlgHWIDrJY/mdqmR7/kxFVy2bvxnfmSkxSyPXxWvGSe17GjIlTfN
/jYOaygegbMI1Q6n+EuAhUY4v7qhDuzu75BnRpItxB5mzyYIYIV+f4tJlE6uDglh
SEtFtRQnIjmNDQ72+70mYlgjy8VvdXc++JW1bjJyONMO5Ghb3CsrpeU+EThBw3Fu
x+HJYNWDd0M3Jhhjjn3pfhkrpGbZNfCxM2QGczkZFWjhlsqdNwn8i/u1HMGb91Yr
nm22ofeTTQrISphxouKg
=fLlV
-----END PGP SIGNATURE-----
