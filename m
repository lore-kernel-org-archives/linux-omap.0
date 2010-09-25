From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 00/11] OMAP4: Smartreflex and Voltage layer support
Date: Sat, 25 Sep 2010 18:21:15 +0530
Message-ID: <1285419086-13047-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45498 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985Ab0IYMvh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 25 Sep 2010 08:51:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch series adds support for OMAP4 support in the
smartreflex and voltage layer. The series involves extensions
to voltage layer and smartreflex layer for supporting OMAP4.
In addition it involves changes to pm debugfs layer to support
OMAP4 so that smartreflex and voltage debug entries can be
viewed, changes in opp layer so that opp layer gets enabled
for OMAP4, some changes in OMAP4 clock database and finally
addition of OMAP4 opp tables.
All these patches might not be dependent on voltage and
smartreflex layer but is required for the correct
functionality of these layers for OMAP4.

This series in based off origin/pm-core and origin/pm-opp
branches off Kevin Hilman' PM tree. But for this series to compile
and work properly one will have to apply the following
additional patches also.
	http://dev.omapzoom.org/?p=santosh/kernel-omap4-base.git;a=summary
		branch - omap4_scm_2.6.37
	http://marc.info/?l=linux-omap&m=128516673609816&w=2

All these patches are also available at 
	http://dev.omapzoom.org/?p=thara/omap-dvfs.git;a=summary
	head: thara-pm-sr

This patch series has been tested on OMAP4430 SDP with omap3_defconfig
and omap_4430dsp_defconfig with the following menuconfig options enabled
        System type -> TI OMAP Implementations -> Smartreflex Support
        System type -> TI OMAP Implementations ->
                Class 3 mode of Smartreflex Implementation

Benoit Cousson (1):
  OMAP4: hwmod: Add inital data for smartreflex modules.

Thara Gopinath (10):
  OMAP4: PM debugfs support
  OMAP4: OPP framework support
  OMAP4: Add the new voltage to vsel calculation formula
  OMAP4: Extend clock data.
  OMAP4: Adding voltage driver support
  OMAP4: PM: Program correct init voltages for scalable VDDs
  OMAP4: Adding dev atrributes to OMAP4 smartreflex hwmod data
  OMAP4: Smartreflex framework extensions
  OMAP4: Enabling smartrefles class 3 driver.
  OMAP4: Add opp tables.

 arch/arm/mach-omap2/Makefile               |    3 +-
 arch/arm/mach-omap2/board-4430sdp.c        |    2 +
 arch/arm/mach-omap2/clock44xx_data.c       |   40 ++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  219 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/opp44xx_data.c         |   99 +++++++++++++
 arch/arm/mach-omap2/pm-debug.c             |   28 ++--
 arch/arm/mach-omap2/pm.c                   |    5 +
 arch/arm/mach-omap2/pm.h                   |    1 +
 arch/arm/mach-omap2/smartreflex.c          |    8 +-
 arch/arm/mach-omap2/sr_device.c            |   15 ++-
 arch/arm/mach-omap2/voltage.c              |  211 ++++++++++++++++++++++++++-
 arch/arm/plat-omap/Kconfig                 |    2 +-
 arch/arm/plat-omap/Makefile                |    1 +
 arch/arm/plat-omap/include/plat/control.h  |   12 ++
 arch/arm/plat-omap/include/plat/voltage.h  |   20 +++-
 arch/arm/plat-omap/opp_twl_tps.c           |   71 +++++++++
 16 files changed, 707 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/mach-omap2/opp44xx_data.c

