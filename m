From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 12/18] omap3+: sr: enable/disable SR only on need
Date: Wed,  2 Mar 2011 16:25:25 +0530
Message-ID: <1299063331-27968-13-git-send-email-nm@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:49401 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757115Ab1CBK5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 05:57:25 -0500
Received: by mail-yw0-f41.google.com with SMTP id 5so2252668yws.28
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 02:57:24 -0800 (PST)
In-Reply-To: <1299063331-27968-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin H <khilman@ti.com>, Tony L <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

Since we already know the state of the autocomp enablement, we can
see if the requested state is different from the current state and
enable/disable SR only on the need basis.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 8cad92d..4fc679e 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -819,10 +819,13 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 		return -EINVAL;
 	}
 
-	if (!val)
-		sr_stop_vddautocomp(sr_info);
-	else
-		sr_start_vddautocomp(sr_info);
+	/* control enable/disable only if there is a delta in value */
+	if (sr_info->autocomp_active ^ val) {
+		if (!val)
+			sr_stop_vddautocomp(sr_info);
+		else
+			sr_start_vddautocomp(sr_info);
+	}
 
 	return 0;
 }
-- 
1.7.1

