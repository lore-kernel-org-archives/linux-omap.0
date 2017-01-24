From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/5] omap device tree changes for v4.11 merge window
Date: Tue, 24 Jan 2017 10:05:17 -0800
Message-ID: <14976.59357633$1505296992@news.gmane.org>
References: <pull-1485274191-192300>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1485274191-192300>
In-Reply-To: <pull-1485274191-192300>
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

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.11/dt-signed-v2

for you to fetch changes up to d8e166b4ad0e3626af0378cadb2d7ba41efa005a:

  ARM: dts: dra72/1-evm: add pcf8575 used for lcd (2017-01-23 11:01:13 -0800)

----------------------------------------------------------------
Device tree changes for omaps for v4.11 merge window. These
changes add earlycon stdout-path propety for the SoCs so far
tested with it. The other changes are addition of BeagleBone
green and making WLAN work on BeagleBone black wireless and
green wireless. The rest of the changes are the usual enabling
features on various devices:

- Enable devices on am335x-sl50

- Changes to dra7-evm boards to enable enable irqs for dp83867
  eth phys, add pinmux configuration for mmc, remov erratum
  i869 pinmux configurations, disable NAND support because of
  pin conflict, add pcf8575 used for lcd

- Remove NAND partition table for omap3-igep

- Configure USB Ethernet MAC from device tree for beagleboard
  xm, pandaboard, omap5-uevm and igepv5

- Configure am335x-chilisom to wake from RTC-only state

- Update Nanobone for external FRAM chip

- Clean up n900 dts

- Update am335x-phycore and am335x-wega for various devices

- Changes for am57xx-beagle-x15 to implement rgmii2 errata

----------------------------------------------------------------
Enric Balletbo i Serra (6):
      ARM: dts: am335x-sl50: Remove I2C1 node.
      ARM: dts: am335x-sl50: Enable UART1.
      ARM: dts: am335x-sl50: Enable SPI0 interface and Flash Memory.
      ARM: dts: am335x-sl50: Enable BQ32000 Real Time Clock.
      ARM: dts: am335x-sl50: Enable the MCP23017 GPIO Expander.
      ARM: dts: am335x-sl50: Enable the Ambient Light Sensor.

Grygorii Strashko (2):
      ARM: dts: dra72-evm-revc: enable irqs for dp83867 eth phys
      ARM: dts: am57xx-beagle-x15: implement errata "Ethernet RGMII2 Limited to 10/100 Mbps"

Kishon Vijay Abraham I (1):
      ARM: dts: dra7-evm: add pinmux configuration for mmc1/2

Ladislav Michl (1):
      ARM: dts: omap3-igep: Remove NAND partition table

Laurent Pinchart (1):
      ARM: omap3: beagleboard-xm: dt: Add ethernet to the device tree

Lokesh Vutla (4):
      ARM: dts: am33xx: Add stdout-path property
      ARM: dts: am43xx: Add stdout-path property
      ARM: dts: am57xx: Add stdout-path property
      ARM: dts: dra7xx: Add stdout-path property

Marcin Niestroj (1):
      ARM: dts: am335x-chilisom: Wakeup from RTC-only state by power on event

Mark Jackson (1):
      ARM: dts: Update Nanobone dts file to add external FRAM chip

Pavel Machek (1):
      ARM: dts: n900: cleanup

Robert Nelson (4):
      ARM: dts: Move most of am335x-boneblack.dts to am335x-boneblack-common.dtsi
      ARM: dts: Add am335x-boneblack-wireless
      ARM: dts: Move most of am335x-bonegreen.dts to am335x-bonegreen-common.dtsi
      ARM: dts: Add am335x-bonegreen-wireless

Sekhar Nori (2):
      ARM: dts: dra7-evm: Remove pinmux configurations for erratum i869
      ARM: dts: dra72-evm: drop NAND support

Teresa Remmet (6):
      ARM: dts: am335x-phycore-som: Update compatible string for spi nor
      ARM: dts: am335x-phycore-som: Add i2c temp sensor
      ARM: dts: am335x-wega: Set USB0 mode to otg
      ARM: dts: am335x-phycore-som: Update ethernet phy node
      ARM: dts: am335x-wega: Update ethernet phy node
      ARM: dts: am335x-phycore-som: Remove partition tables

Tomi Valkeinen (1):
      ARM: dts: dra72/1-evm: add pcf8575 used for lcd

Tony Lindgren (4):
      ARM: dts: pandaboard: Allow bootloader to configure USB Ethernet MAC
      ARM: dts: omap5-uevm: Allow bootloader to configure USB Ethernet MAC
      ARM: dts: omap5-igep0050: Allow bootloader to configure USB Ethernet MAC
      ARM: dts: Configure BeagleBone peripheral USB VBUS irq

 arch/arm/boot/dts/Makefile                      |   2 +
 arch/arm/boot/dts/am335x-bone-common.dtsi       |   2 +
 arch/arm/boot/dts/am335x-boneblack-common.dtsi  | 163 ++++++++++++++
 arch/arm/boot/dts/am335x-boneblack-wireless.dts | 109 +++++++++
 arch/arm/boot/dts/am335x-boneblack.dts          | 155 +------------
 arch/arm/boot/dts/am335x-bonegreen-common.dtsi  |  44 ++++
 arch/arm/boot/dts/am335x-bonegreen-wireless.dts | 126 +++++++++++
 arch/arm/boot/dts/am335x-bonegreen.dts          |  38 +---
 arch/arm/boot/dts/am335x-chilisom.dtsi          |   8 +
 arch/arm/boot/dts/am335x-evm.dts                |   4 +
 arch/arm/boot/dts/am335x-evmsk.dts              |   4 +
 arch/arm/boot/dts/am335x-icev2.dts              |   4 +
 arch/arm/boot/dts/am335x-nano.dts               |  31 ++-
 arch/arm/boot/dts/am335x-phycore-som.dtsi       |  72 +-----
 arch/arm/boot/dts/am335x-sl50.dts               |  70 +++++-
 arch/arm/boot/dts/am335x-wega.dtsi              |   9 +-
 arch/arm/boot/dts/am437x-gp-evm.dts             |   4 +
 arch/arm/boot/dts/am437x-idk-evm.dts            |   4 +
 arch/arm/boot/dts/am437x-sk-evm.dts             |   4 +
 arch/arm/boot/dts/am43x-epos-evm.dts            |   4 +
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |  18 +-
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts   |   5 +
 arch/arm/boot/dts/am57xx-beagle-x15.dts         |   5 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi        |   4 +
 arch/arm/boot/dts/dra7-evm.dts                  | 286 +++---------------------
 arch/arm/boot/dts/dra71-evm.dts                 |   5 +
 arch/arm/boot/dts/dra72-evm-common.dtsi         |  20 +-
 arch/arm/boot/dts/dra72-evm-revc.dts            |   6 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts           |  16 ++
 arch/arm/boot/dts/omap3-igep.dtsi               |  21 --
 arch/arm/boot/dts/omap3-n900.dts                |   3 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi       |  16 ++
 arch/arm/boot/dts/omap5-igep0050.dts            |  21 ++
 arch/arm/boot/dts/omap5-uevm.dts                |  21 ++
 34 files changed, 759 insertions(+), 545 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-boneblack-common.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-boneblack-wireless.dts
 create mode 100644 arch/arm/boot/dts/am335x-bonegreen-common.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-bonegreen-wireless.dts
