From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: first set of hwmod data patches for v3.17
Date: Tue, 22 Jul 2014 21:21:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407222120460.25593@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55834 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861AbaGVVV6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jul 2014 17:21:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee:

  Linux 3.16-rc2 (2014-06-21 19:02:54 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.17/omap-hwmod-a

for you to fetch changes up to c913c8a15a02e91c1f0302d68bebf66838a9689d:

  ARM: DRA7: hwmod: Add data for RTC (2014-07-22 14:35:06 -0600)

- ----------------------------------------------------------------
OMAP hwmod data additions for v3.17.  Most of these are DRA7xx-related,
although one patch adds DSS hwmods for AM43xx.

Basic build, boot, and PM test results are available here:

http://www.pwsan.com/omap/testlogs/hwmod-a-v3.17/20140722143514/

- ----------------------------------------------------------------
Kishon Vijay Abraham I (2):
      arm: dra7xx: Add hwmod data for pcie1 phy and pcie2 phy
      arm: dra7xx: Add hwmod data for pcie1 and pcie2 subsystems

Lokesh Vutla (1):
      ARM: DRA7: hwmod: Add data for RTC

Mugunthan V N (1):
      arm: dra7xx: Add hwmod data for MDIO and CPSW

Roger Quadros (1):
      ARM: DRA7: hwmod: Add OCP2SCP3 module

Sathya Prakash M R (1):
      ARM: AM43xx: hwmod: add DSS hwmod data

 arch/arm/mach-omap2/Makefile                       |   1 +
 arch/arm/mach-omap2/cm2_7xx.h                      |   4 +
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  40 ----
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         | 100 ++++++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 260 +++++++++++++++++++++
 .../mach-omap2/omap_hwmod_common_ipblock_data.c    |  55 +++++
 arch/arm/mach-omap2/prcm43xx.h                     |   1 +
 arch/arm/mach-omap2/prm7xx.h                       |   4 +
 8 files changed, 425 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_common_ipblock_data.c
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTztWUAAoJEMePsQ0LvSpLjF4P/0PEGsq8ctRAQNaIKsVNtsDg
2plzao0Zk0hJjwTQ1HfcrGOiaMRwBpulmvb/hkFu4y7GDBiY2WEJn8d6qHDzbzLJ
2XJxfY69wtrQBs5SG587xNJSmDVoZXKZRbghM0fqJi3ip41bge5HtRD19VXVN5Rj
KZbKZVHWxtyVyZD1Lzl5lTufBgIgLG3nJUrkpIR5nPa0R9k2KtJMeFs88U578Nfs
XT6rQwKyFULqXCYoOOE1Kl2Wmo9mdeVEByx6GYUf0Qz5KES+3+2hiCBsc4FylVSO
tW695bfMgOQ186UZXSYxnQ2pDU/D1meVQ2IQVvlKyG7q+BPslWOgoeFgr1yVZkCz
wRPILUn6G6JRyJ/cCN8nYfrTnFXmV6Ve+Tb2BroHHkiJLPuxNEenFHkVHDaZgwYK
1zDoi1QAVUfy9cnic5yv2/Wd+5rxWwW2V9RCoAU4CT/sRrbH+kqMD1kR0U/Gr06k
L9nowkGwvTUO6aKtUjdsCRXKlThZLcjZcj+yGbDaF7V9UhGS1ys5bTgIXqGU8CDT
ZNg17MpslWTfL2NG6WFkSjU7DO2H8oO3D+o6pETSN6+h2SRkfLhxTjkILm6wSQVQ
HFgPE0fKNLWCRZZk8klAOiG6S4GlxK9S7lDAbVEgr4ivTShdH1p0EsjqDRu+ckPX
AJ8zX9YSxfEqcW/f08LX
=I+wx
-----END PGP SIGNATURE-----
