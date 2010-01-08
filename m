From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv3 0/1] Common mechanism to identify Si revision
Date: Fri,  8 Jan 2010 20:56:07 +0530
Message-ID: <1262964367-21839-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47203 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930Ab0AHP0M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jan 2010 10:26:12 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o08FQ9Qg015899
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 8 Jan 2010 09:26:11 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Current implementation of identifying silicon revision
uses whole number returned by omap_rev() - which includes
cpu id and class as well.

As new silicons are added in 35x, 36x and 44x series,
many 'greater than' comparisons are automatically true;
but 'less than/ equal to' comparisons are no always right.

Also, there could be a problem when revisions of newer
silicons arrive.

This patch uses only revision bits to identify silicon
revision - independent of silicon being used.

This version came after long period as i was trying ways
to include the verbose cpuid in either function name or
signature. But final outcome was bit messy and aborting
it (for now).

  [1] http://marc.info/?l=linux-omap&m=125476176410106&w=2
  [2] http://marc.info/?l=linux-omap&m=125197467922935&w=2

Sanjeev Premi (1):
  omap3: Add macros for comparing si revision

 arch/arm/mach-omap2/clock34xx.c       |    2 +-
 arch/arm/mach-omap2/clock34xx_data.c  |    6 ++-
 arch/arm/mach-omap2/control.c         |    7 ++--
 arch/arm/mach-omap2/id.c              |   13 +++----
 arch/arm/mach-omap2/pm34xx.c          |   35 ++++++++++++++++-----
 arch/arm/plat-omap/include/plat/cpu.h |   55 +++++++++++++++++++++++++++++++++
 6 files changed, 97 insertions(+), 21 deletions(-)

