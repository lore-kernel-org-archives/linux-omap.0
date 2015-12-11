From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] omap device tree changes for v4.5, part 1
Date: Thu, 10 Dec 2015 16:03:09 -0800
Message-ID: <929.643904282962$1449792264@news.gmane.org>
References: <pull-1449792144-865487>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1449792144-865487>
In-Reply-To: <pull-1449792144-865487>
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

The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.5/dt-pt1

for you to fetch changes up to 89c6f2e5ab7a0499c6bcb25d281977ada205765d:

  ARM: dts: omap3-igep0030: Use MMC pwrseq to init SDIO WiFi (2015-12-07 16:11:43 -0800)

----------------------------------------------------------------
Device tree changes for omaps for v4.5 merge window:

- Update all omaps to use pinctrl macros. This makes comparing the pinmux
  settings against the documentation much earlier. Javier compared the
  checksums of the generated dtb files to make sure nothing changed for
  the dtb files.

- Updates for dm816x

- Add GPMC DMA channels for am437x

- Updates for LogicPD Torpedo

- Basic support for CompuLab cm-t335

- Remove tps65217.dtsi file, we're better off adding SoC generic board
  dtsi files for the common features

- Add support for ELM on am33xx

- Add support for Bosch shc c3 board

- Add qspi aliases for am437x and dra7

- Wake-up support for dra7-evm uart1

- Basic support for CompuLab sbc-t43

- Basic support for CompuLab cl-som-am57x

- Use MMC pwrseq for libertas WLAN on igep0020 and igep0030

----------------------------------------------------------------
Adam Ford (6):
      ARM: dts: Add audio support for LogicPD Torpedo DM3730 devkit
      ARM: dts: Change I2C2 and I2C3 to 400KHz for LogicPD Torpedo DM3730 devkit
      ARM: dts: Set VAUX1 and VAUX4 to 3.0V and 1.8V respectively
      ARM: dts: Enable UART2 pinctrl on LogicPD Torpedo + Wireless module
      ARM: dts: Change I2C2 and I2C3 to 400KHz for LogicPD Torpedo DM3730 devkit
      ARM: dts: Set VAUX1 and VAUX4 on Logic PD Torpedo

Andrew F. Davis (1):
      ARM: dts: am335x-boneblack: Use pinctrl constants and AM33XX_IOPAD macro

Dmitry Lifshitz (19):
      ARM: dts: am57xx: cl-som-am57x: add basic module support
      ARM: dts: am57xx: cl-som-am57x: dts: add RTC support
      ARM: dts: am57xx: cl-som-am57x: add I2C3 support
      ARM: dts: am57xx: cl-som-am57x: add EEPROM support
      ARM: dts: am57xx: cl-som-am57x: add eMMC support
      ARM: dts: am57xx: cl-som-am57x: add spi-flash support
      ARM: dts: am57xx: cl-som-am57x: add dual EMAC support
      ARM: dts: am57xx: cl-som-am57x: add USB support
      ARM: dts: am57xx: cl-som-am57x: add touchscreen support
      ARM: dts: am57xx: cl-som-am57x: add analog audio support
      ARM: dts: am57xx: sbc-am57x: add basic board support
      ARM: dts: am57xx: cl-som-am57x: add MMC1 support
      ARM: dts: am57xx: sbc-am57x: add usb vbus pinmux
      ARM: dts: am57xx: sbc-am57x: add EEPROM support
      ARM: dts: am57xx: sbc-am57x: add GPIO expander support
      ARM: dts: am57xx: sbc-am57x: add LCD support
      ARM: dts: am57xx: compulab-sb-som: add HDMI connector
      ARM: dts: am57xx: sbc-am57x: add HDMI support
      ARM: dts: am57xx: cl-som-am57x: skip resetting ETH PHYs

Franklin S Cooper Jr (2):
      ARM: dts: am437x/am33xx/omap/dm816x: Add gpmc dma channel
      ARM: dts: omap4: Add elm node

Heiko Schocher (2):
      regulator: tps65217: remove tps65217.dtsi file
      arm, am335x: add support for the bosch shc board

Ilya Ledvich (6):
      ARM: dts: cm-t335: add initial support
      ARM: dts: cm-t335: add basic support for I2C
      ARM: dts: cm-t335: add support for NAND flash
      ARM: dts: cm-t335: add support for MMC
      ARM: dts: cm-t335: add support for network device
      ARM: dts: cm-t335: add support for PWM backlight

Javier Martinez Canillas (41):
      pinctrl: Move am4372 and dra7 macros to the the SoC header files
      ARM: dts: am335x-baltos-ir5221: Remove leftover pinctrl lines
      ARM: dts: am335x-baltos-ir5221: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-bone-common: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-bonegreen: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-chiliboard: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-chilisom: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-evm: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-evmsk: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-lxm: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-nano: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-pepper: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-phycore-som: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-wega: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am3517-craneboard: Use OMAP3_CORE1_IOPAD pinmux macro
      ARM: dts: am437x-gp-evm: Use AM4372_IOPAD pinmux macro
      ARM: dts: am437x-idk-evm: Use AM4372_IOPAD pinmux macro
      ARM: dts: am437x-sk-evm: Use AM4372_IOPAD pinmux macro
      ARM: dts: am43x-epos-evm: Use AM4372_IOPAD pinmux macro
      ARM: dts: am57xx-beagle-x15: Use DRA7XX_CORE_IOPAD pinmux macro
      ARM: dts: dra7-evm: Use DRA7XX_CORE_IOPAD pinmux macro
      ARM: dts: dra72-evm: Use DRA7XX_CORE_IOPAD pinmux macro
      ARM: dts: omap3-beagle: Use OMAP3_*_IOPAD pinmux macros
      ARM: dts: omap3-beagle-xm: Use OMAP3_*_IOPAD pinmux macros
      ARM: dts: omap3-evm-37xx: Use OMAP3_*_IOPAD pinmux macros
      ARM: dts: omap3-ldp: Use OMAP3_CORE1_IOPAD pinmux macro
      ARM: dts: omap3-n900: Use OMAP3_CORE1_IOPAD pinmux macro
      ARM: dts: omap3-n9: Use OMAP3_CORE1_IOPAD pinmux macro
      ARM: dts: omap3-zoom3: Use OMAP3_*_IOPAD pinmux macros
      ARM: dts: twl4030: Use OMAP3_CORE1_IOPAD pinmux macro
      ARM: dts: omap4-panda-a4: Use OMAP4_IOPAD pinmux macro
      ARM: dts: omap4-panda-common: Use OMAP4_IOPAD pinmux macro
      ARM: dts: omap4-panda-es: Use OMAP4_IOPAD pinmux macro
      ARM: dts: omap4-sdp: Use OMAP4_IOPAD pinmux macro
      ARM: dts: omap4-sdp-es23plus: Use OMAP4_IOPAD pinmux macro
      ARM: dts: twl6030: Use OMAP4_IOPAD pinmux macro
      ARM: dts: omap5-board-common: Use OMAP5_IOPAD pinmux macro
      ARM: dts: omap5-cm-t54: Use OMAP5_IOPAD pinmux macro
      ARM: dts: omap5-uevm.dts: Use OMAP5_IOPAD pinmux macro
      ARM: dts: omap3-igep0020: Use MMC pwrseq to init SDIO WiFi
      ARM: dts: omap3-igep0030: Use MMC pwrseq to init SDIO WiFi

Mugunthan V N (2):
      ARM: dts: dra7: add spi alias for qspi
      ARM: dts: am4372: add spi alias for qspi

Neil Armstrong (3):
      ARM: dts: add dm816x pwm property to timers
      ARM: dts: remove dm816x invalid DT l3_main hwmod
      ARM: dts: Add omap4-hwspinlock support in dm816x

Nikita Kiryanov (14):
      ARM: dts: am437x: cm-t43: add basic support for sbc-t43
      ARM: dts: am437x: cm-t43: add support for module eeprom
      ARM: dts: am437x: cm-t43: add PMIC support.
      ARM: dts: am437x: cm-t43: add spi-flash support
      ARM: dts: am437x: cm-t43: add NAND support
      ARM: dts: am437x: cm-t43: add dual emac support
      ARM: dts: am437x: cm-t43: add USB support
      ARM: dts: am437x: cm-t43: add eMMC support
      ARM: dts: am437x: cm-t43: add touchscreen support
      ARM: dts: am437x: cm-t43: add pca9555 support
      ARM: dts: am437x: cm-t43: add support for baseboard eeprom
      ARM: dts: sb-som: introduce SB-SOM baseboard
      ARM: dts: am437x: cm-t43: add support for mmc1
      ARM: dts: am437x: cm-t43: add lcd support

Vignesh R (1):
      ARM: dts: dra72-evm: Mark uart1 rxd as wakeup capable

 .../devicetree/bindings/arm/compulab-boards.txt    |   5 +
 .../devicetree/bindings/arm/omap/omap.txt          |  15 +
 .../display/panel/startek,startek-kd050c.txt       |   4 +
 .../devicetree/bindings/regulator/tps65217.txt     |  10 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |  18 +-
 arch/arm/boot/dts/am335x-baltos-ir5221.dts         | 186 +++----
 arch/arm/boot/dts/am335x-bone-common.dtsi          | 118 ++--
 arch/arm/boot/dts/am335x-boneblack.dts             |  44 +-
 arch/arm/boot/dts/am335x-bonegreen.dts             |   4 +-
 arch/arm/boot/dts/am335x-chiliboard.dts            |  20 +-
 arch/arm/boot/dts/am335x-chilisom.dtsi             |  94 ++--
 arch/arm/boot/dts/am335x-cm-t335.dts               | 347 ++++++++++++
 arch/arm/boot/dts/am335x-evm.dts                   | 220 ++++----
 arch/arm/boot/dts/am335x-evmsk.dts                 | 278 +++++-----
 arch/arm/boot/dts/am335x-lxm.dts                   | 120 ++--
 arch/arm/boot/dts/am335x-nano.dts                  | 154 ++---
 arch/arm/boot/dts/am335x-pepper.dts                | 214 +++----
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |  60 +-
 arch/arm/boot/dts/am335x-shc.dts                   | 577 +++++++++++++++++++
 arch/arm/boot/dts/am335x-sl50.dts                  |  13 +-
 arch/arm/boot/dts/am335x-wega.dtsi                 |  58 +-
 arch/arm/boot/dts/am33xx.dtsi                      |   2 +
 arch/arm/boot/dts/am3517-craneboard.dts            |   2 +-
 arch/arm/boot/dts/am4372.dtsi                      |   3 +
 arch/arm/boot/dts/am437x-cm-t43.dts                | 422 ++++++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts                | 380 ++++++-------
 arch/arm/boot/dts/am437x-idk-evm.dts               | 128 ++---
 arch/arm/boot/dts/am437x-sbc-t43.dts               | 180 ++++++
 arch/arm/boot/dts/am437x-sk-evm.dts                | 298 +++++-----
 arch/arm/boot/dts/am43x-epos-evm.dts               | 246 ++++----
 arch/arm/boot/dts/am57xx-beagle-x15.dts            | 198 +++----
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          | 617 +++++++++++++++++++++
 arch/arm/boot/dts/am57xx-sbc-am57x.dts             | 179 ++++++
 arch/arm/boot/dts/compulab-sb-som.dtsi             |  49 ++
 arch/arm/boot/dts/dm816x.dtsi                      |  14 +-
 arch/arm/boot/dts/dra7-evm.dts                     | 254 ++++-----
 arch/arm/boot/dts/dra7.dtsi                        |   1 +
 arch/arm/boot/dts/dra72-evm.dts                    | 202 +++----
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts  |  30 +
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |  44 ++
 arch/arm/boot/dts/omap3-beagle-xm.dts              |  18 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |  64 +--
 arch/arm/boot/dts/omap3-evm-37xx.dts               |  54 +-
 arch/arm/boot/dts/omap3-igep0020.dts               |  24 +-
 arch/arm/boot/dts/omap3-igep0030.dts               |  24 +-
 arch/arm/boot/dts/omap3-ldp.dts                    |  42 +-
 arch/arm/boot/dts/omap3-n900.dts                   | 106 ++--
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |  12 +-
 arch/arm/boot/dts/omap3-zoom3.dts                  |  60 +-
 arch/arm/boot/dts/omap3.dtsi                       |   2 +
 arch/arm/boot/dts/omap4-panda-a4.dts               |   6 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi          | 164 +++---
 arch/arm/boot/dts/omap4-panda-es.dts               |  10 +-
 arch/arm/boot/dts/omap4-sdp-es23plus.dts           |   6 +-
 arch/arm/boot/dts/omap4-sdp.dts                    | 110 ++--
 arch/arm/boot/dts/omap4.dtsi                       |  10 +
 arch/arm/boot/dts/omap5-board-common.dtsi          |  94 ++--
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   2 +-
 arch/arm/boot/dts/omap5-uevm.dts                   |   4 +-
 arch/arm/boot/dts/omap5.dtsi                       |   2 +
 arch/arm/boot/dts/tps65217.dtsi                    |  56 --
 arch/arm/boot/dts/twl4030_omap3.dtsi               |   2 +-
 arch/arm/boot/dts/twl6030_omap4.dtsi               |   4 +-
 include/dt-bindings/pinctrl/am43xx.h               |   6 +
 include/dt-bindings/pinctrl/dra.h                  |   6 +
 include/dt-bindings/pinctrl/omap.h                 |   2 -
 67 files changed, 4600 insertions(+), 2099 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/compulab-boards.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.txt
 create mode 100644 arch/arm/boot/dts/am335x-cm-t335.dts
 create mode 100644 arch/arm/boot/dts/am335x-shc.dts
 create mode 100644 arch/arm/boot/dts/am437x-cm-t43.dts
 create mode 100644 arch/arm/boot/dts/am437x-sbc-t43.dts
 create mode 100644 arch/arm/boot/dts/am57xx-cl-som-am57x.dts
 create mode 100644 arch/arm/boot/dts/am57xx-sbc-am57x.dts
 create mode 100644 arch/arm/boot/dts/compulab-sb-som.dtsi
 delete mode 100644 arch/arm/boot/dts/tps65217.dtsi
