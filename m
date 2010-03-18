From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 00/17] OMAP3: PM: Smartreflex and voltage revamp.
Date: Thu, 18 Mar 2010 14:45:38 +0530
Message-ID: <1268903755-4151-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50241 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922Ab0CRJQI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 05:16:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

The main motivations behind this patch series are the following
1. Making smartreflex a platform driver with omap-device layer.
2. Separating voltage specific code from smartreflex.c and other
   locations and consolidating them into voltage.c and voltage.h.
3. Smartreflex module can have Class 3 or Class 2 implementations
   depending on the PMIC in use. Making smartreflex.c capable
   of handling both the class implementaions and separating out
   class specific code into a separate class driver.
4. Remove dependencies on opp id in the smartreflex and
   voltage drivers
5. Implementating  latest TI recommended register settings for
  Smartreflex and Voltage processor module as well as recommended
  sequences for enabling and disabling of Smartreflex and Voltage
  processor modules.
6. Implementing VP force update method of voltage scaling which is
   again TI hardware recommended.

What this patch series does not address are
1. Separating PMIC specific portions from smartreflex and voltage code.
2. OMAP3630 and OMP4 smartreflex support.

This patch series is based on Kevin's PM tree origin/pm-wip-opp branch
and is dependent on the following patches not yet applied onto this branch.

	http://patchwork.kernel.org/patch/81504/
	http://patchwork.kernel.org/patch/81606/

This patch series has been tested on OMAP3430 SDP with basic power
management tests including the dvfs scripts.

Thara Gopinath (17):
  OMAP3: PM: Adding hwmod data for Smartreflex
  OMAP3: PM: Create list to keep track of various smartreflex
    instances.
  OMAP3: PM: Convert smartreflex driver into a platform driver using
    hwmods and omap-device layer
  OMAP3: PM: Move smartreflex autocompensation enable disable hooks to
    PM debugfs.
  OMAP3: PM: Remove OPP id dependency from smartreflex driver
  OMAP3: PM: Correcting API names in samrtreflex driver.
  OMAP3: PM: Smartreflex class related changes for smartreflex.c
  OMAP3: PM: Adding smartreflex class 3 driver.
  OMAP3: PM: Creating separate files for handling OMAP3 voltage related
    operations.
  OMAP3: PM: Disabling Smartreflex across both frequency and voltage
    scaling during DVFS.
  OMAP3: PM: Cleaning up of smartreflex header file.
  OMAP3: PM: Configurations for Smartreflex Class 2 and Smartreflex
    Class 3
  OMAP3: PM: Support for enabling smartreflex autocompensation by
    default.
  OMAP3: PM: Correcting accessing of ERRCONFIG register in
    smartreflex.c
  OMAP3: PM: Implement latest h/w recommendations for SR and VP
    registers and SR VP enable disable sequence.
  OMAP3: PM: VP force update method of voltage scaling
  OMAP3: PM: Enabling Smartreflex Class 3 driver by default in pm
    defconfig

 arch/arm/configs/omap3_pm_defconfig        |    1 +
 arch/arm/mach-omap2/Makefile               |    6 +-
 arch/arm/mach-omap2/board-3430sdp.c        |    3 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   94 ++
 arch/arm/mach-omap2/pm-debug.c             |    4 +-
 arch/arm/mach-omap2/pm.h                   |    7 -
 arch/arm/mach-omap2/pm34xx.c               |   95 +--
 arch/arm/mach-omap2/resource34xx.c         |   27 +-
 arch/arm/mach-omap2/resource34xx.h         |    1 -
 arch/arm/mach-omap2/smartreflex-class3.c   |   53 ++
 arch/arm/mach-omap2/smartreflex.c          | 1297 +++++++++++-----------------
 arch/arm/mach-omap2/smartreflex.h          |  336 ++++----
 arch/arm/mach-omap2/sr_device.c            |  196 +++++
 arch/arm/mach-omap2/voltage.c              |  823 ++++++++++++++++++
 arch/arm/mach-omap2/voltage.h              |   80 ++
 arch/arm/plat-omap/Kconfig                 |   11 +-
 16 files changed, 1935 insertions(+), 1099 deletions(-)
 create mode 100644 arch/arm/mach-omap2/smartreflex-class3.c
 create mode 100644 arch/arm/mach-omap2/sr_device.c
 create mode 100644 arch/arm/mach-omap2/voltage.c
 create mode 100644 arch/arm/mach-omap2/voltage.h

