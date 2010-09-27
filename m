From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL v2] OMAP: clock/CM/PRM/SCM updates for OMAP4 ES2, OMAP3
 CORE DVFS fix: for 2.6.37
Date: Mon, 27 Sep 2010 14:08:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009271404200.5171@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41125 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932619Ab0I0UIq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 16:08:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony, 

Thanks for catching my mistake in the previous pull request for these 
patches - it inadvertently also contained the patches from the pull 
request "OMAP: hwmod fixes and improvements for 2.6.37".  This updated 
pull request contains just the new patches that were posted from this 
series:

The following changes since commit b30a3f6257ed2105259b404d419b4964e363928c:

  Linux 2.6.36-rc5 (2010-09-20 16:56:53 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 omap4_and_sdrc_2.6.27

Benoit Cousson (3):
      OMAP4: clock: Fix clock names and align with hwmod names
      OMAP4: clock: Add optional clock nodes
      OMAP4: clocks: Fix ES2 clock issues

Jon Hunter (1):
      omap3: Prevent SDRC deadlock when L3 is changing frequency

Rajendra Nayak (4):
      OMAP4: clocks: Update clock tree for ES2
      OMAP4: CM & PRM: Update PRCM register bitshifts and masks for ES2
      OMAP4: PM: Define additional registers for ES2
      OMAP4: powerdomain: Update DSS logic state for ES2

Santosh Shilimkar (4):
      omap4: control: Add ctrl_pad_base to omap_globals
      omap4: control: Add accessor api's for pad control module
      omap4: control: Add the register definition headers
      omap4: control: Fix the control module register accesses

 arch/arm/mach-omap2/clock44xx_data.c               | 1310 +++++++++++-------
 arch/arm/mach-omap2/cm-regbits-44xx.h              | 1287 ++++++++++---------
 arch/arm/mach-omap2/cm44xx.h                       |   90 ++-
 arch/arm/mach-omap2/control.c                      |   25 +
 arch/arm/mach-omap2/hsmmc.c                        |   67 +-
 arch/arm/mach-omap2/id.c                           |    2 +-
 .../include/mach/ctrl_module_core_44xx.h           |  391 ++++++
 .../include/mach/ctrl_module_pad_core_44xx.h       | 1409 ++++++++++++++++++++
 .../include/mach/ctrl_module_pad_wkup_44xx.h       |  236 ++++
 .../include/mach/ctrl_module_wkup_44xx.h           |   92 ++
 arch/arm/mach-omap2/powerdomains44xx.h             |    2 +-
 arch/arm/mach-omap2/prm-regbits-44xx.h             | 1314 ++++++++++---------
 arch/arm/mach-omap2/prm44xx.h                      |   14 +-
 arch/arm/mach-omap2/sram34xx.S                     |    6 +-
 arch/arm/plat-omap/common.c                        |    3 +-
 arch/arm/plat-omap/include/plat/common.h           |    1 +
 arch/arm/plat-omap/include/plat/control.h          |   31 +-
 arch/arm/plat-omap/include/plat/powerdomain.h      |    1 +
 18 files changed, 4499 insertions(+), 1782 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pad_wkup_44xx.h
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h


- Paul
