From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] OMAP: clock/CM/PRM/SCM updates for OMAP4 ES2, OMAP3 CORE
 DVFS fix: for 2.6.37
Date: Sat, 25 Sep 2010 01:26:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009250124080.10678@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1392867116-1285399571=:10678"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48773 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab0IYH0M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Sep 2010 03:26:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1392867116-1285399571=:10678
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Tony,

The following changes since commit b30a3f6257ed2105259b404d419b4964e363928c=
:

  Linux 2.6.36-rc5 (2010-09-20 16:56:53 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 omap4_and_sdrc_2.6.27

Benoit Cousson (9):
      OMAP: hwmod: Rename dma_ch to dma_req
      OMAP: hwmod: Do not disable clocks if hwmod already in idle
      OMAP4: prcm: Add temporarily helper functions for rmw and read inside=
 the PRM
      OMAP: hwmod: Force a softreset during _setup
      OMAP: hwmod: Fix softreset status check for some new OMAP4 IPs
      OMAP: hwmod: Fix softreset for modules with optional clocks
      OMAP4: clock: Fix clock names and align with hwmod names
      OMAP4: clock: Add optional clock nodes
      OMAP4: clocks: Fix ES2 clock issues

Beno=EEt Cousson (2):
      OMAP4: PRM: add module hard reset support
      OMAP: hwmod: Add hardreset management support

Jon Hunter (1):
      omap3: Prevent SDRC deadlock when L3 is changing frequency

Kevin Hilman (1):
      OMAP: hwmod: separate list locking and hwmod hardware locking

Liam Girdwood (1):
      OMAP: hwmod: Fix omap_hwmod_reset wrong state test

Partha Basak (1):
      OMAP: hwmod: Handle opt clocks node using clk_add_alias

Paul Walmsley (3):
      OMAP2/3: PRM: add module hard reset support
      OMAP: hwmod: add an hardreset API for use by other core code
      OMAP: hwmod: improve documentation, clean up function names

Rajeev Kulkarni (1):
      OMAP4: prcm: Fix global warm reset bit position

Rajendra Nayak (5):
      OMAP: hwmod: Enable module wakeup if in smartidle
      OMAP4: clocks: Update clock tree for ES2
      OMAP4: CM & PRM: Update PRCM register bitshifts and masks for ES2
      OMAP4: PM: Define additional registers for ES2
      OMAP4: powerdomain: Update DSS logic state for ES2

Santosh Shilimkar (4):
      omap4: control: Add ctrl_pad_base to omap_globals
      omap4: control: Add accessor api's for pad control module
      omap4: control: Add the register definition headers
      omap4: control: Fix the control module register accesses

 arch/arm/mach-omap2/Makefile                       |    4 +-
 arch/arm/mach-omap2/clock44xx_data.c               | 1310 +++++++++++-----=
--
 arch/arm/mach-omap2/cm-regbits-44xx.h              | 1287 ++++++++++------=
---
 arch/arm/mach-omap2/cm44xx.h                       |   90 ++-
 arch/arm/mach-omap2/control.c                      |   25 +
 arch/arm/mach-omap2/hsmmc.c                        |   67 +-
 arch/arm/mach-omap2/id.c                           |    2 +-
 .../include/mach/ctrl_module_core_44xx.h           |  391 ++++++
 .../include/mach/ctrl_module_pad_core_44xx.h       | 1409 ++++++++++++++++=
++++
 .../include/mach/ctrl_module_pad_wkup_44xx.h       |  236 ++++
 .../include/mach/ctrl_module_wkup_44xx.h           |   92 ++
 arch/arm/mach-omap2/omap_hwmod.c                   |  562 +++++++--
 arch/arm/mach-omap2/powerdomains44xx.h             |    2 +-
 arch/arm/mach-omap2/prcm.c                         |   29 +-
 arch/arm/mach-omap2/prm-regbits-44xx.h             | 1314 ++++++++++------=
---
 arch/arm/mach-omap2/prm.h                          |   18 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.c                 |  110 ++
 arch/arm/mach-omap2/prm44xx.c                      |  116 ++
 arch/arm/mach-omap2/prm44xx.h                      |   14 +-
 arch/arm/mach-omap2/sram34xx.S                     |    6 +-
 arch/arm/plat-omap/common.c                        |    3 +-
 arch/arm/plat-omap/include/plat/common.h           |    1 +
 arch/arm/plat-omap/include/plat/control.h          |   31 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |   55 +-
 arch/arm/plat-omap/include/plat/powerdomain.h      |    1 +
 arch/arm/plat-omap/include/plat/prcm.h             |    2 +
 arch/arm/plat-omap/omap_device.c                   |   43 +-
 27 files changed, 5328 insertions(+), 1892 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.=
h
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_4=
4xx.h
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pad_wkup_4=
4xx.h
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.=
h
 create mode 100644 arch/arm/mach-omap2/prm2xxx_3xxx.c
 create mode 100644 arch/arm/mach-omap2/prm44xx.c


- Paul
--155748971-1392867116-1285399571=:10678--
