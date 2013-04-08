From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 8/8] staging: ti-soc-thermal: fix device removal
Date: Mon, 8 Apr 2013 08:19:14 -0400
Message-ID: <1365423555-2669-9-git-send-email-eduardo.valentin@ti.com>
References: <1365423555-2669-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1365423555-2669-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

While removing, the device needs to unregister
the sensor from thermal framework. Before
calling the call back the driver needs to check
if the call back is registered. This patch
fix the check by checking the right callback.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/ti-soc-thermal/ti-bandgap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/ti-bandgap.c b/drivers/staging/ti-soc-thermal/ti-bandgap.c
index 37fdba6..f20c1cf 100644
--- a/drivers/staging/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/staging/ti-soc-thermal/ti-bandgap.c
@@ -1369,7 +1369,7 @@ int ti_bandgap_remove(struct platform_device *pdev)
 
 	/* First thing is to remove sensor interfaces */
 	for (i = 0; i < bgp->conf->sensor_count; i++) {
-		if (bgp->conf->sensors[i].register_cooling)
+		if (bgp->conf->sensors[i].unregister_cooling)
 			bgp->conf->sensors[i].unregister_cooling(bgp, i);
 
 		if (bgp->conf->remove_sensor)
-- 
1.7.7.1.488.ge8e1c

