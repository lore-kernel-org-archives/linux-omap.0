From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/2] l2x0: Add PL310 Errata 727915
Date: Fri, 18 Feb 2011 18:05:23 +0530
Message-ID: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48289 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754823Ab1BRMfu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 07:35:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, tony@atomide.com, catalin.marinas@arm.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Based on feedback from Catalin on the L2X0 ERRATA 742231 patch, I have split
the original patch into two separate patches. First one adds errata and
also removes OMAP dependency from it so that other SOCs can use them.
Second patch populates the set_debug() pointer for OMAP using secure
SMC call to alter the debug registers.

Mail thread on this:
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg44571.html

The following changes since commit 85e2efbb1db9a18d218006706d6e4fbeb0216213:
  Linus Torvalds (1):
        Linux 2.6.38-rc5

Santosh Shilimkar (2):
  ARM: l2x0: Errata fix for flush by Way operation can cause data
    corruption
  omap4: l2x0: Populate set_debug() function and enable Errata 727915

 arch/arm/Kconfig                   |   15 ++++++++++++---
 arch/arm/include/asm/outercache.h  |    1 +
 arch/arm/mach-omap2/Kconfig        |    1 +
 arch/arm/mach-omap2/omap4-common.c |    7 +++++++
 arch/arm/mm/cache-l2x0.c           |   28 +++++++++++++++-------------
 5 files changed, 36 insertions(+), 16 deletions(-)

