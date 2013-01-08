From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] few omap fixes for v3.8-rc2
Date: Tue, 8 Jan 2013 09:48:16 -0800
Message-ID: <20130108174816.GP14149@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63055 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756485Ab3AHRsV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jan 2013 12:48:21 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:

  Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8-rc2/fixes-signed-v2

for you to fetch changes up to 6adba67eb0c4731ed0346731d024b2102f5b4d9d:

  ARM: OMAP2+: am33xx-hwmod: Fix wrongly terminated am33xx_usbss_mpu_irqs array (2013-01-07 12:38:07 -0800)

----------------------------------------------------------------
The biggest change is a fix to deal with different power state
on omap2 registers that causes issues trying to use common PM code.
Also fix few incorrect registers, and an issue for omap1 USB, and
few sparse fixes for issues that sneaked in with all the clean-up.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP1: fix USB configuration use-after-release

Ivan Khoronzhuk (2):
      ARM: OMAP4: PRM: Correct reset source map
      ARM: OMAP4: PRM: Correct wrong instance usage for reading reset sources

Jon Hunter (1):
      ARM: OMAP3: clock data: Add missing enable/disable for EMU clock

Nishanth Menon (1):
      ARM: OMAP4: PRM: fix RSTTIME and RSTST offsets

Pantelis Antoniou (1):
      ARM: OMAP2+: am33xx-hwmod: Fix wrongly terminated am33xx_usbss_mpu_irqs array

Paul Walmsley (4):
      ARM: OMAP: 32k counter: resolve sparse warnings
      ARM: OMAP AM33xx: hwmod data: resolve sparse warnings
      ARM: OMAP: SRAM: resolve sparse warnings
      ARM: OMAP2/3: PRM: fix bogus OMAP2xxx powerstate return values

Tony Lindgren (1):
      Merge tag 'omap-fixes-a2-for-v3.8-rc' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.8-rc2/fixes

 arch/arm/mach-omap1/board-ams-delta.c      |  2 +-
 arch/arm/mach-omap1/usb.c                  |  8 ++-
 arch/arm/mach-omap2/cclock3xxx_data.c      |  2 +
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |  6 +-
 arch/arm/mach-omap2/prm2xxx.c              | 88 +++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/prm2xxx_3xxx.c         | 22 --------
 arch/arm/mach-omap2/prm3xxx.c              | 28 +++++++++-
 arch/arm/mach-omap2/prm44xx.c              |  6 +-
 arch/arm/mach-omap2/prm44xx.h              |  4 +-
 arch/arm/plat-omap/counter_32k.c           |  2 +
 arch/arm/plat-omap/sram.c                  |  2 +
 11 files changed, 132 insertions(+), 38 deletions(-)
