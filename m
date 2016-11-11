From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/14] Drop some unused omap platform_data
Date: Fri, 11 Nov 2016 11:16:57 -0800
Message-ID: <20161111191711.5079-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

I've rebased the earlier legacy platform data removal
patches from few years ago that I've kept stashed in the
omap-for-v3.14/omap3-board-removal branch until omap3
became device tree only.

Looks like we still have hwmod data at least for omap4
that is not yet populated in the dts files. I'll fix
that up later on.

Meanwhile, if you notice some other unused platform_data
related code in mach-omap2, please send patches. I'll
be queueing them into omap-for-v4.10/legacy branch.

Regards,

Tony


Javier Martinez Canillas (2):
  ARM: OMAP2+: Remove legacy smsc911x and smc91x GPMC support
  ARM: OMAP2+: Remove legacy board-flash.c

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
 arch/arm/mach-omap2/twl-common.c                   |   81 -
 arch/arm/mach-omap2/twl-common.h                   |   42 -
 arch/arm/mach-omap2/usb-host.c                     |  496 -----
 arch/arm/mach-omap2/usb-musb.c                     |  106 -
 arch/arm/mach-omap2/usb-tusb6010.c                 |   21 -
 arch/arm/plat-omap/Kconfig                         |   26 -
 arch/arm/plat-omap/Makefile                        |    3 -
 arch/arm/plat-omap/i2c.c                           |  116 --
 45 files changed, 160 insertions(+), 7799 deletions(-)
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

-- 
2.10.2
