From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 00/16] OMAP4: PRCM big spring (late) cleanup
Date: Thu, 23 Jun 2011 19:43:29 +0200
Message-ID: <1308851025-26313-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58025 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933109Ab1FWRoH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 13:44:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi Paul,

Here are a bunch of cleanups on almost every PRCM related files.
Some of them are purely code moves, and will look like a lot of
noise for nothing, but this is needed if we want to keep the files
aligned with generator tool and thus ease the future migration to
whatever format (common clock framework + DT).
Moreover, the diffstat is negative:-)

The series is based on for_3.0.1/1_prcm_files_fixes and tested
on OMAP4430 ES2.1 + SDP.

The patches are available here:
git://gitorious.org/omap-pm/linux.git for_3.0.1/2_prcm_files_cleanup

Regards,
Benoit


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
  OMAP4: hwmod data: Fix typo and alignement
  OMAP4: hwmod data: Replace CHIP_IS_OMAP4430 by OMAP44XX

Jon Hunter (2):
  OMAP4: clock data: Remove McASP2, McASP3 and MMC6 clocks
  OMAP4: clock data: Remove UNIPRO clock nodes

Rajendra Nayak (2):
  OMAP4: clock data: Rename clock flags from 443X to 44XX
  OMAP4: clock data: Add missing divider selection for auxclks

 arch/arm/mach-omap2/clock44xx.h               |    7 -
 arch/arm/mach-omap2/clock44xx_data.c          | 1010 +++++++++++++------------
 arch/arm/mach-omap2/clockdomains44xx_data.c   |  124 ++--
 arch/arm/mach-omap2/cm-regbits-44xx.h         |  702 +++++++-----------
 arch/arm/mach-omap2/cm1_44xx.h                |   36 -
 arch/arm/mach-omap2/cm2_44xx.h                |   90 ---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |  244 +++---
 arch/arm/mach-omap2/prcm_mpu44xx.h            |   69 +-
 arch/arm/mach-omap2/prm-regbits-44xx.h        |  178 +----
 arch/arm/mach-omap2/prm44xx.h                 |   64 --
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    2 +
 arch/arm/plat-omap/include/plat/clock.h       |    3 +-
 arch/arm/plat-omap/include/plat/cpu.h         |    2 +
 13 files changed, 1068 insertions(+), 1463 deletions(-)

