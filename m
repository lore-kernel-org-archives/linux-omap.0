From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 3/4] staging: omap-thermal: fix polling period settings
Date: Tue, 11 Sep 2012 19:06:54 +0300
Message-ID: <1347379615-6881-4-git-send-email-eduardo.valentin@ti.com>
References: <1347379615-6881-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347379615-6881-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: j-keerthy@ti.com, b-cousson@ti.com, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

While registering the omap thermal zones we need to
properly specify TC1 and TC2, as long as the proper
passive polling period and monitor period.

This patch fixes the parameters passed while registering
the thermal zone.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-thermal-common.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-thermal-common.c b/drivers/staging/omap-thermal/omap-thermal-common.c
index 0675a5e..d156424 100644
--- a/drivers/staging/omap-thermal/omap-thermal-common.c
+++ b/drivers/staging/omap-thermal/omap-thermal-common.c
@@ -246,7 +246,9 @@ int omap_thermal_expose_sensor(struct omap_bandgap *bg_ptr, int id,
 	/* Create thermal zone */
 	data->omap_thermal = thermal_zone_device_register(domain,
 				OMAP_TRIP_NUMBER, 0, data, &omap_thermal_ops,
-				0, FAST_TEMP_MONITORING_RATE, 0, 0);
+				1, 2, /*TODO: remove this when FW allows */
+				FAST_TEMP_MONITORING_RATE,
+				FAST_TEMP_MONITORING_RATE);
 	if (IS_ERR_OR_NULL(data->omap_thermal)) {
 		dev_err(bg_ptr->dev, "thermal zone device is NULL\n");
 		return PTR_ERR(data->omap_thermal);
-- 
1.7.7.1.488.ge8e1c
