From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/2] ARM: OMAP: Couple of misc fixes for 3.3
Date: Thu, 2 Feb 2012 19:33:53 +0530
Message-ID: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35256 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110Ab2BBOEG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Feb 2012 09:04:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Patches are tested on OMAP4430 SDP.

The following changes since commit 62aa2b537c6f5957afd98e29f96897419ed5ebab:

  Linux 3.3-rc2 (2012-01-31 13:31:54 -0800)

Rajendra Nayak (1):
  ARM: OMAP: Get rid of reset for system timer

Santosh Shilimkar (1):
  ARM: OMAP4: Move the barrier memboclk_steal() as part of reserve
    callback

 arch/arm/mach-omap2/Kconfig                   |    4 ++--
 arch/arm/mach-omap2/common.h                  |    1 +
 arch/arm/mach-omap2/io.c                      |    1 +
 arch/arm/mach-omap2/omap4-common.c            |   25 ++++++++++++++++---------
 arch/arm/mach-omap2/timer.c                   |    1 -
 arch/arm/plat-omap/common.c                   |    1 +
 arch/arm/plat-omap/include/plat/omap-secure.h |    6 ++++++
 7 files changed, 27 insertions(+), 12 deletions(-)

-- 
1.7.4.1

