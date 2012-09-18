From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap device tree changes for v3.7 merge window
Date: Mon, 17 Sep 2012 20:06:36 -0700
Message-ID: <20120918030636.GP11762@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46344 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932087Ab2IRDGk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Sep 2012 23:06:40 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 68cb700c59fae6cd539c9dc1e9f2584f671935a0:

  ARM: OMAP1: Move SoC specific headers from plat to mach for omap1 (2012-09-12 18:06:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-dt-merged-for-v3.7

for you to fetch changes up to 6bfc82ff589a00e5fbc12b958c649d703d273c86:

  Merge tag 'omap-cleanup-sparseirq-for-v3.7' into devel-dt (2012-09-16 15:35:06 -0700)

----------------------------------------------------------------

Device tree related changes for omaps.

Note that this branch is based on omap-cleanup-sparseirq-for-v3.7
to avoid merge conflicts with the sparseirq changes for gpio-twl4030
driver.

----------------------------------------------------------------
Aneesh V (3):
      Documentation: dt: device tree bindings for LPDDR2 memories
      Documentation: dt: emif: device tree bindings for TI's EMIF sdram controller
      ARM: dts: EMIF and LPDDR2 device tree data for OMAP4 boards

AnilKumar Ch (5):
      arm/dts: regulator: Add tps65910 device tree data
      arm/dts: regulator: Add tps65217 device tree data
      arm/dts: Add tps65910 regulator DT data to am335x-evm.dts
      arm/dts: Add tps65217 regulator DT data to am335x-bone.dts
      ARM: OMAP2+: select PINCTRL in Kconfig

Balaji T K (1):
      arm/dts: omap5: Add mmc controller nodes and board data

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

Olof Johansson (1):
      ARM: omap: add dtb targets

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

Rajendra Nayak (1):
      arm/dts: Cleanup regulator naming and remove @0,1

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

Tony Lindgren (6):
      Merge branch 'devel-dt-regulator' into devel-dt
      Merge branch 'for_3.7/dts' of git://git.kernel.org/.../bcousson/linux-omap-dt into devel-dt
      arm/dts: Add omap36xx.dtsi file and rename omap3-beagle to omap3-beagle-xm
      arm/dts: Add pinctrl driver entries for omap2/3/4
      arm/dts: Mux uart pins for omap4-sdp
      Merge tag 'omap-cleanup-sparseirq-for-v3.7' into devel-dt

Vaibhav Hiremath (4):
      arm/dts: AM33XX: Set the default status of module to "disabled" state
      ARM: OMAP: omap_device: Do not overwrite resources allocated by OF layer
      ARM: dts: AM33XX: Convert all hex numbers to lower-case
      ARM: dts: AM33XX: Specify reg and interrupt property for all nodes

 .../devicetree/bindings/arm/omap/omap.txt          |    3 +
 .../devicetree/bindings/gpio/gpio-twl4030.txt      |    6 +
 .../devicetree/bindings/i2c/trivial-devices.txt    |    1 +
 .../devicetree/bindings/lpddr2/lpddr2-timings.txt  |   52 ++++++
 .../devicetree/bindings/lpddr2/lpddr2.txt          |  102 ++++++++++
 .../bindings/memory-controllers/ti/emif.txt        |   55 ++++++
 arch/arm/boot/dts/am335x-bone.dts                  |   60 ++++++
 arch/arm/boot/dts/am335x-evm.dts                   |  100 ++++++++++
 arch/arm/boot/dts/am33xx.dtsi                      |   71 ++++++-
 arch/arm/boot/dts/elpida_ecb240abacn.dtsi          |   67 +++++++
 arch/arm/boot/dts/omap2420-h4.dts                  |    2 +-
 arch/arm/boot/dts/omap2420.dtsi                    |   48 +++++
 arch/arm/boot/dts/omap2430.dtsi                    |   92 +++++++++
 .../dts/{omap3-beagle.dts => omap3-beagle-xm.dts}  |   54 +++++-
 arch/arm/boot/dts/omap3-evm.dts                    |   13 ++
 arch/arm/boot/dts/omap3-overo.dtsi                 |   57 ++++++
 arch/arm/boot/dts/omap3-tobi.dts                   |   35 ++++
 arch/arm/boot/dts/omap3.dtsi                       |   94 +++++++++-
 arch/arm/boot/dts/omap36xx.dtsi                    |   25 +++
 arch/arm/boot/dts/omap4-panda.dts                  |   11 ++
 arch/arm/boot/dts/omap4-sdp.dts                    |  127 ++++++++++++-
 arch/arm/boot/dts/omap4.dtsi                       |  195 +++++++++++++++++---
 arch/arm/boot/dts/omap5-evm.dts                    |   64 +++++++
 arch/arm/boot/dts/omap5.dtsi                       |  127 +++++++++++++
 arch/arm/boot/dts/tps65217.dtsi                    |   56 ++++++
 arch/arm/boot/dts/tps65910.dtsi                    |   86 +++++++++
 arch/arm/boot/dts/twl4030.dtsi                     |    6 +-
 arch/arm/boot/dts/twl6030.dtsi                     |   26 +--
 arch/arm/configs/omap2plus_defconfig               |    1 +
 arch/arm/mach-omap2/Kconfig                        |    1 +
 arch/arm/mach-omap2/Makefile.boot                  |    6 +
 arch/arm/mach-omap2/omap4-common.c                 |    5 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |   27 +++
 arch/arm/mach-omap2/timer.c                        |    6 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |    1 +
 arch/arm/plat-omap/omap_device.c                   |   79 ++++++--
 drivers/gpio/gpio-twl4030.c                        |   77 +++++---
 37 files changed, 1730 insertions(+), 108 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
 create mode 100644 arch/arm/boot/dts/elpida_ecb240abacn.dtsi
 create mode 100644 arch/arm/boot/dts/omap2420.dtsi
 create mode 100644 arch/arm/boot/dts/omap2430.dtsi
 rename arch/arm/boot/dts/{omap3-beagle.dts => omap3-beagle-xm.dts} (52%)
 create mode 100644 arch/arm/boot/dts/omap3-overo.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-tobi.dts
 create mode 100644 arch/arm/boot/dts/omap36xx.dtsi
 create mode 100644 arch/arm/boot/dts/tps65217.dtsi
 create mode 100644 arch/arm/boot/dts/tps65910.dtsi
