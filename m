From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 0/7] OMAP: hwmod: Full data set for OMAP4430 ES1 & ES2
Date: Thu,  5 Aug 2010 17:47:49 +0200
Message-ID: <1281023276-15679-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39650 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756454Ab0HEPsE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 11:48:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, Benoit Cousson <b-cousson@ti.com>

Hi Kevin & Paul,

Here is the OMAP4430 ES1 & ES2 hwmod data v3 series.

Please note that there is no difference between the ES1 & ES2 wrt hwmod.

This series is re-organised in order to allow initial submission for upstream
with minimal interconnect data set + mpu.

Further data will be sent along with the driver once adapted to hwmod.
A first patch is done for the TIMER IP as an example.

Patches are based on lo/for-next + for-next-fixes + pm-wip/hwmods-reset
+ pm-wip/hwmods-debugfs and are available here:
git://dev.omapzoom.org/pub/scm/swarch/linux-omap-adv.git pm-wip/hwmods-omap4

Tested on OMAP4430 ES1.0 GP device using PAB board.

Thanks,
Benoit

v1
  http://marc.info/?l=linux-omap&m=127324843814741&w=2

v2
  http://www.spinics.net/lists/linux-omap/msg29622.html
  - [PATCH 3/6] OMAP4: hwmod: Enable omap_device build for OMAP4
    Removed some old defines for OMAP_32KSYNCT_BASE that has nothing
    to do in that file and was already removed by Tony.

v3
  - Re-organize the data for initial submission
  - Fix and align clock name with the hwmod
  - Add hardreset support
  - Add DSS sub-modules
  - Add mpu_bus for internal access from mpu to mpu subsystem
  - Fix interconnect wrong class name


Benoit Cousson (7):
  OMAP4: hwmod: Add initial data for OMAP4430 ES1 & ES2
  OMAP4: clock: Fix clock names and align with hwmod names
  OMAP4: pm: Change l3_main to l3_main_1 during bus device init
  OMAP4: hwmod: Add TIMER data for OMAP4430 ES1 & ES2
  OMAP4: hwmod: Add remaining hwmods data for OMAP4430 ES1 & ES2
  OMAP: hwmod: Temporary prevent reset during _setup for GPIOs
  OMAP: hwmod: Temporary prevent reset during _setup for I2Cs

 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/clock44xx_data.c         |  715 ++--
 arch/arm/mach-omap2/io.c                     |    7 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   | 5801 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.c                     |    5 +-
 arch/arm/plat-omap/Makefile                  |    2 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 7 files changed, 6147 insertions(+), 385 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_44xx_data.c

