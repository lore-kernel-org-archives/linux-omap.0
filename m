From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 0/1] Common mechanism to identify Si revision
Date: Thu, 24 Sep 2009 21:22:50 +0530
Message-ID: <1253807570-8642-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38598 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753073AbZIXPwu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Sep 2009 11:52:50 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8OFqpcX022728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2009 10:52:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

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

