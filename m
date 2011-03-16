From: Sanjeev Premi <premi@ti.com>
Subject: [RFCv2 0/2] Support TPS65023 with AM35x
Date: Wed, 16 Mar 2011 13:02:01 +0530
Message-ID: <1300260723-19422-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45476 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083Ab1CPHcO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 03:32:14 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2G7WBdx031820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Mar 2011 02:32:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This is a revised set of patches for getting the
current AM3517 with TPS65023 working.

The patch may not apply cleanly on the latest
master; but should be able to give clear list
of changes (and hacks) that were necessary to
make the combination work.

Since, there is a parallel effort for clean-up
of voltage layer, attempt to rebase against new
baseline would only delay the intended feedback.

Sanjeev Premi (2):
  OMAP3: Add support for TPS65023 (AM35x only)
  AM35x: voltage: Basic initialization

 arch/arm/mach-omap2/Makefile        |    3 +-
 arch/arm/mach-omap2/pm.c            |    1 +
 arch/arm/mach-omap2/pm.h            |    9 +++
 arch/arm/mach-omap2/pmic_tps65023.c |   82 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/voltage.c       |  110 ++++++++++++++++++++++++++++++++++-
 5 files changed, 203 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pmic_tps65023.c

-- 
1.7.2.2

