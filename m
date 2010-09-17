From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 00/14] omap sram, omap4 control module and es2.0 support
Date: Fri, 17 Sep 2010 15:17:44 +0530
Message-ID: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45878 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab0IQJsL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 05:48:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This is consolidated patch series targetted for 2.6.37 merge window.
All of these patches have been already posted/reviewed on the list.

The series contains
	- SRAM mapping fixes to avoid speculative aborts
	- omap4 control module support
	- Fixes for omap4 HS/GP detection
	- omap4 es2.0 fixes. MMC and ethernet fixes are queued in respective
	  trees
	  
Boot tested with omap3_defconfig on
			- OMAP4430 SPP
			- OMAP4 Panda
			- OMAP4 Blaze
			- OMAP3430 SDP

The following changes since commit 03a7ab083e4d619136d6f07ce70fa9de0bc436fc:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../sfrench/cifs-2.6

are available in the git repository at:

  git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git omap_for_2.6.37

David Anders (1):
      omap4: Panda: Add DEBUG_LL support

Santosh Shilimkar (11):
      ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONCACHED L1 entries
      omap: Map only available sram memory
      davinci: map sram using MT_MEMORY_NONCACHED instead of MT_DEVICE
      omap4: control: Add ctrl_pad_base to omap_globals
      omap4: control: Add accessor api's for pad control module
      omap4: control: Add the register definition headers
      omap4: control: Fix the control module register accesses
      omap4: Update id.c and cpu.h for es2.0
      omap4: Fix silicon version detection for early samples
      omap4: l2x0: Fix init parameter for es2.0
      omap4: Fix bootup crash observed with higher CPU clocks

Vikram Pandita (2):
      omap: sram: fix is_sram_locked check
      omap4: sram: Fix start address

 arch/arm/mach-davinci/dm355.c                      |    3 +-
 arch/arm/mach-davinci/dm365.c                      |    3 +-
 arch/arm/mach-davinci/dm644x.c                     |    3 +-
 arch/arm/mach-davinci/dm646x.c                     |    3 +-
 arch/arm/mach-omap2/control.c                      |   25 +
 arch/arm/mach-omap2/hsmmc.c                        |   67 +-
 arch/arm/mach-omap2/id.c                           |   40 +-
 .../include/mach/ctrl_module_core_44xx.h           |  391 ++++++
 .../include/mach/ctrl_module_pad_core_44xx.h       | 1409 ++++++++++++++++++++
 .../include/mach/ctrl_module_pad_wkup_44xx.h       |  236 ++++
 .../include/mach/ctrl_module_wkup_44xx.h           |   92 ++
 arch/arm/mach-omap2/omap4-common.c                 |   10 +-
 arch/arm/mm/mmu.c                                  |   17 +-
 arch/arm/plat-omap/common.c                        |    3 +-
 arch/arm/plat-omap/dmtimer.c                       |    2 +-
 arch/arm/plat-omap/include/plat/common.h           |    1 +
 arch/arm/plat-omap/include/plat/control.h          |   31 +-
 arch/arm/plat-omap/include/plat/cpu.h              |    5 +-
 arch/arm/plat-omap/include/plat/uncompress.h       |    1 +
 arch/arm/plat-omap/sram.c                          |   38 +-
 20 files changed, 2271 insertions(+), 109 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pad_wkup_44xx.h
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
