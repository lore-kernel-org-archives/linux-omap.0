From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/6] omap device tree updates for v3.8 merge window
Date: Tue, 13 Nov 2012 11:10:28 -0800
Message-ID: <20121113191027.GF6801@atomide.com>
References: <pull-1352828737-887235>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:17430 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754329Ab2KMTKd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 14:10:33 -0500
Content-Disposition: inline
In-Reply-To: <pull-1352828737-887235>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit edf8dde393f879fc2d8c22d4bc01ff8d37b80e1a:

  Merge branch 'linus' into omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3 (2012-11-09 14:58:01 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/dt-signed

for you to fetch changes up to d308ba50a1234b299a00e63a95e61fdeb2f1a2df:

  Merge branch 'omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3' into omap-for-v3.8/dt (2012-11-09 14:58:34 -0800)

----------------------------------------------------------------

Device tree related changes for omaps updating the
various .dts files, and timer related changes to allow
configuring the timer via device tree.

----------------------------------------------------------------
Afzal Mohammed (2):
      ARM: dts: AM33XX: Add rtc node
      usb: musb: dsps: dt binding - add resources, example

Ajay Kumar Gupta (1):
      ARM: dts: AM33XX: Add usbss node

AnilKumar Ch (18):
      ARM: dts: AM33XX: Add device tree OPP table
      ARM: dts: AM33XX: Add basic pinctrl device tree data
      ARM: dts: AM33XX: Add D_CAN device tree data
      ARM: dts: AM33XX: Add lis331dlh device tree data to am335x-evm
      ARM: dts: AM33XX: Add temperature sensor device tree data to am335x-evm
      ARM: dts: AM33XX: Add tsl2550 ambient light sensor DT data
      ARM: dts: Add am335x-evmsk.dts
      Documentation: dt: i2c: Update trivial-devices list
      ARM: dts: AM33XX: Add pinmux configuration for matrix keypad to EVM
      ARM: dts: AM33XX: Add matrix keypad device tree data to am335x-evm
      ARM: dts: AM33XX: Add pinmux configuration for volume-keys to EVM
      ARM: dts: AM33XX: Add volume-keys device tree data to am335x-evm
      ARM: dts: AM33XX: Add pinmux configuration for user-leds to BONE
      ARM: dts: AM33XX: Add user-leds device tree data to am335x-bone
      ARM: dts: AM33XX: Add pinmux configuration for gpio-leds to EVMSK
      ARM: dts: AM33XX: Add user-leds device tree data to am335x-evmsk
      ARM: dts: AM33XX: Add pinmux configuration for gpio-keys to EVMSK
      ARM: dts: AM33XX: Add push-buttons device tree data to am335x-evmsk

Benoit Cousson (3):
      ARM: dts: OMAP: Move interrupt-parent to the root node to avoid duplication
      ARM: dts: OMAP: Rename pandaES and var_som for consistency
      ARM: dts: Makefile: Add the am335x-evmsk target in dtbs list

Jon Hunter (11):
      ARM: dts: Add omap3-beagle.dts
      ARM: dts: OMAP: Add timer nodes
      ARM: dts: OMAP: Add counter-32k nodes
      ARM: dts: OMAP4: Update timer addresses
      ARM: dts: OMAP5: Add timer nodes
      ARM: dts: OMAP5: Add counter node
      ARM: OMAP3: Dynamically disable secure timer nodes for secure devices
      ARM: OMAP: Add function to request a timer by capability
      ARM: OMAP3: Add generic machine descriptor for boards with OMAP3 GP devices
      ARM: OMAP: Add DT support for timer driver
      ARM: OMAP2+: Add device-tree support for 32kHz counter

Kishon Vijay Abraham I (3):
      ARM: dts: Add twl6030-usb data
      ARM: dts: Add twl4030-usb data
      ARM: dts: OMAP4: add *reg* property for ocp2scp

Lokesh Vutla (3):
      ARM: dts: omap5-evm: Fix size of memory defined for EVM
      ARM: dts: omap5: EMIF device tree data for OMAP5 boards
      ARM: dts: omap5-evm: LPDDR2 memory device details for EVM

Philip, Avinash (1):
      ARM: dts: AM33XX: Add SPI node

Ricardo Neri (2):
      ARM: dts: omap4-panda: Add pinmux configuration for HDMI
      ARM: dts: omap4-sdp: Add pinmux configuration for HDMI

Sebastien Guiriec (4):
      ARM: dts: omap5: Update GPIO with address space and interrupts
      ARM: dts: omap5: Update I2C with address space and interrupts
      ARM: dts: omap5: Update UART with address space and interrupts
      ARM: dts: omap5: Update MMC with address space and interrupts

Tony Lindgren (5):
      Merge branch 'for_3.8/dts' of git://git.kernel.org/.../bcousson/linux-omap-dt into omap-for-v3.8/dt
      Merge branch 'dev-dt-timer' of github.com:jonhunter/linux into omap-for-v3.8/dt
      Merge branch 'for_3.8/dts_part2' of git://git.kernel.org/.../bcousson/linux-omap-dt into omap-for-v3.8/dt
      Merge branch 'omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3' into omap-for-v3.8/dt
      Merge branch 'omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3' into omap-for-v3.8/dt

 .../devicetree/bindings/arm/omap/counter.txt       |  15 ++
 .../devicetree/bindings/arm/omap/timer.txt         |  31 +++
 .../devicetree/bindings/bus/omap-ocp2scp.txt       |  18 ++
 .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +
 .../devicetree/bindings/usb/am33xx-usb.txt         |  21 ++
 arch/arm/boot/dts/Makefile                         |   6 +-
 arch/arm/boot/dts/am335x-bone.dts                  |  50 +++++
 arch/arm/boot/dts/am335x-evm.dts                   | 118 ++++++++++
 arch/arm/boot/dts/am335x-evmsk.dts                 | 250 +++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi                      | 156 +++++++++++--
 arch/arm/boot/dts/omap2.dtsi                       |  86 +++++++
 arch/arm/boot/dts/omap2420.dtsi                    |  16 +-
 arch/arm/boot/dts/omap2430.dtsi                    |  19 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   6 -
 arch/arm/boot/dts/omap3-beagle.dts                 |  67 ++++++
 arch/arm/boot/dts/omap3.dtsi                       | 107 ++++++++-
 arch/arm/boot/dts/omap4-panda-a4.dts               |  17 ++
 .../dts/{omap4-pandaES.dts => omap4-panda-es.dts}  |   9 +
 arch/arm/boot/dts/omap4-panda.dts                  |  22 ++
 arch/arm/boot/dts/omap4-sdp-es23plus.dts           |  17 ++
 arch/arm/boot/dts/omap4-sdp.dts                    |  22 ++
 .../dts/{omap4-var_som.dts => omap4-var-som.dts}   |   0
 arch/arm/boot/dts/omap4.dtsi                       | 105 ++++++++-
 arch/arm/boot/dts/omap5-evm.dts                    |  13 +-
 arch/arm/boot/dts/omap5.dtsi                       | 178 ++++++++++++++-
 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi          |  67 ++++++
 arch/arm/boot/dts/twl4030.dtsi                     |  27 +++
 arch/arm/boot/dts/twl6030.dtsi                     |   5 +
 arch/arm/mach-omap2/board-generic.c                |  17 ++
 arch/arm/mach-omap2/timer.c                        | 203 ++++++++++++++---
 arch/arm/plat-omap/dmtimer.c                       |  95 +++++++-
 arch/arm/plat-omap/include/plat/dmtimer.h          |   1 +
 32 files changed, 1675 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/counter.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/timer.txt
 create mode 100644 arch/arm/boot/dts/am335x-evmsk.dts
 create mode 100644 arch/arm/boot/dts/omap3-beagle.dts
 create mode 100644 arch/arm/boot/dts/omap4-panda-a4.dts
 rename arch/arm/boot/dts/{omap4-pandaES.dts => omap4-panda-es.dts} (70%)
 create mode 100644 arch/arm/boot/dts/omap4-sdp-es23plus.dts
 rename arch/arm/boot/dts/{omap4-var_som.dts => omap4-var-som.dts} (100%)
 create mode 100644 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi
