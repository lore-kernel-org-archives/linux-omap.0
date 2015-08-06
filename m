From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap dts changes for v4.3 merge window, part 3
Date: Thu, 6 Aug 2015 03:45:16 -0700
Message-ID: <20150806104516.GF4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit f5887fe5d14181aef0653ab04f60988252d42461:

  ARM: OMAP2+: Add custom abort handler for t410 (2015-07-23 22:33:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/dt-pt3

for you to fetch changes up to ed05637c30e6d13e5793aab64d6a6e57e30228af:

  ARM: dts: omap3-devkit8000: Add ADS7846 Touchscreen support (2015-08-06 02:43:09 -0700)

----------------------------------------------------------------
Omap device tree changes for v4.3 merge window. Pretty much all
just trivial additions to configure devices for various SoCs and
boards:

- Updates for omap3-devkit8000 board support

- M3 coprosessor, regulator, mux, RTC and eMMC updates for am437x

- MMC, regmap, mux and dwc3 updates for dra7 and omap5

----------------------------------------------------------------
Anthoine Bourgeois (7):
      ARM: dts: omap3-devkit8000: Add user button support
      ARM: dts: omap3-devkit8000: Add PMU stat support
      ARM: dts: omap3-devkit8000: Add keymap support
      ARM: dts: omap3-devkit8000: Add S-video output support
      ARM: dts: omap3-devkit8000: Add DSS' DVI support
      ARM: dts: omap3-devkit8000: add LCD panels
      ARM: dts: omap3-devkit8000: Add ADS7846 Touchscreen support

Balaji T K (1):
      ARM: dts: dra7-evm: add evm_3v3_sd regulator

Dave Gerlach (2):
      ARM: dts: am43xx: Introduce MUX_MODE9 for pinctrl
      ARM: dts: am437x-gp-evm: Add regulator-always-on and regulator-boot-on for RTC DCDCs

Felipe Balbi (1):
      ARM: dts: am4372: Add named interrupt property for dwc3

Keerthy (1):
      ARM: dts: AM4372: Reorder the rtc compatible string

Kishon Vijay Abraham I (5):
      ARM: dts: dra72-evm: add evm_3v3_sd regulator
      ARM: dts: dra72-evm: Set max clock frequency of MMC1 and MMC2
      ARM: dts: am57xx-beagle-x15: mmc1: remove redundant pbias-supply property
      ARM: dts: dra7-evm: Fix spurious card insert/removal interrupt
      ARM: dts: dra72-evm: Fix spurious card insert/removal interrupt

Nishanth Menon (1):
      ARM: dts: dra7-evm: Add MMCSD card removal GPIO

Roger Quadros (7):
      ARM: dts: omap5: Add named interrupt property for dwc3
      ARM: dts: dra7: Add named interrupt property for dwc3
      ARM: dts: dra7: Remove ctrl_core and ctrl_general nodes
      ARM: dts: dra7: fix pinmux@1400 resource length
      ARM: dts: dra7: Add scm_conf@1c04 node
      ARM: dts: am437x-gp-evm: Add gpio-hog for configuring eMMC/NAND driver
      ARM: dts: am437x-gp-evm: Add eMMC support

Suman Anna (2):
      ARM: dts: AM33xx: Add the wkup_m3_ipc node
      ARM: dts: AM4372: Add the wkup_m3_ipc node

 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/am33xx.dtsi                      |   8 +
 arch/arm/boot/dts/am4372.dtsi                      |  24 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |  76 ++++-
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |   1 -
 arch/arm/boot/dts/dra7-evm.dts                     |  18 +-
 arch/arm/boot/dts/dra7.dtsi                        |  38 ++-
 arch/arm/boot/dts/dra72-evm.dts                    |  16 +-
 arch/arm/boot/dts/dra74x.dtsi                      |   7 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi     | 369 +++++++++++++++++++++
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi |  73 ++++
 arch/arm/boot/dts/omap3-devkit8000-lcd43.dts       |  37 +++
 arch/arm/boot/dts/omap3-devkit8000-lcd70.dts       |  37 +++
 arch/arm/boot/dts/omap3-devkit8000.dts             | 191 +----------
 arch/arm/boot/dts/omap5.dtsi                       |   7 +-
 include/dt-bindings/pinctrl/am43xx.h               |   1 +
 16 files changed, 695 insertions(+), 210 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-devkit8000-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-devkit8000-lcd43.dts
 create mode 100644 arch/arm/boot/dts/omap3-devkit8000-lcd70.dts
