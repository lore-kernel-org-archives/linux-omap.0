From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 09/28] OMAP: DSS2: Use omap_pm_get_dev_context_loss_count to get ctx loss count
Date: Thu,  9 Jun 2011 16:56:31 +0300
Message-ID: <1307627810-3768-10-git-send-email-tomi.valkeinen@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:39871 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758059Ab1FIN5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:57:25 -0400
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
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

