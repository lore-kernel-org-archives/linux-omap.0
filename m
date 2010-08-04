From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/4] OMAP: hwmod & prcm fixes
Date: Wed,  4 Aug 2010 23:38:26 +0200
Message-ID: <1280957910-22718-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44572 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186Ab0HDVii (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Aug 2010 17:38:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, Benoit Cousson <b-cousson@ti.com>

Hi Paul & Kevin,

Here are a couples of fixes related to hwmod and prcm.

Tested on PAB board using OMAP4 ES1.0 GP device

Patches are based on lo/for-next and are available here:
git://dev.omapzoom.org/pub/scm/swarch/linux-omap-adv.git for-next-fixes

Regards,
Benoit


Benoit Cousson (2):
  OMAP: hwmod: Rename dma_ch to dma_req
  OMAP: hwmod: Do not disable clocks if hwmod already in idle

Liam Girdwood (1):
  OMAP: hwmod: Fix omap_hwmod_reset wrong state test

Rajeev Kulkarni (1):
  OMAP4: prcm: Fix global warm reset bit position

 arch/arm/mach-omap2/omap_hwmod.c             |   26 ++++++++++++++------------
 arch/arm/mach-omap2/prcm.c                   |    5 +++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   12 ++++++------
 3 files changed, 23 insertions(+), 20 deletions(-)

