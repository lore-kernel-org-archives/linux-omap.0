From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v5 0/5] OMAP4: Smartreflex and Voltage layer support
Date: Mon, 20 Dec 2010 22:30:32 +0530
Message-ID: <1292864437-15353-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54802 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932874Ab0LTRAz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 12:00:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, nm@ti.com, Thara Gopinath <thara@ti.com>

This patch series adds support for OMAP4 support in the
smartreflex and voltage layer. The series involves extensions
to voltage layer and smartreflex layer for supporting OMAP4.

This series in based against kernel.org  2.6.37-rc3 and is
dependent on the "OMAP3: Adding Smartreflex and Voltage driver support"
series.

All these patches are also available at
        http://dev.omapzoom.org/?p=thara/omap-dvfs.git;a=summary
        head: kevin-pm-sr

This patch series has been tested on OMAP4430 SDP with omap2plus_defconfig
with the following menuconfig options enabled
        System type -> TI OMAP Implementations -> Smartreflex Support
        System type -> TI OMAP Implementations ->
                Class 3 mode of Smartreflex Implementation

Benoit Cousson (1):
  OMAP4: hwmod: Add inital data for smartreflex modules.

Thara Gopinath (4):
  OMAP4: Register voltage PMIC parameters with the voltage layer
  OMAP4: Adding voltage driver support
  OMAP4: PM: Program correct init voltages for scalable VDDs
  OMAP4: Smartreflex framework extensions

 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/control.h              |   12 ++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  168 +++++++++++++++++
 arch/arm/mach-omap2/omap_twl.c             |  166 +++++++++++++++++
 arch/arm/mach-omap2/pm.c                   |   12 ++
 arch/arm/mach-omap2/pm.h                   |    5 +
 arch/arm/mach-omap2/smartreflex.c          |    8 +-
 arch/arm/mach-omap2/sr_device.c            |   17 ++-
 arch/arm/mach-omap2/voltage.c              |  279 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/Kconfig                 |    2 +-
 arch/arm/plat-omap/include/plat/voltage.h  |   12 ++
 11 files changed, 678 insertions(+), 5 deletions(-)

