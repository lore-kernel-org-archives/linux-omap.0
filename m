From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/3] OMAP: hwmod: Add hardreset and softreset management
Date: Thu,  5 Aug 2010 00:12:45 +0200
Message-ID: <1280959968-23933-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59261 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047Ab0HDWM4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Aug 2010 18:12:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, Benoit Cousson <b-cousson@ti.com>

Hi Paul & Kevin,

Here are a reset management series.

- The first patch will be removed as soon as we will have the proper
  OMAP4 support for the prm_xxx accessors.
- The second one is adding hardreset support in order to allow
  syslink driver to manage properly the DSP and IPU processor
  reset.
- The last one is forcing a sofreset after the first init. 
  Some IP might require sofreset after each wakeup
  from power domain OFF mode. That still needs to be confirm.


Tested on PAB board using OMAP4 ES1.0 GP device

Patches are based on lo/for-next + for-next-fixes and are available here:
git://dev.omapzoom.org/pub/scm/swarch/linux-omap-adv.git pm-wip/hwmods-reset

Regards,
Benoit


Benoit Cousson (3):
  OMAP4: prcm: Add temporarily helper functions for rmw and read inside
    the PRM
  OMAP: hwmod: Add hardreset management support
  OMAP: hwmod: Force a softreset during _setup

 arch/arm/mach-omap2/omap_hwmod.c             |  197 ++++++++++++++++++++++++--
 arch/arm/mach-omap2/prcm.c                   |   24 +++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   21 +++
 arch/arm/plat-omap/include/plat/prcm.h       |    2 +
 4 files changed, 235 insertions(+), 9 deletions(-)

