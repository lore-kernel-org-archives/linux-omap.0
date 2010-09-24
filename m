From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/12] OMAP: clock/CM/PRM/SCM updates for OMAP4 ES2,
	OMAP3 CORE DVFS fix: for 2.6.37
Date: Fri, 24 Sep 2010 01:08:05 -0600
Message-ID: <20100924070643.14014.11359.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33625 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749Ab0IXHJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 03:09:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

this series, intended to be merged for 2.6.37 through Tony's
tree, contains mostly OMAP4430 ES2 updates.  Also present is an
important OMAP3 CORE DVFS fix.  Comments welcome.


- Paul

---

   text	   data	    bss	    dec	    hex	filename
3361500	 176832	  99336	3637668	 3781a4	vmlinux.omap_4430sdp_defconfig.orig
3362268	 180384	  99336	3641988	 379284	vmlinux.omap_4430sdp_defconfig.patched

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


 arch/arm/mach-omap2/clock44xx_data.c               | 1310 +++++++++++--------
 arch/arm/mach-omap2/cm-regbits-44xx.h              | 1287 ++++++++++--------
 arch/arm/mach-omap2/cm44xx.h                       |   90 +
 arch/arm/mach-omap2/control.c                      |   25 
 arch/arm/mach-omap2/hsmmc.c                        |   67 +
 arch/arm/mach-omap2/id.c                           |    2 
 .../include/mach/ctrl_module_core_44xx.h           |  391 ++++++
 .../include/mach/ctrl_module_pad_core_44xx.h       | 1409 ++++++++++++++++++++
 .../include/mach/ctrl_module_pad_wkup_44xx.h       |  236 +++
 .../include/mach/ctrl_module_wkup_44xx.h           |   92 +
 arch/arm/mach-omap2/powerdomains44xx.h             |    2 
 arch/arm/mach-omap2/prm-regbits-44xx.h             | 1314 ++++++++++---------
 arch/arm/mach-omap2/prm44xx.h                      |   14 
 arch/arm/mach-omap2/sram34xx.S                     |    6 
 arch/arm/plat-omap/common.c                        |    3 
 arch/arm/plat-omap/include/plat/common.h           |    1 
 arch/arm/plat-omap/include/plat/control.h          |   31 
 arch/arm/plat-omap/include/plat/powerdomain.h      |    1 
 18 files changed, 4499 insertions(+), 1782 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pad_wkup_44xx.h
 create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h

