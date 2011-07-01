From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 0/8] OMAP2+: hwmod framework fixes
Date: Fri, 1 Jul 2011 22:53:59 +0200
Message-ID: <1309553647-14624-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35263 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756130Ab1GAUyR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 16:54:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Hi Paul,

Here are the latest bug fixes done on the hwmod framework.
There are mainly around wakeup capability added in OMAP4.

The series is based on for_3.1/2_prcm_files_cleanup and tested
on OMAP4430 ES2.1 + SDP.

The patches are available here:
git://gitorious.org/omap-pm/linux.git for_3.1/3_hwmod_fixes

Regards,
Benoit


Changes since v1:
    - Fix prm_ prefix
    - Move one patch from the module mode series here.
    - Add a extra patch to move the debug information at
      a better place in the code.

Benoit Cousson (7):
  OMAP2+: hwmod: Fix smart-standby + wakeup support
  OMAP4: hwmod data: Add MSTANDBY_SMART_WKUP flag
  OMAP2+: hwmod: Do not write the enawakeup bit if SYSC_HAS_ENAWAKEUP is not set
  OMAP2+: hwmod: Remove _populate_mpu_rt_base warning
  OMAP2+: hwmod: Fix the HW reset management
  OMAP: hwmod: Add warnings if enable failed
  OMAP: hwmod: Move pr_debug to improve the readability

Miguel Vadillo (1):
  OMAP2+: hwmod: Enable module in shutdown to access sysconfig

 arch/arm/mach-omap2/omap_hwmod.c             |  122 +++++++++++++++-----------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    9 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +-
 3 files changed, 77 insertions(+), 56 deletions(-)

