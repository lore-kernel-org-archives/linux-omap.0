From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] thermal: Switch mode to enabled once the cooling device is bound
Date: Thu, 25 Jun 2015 18:20:35 +0530
Message-ID: <1435236635-20830-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-omap@vger.kernel.org, rui.zhang@intel.com, t-kristo@ti.com, j-keerthy@ti.com, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Currently mode is still disabled even after the cooling device is bound
to the appropriate device. Hence changing the mode to enabled as soon as
the cooling device is registered successfully.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/thermal/of-thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 04b1be7..bc84485 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -163,6 +163,9 @@ static int of_thermal_bind(struct thermal_zone_device *thermal,
 		}
 	}
 
+	/* Now that cooling device is bound enable the thermal device*/
+	data->mode = THERMAL_DEVICE_ENABLED;
+
 	return 0;
 }
 
-- 
1.9.1

