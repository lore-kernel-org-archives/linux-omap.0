From: Benoit Cousson <b-cousson@ti.com>
Subject: [GIT PULL] ARM: OMAP: DTS for 3.8
Date: Thu, 1 Nov 2012 18:14:15 +0100
Message-ID: <5092ADE7.1030709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39855 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943Ab2KAROa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Nov 2012 13:14:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Jon Hunter <jon-hunter@ti.com>, "AnilKumar, Chimata" <anilkumar@ti.com>

Hi Tony,

Please pull some more OMAP5 and AM33xx data for 3.8.
The branch contains as well some cleanup and the omap3-beagle support since the previous one was in fact a beagle-xm.

Thanks,
Benoit


The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:
  Linus Torvalds (1):
        Linux 3.7-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.8/dts

Afzal Mohammed (1):
      ARM: dts: AM33XX: Add rtc node

AnilKumar Ch (8):
      ARM: dts: AM33XX: Add device tree OPP table
      ARM: dts: AM33XX: Add basic pinctrl device tree data
      ARM: dts: AM33XX: Add D_CAN device tree data
      ARM: dts: AM33XX: Add lis331dlh device tree data to am335x-evm
      ARM: dts: AM33XX: Add temperature sensor device tree data to am335x-evm
      ARM: dts: AM33XX: Add tsl2550 ambient light sensor DT data
      ARM: dts: Add am335x-evmsk.dts
      Documentation: dt: i2c: Update trivial-devices list

Benoit Cousson (2):
      ARM: dts: OMAP: Move interrupt-parent to the root node to avoid duplication
      ARM: dts: OMAP: Rename pandaES and var_som for consistency

Jon Hunter (6):
      ARM: dts: Add omap3-beagle.dts
      ARM: dts: OMAP: Add timer nodes
      ARM: dts: OMAP: Add counter-32k nodes
      ARM: dts: OMAP4: Update timer addresses
      ARM: dts: OMAP5: Add timer nodes
      ARM: dts: OMAP5: Add counter node

Kishon Vijay Abraham I (3):
      ARM: dts: Add twl6030-usb data
      ARM: dts: Add twl4030-usb data
      ARM: dts: OMAP4: add *reg* property for ocp2scp

Philip, Avinash (1):
      ARM: dts: AM33XX: Add SPI node

Sebastien Guiriec (4):
      ARM: dts: omap5: Update GPIO with address space and interrupts
      ARM: dts: omap5: Update I2C with address space and interrupts
      ARM: dts: omap5: Update UART with address space and interrupts
      ARM: dts: omap5: Update MMC with address space and interrupts

 .../devicetree/bindings/arm/omap/counter.txt       |   15 ++
 .../devicetree/bindings/arm/omap/timer.txt         |   31 ++++
 .../devicetree/bindings/bus/omap-ocp2scp.txt       |   18 ++
 .../devicetree/bindings/i2c/trivial-devices.txt    |    2 +
 arch/arm/boot/dts/Makefile                         |    5 +-
 arch/arm/boot/dts/am335x-bone.dts                  |    6 +
 arch/arm/boot/dts/am335x-evm.dts                   |   55 +++++++
 arch/arm/boot/dts/am335x-evmsk.dts                 |  166 ++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi                      |  139 +++++++++++++++--
 arch/arm/boot/dts/omap2.dtsi                       |   86 ++++++++++
 arch/arm/boot/dts/omap2420.dtsi                    |   16 ++-
 arch/arm/boot/dts/omap2430.dtsi                    |   19 ++-
 arch/arm/boot/dts/omap3-beagle-xm.dts              |    6 -
 arch/arm/boot/dts/omap3-beagle.dts                 |   67 ++++++++
 arch/arm/boot/dts/omap3.dtsi                       |  107 ++++++++++++-
 .../dts/{omap4-pandaES.dts => omap4-panda-es.dts}  |    0
 arch/arm/boot/dts/omap4-panda.dts                  |    4 +
 arch/arm/boot/dts/omap4-sdp.dts                    |    4 +
 .../dts/{omap4-var_som.dts => omap4-var-som.dts}   |    0
 arch/arm/boot/dts/omap4.dtsi                       |  105 ++++++++++++-
 arch/arm/boot/dts/omap5.dtsi                       |  156 +++++++++++++++++-
 arch/arm/boot/dts/twl4030.dtsi                     |   27 +++
 arch/arm/boot/dts/twl6030.dtsi                     |    5 +
 23 files changed, 989 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/counter.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/timer.txt
 create mode 100644 arch/arm/boot/dts/am335x-evmsk.dts
 create mode 100644 arch/arm/boot/dts/omap3-beagle.dts
 rename arch/arm/boot/dts/{omap4-pandaES.dts => omap4-panda-es.dts} (100%)
 rename arch/arm/boot/dts/{omap4-var_som.dts => omap4-var-som.dts} (100%)
