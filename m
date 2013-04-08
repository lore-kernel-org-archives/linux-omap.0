From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 3/8] staging: ti-soc-thermal: Remove TC1/TC2 TODO (already done)
Date: Mon, 8 Apr 2013 08:19:09 -0400
Message-ID: <1365423555-2669-4-git-send-email-eduardo.valentin@ti.com>
References: <1365423555-2669-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1365423555-2669-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

TC1/TC2 are not needed anymore, API has been upgraded.
This is a TODO left-over.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/ti-soc-thermal/ti-thermal-common.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/ti-thermal-common.c b/drivers/staging/ti-soc-thermal/ti-thermal-common.c
index 18f6fb9..58e19bc 100644
--- a/drivers/staging/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/staging/ti-soc-thermal/ti-thermal-common.c
@@ -291,7 +291,6 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 	if (!data)
 		return -EINVAL;
 
-	/* TODO: remove TC1 TC2 */
 	/* Create thermal zone */
 	data->ti_thermal = thermal_zone_device_register(domain,
 				OMAP_TRIP_NUMBER, 0, data, &ti_thermal_ops,
-- 
1.7.7.1.488.ge8e1c

