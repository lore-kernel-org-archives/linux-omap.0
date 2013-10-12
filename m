From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/6] omap device tree changes for v3.13 merge window
Date: Fri, 11 Oct 2013 18:44:58 -0700
Message-ID: <E1VUoHa-0004gy-CF@merlin.infradead.org>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/dt-signed

for you to fetch changes up to c49f4984fd45be36502e903e7a5a6a4faff42931:

  Merge tag 'for_3.13/dts_signed' of git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt into omap-for-v3.13/dt (2013-10-11 15:40:07 -0700)

----------------------------------------------------------------

omap device tree related changes via Benoit Cousson <bcousson@baylibre.com>:

Add the minimal DTS support for DRA7xx based SoC core.
Add the initial support for N900 and gta04 phones.
Enable USB3 on OMAP5 evm board.
Add support for cryto accelerators
Add new IGEP AQUILA board
Add AM33XX EDMA support
Update HSUSB node to use the reset-gpios fmwk

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: dts: omap3-devkit8000: fix a typo in GMPC node

Afzal Mohammed (2):
      ARM: dts: AM4372: cpu(s) node per latest binding
      ARM: dts: AM4372: add few nodes

Alexander Holler (1):
      ARM: dts: am335x-bone: add CD for mmc1

Alexandre Belloni (1):
      ARM: dts: AM33XX: Add PMU support

Balaji T K (4):
      ARM: dts: am335x-bone-common: correct mux mode for cmd line
      ARM: dts: am335x-evm[sdk]: switch mmc1 to 4-bit mode
      ARM: dts: dra7-evm: Add mmc1 node for micro-sd support
      ARM: dts: dra7-evm: Add mmc2 node for eMMC support

Benoit Parrot (1):
      ARM: dts: AM33XX: Add LCDC info into am335x-evm

Dan Murphy (1):
      ARM: dts: AM33XX: add ethernet alias's for am33xx

Darren Etheridge (1):
      ARM: dts: AM33XX beagle black: add pinmux and hdmi node to enable display

Enric Balletbo i Serra (2):
      ARM: dts: AM33XX: Add support for IGEP COM AQUILA
      ARM: dts: AM33XX: Add support for IGEP AQUILA EXPANSION board.

Felipe Balbi (1):
      ARM: dts: OMAP5: add palmas-usb node

Javier Martinez Canillas (8):
      ARM: dts: omap3-igep: add pinmux node for GPIO LED configuration
      ARM: dts: omap3-igep0020: add mux conf for GPIO LEDs
      ARM: dts: omap3-igep0030: add mux conf for GPIO LED
      ARM: dts: AM33XX: use pinmux node defined in included file
      ARM: dts: AM33XX: don't redefine OCP bus and device nodes
      ARM: dts: omap3-igep: Add USB OTG support
      ARM: dts: omap3-igep0020: Add HS USB Host support
      ARM: dts: omap3-igep0020: use standard constant for IRQ flags

Joel Fernandes (5):
      ARM: dts: OMAP4: Add AES node
      ARM: dts: OMAP4: Add DES3DES node
      ARM: dts: AM33XX: Fix AES interrupt number
      ARM: dts: AM437X: Add AES node
      ARM: dts: AM437X: Add DES node

Keerthy (1):
      ARM: dts: DRA7: Add TPS659038 PMIC nodes

Kishon Vijay Abraham I (1):
      ARM: dts: omap5-uevm: Split SMPS10 in two nodes

Koen Kooi (3):
      ARM: dts: am335x-boneblack: add eMMC DT entry
      ARM: dts: am335x-bone-common: switch mmc1 to 4-bit mode
      ARM: dts: am335x-bone-common: add cpu0 and mmc1 triggers

Lars Poeschel (1):
      ARM: dts: AM33xx: Correct gpio #interrupt-cells property

Lee Jones (7):
      ARM: dts: Remove '0x's from OMAP2420 H4 DTS file
      ARM: dts: Remove '0x's from OMAP3 IGEP0020 DTS file
      ARM: dts: Remove '0x's from OMAP3 IGEP0030 DTS file
      ARM: dts: Remove '0x's from OMAP3 DTS file
      ARM: dts: Remove '0x's from OMAP3430 SDP DTS file
      ARM: dts: Remove '0x's from OMAP4 DTS file
      ARM: dts: Remove '0x's from OMAP5 DTS file

Marek Belisko (1):
      ARM: dts: Add devicetree for gta04 board.

Mark A. Greer (2):
      ARM: dts: AM33XX: Add SHAM data and documentation
      ARM: dts: AM33XX: Add AES data and documentation

Matt Porter (3):
      ARM: dts: AM33XX: Add EDMA support
      ARM: dts: AM33XX: Add SPI DMA support
      ARM: dts: AM33XX: Add MMC support and documentation

Nishanth Menon (2):
      ARM: dts: am335x-boneblack: move fixed regulator to board level
      ARM: dts: omap5-uevm: mark TWL6037 as system-power-controller

Pavel Machek (1):
      ARM: dts: N900: Add device tree

R Sricharan (1):
      ARM: dts: DRA7: Add the dts files for dra7 SoC and dra7-evm board

Roger Quadros (6):
      ARM: dts: omap3-beagle: Make USB host pin naming consistent
      ARM: dts: omap3-beagle: Use reset-gpios for hsusb2_reset
      ARM: dts: omap4-panda: Use reset-gpios for hsusb1_reset
      ARM: dts: omap5-uevm: Use reset-gpios for hsusb2/3_reset
      ARM: dts: omap3-beagle-xm: Add USB Host support
      ARM: dts: omap3-beagle: Add USB OTG PHY details

Ruslan Bilovol (1):
      ARM: dts: twl6030: Move common configuration for OMAP4 boards in a separate dtsi file

Tony Lindgren (1):
      Merge tag 'for_3.13/dts_signed' of git://git.kernel.org/.../bcousson/linux-omap-dt into omap-for-v3.13/dt

 .../devicetree/bindings/crypto/omap-aes.txt        |  31 +
 .../devicetree/bindings/crypto/omap-sham.txt       |  28 +
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |  26 +-
 arch/arm/boot/dts/Makefile                         |   6 +-
 arch/arm/boot/dts/am335x-base0033.dts              |  16 +
 arch/arm/boot/dts/am335x-bone-common.dtsi          | 311 +++++----
 arch/arm/boot/dts/am335x-bone.dts                  |  18 +
 arch/arm/boot/dts/am335x-boneblack.dts             |  61 ++
 arch/arm/boot/dts/am335x-evm.dts                   | 721 ++++++++++++---------
 arch/arm/boot/dts/am335x-evmsk.dts                 | 422 ++++++------
 arch/arm/boot/dts/am335x-igep0033.dtsi             | 265 ++++++++
 arch/arm/boot/dts/am33xx.dtsi                      | 103 ++-
 arch/arm/boot/dts/am4372.dtsi                      | 361 +++++++++++
 arch/arm/boot/dts/dra7-evm.dts                     | 271 ++++++++
 arch/arm/boot/dts/dra7.dtsi                        | 575 ++++++++++++++++
 arch/arm/boot/dts/omap2420-h4.dts                  |   6 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts              |  65 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |  44 +-
 arch/arm/boot/dts/omap3-devkit8000.dts             |   2 +-
 arch/arm/boot/dts/omap3-gta04.dts                  | 168 +++++
 arch/arm/boot/dts/omap3-igep.dtsi                  |  11 +
 arch/arm/boot/dts/omap3-igep0020.dts               |  70 +-
 arch/arm/boot/dts/omap3-igep0030.dts               |  17 +-
 arch/arm/boot/dts/omap3-n900.dts                   |  92 +++
 arch/arm/boot/dts/omap3.dtsi                       |   2 +-
 arch/arm/boot/dts/omap3430-sdp.dts                 |  22 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi          |  39 +-
 arch/arm/boot/dts/omap4-sdp.dts                    |  21 +-
 arch/arm/boot/dts/omap4.dtsi                       |  20 +-
 arch/arm/boot/dts/omap5-uevm.dts                   |  52 +-
 arch/arm/boot/dts/omap5.dtsi                       |   6 +-
 arch/arm/boot/dts/twl6030_omap4.dtsi               |  38 ++
 include/dt-bindings/pinctrl/dra.h                  |  50 ++
 33 files changed, 3130 insertions(+), 810 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-aes.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt
 create mode 100644 arch/arm/boot/dts/am335x-base0033.dts
 create mode 100644 arch/arm/boot/dts/am335x-igep0033.dtsi
 create mode 100644 arch/arm/boot/dts/dra7-evm.dts
 create mode 100644 arch/arm/boot/dts/dra7.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-gta04.dts
 create mode 100644 arch/arm/boot/dts/omap3-n900.dts
 create mode 100644 arch/arm/boot/dts/twl6030_omap4.dtsi
 create mode 100644 include/dt-bindings/pinctrl/dra.h
