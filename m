From: Benoit Cousson <b-cousson@ti.com>
Subject: [GIT PULL] OMAP devicetree for 3.7
Date: Mon, 10 Sep 2012 17:48:30 +0200
Message-ID: <504E0BCE.3030301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50722 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753219Ab2IJPsk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 11:48:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

Hi Tony,

Please pull the following branch. It contains a bunch of devicetree related series.

It contains as well a gpio-twl4030 patch acked by Linus W.

It is tested on omap4-panda, omap3-beagle, omap3-overo-tobi, am335x-bone, am335x-evm.

It is based on your current devel-dt branch (a06ceff6f29e34edff5d6b082885c1c4139a0362).

Thanks,
Benoit

---
The following changes since commit a06ceff6f29e34edff5d6b082885c1c4139a0362:
  AnilKumar Ch (1):
        arm/dts: Add tps65217 regulator DT data to am335x-bone.dts

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.7/dts

Aneesh V (3):
      Documentation: dt: device tree bindings for LPDDR2 memories
      Documentation: dt: emif: device tree bindings for TI's EMIF sdram controller
      ARM: dts: EMIF and LPDDR2 device tree data for OMAP4 boards

Benoit Cousson (3):
      ARM: dts: OMAP4: Cleanup and move GIC outside of the OCP
      ARM: dts: omap3-beagle: Add heartbeat and mmc LEDs support
      ARM: dts: OMAP4: Add reg and interrupts for every nodes

Florian Vaussard (5):
      gpio/twl4030: get platform data from device tree
      ARM: dts: omap3: Add gpio-twl4030 properties for BeagleBoard and omap3-EVM
      ARM: dts: OMAP3: Add support for Gumstix Overo with Tobi expansion board
      Documentation: dt: Update the OMAP documentation with Overo/Toby
      ARM: dts: omap3-overo: Add support for the blue LED

Peter Ujfalusi (9):
      ARM: OMAP: omap_device: Fix up resource names when booted with devicetree
      ARM: dts: omap2: Add McBSP entries for OMAP2420 and OMAP2430 SoC
      ARM: dts: omap2420-h4: Include omap2420.dtsi file instead the common omap2
      ARM: dts: omap3: Add McBSP entries
      ARM: dts: omap4: Add McBSP entries
      ARM: dts: omap4: Add reg-names for McPDM and DMIC
      ARM: dts: omap5: Add McBSP entries
      ARM: dts: omap5: Add McPDM and DMIC section to the dtsi file
      ARM: dts: omap3-beagle: Enable audio support

Santosh Shilimkar (2):
      ARM: OMAP4: Add L2 Cache Controller in Device Tree
      ARM: OMAP4: Add local timer support for Device Tree

Sourav Poddar (6):
      ARM: dts: omap5-evm: Add I2C support
      ARM: dts: omap5-evm: Add tmp102 sensor support
      ARM: dts: omap5-evm: Add keypad data
      ARM: dts: omap5-evm: Add bmp085 sensor support
      ARM: dts: omap4-sdp: Add keypad data
      Documentation: dt: i2c: trivial-devices: Update for tmp102

Vaibhav Hiremath (3):
      ARM: OMAP: omap_device: Do not overwrite resources allocated by OF layer
      ARM: dts: AM33XX: Convert all hex numbers to lower-case
      ARM: dts: AM33XX: Specify reg and interrupt property for all nodes

 .../devicetree/bindings/arm/omap/omap.txt          |    3 +
 .../devicetree/bindings/gpio/gpio-twl4030.txt      |    6 +
 .../devicetree/bindings/i2c/trivial-devices.txt    |    1 +
 .../devicetree/bindings/lpddr2/lpddr2-timings.txt  |   52 ++++++
 .../devicetree/bindings/lpddr2/lpddr2.txt          |  102 +++++++++++
 .../bindings/memory-controllers/ti/emif.txt        |   55 ++++++
 arch/arm/boot/dts/am335x-bone.dts                  |    4 +-
 arch/arm/boot/dts/am335x-evm.dts                   |    8 +-
 arch/arm/boot/dts/am33xx.dtsi                      |   62 ++++++-
 arch/arm/boot/dts/elpida_ecb240abacn.dtsi          |   67 +++++++
 arch/arm/boot/dts/omap2420-h4.dts                  |    2 +-
 arch/arm/boot/dts/omap2420.dtsi                    |   39 ++++
 arch/arm/boot/dts/omap2430.dtsi                    |   83 +++++++++
 arch/arm/boot/dts/omap3-beagle.dts                 |   46 +++++
 arch/arm/boot/dts/omap3-evm.dts                    |   13 ++
 arch/arm/boot/dts/omap3-overo.dtsi                 |   57 ++++++
 arch/arm/boot/dts/omap3-tobi.dts                   |   35 ++++
 arch/arm/boot/dts/omap3.dtsi                       |   69 ++++++++
 arch/arm/boot/dts/omap4-panda.dts                  |   11 ++
 arch/arm/boot/dts/omap4-sdp.dts                    |   81 +++++++++
 arch/arm/boot/dts/omap4.dtsi                       |  182 ++++++++++++++++----
 arch/arm/boot/dts/omap5-evm.dts                    |   33 ++++
 arch/arm/boot/dts/omap5.dtsi                       |   96 ++++++++++
 arch/arm/mach-omap2/Makefile.boot                  |    2 +-
 arch/arm/mach-omap2/omap4-common.c                 |    6 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |   27 +++
 arch/arm/mach-omap2/timer.c                        |    6 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |    1 +
 arch/arm/plat-omap/omap_device.c                   |   79 +++++++--
 drivers/gpio/gpio-twl4030.c                        |   82 ++++++---
 30 files changed, 1220 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
 create mode 100644 arch/arm/boot/dts/elpida_ecb240abacn.dtsi
 create mode 100644 arch/arm/boot/dts/omap2420.dtsi
 create mode 100644 arch/arm/boot/dts/omap2430.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-tobi.dts
