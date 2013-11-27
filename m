From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v3.13-rc1
Date: Tue, 26 Nov 2013 17:30:58 -0800
Message-ID: <23303.2679222108$1385515896@news.gmane.org>
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

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/fixes-against-rc1-take2

for you to fetch changes up to 9cb238c00ba5c1ddfff2c2ed6aa66c15b962e4c3:

  mmc: omap: Fix I2C dependency and make driver usable with device tree (2013-11-26 15:51:16 -0800)

----------------------------------------------------------------
Some omap related fixes that have come up with people moving to device
tree only based booting for omap2+.

The series contains a handful of fixes for the igep boards as they were
one of the first omap3 boards to jump over completely to device tree
based booting. So these can be considered regressions compared to
booting igep in legacy mode with board files in v3.12.

Also included are few other device tree vs legacy booting regressions:

- yet more missing omap3 .dtsi entries that have showed up booting
  various boards with device tree only

- n900 eMMC device tree fix

- fixes for beagle USB EHCI

- two fixes to make omap2420 MMC work

As we're moving omap2+ to be device tree only for v3.14, I'd like to
have v3.13 work equally well for legacy based booting and device tree
based booting. So there will be likely few more device tree related
booting patches trickling in.

This series also includes a regression fix for the omap timer posted
mode that may wrongly stay on from the bootloader for some SoCs.

----------------------------------------------------------------
Enric Balletbo i Serra (7):
      ARM: dts: omap3-igep: Fix bus-width for mmc1
      ARM: dts: omap3-igep: Add support for LBEE1USJYC WiFi connected to SDIO
      ARM: dts: omap3-igep: Update to use the TI AM/DM37x processor
      ARM: dts: AM33XX BASE0033: add pinmux and hdmi node to enable display
      ARM: dts: AM33XX BASE0033: add pinmux and user led support
      ARM: dts: AM33XX BASE0033: add 32KBit EEPROM support
      ARM: dts: AM33XX IGEP0033: add USB support

Javier Martinez Canillas (4):
      ARM: OMAP2+: dss-common: change IGEP's DVI DDC i2c bus
      ARM: dts: omap3-igep0020: Add pinmux setup for i2c devices
      ARM: dts: omap3-igep0020: Add pinmuxing for DVI output
      ARM: dts: omap3-igep0020: name twl4030 VPLL2 regulator as vdds_dsi

Joel Fernandes (1):
      ARM: OMAP2+: Disable POSTED mode for errata i103 and i767

Roger Quadros (1):
      ARM: dts: omap3-beagle: Fix USB host on beagle boards (for 3.13)

Tony Lindgren (5):
      ARM: OMAP2+: Fix more missing data for omap3.dtsi file
      ARM: OMAP2+: Add fixed regulator to omap2plus_defconfig
      ARM: OMAP2+: Fix eMMC on n900 with device tree
      mmc: omap: Fix DMA configuration to not rely on device id
      mmc: omap: Fix I2C dependency and make driver usable with device tree

 Documentation/devicetree/bindings/mmc/ti-omap.txt | 54 ++++++++++++++
 arch/arm/boot/dts/am335x-base0033.dts             | 79 +++++++++++++++++++++
 arch/arm/boot/dts/am335x-igep0033.dtsi            | 29 ++++++++
 arch/arm/boot/dts/omap3-beagle-xm.dts             |  7 ++
 arch/arm/boot/dts/omap3-beagle.dts                |  7 ++
 arch/arm/boot/dts/omap3-igep.dtsi                 | 85 ++++++++++++++++++++---
 arch/arm/boot/dts/omap3-igep0020.dts              | 50 ++++++++++++-
 arch/arm/boot/dts/omap3-igep0030.dts              |  4 +-
 arch/arm/boot/dts/omap3-n900.dts                  | 23 +++++-
 arch/arm/boot/dts/omap3.dtsi                      | 42 +++++++++++
 arch/arm/configs/omap2plus_defconfig              |  1 +
 arch/arm/mach-omap2/dss-common.c                  |  2 +-
 arch/arm/mach-omap2/pdata-quirks.c                |  1 +
 arch/arm/plat-omap/include/plat/dmtimer.h         |  5 +-
 drivers/mmc/host/omap.c                           | 45 ++++++------
 15 files changed, 396 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/ti-omap.txt
