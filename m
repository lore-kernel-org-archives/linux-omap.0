From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2] OMAP3: move check_revision above check_features
Date: Tue, 20 Oct 2009 05:48:57 -0500
Message-ID: <1256035738-17571-2-git-send-email-nm@ti.com>
References: <1256035738-17571-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47304 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696AbZJTKs5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Oct 2009 06:48:57 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9KAn1UY007750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 05:49:01 -0500
In-Reply-To: <1256035738-17571-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>

omap3_check_revision() does not depend on omap3_check_features()
move this above so that we can add logic based on revision
detected in check_features.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/id.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 1c15112..702d3b4 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -328,8 +328,8 @@ void __init omap2_check_revision(void)
 	if (cpu_is_omap24xx())
 		omap24xx_check_revision();
 	else if (cpu_is_omap34xx()) {
-		omap3_check_features();
 		omap3_check_revision();
+		omap3_check_features();
 		omap3_cpuinfo();
 	}
 	else if (cpu_is_omap44xx()) {
-- 
1.6.3.3

