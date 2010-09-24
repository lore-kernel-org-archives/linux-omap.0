From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH 0/2] OMAP3 PM: sleep code clean up
Date: Fri, 24 Sep 2010 16:17:17 +0530
Message-ID: <1285325239-6110-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54027 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106Ab0IXKtb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 06:49:31 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8OAnS6U031047
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 05:49:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>

This patch series has some clean up in OMAP3 sleep code.
Patches have been rebased to latest kevin's pm branch.

Vishwanath BS (2):
  OMAP3 PM: move omap3 sleep to ddr
  OMAP3 PM: sleep code clean up

 arch/arm/mach-omap2/pm34xx.c              |    9 +-
 arch/arm/mach-omap2/sleep34xx.S           |  377 ++++++++++++++---------------
 arch/arm/plat-omap/include/plat/control.h |    2 +
 3 files changed, 190 insertions(+), 198 deletions(-)

