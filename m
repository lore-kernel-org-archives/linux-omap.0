From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH v2] omap3: Change the default silicon
Date: Fri, 13 Nov 2009 15:44:56 +0530
Message-ID: <1258107296-6465-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47670 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755606AbZKMKOy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Nov 2009 05:14:54 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nADAEvjR029842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2009 04:14:59 -0600
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
index 1c15112..7098e12 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -243,8 +243,8 @@ void __init omap3_check_revision(void)
 		}
 		break;
 	default:
-		/* Unknown default to latest silicon rev as default*/
-		omap_revision = OMAP3630_REV_ES1_0;
+		/* Unknown. Default to most common among all variants */
+		omap_revision = OMAP3430_REV_ES3_1;
 	}
 }
 
-- 
1.6.2.2

