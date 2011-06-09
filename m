From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 24/28] OMAP: DSS2: Remove unused code from display.c
Date: Thu,  9 Jun 2011 16:56:46 +0300
Message-ID: <1307627810-3768-25-git-send-email-tomi.valkeinen@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:40895 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758139Ab1FIN6A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:58:00 -0400
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

oh_core variable is no longer used, so it and its initialization can be
removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index af43620..a5b7a23 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -43,9 +43,6 @@ static struct omap_device_pm_latency omap_dss_latency[] = {
 	},
 };
 
-/* oh_core is used for getting opt-clocks */
-static struct omap_hwmod	*oh_core;
-
 struct omap_dss_hwmod_data {
 	const char *oh_name;
 	const char *dev_name;
@@ -99,13 +96,6 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 		oh_count = ARRAY_SIZE(omap4_dss_hwmod_data);
 	}
 
-	/* opt_clks are always associated with dss hwmod */
-	oh_core = omap_hwmod_lookup("dss_core");
-	if (!oh_core) {
-		pr_err("Could not look up dss_core.\n");
-		return -ENODEV;
-	}
-
 	pdata.board_data = board_data;
 	pdata.board_data->get_context_loss_count =
 		omap_pm_get_dev_context_loss_count;
-- 
1.7.4.1

