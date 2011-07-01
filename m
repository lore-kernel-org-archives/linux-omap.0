From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 00/18] OMAP4: PM data big spring cleanup and fixes
Date: Fri, 1 Jul 2011 22:41:23 +0200
Message-ID: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34605 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090Ab1GAUlv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 16:41:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Hi Paul,

Here are a bunch of cleanups on almost every PRCM related data files.
Some of them are purely code moves, and will look like a lot of
noise for nothing, but this is needed if we want to keep the files
aligned with generator tool and thus ease the future migration to
whatever format (common clock framework + DT).
Moreover, the diffstat is negative:-)

I added as well the 2 fixes that Tomi did for the DSS pm_runtime
migration. That series must then be merged before the DSS series.

The series is based on for_3.1/1_prcm_files_fixes and tested
on OMAP4430 ES2.1 + SDP.

The patches are available here:
git://gitorious.org/omap-pm/linux.git for_3.1/2_prcm_files_cleanup

Regards,
Benoit


Changes since v1:
    - Add 2 patches for the DSS

Benoit Cousson (12):
  OMAP4: cm: Remove RESTORE macros to avoid access from SW
  OMAP4: prcm_mpu: Fix indent in few macros
  OMAP4: clockdomain data: Fix data order and wrong name
  OMAP4: clock data: Add sddiv to USB DPLL
  OMAP4: clock data: Remove usb_host_fs clkdev with NULL dev
  OMAP4: clock data: Re-order some clock nodes and structure fields
  OMAP4: clock data: Fix max mult and div for USB DPLL
  OMAP4: prcm: Remove references to non-existant peripherals
  OMAP4: hwmod data: Fix L3 interconnect data order and alignement
  OMAP4: hwmod data: Remove un-needed parens
  OMAP4: hwmod data: Fix bad alignement
  OMAP4: hwmod data: Replace CHIP_IS_OMAP4430 by OMAP44XX

Jon Hunter (2):
  OMAP4: clock data: Remove McASP2, McASP3 and MMC6 clocks
  OMAP4: clock data: Remove UNIPRO clock nodes

Rajendra Nayak (2):
  OMAP4: clock data: Rename clock flags from 443X to 44XX
  OMAP4: clock data: Add missing divider selection for auxclks

Tomi Valkeinen (2):
  OMAP4: hwmod data: Modify DSS opt clocks
  OMAP4: hwmod data: Change DSS main_clk scheme

 arch/arm/mach-omap2/clock44xx.h               |    7 -
 arch/arm/mach-omap2/clock44xx_data.c          | 1022 +++++++++++++------------
 arch/arm/mach-omap2/clockdomains44xx_data.c   |  124 ++--
 arch/arm/mach-omap2/cm-regbits-44xx.h         |  702 +++++++----------
 arch/arm/mach-omap2/cm1_44xx.h                |   36 -
 arch/arm/mach-omap2/cm2_44xx.h                |   90 ---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |  312 +++++----
 arch/arm/mach-omap2/prcm_mpu44xx.h            |   69 +-
 arch/arm/mach-omap2/prm-regbits-44xx.h        |  178 +----
 arch/arm/mach-omap2/prm44xx.h                 |   64 --
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    2 +
 arch/arm/plat-omap/include/plat/clock.h       |    3 +-
 arch/arm/plat-omap/include/plat/cpu.h         |    2 +
 13 files changed, 1130 insertions(+), 1481 deletions(-)

