From: Sanjeev Premi <premi@ti.com>
Subject: From: Sanjeev Premi <premi@ti.com>
Date: Thu, 24 Sep 2009 21:20:32 +0530
Message-ID: <1253807432-23121-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42983 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319AbZIXPub (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Sep 2009 11:50:31 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8OFoYdL004260
	for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2009 10:50:35 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id n8OFoW14020550
	for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2009 21:20:33 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Currently there are multiple mechanisms for identifying
silicon revisions.

Most places the comparison is against omap_rev() as a
whole number. This patch implements the comparison against
the omap_revision bits alone.

This makes the test independent of silicon in use.

This patch doesn't remove all existing mechanisms for the
check to maintain stability. The migration can follow in
phases.

  [1] http://marc.info/?l=linux-omap&m=125197467922935&w=2

Sanjeev Premi (1):
  OMAP3: Common mechanism to identify cpu revision

 arch/arm/mach-omap2/clock34xx.c       |    4 +-
 arch/arm/mach-omap2/control.c         |    6 ++--
 arch/arm/mach-omap2/pm34xx.c          |   17 +++++-----
 arch/arm/plat-omap/include/mach/cpu.h |   55 +++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 13 deletions(-)

