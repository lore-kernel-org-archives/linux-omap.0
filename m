From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 2/8] staging: ti-soc-thermal: fix min/max TODO (already done)
Date: Mon, 8 Apr 2013 08:19:08 -0400
Message-ID: <1365423555-2669-3-git-send-email-eduardo.valentin@ti.com>
References: <1365423555-2669-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54884 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935600Ab3DHMUp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Apr 2013 08:20:45 -0400
In-Reply-To: <1365423555-2669-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

Min/Max cooling state are defined by registration helper
function, if no specific limits are passed. No need to change
this code.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/ti-soc-thermal/ti-thermal-common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/ti-thermal-common.c b/drivers/staging/ti-soc-thermal/ti-thermal-common.c
index 092b39d..18f6fb9 100644
--- a/drivers/staging/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/staging/ti-soc-thermal/ti-thermal-common.c
@@ -124,9 +124,9 @@ static int ti_thermal_bind(struct thermal_zone_device *thermal,
 
 	id = data->sensor_id;
 
-	/* TODO: bind with min and max states */
 	/* Simple thing, two trips, one passive another critical */
 	return thermal_zone_bind_cooling_device(thermal, 0, cdev,
+	/* bind with min and max states defined by cpu_cooling */
 						THERMAL_NO_LIMIT,
 						THERMAL_NO_LIMIT);
 }
-- 
1.7.7.1.488.ge8e1c

