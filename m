From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv3 0/2] OMAP3: PM: OMAP3630 support for smartreflex driver
Date: Fri, 16 Apr 2010 15:49:54 +0530
Message-ID: <1271413196-6087-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43811 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259Ab0DPKUG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 06:20:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch series adds support for the updated 45nm smrtrelfex IP
supported in OMAP3630 and OMAP4 in the smartreflex driver and
adds support to enable smartreflex autocompensation for OMAP3630
using test nvalues.

This patch series is based on the V3 version of Smartreflex and
voltage revamp  patch series.

This patch series has been tested on OMAP3630 SDP board with
CONFIG_OMAP_SMARTREFLEX_TESTING option enabled in the menuconfig.

This patch series has been based on Kevin's PM tree
origin/pm-wip-opp branch.

Thara Gopinath (2):
  OMAP3: PM: Smartreflex IP update changes for OMAP3630
  OMAP3: PM: Adding OMAP3630 support in smartreflex driver

 arch/arm/mach-omap2/board-3630sdp.c        |    2 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   86 +++++++++++-
 arch/arm/mach-omap2/smartreflex.c          |  217 ++++++++++++++++++++--------
 arch/arm/mach-omap2/smartreflex.h          |   44 +++++-
 arch/arm/mach-omap2/voltage.c              |   45 ++++++-
 arch/arm/mach-omap2/voltage.h              |   22 +++-
 arch/arm/plat-omap/include/plat/control.h  |    8 +
 7 files changed, 348 insertions(+), 76 deletions(-)

