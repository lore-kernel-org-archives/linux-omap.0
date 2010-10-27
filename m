From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v3 0/6] OMAP4: Smartreflex and Voltage layer support
Date: Wed, 27 Oct 2010 21:46:30 +0530
Message-ID: <1288196196-15469-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56151 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756380Ab0J0QQo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Oct 2010 12:16:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch series adds support for OMAP4 support in the
smartreflex and voltage layer. The series involves extensions
to voltage layer and smartreflex layer for supporting OMAP4.
All these patches might not be dependent on voltage and
smartreflex layer but is required for the correct
functionality of these layers for OMAP4.

This series in based off lo-master and is dependent on the
"OMAP3: Adding Smartreflex and Voltage driver support" series
the link to which is below.

All these patches are also available at 
	http://dev.omapzoom.org/?p=thara/omap-dvfs.git;a=summary
	head: thara-pm-sr

This patch series has been tested on OMAP4430 SDP with omap2plus_defconfig
with the following menuconfig options enabled
        System type -> TI OMAP Implementations -> Smartreflex Support
        System type -> TI OMAP Implementations ->
                Class 3 mode of Smartreflex Implementation

Benoit Cousson (1):
  OMAP4: hwmod: Add inital data for smartreflex modules.

Thara Gopinath (5):
  OMAP4: Add the new voltage to vsel calculation formula
  OMAP4: Adding voltage driver support
  OMAP4: PM: Program correct init voltages for scalable VDDs
  OMAP4: Adding dev atrributes to OMAP4 smartreflex hwmod data
  OMAP4: Smartreflex framework extensions

 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/control.h              |   13 ++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  219 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.c                   |    4 +
 arch/arm/mach-omap2/smartreflex.c          |    8 +-
 arch/arm/mach-omap2/sr_device.c            |   12 ++-
 arch/arm/mach-omap2/voltage.c              |  208 ++++++++++++++++++++++++++-
 arch/arm/plat-omap/Kconfig                 |    2 +-
 arch/arm/plat-omap/include/plat/voltage.h  |   20 +++-
 arch/arm/plat-omap/opp_twl_tps.c           |   71 +++++++++
 10 files changed, 552 insertions(+), 7 deletions(-)

