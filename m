From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] wireless wl12xx and omap device tree changes for v4.1
Date: Wed, 25 Mar 2015 14:40:51 -0700
Message-ID: <20150325214050.GA31346@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:39853 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbbCYVpO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Mar 2015 17:45:14 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Luciano Coelho <luca@coelho.fi>, Eliad Peller <eliad@wizery.com>, Kalle Valo <kvalo@codeaurora.org>, Sekhar Nori <nsekhar@ti.com>

The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda:

  Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.1/wl12xx-dt

for you to fetch changes up to 83c3a7d4ac7fdc29a64bf9a5467a36b4c72a1eed:

  wlcore: remove wl12xx_platform_data (2015-03-24 09:48:14 -0700)

----------------------------------------------------------------
Wireless and omap changes to make wl12xx driver to use device tree
data instead of platform data from Eliad Peller <eliad@wizery.com>:

- Add device-tree support to the wlcore (wl12xx/wl18xx) driver.

- Update the current users to use the bindings instead of pdata-quirks.

- Finally, remove the deprecated wl12xx_platform_data struct

Note that da850 board file code that still uses the platform data,
but we have da850.dtsi that can be used instead. So it was decided
that we should try to remove the wl12xx support from the da850
board file as suggested by Sekhar Nori <nsekhar@ti.com>. As it's
the last patch in the series, the last patch can be simply reverted
if needed.

As this series touches quite a bit of arch code, it was suggested
by Kalle Valo <kvalo@codeaurora.org> that the whole series should
be merged via the arm-soc tree.

----------------------------------------------------------------
Eliad Peller (4):
      dt: bindings: add TI's wilink wireless device
      wlcore: add device-tree support
      ARM: dts: add wl12xx/wl18xx bindings
      wlcore: remove wl12xx_platform_data

Luciano Coelho (2):
      wlcore: set irq_trigger in board files instead of hiding behind a quirk
      wl12xx: use frequency instead of enumerations for pdata clocks

 .../devicetree/bindings/net/wireless/ti,wlcore.txt |  47 +++++++++
 arch/arm/boot/dts/am335x-evmsk.dts                 |  11 ++
 arch/arm/boot/dts/omap3-cm-t3517.dts               |  10 ++
 arch/arm/boot/dts/omap3-cm-t3730.dts               |  10 ++
 arch/arm/boot/dts/omap3-evm-common.dtsi            |  10 ++
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts         |   9 ++
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts         |   9 ++
 arch/arm/boot/dts/omap3-zoom3.dts                  |  10 ++
 arch/arm/boot/dts/omap4-panda-common.dtsi          |  10 ++
 arch/arm/boot/dts/omap4-sdp.dts                    |  11 ++
 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi     |  10 ++
 arch/arm/mach-davinci/Kconfig                      |  11 --
 arch/arm/mach-davinci/board-da850-evm.c            | 112 ---------------------
 arch/arm/mach-omap2/pdata-quirks.c                 |  74 --------------
 drivers/net/wireless/ti/wilink_platform_data.c     |  25 -----
 drivers/net/wireless/ti/wl12xx/main.c              |  63 ++++++++++--
 drivers/net/wireless/ti/wl12xx/wl12xx.h            |  28 ++++++
 drivers/net/wireless/ti/wlcore/boot.c              |   1 -
 drivers/net/wireless/ti/wlcore/debugfs.c           |   2 +-
 drivers/net/wireless/ti/wlcore/main.c              |  31 +++---
 drivers/net/wireless/ti/wlcore/sdio.c              |  63 ++++++++++--
 drivers/net/wireless/ti/wlcore/spi.c               |   6 +-
 drivers/net/wireless/ti/wlcore/wlcore.h            |   5 +-
 drivers/net/wireless/ti/wlcore/wlcore_i.h          |   6 +-
 include/linux/wl12xx.h                             |  49 ---------
 25 files changed, 311 insertions(+), 312 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt
