From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap dts updates for v4.9 merge window, part 2
Date: Thu, 15 Sep 2016 10:20:22 -0700
Message-ID: <20160915172021.6u2zam4yd6vruub4@atomide.com>
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

The following changes since commit 5c4d9f0d49b0c3beda734687248fc74542566ee9:

  ARM: dts: dra7: Add missing unit name to memory nodes (2016-08-31 07:40:28 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.9/dt-pt2-signed

for you to fetch changes up to a2a2b8215621536a7620e31f36bede81bb86680b:

  Merge branch 'am335x-cpufreq-regression' into omap-for-v4.9/dt-v2 (2016-09-14 16:27:28 -0700)

----------------------------------------------------------------
Part two of device tree changes for omaps for v4.9 merge window. This
is mostly usability and non-critical fixes except for the addition of
beagleboard-x15 rev B1 support:

- Fix omap4 pandaboard SDIO WLAN latencies in idle mode by enabling wakeirq

- Usability fixes for WLAN, USB, LEDs and power button on omap5 boards

- Remove am57xx beagleboard-x15 pinmux configuration as the processor requires
  that it's done in IO isolation in bootloader except for MMC and DCAN

- Add support for beagleboard-x15 rev B1 by moving most of the
  configuration to am57xx-beagle-x15-common.dtsi

- Enable support for more than 2GB of memory for omap5 with LPAE with
  #address-cells

- Fix omap3-gta04 backlight PWM frequency until the PWM driver

- Revert am335x dts changes related to cpufreq as the driver changes
  still have not merged and the dts changes broke cpufreq

----------------------------------------------------------------
Dave Gerlach (3):
      Revert "ARM: dts: am335x-boneblack: Enable 1GHz OPP for cpu"
      Revert "ARM: dts: am33xx: Move to operating-points-v2 table and ti-cpufreq driver"
      Revert "ARM: dts: dra7: Move to operating-points-v2 table"

H. Nikolaus Schaller (1):
      ARM: dts: omap3-gta04: reduce panel backlight PWM frequency to 83Hz

Nishanth Menon (2):
      ARM: dts: am57xx-beagle-x15: Remove pinmux configurations for erratum i869
      ARM: dts: am57xx-beagle-x15: Add support for rev B1

Tony Lindgren (7):
      ARM: dts: Configure panda SDIO WLAN wakeirq
      ARM: dts: ARM: dts: Fix omap5 SDIO dat1 interrupt
      ARM: dts: Configure omap5 OTG ID pin
      ARM: dts: Add power button support for igepv5
      ARM: dts: Fix LEDs for igepv5
      ARM: dts: Add support for more than 2GB of memory for omap5
      Merge branch 'am335x-cpufreq-regression' into omap-for-v4.9/dt-v2

 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/am335x-boneblack.dts          |  11 -
 arch/arm/boot/dts/am33xx.dtsi                   |  88 +--
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 596 +++++++++++++++++
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts   |  24 +
 arch/arm/boot/dts/am57xx-beagle-x15.dts         | 812 +-----------------------
 arch/arm/boot/dts/dra7.dtsi                     |  26 +-
 arch/arm/boot/dts/dra74x.dtsi                   |   1 -
 arch/arm/boot/dts/omap3-gta04.dtsi              |   2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi       |   2 +
 arch/arm/boot/dts/omap5-board-common.dtsi       |  29 +-
 arch/arm/boot/dts/omap5-cm-t54.dts              |   2 +-
 arch/arm/boot/dts/omap5-igep0050.dts            |  40 +-
 arch/arm/boot/dts/omap5-uevm.dts                |  16 +-
 arch/arm/boot/dts/omap5.dtsi                    |  24 +-
 15 files changed, 731 insertions(+), 943 deletions(-)
 create mode 100644 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
 create mode 100644 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
