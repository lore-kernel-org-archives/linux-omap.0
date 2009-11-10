From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: [PATCH] AM35xx: Initialize omap_chip bits
Date: Tue, 10 Nov 2009 09:51:32 +0530
Message-ID: <1257826892-17266-1-git-send-email-ranjithl@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59113 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755303AbZKJEVb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Nov 2009 23:21:31 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAA4LYfQ028240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 9 Nov 2009 22:21:36 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ranjithl@ti.com

AM35xx is functionally similar to OMAP3430 ES3.1 from a
powerdomain/clockdomain perspective. This patch initializes the
omap_chip bits on AM35xx for use by powerdomain and clockdomain code.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
---
Applies on for-next

 arch/arm/mach-omap2/id.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index f77dba1..5396785 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -372,6 +372,8 @@ void __init omap2_check_revision(void)
 	} else if (cpu_is_omap242x()) {
 		/* Currently only supports 2420ES2.1.1 and 2420-all */
 		omap_chip.oc |= CHIP_IS_OMAP2420;
+	} else if (cpu_is_omap3505() || cpu_is_omap3517()) {
+		omap_chip.oc = CHIP_IS_OMAP3430 | CHIP_IS_OMAP3430ES3_1;
 	} else if (cpu_is_omap343x()) {
 		omap_chip.oc = CHIP_IS_OMAP3430;
 		if (omap_rev() == OMAP3430_REV_ES1_0)
-- 
1.6.2.4

