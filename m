From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 00/10] OMAP4: Smartreflex and Voltage layer support
Date: Wed, 18 Aug 2010 16:46:21 +0530
Message-ID: <1282130191-9062-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42877 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab0HRLQn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Aug 2010 07:16:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, thara gopinath <thara@ti.com>

From: thara gopinath <thara@ti.com>

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

This series in based off origin/pm-opp branch off
Kevin Hilman's PM tree which is effectively 2.6.35 with
basic opp support added. But for this series to compile
and work properly one will have to apply the following
additional patches in the below mentioned order before
applying this series.
	https://patchwork.kernel.org/patch/119544/
	https://patchwork.kernel.org/patch/117347/
	https://patchwork.kernel.org/patch/117348/
	https://patchwork.kernel.org/patch/117349/
	http://marc.info/?l=linux-omap&m=128162263809748&w=2
	https://patchwork.kernel.org/patch/119854/
	all 5 patches from origin/pm-cpufreq branch off Kevin's pm tree
	http://marc.info/?l=linux-omap&m=128170725127719&w=2
				- all eight patches in this series

This patch series has been tested on OMAP4430 SDP with omap3_defconfig
with the following menuconfig options enabled
	System type -> TI OMAP Implementations -> Smartreflex Support
	System type -> TI OMAP Implementations ->
                Class 3 mode of Smartreflex Implementation

Benoit Cousson (1):
  OMAP4: hwmod: Add inital data for smartreflex modules.

Thara Gopinath (9):
  OMAP4: PM debugfs support
  OMAP4: OPP framework support
  OMAP4: Add the new voltage to vsel calculation formula
  OMAP4: Extend clock data.
  OMAP4: Adding voltage driver support
  OMAP4: Adding dev atrributes to OMAP4 smartreflex hwmod data
  OMAP4: Smartreflex framework extensions
  OMAP4: Enabling smartrefles class 3 driver.
  OMAP4: Add opp tables.

 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c        |    2 +
 arch/arm/mach-omap2/clock44xx_data.c       |   40 ++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  220 +++++++++++++++++++++++++
 arch/arm/mach-omap2/opp44xx.h              |   26 +++
 arch/arm/mach-omap2/opp44xx_data.c         |   80 +++++++++
 arch/arm/mach-omap2/pm-debug.c             |   53 +++++-
 arch/arm/mach-omap2/pm.c                   |    6 +-
 arch/arm/mach-omap2/smartreflex.c          |    7 +-
 arch/arm/mach-omap2/sr_device.c            |   21 ++-
 arch/arm/mach-omap2/voltage.c              |  246 +++++++++++++++++++++++++++-
 arch/arm/plat-omap/Kconfig                 |    2 +-
 arch/arm/plat-omap/Makefile                |    1 +
 arch/arm/plat-omap/include/plat/control.h  |   12 ++
 arch/arm/plat-omap/include/plat/voltage.h  |   20 ++-
 arch/arm/plat-omap/opp_twl_tps.c           |    8 +
 16 files changed, 721 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/mach-omap2/opp44xx.h
 create mode 100644 arch/arm/mach-omap2/opp44xx_data.c

-- 
1.7.1.GIT

