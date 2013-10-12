From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/6] omap pdata and dt preparation changes for v3.13 merge
 window
Date: Fri, 11 Oct 2013 18:44:57 -0700
Message-ID: <E1VUoH0-0004eO-No@merlin.infradead.org>
References: <pull-1381542299-305003>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1381542299-305003>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:

  Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/quirk-signed

for you to fetch changes up to 8d71528343c69ce387bd5fdb4fd8dc2b9f69d97c:

  ARM: configs: omap2plus_defconfig: enable dwc3 and dependencies (2013-10-11 15:41:25 -0700)

----------------------------------------------------------------
Changes needed to prepare for making omap3 device tree only:

- Always build in board-generic, and add pdata quirks and auxdata
  support for it so we have all the pdata related quirks
  in the same place.

- Merge of the drivers/pinctrl changes that are needed for PM
  to continue working on omap3 and also needed for other omaps
  eventually. The three pinctrl related patches have been acked
  by Linus Walleij and are pulled into both the pinctrl tree
  and this branch.

- Few defconfig related changes for drivers needed.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP2+: pdata-quirks: set internal clock source for MMC2 on N950/N9

Felipe Balbi (1):
      ARM: configs: omap2plus_defconfig: enable dwc3 and dependencies

Javier Martinez Canillas (2):
      ARM: OMAP2+: pdata-quirks: add legacy display init for IGEPv2 board
      ARM: OMAP2+: igep0020: use display init from dss-common

Tony Lindgren (14):
      ARM: OMAP2+: Always build in board-generic
      ARM: OMAP2+: Add quirk support for legacy platform data init
      ARM: OMAP2+: Use pdata quirk support for board-generic.c
      ARM: OMAP2+: Use pdata quirks for wl12xx legacy init
      pinctrl: single: Prepare for supporting SoC specific features
      pinctrl: single: Add support for wake-up interrupts
      pinctrl: single: Add support for auxdata
      Merge tag 'pinctrl-single-for-linus-for-v3.13-signed' into omap-for-v3.13/quirk
      ARM: OMAP2+: Add support for auxdata
      ARM: OMAP: Move DT wake-up event handling over to use pinctrl-single-omap
      ARM: OMAP2+: Use pdata quirks for wl12xx for omap3 evm and zoom3
      ARM: OMAP2+: Add minimal 8250 support for GPMC
      ARM: OMAP2+: Run make savedefconfig on omap2plus_defconfig to shrink it
      ARM: OMAP2+: Add WLAN modules and of_serial to omap2plus_defconfig

 .../devicetree/bindings/pinctrl/pinctrl-single.txt |  11 +
 arch/arm/boot/dts/omap3.dtsi                       |   4 +
 arch/arm/boot/dts/omap4.dtsi                       |   4 +
 arch/arm/configs/omap2plus_defconfig               | 109 +++---
 arch/arm/mach-omap2/Kconfig                        |  10 +-
 arch/arm/mach-omap2/Makefile                       |   2 +-
 arch/arm/mach-omap2/board-generic.c                |  36 +-
 arch/arm/mach-omap2/board-igep0020.c               |  41 +--
 arch/arm/mach-omap2/common.h                       |   3 +
 arch/arm/mach-omap2/devices.c                      |  38 --
 arch/arm/mach-omap2/dss-common.c                   |  44 +++
 arch/arm/mach-omap2/dss-common.h                   |   1 +
 arch/arm/mach-omap2/gpmc.c                         |  38 ++
 arch/arm/mach-omap2/mux.c                          |   8 +-
 arch/arm/mach-omap2/pdata-quirks.c                 | 174 ++++++++++
 arch/arm/mach-omap2/prm3xxx.h                      |   8 +-
 arch/arm/mach-omap2/prm44xx_54xx.h                 |   8 +-
 arch/arm/mach-omap2/prm_common.c                   |  11 +
 drivers/pinctrl/pinctrl-single.c                   | 383 ++++++++++++++++++++-
 include/linux/platform_data/pinctrl-single.h       |  12 +
 20 files changed, 751 insertions(+), 194 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pdata-quirks.c
 create mode 100644 include/linux/platform_data/pinctrl-single.h
