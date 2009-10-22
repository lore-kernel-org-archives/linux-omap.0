From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2 v2] OMAP3:PM: refactor Smart Reflex
Date: Thu, 22 Oct 2009 12:27:59 -0500
Message-ID: <1256232481-30636-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56094 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815AbZJVR16 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Oct 2009 13:27:58 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9MHS2RK005514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Oct 2009 12:28:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>

Hi,
Smart Reflex sequencing recommendation has improved
in recent times and presents an opportunity to refactor
the code to add in understanding that we have of the
system. The patch set replaces smartreflex.c with a
new revision.

Revision 3 of the patch rebased to PM

Nishanth Menon (2):
  OMAP3:PM:SR: prepare: remove old SR code
  OMAP3:PM:SR: SmartReflex Refactor Rev3.0

 arch/arm/mach-omap2/pm-debug.c     |    3 +
 arch/arm/mach-omap2/resource34xx.c |    8 +-
 arch/arm/mach-omap2/smartreflex.c  | 1988 ++++++++++++++++++++++--------------
 arch/arm/mach-omap2/smartreflex.h  |  280 +++---
 arch/arm/plat-omap/Kconfig         |   15 +-
 5 files changed, 1363 insertions(+), 931 deletions(-)

Regards,
Nishanth Menon
