From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] omap board removal for some omap3 boards for v3.13 merge window
Date: Thu, 17 Oct 2013 13:00:21 -0700
Message-ID: <33340.6729776927$1382040037@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42445 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759244Ab3JQUA1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Oct 2013 16:00:27 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit f41509ad0d4c11d0911630440749d409ce2aa1aa:

  Merge branches 'omap-for-v3.13/dt' and 'omap-for-v3.13/quirk' into omap-for-v3.13/board-removal (2013-10-14 11:33:07 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/board-removal-signed

for you to fetch changes up to f0c09b7c3b4e6b2fe501b3e888797b470de8320c:

  ARM: OMAP2+: Remove legacy support for zoom platforms (2013-10-15 17:38:21 -0700)

----------------------------------------------------------------
Changes needed to drop legacy booting support for some
omap3 boards.

Note that that these are based on a merge of the
following for the dependencies:

- v3.12-rc5 for fixes to pinctrl mask
- omap-for-v3.13/dt-signed to avoid pointless merge conflicts
- omap-for-v3.13/quirk-signed for legacy pdata handling

----------------------------------------------------------------
Aaro Koskinen (2):
      ARM: dts: add minimal DT support for Nokia N950 & N9 phones
      ARM: OMAP2: delete board-rm680

Tony Lindgren (6):
      ARM: dts: Shared file for omap GPMC connected smsc911x
      ARM: dts: Add common support for omap3-evm
      ARM: dts: Add basic support for TMDSEVM3730 (Mistral AM/DM37x EVM)
      ARM: dts: Add basic support for zoom3
      ARM: OMAP2+: Remove legacy booting support for omap3 EVM
      ARM: OMAP2+: Remove legacy support for zoom platforms

 arch/arm/boot/dts/Makefile                   |   4 +
 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi    |  52 ++
 arch/arm/boot/dts/omap-zoom-common.dtsi      |  33 ++
 arch/arm/boot/dts/omap3-evm-37xx.dts         | 146 ++++++
 arch/arm/boot/dts/omap3-evm-common.dtsi      |  96 ++++
 arch/arm/boot/dts/omap3-evm.dts              |  58 +-
 arch/arm/boot/dts/omap3-igep0020.dts         |  45 +-
 arch/arm/boot/dts/omap3-n9.dts               |  18 +
 arch/arm/boot/dts/omap3-n950-n9.dtsi         | 174 ++++++
 arch/arm/boot/dts/omap3-n950.dts             |  18 +
 arch/arm/boot/dts/omap3-zoom3.dts            | 217 ++++++++
 arch/arm/mach-omap2/Kconfig                  |  33 --
 arch/arm/mach-omap2/Makefile                 |  11 -
 arch/arm/mach-omap2/board-3630sdp.c          | 225 --------
 arch/arm/mach-omap2/board-ldp.c              |   3 +-
 arch/arm/mach-omap2/board-omap3evm.c         | 756 ---------------------------
 arch/arm/mach-omap2/board-rm680.c            | 167 ------
 arch/arm/mach-omap2/board-zoom-debugboard.c  | 139 -----
 arch/arm/mach-omap2/board-zoom-display.c     |  71 ---
 arch/arm/mach-omap2/board-zoom-peripherals.c | 360 -------------
 arch/arm/mach-omap2/board-zoom.c             | 159 ------
 arch/arm/mach-omap2/board-zoom.h             |  10 -
 22 files changed, 763 insertions(+), 2032 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
 create mode 100644 arch/arm/boot/dts/omap-zoom-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-evm-37xx.dts
 create mode 100644 arch/arm/boot/dts/omap3-evm-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-n9.dts
 create mode 100644 arch/arm/boot/dts/omap3-n950-n9.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-n950.dts
 create mode 100644 arch/arm/boot/dts/omap3-zoom3.dts
 delete mode 100644 arch/arm/mach-omap2/board-3630sdp.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3evm.c
 delete mode 100644 arch/arm/mach-omap2/board-rm680.c
 delete mode 100644 arch/arm/mach-omap2/board-zoom-debugboard.c
 delete mode 100644 arch/arm/mach-omap2/board-zoom-display.c
 delete mode 100644 arch/arm/mach-omap2/board-zoom-peripherals.c
 delete mode 100644 arch/arm/mach-omap2/board-zoom.c
 delete mode 100644 arch/arm/mach-omap2/board-zoom.h
