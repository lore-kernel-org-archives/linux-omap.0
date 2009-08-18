From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 00/11] OMAP PM, clock,
	and SDRC updates for the 2.6.32 merge window
Date: Tue, 18 Aug 2009 14:56:16 +0300
Message-ID: <20090818115147.14171.55785.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51865 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145AbZHRL6t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 07:58:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-arm@vger.kernel.org
Cc: linux-omap@vger.kernel.org

Hello,

This second revision of this series drops the patch that ensures that
OMAP clocks use unique names, and the patch that adds
omap_clk_get_by_name().  The omap_hwmod code has been changed to use
clk_get_sys().


- Paul

--------------------------------------------------------------------------

This series contains power management, clock, and SDRC patches for the
2.6.32 merge window.  All but the bugfix patches 1 and 3 are in use in
Kevin's PM branch.

The series includes:

- several bugfixes (patches 1, 3, 4, 5);

- introduces the OMAP PM interface (patch 6), used by core code and some
  device drivers (via platform_data function pointers) to communicate
  OMAP-specific PM requirements to OMAP core code;

- introduces the omap_hwmod and omap_device layers (prereqs are patches 7, 8;
  core is patches 9, 10, 11);

- and adds some missing SDRC registers that are used by other code in the PM
  branch (patch 2).

For reference:

Code that uses the OMAP PM interface is here: (despite the header text,
this was not written by me; the header was simply copied from omap-pm-noop.c):

    http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=blob;f=arch/arm/plat-omap/omap-pm-srf.c;h=4350650b95090b2a5b503b09830bac42109dc262;hb=pm

Code that uses the omap_hwmod/omap_device code is here:

    http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=0ddd9080f3c20c32dadf40e12bee05b8cf6784bc
    http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=4d04506972aba09f21df3b956895fe59a9230697
    http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=9ef2c1a657621b10e0ea46f7824ebbc725cd2c26


regards,

- Paul


---

Paul Walmsley (9):
      OMAP: powerdomain: Fix overflow when doing powerdomain deps lookups.
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
 arch/arm/mach-omap2/Makefile                  |    7 
 arch/arm/mach-omap2/board-2430sdp.c           |   17 
 arch/arm/mach-omap2/board-3430sdp.c           |   18 
 arch/arm/mach-omap2/board-apollon.c           |   20 
 arch/arm/mach-omap2/board-generic.c           |   14 
 arch/arm/mach-omap2/board-h4.c                |   20 
 arch/arm/mach-omap2/board-ldp.c               |   20 
 arch/arm/mach-omap2/board-omap3beagle.c       |   26 
 arch/arm/mach-omap2/board-omap3evm.c          |   14 
 arch/arm/mach-omap2/board-omap3pandora.c      |   20 
 arch/arm/mach-omap2/board-overo.c             |   20 
 arch/arm/mach-omap2/board-rx51.c              |    4 
 arch/arm/mach-omap2/board-zoom2.c             |   18 
 arch/arm/mach-omap2/clock34xx.c               |   17 
 arch/arm/mach-omap2/clock34xx.h               |   21 
 arch/arm/mach-omap2/cm.c                      |   70 +
 arch/arm/mach-omap2/cm.h                      |    4 
 arch/arm/mach-omap2/cm4xxx.c                  |   68 +
 arch/arm/mach-omap2/io.c                      |   23 
 arch/arm/mach-omap2/omap_hwmod.c              | 1554 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420.h         |  141 ++
 arch/arm/mach-omap2/omap_hwmod_2430.h         |  143 ++
 arch/arm/mach-omap2/omap_hwmod_34xx.h         |  168 +++
 arch/arm/mach-omap2/powerdomain.c             |    4 
 arch/arm/mach-omap2/serial.c                  |   14 
 arch/arm/plat-omap/Kconfig                    |   13 
 arch/arm/plat-omap/Makefile                   |    5 
 arch/arm/plat-omap/include/mach/omap-pm.h     |  301 +++++
 arch/arm/plat-omap/include/mach/omap_device.h |  141 ++
 arch/arm/plat-omap/include/mach/omap_hwmod.h  |  447 +++++++
 arch/arm/plat-omap/include/mach/sdrc.h        |    9 
 arch/arm/plat-omap/include/mach/serial.h      |    3 
 arch/arm/plat-omap/omap-pm-noop.c             |  296 +++++
 arch/arm/plat-omap/omap_device.c              |  687 +++++++++++
 35 files changed, 4337 insertions(+), 139 deletions(-)
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

