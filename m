From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH 0/2] OMAP3 PM: sleep code clean up
Date: Fri, 24 Sep 2010 16:26:23 +0530
Message-ID: <1285325785-6163-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48941 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139Ab0IXK6m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Sep 2010 06:58:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linaro-dev@lists.linaro.org, Vishwanath BS <vishwanath.bs@ti.com>

This patch series has some clean up in OMAP3 sleep code.
Patches have been rebased to latest kevin's pm branch.

Vishwanath BS (2):
  OMAP3 PM: move omap3 sleep to ddr
  OMAP3 PM: sleep code clean up

 arch/arm/mach-omap2/pm34xx.c              |    9 +-
 arch/arm/mach-omap2/sleep34xx.S           |  377 ++++++++++++++---------------
 arch/arm/plat-omap/include/plat/control.h |    2 +
 3 files changed, 190 insertions(+), 198 deletions(-)

