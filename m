From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/4] omap late device tree changes for v3.13 merge window
Date: Wed, 23 Oct 2013 07:36:43 -0700
Message-ID: <E1VYzZA-0008Nm-Cy@merlin.infradead.org>
References: <pull-1382539003-174282>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1382539003-174282>
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

The following changes since commit c49f4984fd45be36502e903e7a5a6a4faff42931:

  Merge tag 'for_3.13/dts_signed' of git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt into omap-for-v3.13/dt (2013-10-11 15:40:07 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/dt-late

for you to fetch changes up to b4887e16375be312cf64642ac1d826186cb836bf:

  Merge tag 'for_3.13_super_late/dts_signed' of git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt into omap-for-v3.13/dt (2013-10-23 03:12:45 -0700)

----------------------------------------------------------------

Some more dts changes via  Benoit Cousson <bcousson@baylibre.com>:

Add a lot of N900 nodes
Add OPP table to OMAP5/DRA7
Add support for Newflow NanoBone board
Add i2c aliases
Add McASP and audio support
Add reset/idle on init bindings for OMAP
Add more nodes for AM4272

----------------------------------------------------------------
Darren Etheridge (1):
      ARM: dts: am335x-evm: Add audio support for am335x-evm.dts

Enric Balletbo i Serra (1):
      ARM: dts: igep0033: Add mmc1 node for SDCARD support.

Eric Witcher (1):
      ARM: dts: omap5-uevm: fix mcspi node pin descriptions

George Cherian (1):
      ARM: dts: OMAP5: Add dr_mode for dwc3

J Keerthy (3):
      ARM: dts: dra7-evm: add smps123 supply for CPU
      ARM: dts: OMAP5: Add CPU OPP table
      ARM: dts: DRA7: Add CPU OPP table

Jyri Sarha (1):
      ARM: dts: AM33XX: mcasp: Add location for data port registers to reg-property

Kishon Vijay Abraham I (1):
      ARM: dts: omap5-uevm: remove always_on, boot_on from smps10_out1

Lokesh Vutla (1):
      ARM: dts: AM4372: Add L2, EDMA, mailbox, MMC and SHAM nodes

Mark Jackson (1):
      ARM: dts: Add support for Newflow NanoBone board

Markus Pargmann (1):
      ARM: dts: am33xx, change usb ctrl module label

Mugunthan V N (1):
      ARM: dts: AM4372: Update Support for EPOS EVM

Nishanth Menon (4):
      ARM: dts: omap4-panda-es: Do not reset gpio1
      ARM: dts: OMAP3+: Add i2c aliases
      ARM: dts: AM33xx+: Add i2c aliases
      ARM: dts: omap5-uevm: add smps123 supply for CPU

Pantelis Antoniou (1):
      ARM: dts: AM33XX: Add mcasp0 and mcasp1 device tree entries

Peter Ujfalusi (4):
      ARM: dts: am335x-evmsk: Audio support
      ARM: dts: AM4372: Add McASP nodes
      ARM: dts: omap5-uevm: Correct twl6040 reset GPIO pinmux
      ARM: dts: omap5-uevm: Remove pinmux for dmic pins

Rajendra Nayak (2):
      ARM: dts: omap: Add reset/idle on init bindings for OMAP
      ARM: dts: am335x-evmsk: Do not reset gpio0

Roger Quadros (2):
      ARM: dts: omap3: Adapt USB OTG to generic PHY framework
      ARM: dts: omap3-beagle: Adapt USB OTG to generic PHY framework

Sebastian Reichel (14):
      ARM: dts: omap3-n900: Add pinctrl for i2c devices
      ARM: dts: omap3-n900: Fix i2c bus speed
      ARM: dts: omap3-n900: Add UART support
      ARM: dts: omap3-n900: Add support for SD cards
      ARM: dts: omap3-n900: GPIO key definitions
      ARM: dts: omap3-n900: Add vibrator device
      ARM: dts: omap3-n900: Add LP5523 support
      ARM: dts: TWL4030: Add missing regulators
      ARM: dts: omap3-n900: Specify regulator info
      ARM: dts: omap3-n900: Add NAND support
      ARM: dts: omap3-n900:: Mux RX51_LCD_RESET_GPIO in DTS
      ARM: dts: omap3-n900: Add TLV320AIC3X support
      ARM: dts: omap3-n900: Add LP5523 support
      ARM: dts: TWL4030: Add power button support

Sricharan R (1):
      ARM: dts: OMAP5: Remove clock-frequency field for cpu timers

Tony Lindgren (3):
      Merge tag 'for_3.13_late/dts_signed' of git://git.kernel.org/.../bcousson/linux-omap-dt into omap-for-v3.13/dt
      ARM: dts: Add missing reg, interrupt and dma entries for omap3
      Merge tag 'for_3.13_super_late/dts_signed' of git://git.kernel.org/.../bcousson/linux-omap-dt into omap-for-v3.13/dt

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +-
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-evm.dts                   |  50 +++
 arch/arm/boot/dts/am335x-evmsk.dts                 |  52 +++
 arch/arm/boot/dts/am335x-igep0033.dtsi             |  13 +
 arch/arm/boot/dts/am335x-nano.dts                  | 431 +++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi                      |  39 +-
 arch/arm/boot/dts/am4372.dtsi                      | 240 +++++++++++-
 arch/arm/boot/dts/am43x-epos-evm.dts               | 168 ++++++++
 arch/arm/boot/dts/dra7-evm.dts                     |   4 +
 arch/arm/boot/dts/dra7.dtsi                        |  13 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |   2 +
 arch/arm/boot/dts/omap3-gta04.dts                  |   2 +
 arch/arm/boot/dts/omap3-n900.dts                   | 398 ++++++++++++++++++-
 arch/arm/boot/dts/omap3.dtsi                       |  52 +++
 arch/arm/boot/dts/omap36xx.dtsi                    |   4 +
 arch/arm/boot/dts/omap4-panda-es.dts               |   4 +
 arch/arm/boot/dts/omap4.dtsi                       |   7 +
 arch/arm/boot/dts/omap5-uevm.dts                   |  36 +-
 arch/arm/boot/dts/omap5.dtsi                       |  18 +-
 arch/arm/boot/dts/twl4030.dtsi                     |  49 ++-
 include/dt-bindings/pinctrl/am43xx.h               |  31 ++
 23 files changed, 1586 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-nano.dts
 create mode 100644 include/dt-bindings/pinctrl/am43xx.h
