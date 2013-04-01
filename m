From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 03/14] staging: ti-soc-thermal: expose ti_thermal_report_temperature
Date: Mon, 1 Apr 2013 12:04:35 -0400
Message-ID: <1364832286-17304-4-git-send-email-eduardo.valentin@ti.com>
References: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59158 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758935Ab3DAQG0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Apr 2013 12:06:26 -0400
In-Reply-To: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

Whenever a sensor has an alert to be reported to the thermal framework,
it can use the report ti_thermal_report_temperature helper. This patch
expose this function so that bandgap data config declarations could use it.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/ti-soc-thermal/ti-thermal.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/ti-thermal.h b/drivers/staging/ti-soc-thermal/ti-thermal.h
index ef6981c..7b2d600 100644
--- a/drivers/staging/ti-soc-thermal/ti-thermal.h
+++ b/drivers/staging/ti-soc-thermal/ti-thermal.h
@@ -76,6 +76,7 @@
 #ifdef CONFIG_TI_THERMAL
 int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id, char *domain);
 int ti_thermal_remove_sensor(struct ti_bandgap *bgp, int id);
+int ti_thermal_report_sensor_temperature(struct ti_bandgap *bgp, int id);
 int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id);
 int ti_thermal_unregister_cpu_cooling(struct ti_bandgap *bgp, int id);
 #else
@@ -92,6 +93,12 @@ int ti_thermal_remove_sensor(struct ti_bandgap *bgp, int id)
 }
 
 static inline
+int ti_thermal_report_sensor_temperature(struct ti_bandgap *bgp, int id)
+{
+	return 0;
+}
+
+static inline
 int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
 {
 	return 0;
-- 
1.7.7.1.488.ge8e1c

