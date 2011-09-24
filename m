From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [GIT PULL] OMAP: Few sparse/bug fixes and clean-up for 3.2
Date: Sat, 24 Sep 2011 13:52:00 +0530
Message-ID: <1316852520-10377-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47736 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab1IXIWP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Sep 2011 04:22:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tony,

Please pull few OMAP sparse/bug fixes and clean-up for 3.2 

Thnaks,
Santosh

The following changes since commit b6fd41e29dea9c6753b1843a77e50433e6123bcb:

  Linux 3.1-rc6 (2011-09-12 14:02:02 -0700)

are available in the git repository at:
  git://gitorious.org/omap-sw-develoment/linux-omap-dev.git for_3_2/omap_misc

Santosh Shilimkar (1):
      OMAP4: Fix the emif and dmm virtual mapping

Todd Poynor (2):
      OMAP: Improve register access in L3 Error handler.
      OMAP: Fix a BUG in l3 error handler.

sricharan (3):
      OMAP: Fix indentation issues in l3 error handler.
      OMAP: Fix sparse warnings in l3 error handler.
      OMAP: Print Initiator name for l3 custom error.

 arch/arm/mach-omap2/omap_l3_noc.c    |  130 ++++++++++----------
 arch/arm/mach-omap2/omap_l3_noc.h    |  224 +++++++++++++++++++---------------
 arch/arm/mach-omap2/omap_l3_smx.c    |   91 +++++++-------
 arch/arm/mach-omap2/omap_l3_smx.h    |  164 ++++++++++++------------
 arch/arm/plat-omap/include/plat/io.h |    4 +-
 5 files changed, 322 insertions(+), 291 deletions(-)
