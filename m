From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv2 0/1] omap3: cpuidle: Update statistics for correct state
Date: Tue, 24 Nov 2009 23:20:27 +0530
Message-ID: <1259085027-13269-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34004 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933576AbZKXRu0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Nov 2009 12:50:26 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAOHoUxk032387
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 11:50:32 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This is a fresh look at the problem [1] discussed earlier.

Generic approach here is same; but the 'valid' flag for the
target state is verified in omap3_enter_idle_bm(). If the
valid flag == 0, we look for next (lower) state with valid
flag == 1.

Have tried to optimize the look-up without loosing readability.

Sanjeev Premi (1):
  omap3: cpuidle: Update statistics for correct state

 arch/arm/mach-omap2/cpuidle34xx.c |   98 ++++++++++++++++++++++++++++++++++---
 arch/arm/mach-omap2/pm.h          |    1 +
 arch/arm/mach-omap2/pm34xx.c      |    4 ++
 3 files changed, 95 insertions(+), 8 deletions(-)

