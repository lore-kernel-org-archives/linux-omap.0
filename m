From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Pull request for OMAP PM, clock, SDRC 2.6.32 patches
Date: Sun, 16 Aug 2009 07:45:59 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908160737380.31720@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hiroshi.doyu-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Hello Russell,

Here's the pull request for the thirteen patches posted earlier, plus 
Hiroshi's clock debugfs error path fix.

regards,

- Paul

The following changes since commit 3b3119fc549c93df60316d28bdd77c2de3986588:
  Russell King (1):
        Merge branch 'ixp4xx-fixes' of git://git.kernel.org/.../chris/linux-2.6

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 2_6_32_merge

Hiroshi DOYU (1):
      OMAP clock: use debugfs_remove_recursive() for rewinding

Paul Walmsley (11):
      OMAP: powerdomain: Fix overflow when doing powerdomain deps lookups
      OMAP2/3 clock: ensure each clock has a unique name
      OMAP clock: add omap_clk_get_by_name()
      OMAP clock: associate MPU clocks with the mpu_clkdm
      OMAP3 clock: remove superfluous calls to omap2_init_clk_clkdm
      OMAP2/3 PM: create the OMAP PM interface and add a default OMAP PM no-op layer
      OMAP2/3/4 PRCM: add module IDLEST wait code
      OMAP2/3 board-*.c files: read bootloader configuration earlier
      OMAP2/3/4: create omap_hwmod layer
      OMAP: omap_hwmod: call omap_hwmod init at boot; create interconnects
      OMAP2/3/4 core: create omap_device layer

Sanjeev Premi (1):
      OMAP3 clock: Fixed processing of bootarg 'mpurate'

Tero Kristo (1):
      OMAP: SDRC: Add several new register definitions

 Documentation/arm/OMAP/omap_pm                |  129 ++
 arch/arm/mach-omap2/Makefile                  |    7 +-
 arch/arm/mach-omap2/board-2430sdp.c           |   17 +-
 arch/arm/mach-omap2/board-3430sdp.c           |   18 +-
 arch/arm/mach-omap2/board-apollon.c           |   20 +-
 arch/arm/mach-omap2/board-generic.c           |   14 +-
 arch/arm/mach-omap2/board-h4.c                |   20 +-
 arch/arm/mach-omap2/board-ldp.c               |   20 +-
 arch/arm/mach-omap2/board-omap3beagle.c       |   26 +-
 arch/arm/mach-omap2/board-omap3evm.c          |   14 +-
 arch/arm/mach-omap2/board-omap3pandora.c      |   20 +-
 arch/arm/mach-omap2/board-overo.c             |   20 +-
 arch/arm/mach-omap2/board-rx51.c              |    4 +-
 arch/arm/mach-omap2/board-zoom2.c             |   18 +-
 arch/arm/mach-omap2/clock24xx.h               |   52 +-
 arch/arm/mach-omap2/clock34xx.c               |   17 +-
 arch/arm/mach-omap2/clock34xx.h               |   81 +-
 arch/arm/mach-omap2/cm.c                      |   70 ++
 arch/arm/mach-omap2/cm.h                      |    4 +
 arch/arm/mach-omap2/cm4xxx.c                  |   68 ++
 arch/arm/mach-omap2/io.c                      |   23 +-
 arch/arm/mach-omap2/omap_hwmod.c              | 1552 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420.h         |  140 +++
 arch/arm/mach-omap2/omap_hwmod_2430.h         |  142 +++
 arch/arm/mach-omap2/omap_hwmod_34xx.h         |  167 +++
 arch/arm/mach-omap2/powerdomain.c             |    4 +-
 arch/arm/mach-omap2/serial.c                  |   11 +-
 arch/arm/plat-omap/Kconfig                    |   13 +
 arch/arm/plat-omap/Makefile                   |    5 +
 arch/arm/plat-omap/clock.c                    |   29 +-
 arch/arm/plat-omap/include/mach/clock.h       |    1 +
 arch/arm/plat-omap/include/mach/omap-pm.h     |  301 +++++
 arch/arm/plat-omap/include/mach/omap_device.h |  141 +++
 arch/arm/plat-omap/include/mach/omap_hwmod.h  |  438 +++++++
 arch/arm/plat-omap/include/mach/sdrc.h        |    9 +
 arch/arm/plat-omap/include/mach/serial.h      |    3 +
 arch/arm/plat-omap/omap-pm-noop.c             |  296 +++++
 arch/arm/plat-omap/omap_device.c              |  687 +++++++++++
 38 files changed, 4405 insertions(+), 196 deletions(-)
 create mode 100644 Documentation/arm/OMAP/omap_pm
 create mode 100644 arch/arm/mach-omap2/cm.c
 create mode 100644 arch/arm/mach-omap2/cm4xxx.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2420.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2430.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_34xx.h
 create mode 100644 arch/arm/plat-omap/include/mach/omap-pm.h
 create mode 100644 arch/arm/plat-omap/include/mach/omap_device.h
 create mode 100644 arch/arm/plat-omap/include/mach/omap_hwmod.h
 create mode 100644 arch/arm/plat-omap/omap-pm-noop.c
 create mode 100644 arch/arm/plat-omap/omap_device.c
--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
