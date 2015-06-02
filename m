From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod code and data changes for v4.2
Date: Tue, 2 Jun 2015 03:22:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1506020321510.14902@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-292835147-1433215351=:14902"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60117 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754437AbbFBDWc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2015 23:22:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-292835147-1433215351=:14902
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit e26081808edadfd257c6c9d81014e3b25e9a6118=
:

  Linux 4.1-rc4 (2015-05-18 10:13:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/f=
or-v4.2/omap-hwmod-a

for you to fetch changes up to a55a744582e0dc106537ba5e508c340c39cfe454:

  ARM: OMAP3: Fix crypto support for HS devices (2015-06-01 19:23:04 -0600)

The branch contains a AM43xx hwmod data change, and thus is based on
v4.1-rc4 to avoid merge conflicts.

- ----------------------------------------------------------------
ARM: OMAP2+: hwmod code and data changes for v4.2

Several OMAP2+ hwmod changes for v4.2.  One patch cleans up a nasty
interaction between the OMAP GPMC and the hwmod code when debugging is
enabled.  IP block integration data has been added for the AM43xx EMIF
RAM controller.  There's also a fix for the omap-aes driver when used in
QEMU.  And finally, some changes to the OMAP3 hwmod code to support the
use of the security IP blocks (AES and SHA) on GP devices, or when they've
specifically been enabled in the DT data.

Basic build, boot, and power management test results are here:

http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v4.2/20150601192349/

- ----------------------------------------------------------------
Dave Gerlach (1):
      ARM: OMAP: AM43xx hwmod: Add data for am43xx emif hwmod

Pali Roh=E1r (2):
      ARM: OMAP2+: Return correct error values from device and hwmod
      ARM: OMAP3: Fix crypto support for HS devices

Tony Lindgren (1):
      memory: omap-gpmc: Add Kconfig option for debug

 arch/arm/mach-omap2/omap_device.c                  |  30 +++---
 arch/arm/mach-omap2/omap_hwmod.c                   |  10 +-
 arch/arm/mach-omap2/omap_hwmod.h                   |   6 ++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  12 +--
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |   1 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  16 ++-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  13 ---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 119 +++++++++++++++++=
----
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  22 ++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  11 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   4 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |   2 +
 arch/arm/mach-omap2/prcm43xx.h                     |   2 +
 drivers/memory/Kconfig                             |   8 ++
 drivers/memory/omap-gpmc.c                         |   6 +-
 15 files changed, 184 insertions(+), 78 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbSEcAAoJEMePsQ0LvSpLTiwP/2dv6NKgLL2PoXkyqcMcHdcI
/zlh8mGH6yaia8jsNZ09Tf6lqZpsIr8FIOZAxq/kx21PhfQ89AcPDYAILmEB1DGk
x3/Z6rl26SgZ2HOgjs95FzJYjxy1T48BgZve9rVa/oKlkXdQ6CIdl9rP1SLwLAla
Cw++IwfBMr95y+71ov+6Tvit5UmMgCnjCsrcjK0RWUdeVps9Kye8HvWMBLMq7NB2
Tif9S7QGXVFIdPGsOL2ADeC/dvshgSjGsGkQWLi8bkJX92AfU2+WobdZ1aZlKJj+
e8+hj+hVwOLbIYCDPqG14r5z1cVCkoNDvb81J/XTszKTYEcr1d5Z9UgAJkj0kdyb
zv41VKL7WxWw7R0biwDlC7XkLD7Ob57ZL3BJ3yMNT7T4dzaJxX8nvwWN0c1OBMXG
LyhDm10pPWyy9SAKDczh35veL0EQEMSMt6HUGx9h+fhyU3Sw/XUHzO13l7AWxnIu
s0JWYuzk89YXN6q3vBK3OWBe0oQXd7rxKigQ3w2BZ7Squ9jWqIka3vphuwx+UNZ+
UU+wv2+/3gHkzoPFSsVB4C7O3oI07A5HjHegDbPdyaEDq5Bv4Ri7t38+DyKzuZs6
L7J1kMD/xa8XoFHnLuX1cv9k3PPTpkYxxGJOmkhRZ3XVfpqxKYi34uvKkJbHnD7E
jDycRKMnfuDOWsqpinJ9
=3DAOYe
-----END PGP SIGNATURE-----
--843723315-292835147-1433215351=:14902--
