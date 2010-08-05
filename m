From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR][PATCH 09/12] omap3: sr: enable/disable sr only if required
Date: Thu,  5 Aug 2010 17:24:09 -0500
Message-ID: <1281047052-21346-10-git-send-email-nm@ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47367 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760827Ab0HEWYU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Aug 2010 18:24:20 -0400
In-Reply-To: <1281047052-21346-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

We dont need to go down the path of enabling/disabling the SR
if we dont need to. do some sanity check and trigger if needed

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index d63691b..9b5a10e 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -778,15 +778,26 @@ static int omap_sr_autocomp_show(void *data, u64 *val)
 static int omap_sr_autocomp_store(void *data, u64 val)
 {
 	struct omap_sr *sr_info = (struct omap_sr *) data;
+	u32 value = (u32) val;
 
 	if (!sr_info) {
 		pr_warning("%s: omap_sr struct for SR not found\n", __func__);
 		return -EINVAL;
 	}
-	if (!val)
-		sr_stop_vddautocomp(sr_info);
-	else
-		sr_start_vddautocomp(sr_info);
+
+	/* Sanity check */
+	if (value && (value != 1)) {
+		pr_err("%s: invalid value %d\n", __func__, value);
+		return -EINVAL;
+	}
+
+	/* change only if needed */
+	if (sr_info->is_autocomp_active ^ value) {
+		if (!val)
+			sr_stop_vddautocomp(sr_info);
+		else
+			sr_start_vddautocomp(sr_info);
+	}
 	return 0;
 }
 
-- 
1.6.3.3

