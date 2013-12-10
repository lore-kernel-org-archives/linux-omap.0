From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] make mach-omap2 boot with device tree only for v3.14
Date: Mon, 9 Dec 2013 18:42:27 -0800
Message-ID: <29388.468390289$1386643388@news.gmane.org>
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

The following changes since commit f2e2c9d9b4087b74eb9e00d8dfac148354cb0b71:

  ARM: dts: Fix booting for secure omaps (2013-12-06 15:30:43 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/omap3-board-removal-signed

for you to fetch changes up to 736e812636ea72be444b85fa7e92554967459069:

  ARM: OMAP2+: Remove unused platform init code and headers (2013-12-08 14:15:46 -0800)

----------------------------------------------------------------
We can now finally make mach-omap2 to boot with device tree only and get
rid of over 20k lines of platform init code that way.

Most basic devices already work using device tree based initialization
and the remaining devices can be initialized using platform data
with pdata-quirks.c.

So for most missing boards it's just a question of adding a .dts file
that should be fairly similar to one of the existing .dts files as
we've tried to cover all basic omap3 board types.

For people getting started updating their board files to for device
tree, there are some basic instructions in commit 8dc8b3ddf5d7
(ARM: OMAP2+: Remove legacy omap3 board-*.c files and make mach-omap2
DT only for booting).

Please also note that there are also some related fixes making their way
into the mainline kernel that are needed for some use cases:

PM off-idle for omap3 and wake-up events need the following two patches:

[PATCH] of/platform: Fix no irq domain found errors when populating interrupts
http://lkml.org/lkml/2013/11/22/520

[PATCH] ARM: dts: Fix omap serial wake-up when booted with device tree
http://www.spinics.net/lists/devicetree/msg13374.html

EMAC Ethernet on am3517 boards needs:

[PATCH] net: davinci_emac: Fix platform data handling and make usable for am3517
http://patchwork.ozlabs.org/patch/296351/

Ethernet for boards using smc91x needs:

[PATCH v2] net: smc91x: Fix device tree based configuration so it's usable
http://www.spinics.net/lists/netdev/msg258913.html

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP2+: dts: add n8x0 onenand

Javier Martinez Canillas (3):
      ARM: OMAP2+: Remove legacy smsc911x and smc91x GPMC support
      ARM: OMAP2+: Remove unnecesary include in GPMC driver
      ARM: OMAP2+: Remove legacy board-flash.c

Tony Lindgren (34):
      mfd: twl-core: Fix passing of platform data in the device tree case
      Merge branch 'dt-regressions' into omap-for-v3.13/fixes-take4
      ARM: dts: Add basic device tree support for omap2430 sdp
      ARM: dts: Add basic Nokia N8X0 support
      ARM: dts: Add basic support for omap3 LDP zoom1 labrador
      Merge branch 'omap-for-v3.13/fixes-take4' into omap-for-v3.14/board-removal
      Merge branch 'omap-for-v3.14/dt' into omap-for-v3.14/board-removal
      ARM: OMAP2+: Add support for board specific auxdata quirks
      ARM: OMAP2+: Add device tree compatible revision checks for n8x0
      ARM: OMAP2+: Make n8x0 behave better with device tree based booting
      ARM: OMAP2+: Add quirks support for n8x0
      ARM: OMAP2+: Remove legacy booting support for n8x0
      ARM: OMAP2+: Remove board file for H4
      ARM: OMAP2+: Remove legacy board file for 2430sdp
      ARM: OMAP2+: Remove legacy mux code for omap2
      ARM: OMAP2+: Remove legacy hwmod entries for omap2
      Merge branch 'omap-for-v3.14/board-removal' into omap-for-v3.14/omap3-board-removal
      ARM: OMAP2+: Add support for legacy auxdata for twl
      ARM: OMAP2+: Use pdata quirks for emac on am3517
      ARM: dts: Add basic devices on am3517-evm
      ARM: OMAP2+: Remove legacy omap3 board-*.c files and make mach-omap2 DT only for booting
      ARM: OMAP2+: Remove legacy serial.c
      ARM: OMAP2+: Remove legacy hsmmc.c
      ARM: OMAP2+: Remove legacy i2c.c platform init code
      ARM: OMAP2+: Remove legacy PM init
      ARM: OMAP2+: Remove legacy twl4030 platform init code
      ARM: OMAP2+: Remove legacy usb-host.c platform init code
      ARM: OMAP2+: Remove legacy muxing for usb-tusb6010.c
      ARM: OMAP2+: Remove legacy usb-musb.c platform init code
      ARM: OMAP2+: Remove legacy hwmod mux code
      ARM: OMAP2+: Remove legacy mux code
      ARM: OMAP2+: Remove legacy data from hwmod for omap3
      ARM: OMAP2+: Remove legacy emac code
      ARM: OMAP2+: Remove unused platform init code and headers

 arch/arm/boot/dts/Makefile                         |    5 +
 arch/arm/boot/dts/am3517-evm.dts                   |   29 +
 arch/arm/boot/dts/omap2420-n800.dts                |    8 +
 arch/arm/boot/dts/omap2420-n810-wimax.dts          |    8 +
 arch/arm/boot/dts/omap2420-n810.dts                |    8 +
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |   99 +
 arch/arm/boot/dts/omap2430-sdp.dts                 |   49 +
 arch/arm/boot/dts/omap3-ldp.dts                    |  231 +++
 arch/arm/mach-omap1/Kconfig                        |   26 +
 arch/arm/mach-omap1/i2c.c                          |   83 +
 arch/arm/mach-omap2/Kconfig                        |  125 --
 arch/arm/mach-omap2/Makefile                       |   51 +-
 arch/arm/mach-omap2/am33xx-restart.c               |    2 -
 arch/arm/mach-omap2/am35xx-emac.c                  |  115 --
 arch/arm/mach-omap2/am35xx-emac.h                  |   15 -
 arch/arm/mach-omap2/board-2430sdp.c                |  273 ---
 arch/arm/mach-omap2/board-3430sdp.c                |  633 ------
 arch/arm/mach-omap2/board-am3517crane.c            |  150 --
 arch/arm/mach-omap2/board-am3517evm.c              |  379 ----
 arch/arm/mach-omap2/board-cm-t35.c                 |  771 --------
 arch/arm/mach-omap2/board-cm-t3517.c               |  337 ----
 arch/arm/mach-omap2/board-devkit8000.c             |  655 -------
 arch/arm/mach-omap2/board-flash.c                  |  245 ---
 arch/arm/mach-omap2/board-flash.h                  |   62 -
 arch/arm/mach-omap2/board-h4.c                     |  365 ----
 arch/arm/mach-omap2/board-ldp.c                    |  425 ----
 arch/arm/mach-omap2/board-n8x0.c                   |  239 +--
 arch/arm/mach-omap2/board-omap3beagle.c            |  596 ------
 arch/arm/mach-omap2/board-omap3logic.c             |  251 ---
 arch/arm/mach-omap2/board-omap3pandora.c           |  630 ------
 arch/arm/mach-omap2/board-omap3stalker.c           |  438 -----
 arch/arm/mach-omap2/board-omap3touchbook.c         |  396 ----
 arch/arm/mach-omap2/board-overo.c                  |  572 ------
 arch/arm/mach-omap2/board-rx51-peripherals.c       | 1323 -------------
 arch/arm/mach-omap2/board-rx51-video.c             |   67 -
 arch/arm/mach-omap2/board-rx51.c                   |  142 --
 arch/arm/mach-omap2/board-rx51.h                   |   11 -
 arch/arm/mach-omap2/board-ti8168evm.c              |   62 -
 arch/arm/mach-omap2/common-board-devices.h         |    3 +-
 arch/arm/mach-omap2/common.h                       |   16 +-
 arch/arm/mach-omap2/devices.c                      |   34 -
 arch/arm/mach-omap2/dss-common.c                   |    1 -
 arch/arm/mach-omap2/gpmc-smc91x.c                  |  186 --
 arch/arm/mach-omap2/gpmc-smc91x.h                  |   42 -
 arch/arm/mach-omap2/gpmc-smsc911x.c                |  100 -
 arch/arm/mach-omap2/gpmc-smsc911x.h                |   35 -
 arch/arm/mach-omap2/gpmc.c                         |    1 -
 arch/arm/mach-omap2/hsmmc.c                        |  518 -----
 arch/arm/mach-omap2/hsmmc.h                        |   53 -
 arch/arm/mach-omap2/i2c.c                          |   97 -
 arch/arm/mach-omap2/i2c.h                          |   13 -
 arch/arm/mach-omap2/include/mach/serial.h          |   66 -
 arch/arm/mach-omap2/io.c                           |    2 -
 arch/arm/mach-omap2/msdi.c                         |   70 -
 arch/arm/mach-omap2/mux.c                          | 1161 -----------
 arch/arm/mach-omap2/mux.h                          |  357 ----
 arch/arm/mach-omap2/mux2420.c                      |  690 -------
 arch/arm/mach-omap2/mux2420.h                      |  282 ---
 arch/arm/mach-omap2/mux2430.c                      |  793 --------
 arch/arm/mach-omap2/mux2430.h                      |  370 ----
 arch/arm/mach-omap2/mux34xx.c                      | 2061 --------------------
 arch/arm/mach-omap2/mux34xx.h                      |  402 ----
 arch/arm/mach-omap2/omap4-keypad.h                 |    8 -
 arch/arm/mach-omap2/omap_device.c                  |    2 +
 arch/arm/mach-omap2/omap_hwmod.c                   |  160 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  147 --
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  274 ---
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |  134 +-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  201 +-
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |  166 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   72 +-
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |    7 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  854 +-------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    8 -
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |   10 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   10 -
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    5 -
 arch/arm/mach-omap2/omap_twl.c                     |  314 ---
 arch/arm/mach-omap2/pdata-quirks.c                 |  107 +-
 arch/arm/mach-omap2/pm.c                           |  164 +-
 arch/arm/mach-omap2/serial.c                       |  335 ----
 arch/arm/mach-omap2/serial.h                       |    1 -
 arch/arm/mach-omap2/twl-common.c                   |  570 ------
 arch/arm/mach-omap2/twl-common.h                   |   66 -
 arch/arm/mach-omap2/usb-host.c                     |  496 -----
 arch/arm/mach-omap2/usb-musb.c                     |  114 --
 arch/arm/mach-omap2/usb-tusb6010.c                 |   21 -
 arch/arm/plat-omap/Kconfig                         |   26 -
 arch/arm/plat-omap/Makefile                        |    3 -
 arch/arm/plat-omap/i2c.c                           |  116 --
 drivers/mfd/twl-core.c                             |   15 +-
 91 files changed, 773 insertions(+), 20862 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap2420-n800.dts
 create mode 100644 arch/arm/boot/dts/omap2420-n810-wimax.dts
 create mode 100644 arch/arm/boot/dts/omap2420-n810.dts
 create mode 100644 arch/arm/boot/dts/omap2420-n8x0-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap2430-sdp.dts
 create mode 100644 arch/arm/boot/dts/omap3-ldp.dts
 delete mode 100644 arch/arm/mach-omap2/am35xx-emac.c
 delete mode 100644 arch/arm/mach-omap2/am35xx-emac.h
 delete mode 100644 arch/arm/mach-omap2/board-2430sdp.c
 delete mode 100644 arch/arm/mach-omap2/board-3430sdp.c
 delete mode 100644 arch/arm/mach-omap2/board-am3517crane.c
 delete mode 100644 arch/arm/mach-omap2/board-am3517evm.c
 delete mode 100644 arch/arm/mach-omap2/board-cm-t35.c
 delete mode 100644 arch/arm/mach-omap2/board-cm-t3517.c
 delete mode 100644 arch/arm/mach-omap2/board-devkit8000.c
 delete mode 100644 arch/arm/mach-omap2/board-flash.c
 delete mode 100644 arch/arm/mach-omap2/board-flash.h
 delete mode 100644 arch/arm/mach-omap2/board-h4.c
 delete mode 100644 arch/arm/mach-omap2/board-ldp.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3beagle.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3logic.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3pandora.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3stalker.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3touchbook.c
 delete mode 100644 arch/arm/mach-omap2/board-overo.c
 delete mode 100644 arch/arm/mach-omap2/board-rx51-peripherals.c
 delete mode 100644 arch/arm/mach-omap2/board-rx51-video.c
 delete mode 100644 arch/arm/mach-omap2/board-rx51.c
 delete mode 100644 arch/arm/mach-omap2/board-rx51.h
 delete mode 100644 arch/arm/mach-omap2/board-ti8168evm.c
 delete mode 100644 arch/arm/mach-omap2/gpmc-smc91x.c
 delete mode 100644 arch/arm/mach-omap2/gpmc-smc91x.h
 delete mode 100644 arch/arm/mach-omap2/gpmc-smsc911x.c
 delete mode 100644 arch/arm/mach-omap2/gpmc-smsc911x.h
 delete mode 100644 arch/arm/mach-omap2/hsmmc.c
 delete mode 100644 arch/arm/mach-omap2/hsmmc.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/serial.h
 delete mode 100644 arch/arm/mach-omap2/mux.c
 delete mode 100644 arch/arm/mach-omap2/mux.h
 delete mode 100644 arch/arm/mach-omap2/mux2420.c
 delete mode 100644 arch/arm/mach-omap2/mux2420.h
 delete mode 100644 arch/arm/mach-omap2/mux2430.c
 delete mode 100644 arch/arm/mach-omap2/mux2430.h
 delete mode 100644 arch/arm/mach-omap2/mux34xx.c
 delete mode 100644 arch/arm/mach-omap2/mux34xx.h
 delete mode 100644 arch/arm/mach-omap2/omap4-keypad.h
 delete mode 100644 arch/arm/mach-omap2/omap_twl.c
 delete mode 100644 arch/arm/mach-omap2/serial.c
 delete mode 100644 arch/arm/mach-omap2/serial.h
 delete mode 100644 arch/arm/mach-omap2/twl-common.c
 delete mode 100644 arch/arm/mach-omap2/twl-common.h
 delete mode 100644 arch/arm/mach-omap2/usb-host.c
 delete mode 100644 arch/arm/mach-omap2/usb-musb.c
 delete mode 100644 arch/arm/plat-omap/i2c.c
