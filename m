From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 14/14] TEMP: OMAP device: change pr_warnings to pr_debugs
Date: Fri, 9 Dec 2011 16:27:37 +0200
Message-ID: <1323440857-385-15-git-send-email-t-kristo@ti.com>
References: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54922 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319Ab1LIO22 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 09:28:28 -0500
In-Reply-To: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com
Cc: "Govindraj.R" <govindraj.raja@ti.com>

Prevents a hang when omap_device would want to print something for
serial console device while enabling / disabling its clocks.
Should be handled properly by serial runtime PM support.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/plat-omap/omap_device.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index f72fafc..1cd5f74 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -164,7 +164,7 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 					"%d: %llu\n",
 					od->pm_lat_level, act_lat);
 			} else
-				dev_warn(&od->pdev->dev,
+				dev_dbg(&od->pdev->dev,
 					 "activate latency %d "
 					 "higher than exptected. (%llu > %d)\n",
 					 od->pm_lat_level, act_lat,
@@ -231,7 +231,7 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 					"%d: %llu\n",
 					od->pm_lat_level, deact_lat);
 			} else
-				dev_warn(&od->pdev->dev,
+				dev_dbg(&od->pdev->dev,
 					 "deactivate latency %d "
 					 "higher than exptected. (%llu > %d)\n",
 					 od->pm_lat_level, deact_lat,
-- 
1.7.4.1

