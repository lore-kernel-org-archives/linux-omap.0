From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 10/19] OMAP3+: SR: enable/disable SR only on need
Date: Sat,  5 Mar 2011 20:59:13 +0530
Message-ID: <1299338962-5602-11-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:35546 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752566Ab1CEPbQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 10:31:16 -0500
Received: by yic21 with SMTP id 21so1868993yic.15
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 07:31:15 -0800 (PST)
In-Reply-To: <1299338962-5602-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, Nishanth Menon <nm@ti.com>

Since we already know the state of the autocomp enablement, we can
see if the requested state is different from the current state and
enable/disable SR only on the need basis.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index f9057ad..2b6fdc7 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -806,10 +806,13 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 		return -EINVAL;
 	}
 
-	if (!val)
-		sr_stop_vddautocomp(sr_info);
-	else
-		sr_start_vddautocomp(sr_info);
+	/* control enable/disable only if there is a delta in value */
+	if (sr_info->autocomp_active != val) {
+		if (!val)
+			sr_stop_vddautocomp(sr_info);
+		else
+			sr_start_vddautocomp(sr_info);
+	}
 
 	return 0;
 }
-- 
1.7.1

