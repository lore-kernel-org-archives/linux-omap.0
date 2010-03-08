From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 0/3] OMAP3: PM: OMAP3630 support for smartreflex driver
Date: Mon,  8 Mar 2010 22:50:48 +0530
Message-ID: <1268068851-30022-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48425 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279Ab0CHRVF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 12:21:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

This patch series adds support for the updated 45nm smrtrelfex IP
supported in OMAP3630 and OMAP4 in the smartreflex driver and
adds support to enable smartreflex autocompensation for OMAP3630
using test nvalues.

This patch series is based on the following patch series/patches
for proper functionality.
	http://marc.info/?l=linux-omap&m=126700378625593&w=2
	http://patchwork.kernel.org/patch/77739/

This patch series has been tested on OMAP3630 SDP board with
CONFIG_OMAP_SMARTREFLEX_TESTING option enabled in the menuconfig.

This patch series has been based on Kevin's PM tree
origin/pm-wip-opp branch and on
adea81232e8fc82334bca3707efa23dc854f29fc commit id.

Thara Gopinath (3):
  OMAP3: PM: Bug fix in Smartreflex driver.
  OMAP3: PM: Smartreflex IP update changes for OMAP3630
  OMAP3: PM: Adding OMAP3630 support in smartreflex driver

 arch/arm/mach-omap2/omap_hwmod_34xx.h     |   49 ++++-
 arch/arm/mach-omap2/smartreflex.c         |  354 +++++++++++++++++++++++-----
 arch/arm/mach-omap2/smartreflex.h         |   51 ++++-
 arch/arm/mach-omap2/voltage.c             |  167 +++++++++++---
 arch/arm/mach-omap2/voltage.h             |   32 ++-
 arch/arm/plat-omap/include/plat/control.h |    8 +
 6 files changed, 542 insertions(+), 119 deletions(-)

