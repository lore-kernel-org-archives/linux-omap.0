From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/27] OMAP: DSS2: Use omap_pm_get_dev_context_loss_count to get ctx loss count
Date: Fri,  3 Jun 2011 13:00:19 +0300
Message-ID: <1307095237-14805-10-git-send-email-tomi.valkeinen@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:59447 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752631Ab1FCKBU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 06:01:20 -0400
In-Reply-To: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Initialize get_context_loss_count in the DSS board data to
omap_pm_get_dev_context_loss_count, so that omapdss driver can use it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 084a51b..c7e19c4 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -25,6 +25,7 @@
 #include <video/omapdss.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
+#include <plat/omap-pm.h>
 
 static struct platform_device omap_display_device = {
 	.name          = "omapdss",
@@ -117,7 +118,8 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 	}
 
 	pdata.board_data = board_data;
-	pdata.board_data->get_context_loss_count = NULL;
+	pdata.board_data->get_context_loss_count =
+		omap_pm_get_dev_context_loss_count;
 	pdata.opt_clock_available = opt_clock_available;
 
 	for (i = 0; i < oh_count; i++) {
-- 
1.7.4.1

