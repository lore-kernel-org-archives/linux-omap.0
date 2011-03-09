From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [GIT PULL] OMAP: L3 error handling driver for for 2.6.39
Date: Wed,  9 Mar 2011 17:35:50 +0530
Message-ID: <1299672350-17397-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53774 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932113Ab1CIMGD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 07:06:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, r.sricharan@ti.com, balbi@ti.com, b-cousson@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Tony,

Here is the pull-request for OMAP3 and OMAP4 L3 error handling driver.
It's based on the latest omap-for-linus branch of yours.

The following changes since commit 0640b436e410290193f554dcfd777bcdeee59697:
  Abhilash Vadakkepat Koyamangalath (1):
        audio : AM3517 : Adding i2c info for AIC23 codec

are available in the git repository at:

  git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git omap-l3-for-next

Felipe Balbi (1):
      OMAP3: l3: Introduce l3-interconnect error handling driver

Santosh Shilimkar (1):
      OMAP4: l3: Introduce l3-interconnect error handling driver

sricharan (4):
      OMAP3: hwmod_data: Add address space and irq in L3 hwmod.
      OMAP3: devices: Initialise the l3 device with the hwmod data.
      OMAP4: hwmod_data: Add address space and irq in L3 hwmod.
      OMAP4: Initialise the l3 device with the hwmod data.

 arch/arm/mach-omap2/Makefile               |    4 +
 arch/arm/mach-omap2/devices.c              |   64 ++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   22 ++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   38 +++
 arch/arm/mach-omap2/omap_l3_noc.c          |  253 +++++++++++++++++++++
 arch/arm/mach-omap2/omap_l3_noc.h          |  132 +++++++++++
 arch/arm/mach-omap2/omap_l3_smx.c          |  314 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_l3_smx.h          |  338 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/irqs.h     |    2 +
 9 files changed, 1165 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_l3_noc.c
 create mode 100644 arch/arm/mach-omap2/omap_l3_noc.h
 create mode 100644 arch/arm/mach-omap2/omap_l3_smx.c
 create mode 100644 arch/arm/mach-omap2/omap_l3_smx.h
 
 Regards
 Santosh
