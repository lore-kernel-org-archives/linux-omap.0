From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/6] OMAP2+: hwmod framework fixes
Date: Thu, 23 Jun 2011 23:00:36 +0200
Message-ID: <1308862842-3933-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40547 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753Ab1FWVAs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 17:00:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi Paul,

Here are the latest bug fixes done on the hwmod framework.
There are mainly around wakeup capability added in OMAP4.

The series is based on for_3.0.1/2_prcm_files_cleanup and tested
on OMAP4430 ES2.1 + SDP.

The patches are available here:
git://gitorious.org/omap-pm/linux.git for_3.0.1/3_hwmod_fixes

Regards,
Benoit


Benoit Cousson (5):
  OMAP2+: hwmod: Fix smart-standby + wakeup support
  OMAP4: hwmod data: Add MSTANDBY_SMART_WKUP flag
  OMAP2+: hwmod: Do not write the enawakeup bit if SYSC_HAS_ENAWAKEUP is not set
  OMAP2+: hwmod: Remove _populate_mpu_rt_base warning
  OMAP2+: hwmod: Fix the HW reset management

Miguel Vadillo (1):
  OMAP2+: hwmod: Enable module in shutdown to access sysconfig

 arch/arm/mach-omap2/omap_hwmod.c             |   88 +++++++++++++++-----------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    9 ++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +-
 3 files changed, 58 insertions(+), 41 deletions(-)

