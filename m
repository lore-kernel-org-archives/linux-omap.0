From: shubhrajyoti@ti.com
Subject: [PATCH] McBSP: Fix the free variable update at remove.
Date: Fri, 29 Oct 2010 13:49:27 +0530
Message-ID: <1288340367-29956-1-git-send-email-shubhrajyoti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55286 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755715Ab0J2ITc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Oct 2010 04:19:32 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o9T8JTHd032529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 29 Oct 2010 03:19:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: vikram.pandita@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>

From: Shubhrajyoti D <shubhrajyoti@ti.com>

At remove the free variable is wrongly updated.Attempting to solve the same.


Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reported-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/plat-omap/mcbsp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index eac4b97..6802ed1 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1845,7 +1845,7 @@ static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 
 		mcbsp->fclk = NULL;
 		mcbsp->iclk = NULL;
-		mcbsp->free = 0;
+		mcbsp->free = 1;
 		mcbsp->dev = NULL;
 	}
 
-- 
1.7.0.4

