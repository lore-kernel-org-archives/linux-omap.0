From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: [PATCH 0/2] Introduce clock support for AM35xx IPSS modules
Date: Tue, 19 Jan 2010 14:49:56 +0530
Message-ID: <1263892796-2279-1-git-send-email-ranjithl@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38398 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755349Ab0ASJUG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 04:20:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, ranjithl@ti.com

The patch series add support for the new modules on AM35xx IP Sub-System
(IPSS) and incorporates all the earlier review comments.

Since AM35xx follows a completely different scheme for indicating clock
idle status, the find_idlest() function in clkops is extended to pass
back the idle status indicator for that clock.

This patch series depends on the following patches
http://marc.info/?l=linux-omap&m=126325725822266&w=2
http://marc.info/?l=linux-omap&m=126325725822263&w=2
http://marc.info/?l=linux-omap&m=126325725722251&w=2

Tested on OMAP3 and AM3517 EVM's.

Ranjith Lohithakshan (2):
  OMAP2/3 clock: Extend find_idlest() to pass back idle state value
  AM35xx: Add clock support for new modules on AM35xx

 arch/arm/mach-omap2/clock.c             |   22 +++++-
 arch/arm/mach-omap2/clock.h             |    2 +-
 arch/arm/mach-omap2/clock2xxx.c         |    7 ++-
 arch/arm/mach-omap2/clock34xx.c         |  108 +++++++++++++++++++++++++++-
 arch/arm/mach-omap2/clock34xx.h         |    4 +
 arch/arm/mach-omap2/clock34xx_data.c    |  117 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm-regbits-34xx.h   |   10 +++
 arch/arm/mach-omap2/cm.h                |    3 +
 arch/arm/mach-omap2/prcm.c              |   14 ++---
 arch/arm/plat-omap/include/plat/clock.h |    2 +-
 arch/arm/plat-omap/include/plat/prcm.h  |    2 +-
 11 files changed, 270 insertions(+), 21 deletions(-)

