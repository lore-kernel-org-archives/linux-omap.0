From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 0/3] OMAP3: PM: OMAP3630 support for smartreflex driver
Date: Wed, 31 Mar 2010 12:00:11 +0530
Message-ID: <1270017014-27704-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38178 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932751Ab0CaGaa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Mar 2010 02:30:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch series adds support for the updated 45nm smrtrelfex IP
supported in OMAP3630 and OMAP4 in the smartreflex driver and
adds support to enable smartreflex autocompensation for OMAP3630
using test nvalues.

This patch series is based on the V2 version of Smartreflex and
voltage revamp patch series, link to which is the following.

	http://marc.info/?l=linux-omap&m=126890378014626&w=2

This patch series has been tested on OMAP3630 SDP board with
CONFIG_OMAP_SMARTREFLEX_TESTING option enabled in the menuconfig.

This patch series has been based on Kevin's PM tree
origin/pm-wip-opp branch.

Thara Gopinath (3):
  OMAP3: PM: Fix crash when enabling SmartReflex on non-supported
    OMAPs.
  OMAP3: PM: Smartreflex IP update changes for OMAP3630
  OMAP3: PM: Adding OMAP3630 support in smartreflex driver

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   47 +++++-
 arch/arm/mach-omap2/smartreflex.c          |  280 +++++++++++++++++++++-------
 arch/arm/mach-omap2/smartreflex.h          |   50 ++++-
 arch/arm/mach-omap2/sr_device.c            |   94 +++++++++-
 arch/arm/mach-omap2/voltage.c              |   47 ++++-
 arch/arm/mach-omap2/voltage.h              |   32 +++-
 arch/arm/plat-omap/include/plat/control.h  |    8 +
 7 files changed, 464 insertions(+), 94 deletions(-)

