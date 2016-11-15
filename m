From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/5] drop unused omap platform_data for v4.10
Date: Tue, 15 Nov 2016 13:22:22 -0800
Message-ID: <20183.1274819144$1505294616@news.gmane.org>
References: <pull-1479236877-351747>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1479236877-351747>
In-Reply-To: <pull-1479236877-351747>
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

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.10/legacy-signed

for you to fetch changes up to 19944b3a4a30163656b26e9d2ca659657113ac3e:

  ARM: OMAP2+: Drop legacy sdram timings (2016-11-10 16:07:32 -0700)

----------------------------------------------------------------
Legacy platform_data removal for omaps for v4.10 merge window.
We've dropped the last legacy boot board-*.c files for mach-omap2
for v4.9 so now we can start removing the unused platform_data.

All of the below has been unused since v4.9 merge window:

- Drop legacy pmic init code

- Apply seq_puts() fixes for legacy mux code, then drop it

- Drop legacy serial init

- Drop legacy i2c init

- Drop legacy PM init

- Drop legacy twl4030 platform init

- Drop legacy USB host init

- Drop legacy muxing for tusb6010, n8x0 is still using it's
  platform init via pdata-quirks.c

- Drop legacy musb init

- Drop hwmod related legacy mux code

- Drop legacy hwmod data for omap3

- Drop legacy smsc911x and smc91x init

- Drop legacy board flash init

- Drop legacy ads7846 init

- Drop legacy sdram timings

----------------------------------------------------------------
Javier Martinez Canillas (2):
      ARM: OMAP2+: Remove legacy smsc911x and smc91x GPMC support
      ARM: OMAP2+: Remove legacy board-flash.c

Markus Elfring (2):
      ARM: OMAP2+: mux: Replace three seq_printf() calls by seq_puts()
      ARM: OMAP2+: mux: Use seq_putc() in omap_mux_dbg_signal_show()

Nicolae Rosia (5):
      ARM: OMAP4: kill omap4_pmic_init and omap4_pmic_get_config
      ARM: OMAP3: kill omap3_pmic_get_config and twl_{get,set}_voltage
      ARM: OMAP3: kill omap3_pmic_init
      ARM: OMAP2: kill omap2_pmic_init
      ARM: OMAP: kill omap_pmic_init

Tony Lindgren (12):
      ARM: OMAP2+: Remove legacy serial.c
      ARM: OMAP2+: Remove legacy i2c.c platform init code
      ARM: OMAP2+: Remove legacy PM init
      ARM: OMAP2+: Remove legacy twl4030 platform init code
      ARM: OMAP2+: Remove legacy usb-host.c platform init code
      ARM: OMAP2+: Remove legacy muxing for usb-tusb6010.c
      ARM: OMAP2+: Remove legacy usb-musb.c platform init code
      ARM: OMAP2+: Remove legacy hwmod mux code
      ARM: OMAP2+: Remove legacy mux code
      ARM: OMAP2+: Remove legacy data from hwmod for omap3
      ARM: OMAP2+: Drop legacy ads7846 init
      ARM: OMAP2+: Drop legacy sdram timings

 arch/arm/mach-omap1/Kconfig                        |   26 +
 arch/arm/mach-omap1/i2c.c                          |   83 +
 arch/arm/mach-omap2/Makefile                       |   16 +-
 arch/arm/mach-omap2/board-flash.c                  |  242 ---
 arch/arm/mach-omap2/board-flash.h                  |   56 -
 arch/arm/mach-omap2/common-board-devices.c         |  102 -
 arch/arm/mach-omap2/common-board-devices.h         |    8 -
 arch/arm/mach-omap2/common.h                       |    9 -
 arch/arm/mach-omap2/devices.c                      |    1 -
 arch/arm/mach-omap2/dss-common.c                   |   37 -
 arch/arm/mach-omap2/dss-common.h                   |   13 -
 arch/arm/mach-omap2/gpmc-smsc911x.c                |  100 -
 arch/arm/mach-omap2/gpmc-smsc911x.h                |   35 -
 arch/arm/mach-omap2/hsmmc.c                        |   88 -
 arch/arm/mach-omap2/i2c.c                          |   97 -
 arch/arm/mach-omap2/io.c                           |    1 -
 arch/arm/mach-omap2/msdi.c                         |    1 -
 arch/arm/mach-omap2/mux.c                          | 1153 -----------
 arch/arm/mach-omap2/mux.h                          |  352 ----
 arch/arm/mach-omap2/mux34xx.c                      | 2061 --------------------
 arch/arm/mach-omap2/mux34xx.h                      |  402 ----
 arch/arm/mach-omap2/omap_hwmod.c                   |  107 +-
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |  149 +-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  201 +-
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |    4 -
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  787 +-------
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   15 -
 arch/arm/mach-omap2/pdata-quirks.c                 |    1 -
 arch/arm/mach-omap2/pm.c                           |   66 +-
 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h |   51 -
 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h  |   55 -
 arch/arm/mach-omap2/sdram-nokia.c                  |  299 ---
 arch/arm/mach-omap2/sdram-nokia.h                  |   12 -
 arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h     |   51 -
 .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |   54 -
 arch/arm/mach-omap2/serial.c                       |  332 ----
 arch/arm/mach-omap2/twl-common.c                   |  564 ------
 arch/arm/mach-omap2/twl-common.h                   |   66 -
 arch/arm/mach-omap2/usb-host.c                     |  496 -----
 arch/arm/mach-omap2/usb-musb.c                     |  106 -
 arch/arm/mach-omap2/usb-tusb6010.c                 |   21 -
 arch/arm/plat-omap/Kconfig                         |   26 -
 arch/arm/plat-omap/Makefile                        |    3 -
 arch/arm/plat-omap/i2c.c                           |  116 --
 45 files changed, 160 insertions(+), 8306 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-flash.c
 delete mode 100644 arch/arm/mach-omap2/board-flash.h
 delete mode 100644 arch/arm/mach-omap2/common-board-devices.c
 delete mode 100644 arch/arm/mach-omap2/dss-common.c
 delete mode 100644 arch/arm/mach-omap2/dss-common.h
 delete mode 100644 arch/arm/mach-omap2/gpmc-smsc911x.c
 delete mode 100644 arch/arm/mach-omap2/gpmc-smsc911x.h
 delete mode 100644 arch/arm/mach-omap2/mux.c
 delete mode 100644 arch/arm/mach-omap2/mux.h
 delete mode 100644 arch/arm/mach-omap2/mux34xx.c
 delete mode 100644 arch/arm/mach-omap2/mux34xx.h
 delete mode 100644 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h
 delete mode 100644 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
 delete mode 100644 arch/arm/mach-omap2/sdram-nokia.c
 delete mode 100644 arch/arm/mach-omap2/sdram-nokia.h
 delete mode 100644 arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h
 delete mode 100644 arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
 delete mode 100644 arch/arm/mach-omap2/serial.c
 delete mode 100644 arch/arm/mach-omap2/twl-common.c
 delete mode 100644 arch/arm/mach-omap2/twl-common.h
 delete mode 100644 arch/arm/mach-omap2/usb-host.c
 delete mode 100644 arch/arm/mach-omap2/usb-musb.c
 delete mode 100644 arch/arm/plat-omap/i2c.c
