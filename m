From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap3: Change the default silicon
Date: Thu, 29 Oct 2009 20:05:08 +0530
Message-ID: <1256826908-14703-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48787 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753813AbZJ2OfI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Oct 2009 10:35:08 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9TEZAlu021066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 09:35:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Currently the default silicon - in absence of
identification - is set to OMAP3630 ES1.0.

Though, condition may/should not arise; but
the default should be latest in the most
common silicon variant - currently OMAP3430
ES3.1.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/id.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 1c15112..0162623 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -243,8 +243,8 @@ void __init omap3_check_revision(void)
 		}
 		break;
 	default:
-		/* Unknown default to latest silicon rev as default*/
-		omap_revision = OMAP3630_REV_ES1_0;
+		/* Unknown. Default to latest among all variants */
+		omap_revision = OMAP3430_REV_ES3_1;
 	}
 }
 
-- 
1.6.2.2

