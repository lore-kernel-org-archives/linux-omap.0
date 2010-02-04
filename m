From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 0/3] OMAP2/3 PM: Powerdomain patch set for supporting Open Switch Retention
Date: Thu,  4 Feb 2010 22:17:48 +0530
Message-ID: <1265302071-7624-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49533 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758487Ab0BDQsA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Feb 2010 11:48:00 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o14GlrHk023981
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 4 Feb 2010 10:47:55 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Thara Gopinath (none)" <thara@omaplbp.india.ti.com>

From: Thara Gopinath <thara@omaplbp.(none)>

This patch series contains some preparatory powerdomain framework
related fixes for supporting Open Switch Retetion of Core and MPU
domains in OMAP3.

Thara Gopinath (3):
  OMAP2/3 PM: Adding powerdomain APIs for reading the next logic and
    mem state
  OMAP3 PM: Defining .pwrsts_logic_ret field for core power domain
    structure
  OMAP3 PM: Adding counters for power domain logic off and mem off
    during retention.

 arch/arm/mach-omap2/pm-debug.c                |    5 ++
 arch/arm/mach-omap2/powerdomain.c             |   93 +++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomains34xx.h        |    2 +
 arch/arm/plat-omap/include/plat/powerdomain.h |    4 +
 4 files changed, 104 insertions(+), 0 deletions(-)

