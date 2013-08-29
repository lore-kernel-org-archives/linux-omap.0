From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/15] OMAPDSS: fix DPI and SDI device ids
Date: Thu, 29 Aug 2013 16:31:48 +0300
Message-ID: <1377783120-14001-4-git-send-email-tomi.valkeinen@ti.com>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48882 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754552Ab3H2NcN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:32:13 -0400
In-Reply-To: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The DPI and SDI platform devices are currently created with the ID of
-1. The ID doesn't currently affect anything.

However, we have added regulator supply entries for "omapdss_dpi.0" and
"omapdss_sdi.0" to the board files, although these supply entries are
not yet used. As the ID used for the devices is -1, these regulator
supply entries will not work.

To fix the issue, assign ID of 0 to the devices. In the future there may
be more than one DPI or SDI output, so it makes sense to have a proper
ID for them.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index ff37be1..03a0516 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -400,7 +400,7 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 
 	/* Create devices for DPI and SDI */
 
-	pdev = create_simple_dss_pdev("omapdss_dpi", -1,
+	pdev = create_simple_dss_pdev("omapdss_dpi", 0,
 			board_data, sizeof(*board_data), dss_pdev);
 	if (IS_ERR(pdev)) {
 		pr_err("Could not build platform_device for omapdss_dpi\n");
@@ -408,7 +408,7 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 	}
 
 	if (cpu_is_omap34xx()) {
-		pdev = create_simple_dss_pdev("omapdss_sdi", -1,
+		pdev = create_simple_dss_pdev("omapdss_sdi", 0,
 				board_data, sizeof(*board_data), dss_pdev);
 		if (IS_ERR(pdev)) {
 			pr_err("Could not build platform_device for omapdss_sdi\n");
-- 
1.8.1.2

