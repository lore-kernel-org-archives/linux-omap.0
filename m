From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv2 0/1] omap2/3: Update revision identification
Date: Fri, 24 Sep 2010 19:34:19 +0530
Message-ID: <1285337059-11720-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57724 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932218Ab0IXOE1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Sep 2010 10:04:27 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8OE4O30029602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 09:04:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch unifies the definition of revision bits that
are were using different base (nibble) since revision bits
for OMAP3630 were defined.

The changes are:
1) Common definition of revision bits starting at lower
   nibble.
2) Generic CLASS has been defined for each processor in
   the OMAP family.
3) Revision bits are ORed with processor class to complete
   the identification.

This patch version addresses all comments and suggetions
by Tony[1] and adds support to identify AM3505/17 ES1.1.

  [1] http://marc.info/?l=linux-omap&m=128526100030661&w=2

The patch has been tested against these processors:
 * OMAP3630 ES1.1
 * OMAP3530 ES3.1
 * AM3517 ES1.0
 * AM3517 ES1.1

Sanjeev Premi (1):
  omap2/3: Update revision identification

 arch/arm/mach-omap2/id.c              |   72 ++++++++++++++++++++++-----------
 arch/arm/plat-omap/include/plat/cpu.h |   36 ++++++++--------
 2 files changed, 66 insertions(+), 42 deletions(-)

-- 
1.7.2.2

