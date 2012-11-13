From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 2/5] staging: omap-thermal: remove platform data nomenclature
Date: Tue, 13 Nov 2012 11:43:19 -0400
Message-ID: <1352821402-13458-3-git-send-email-eduardo.valentin@ti.com>
References: <1352821402-13458-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352821402-13458-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: b-cousson@ti.com, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Because the driver is not really using platform data, this patch
removes the pdata nomenclature from this driver.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-thermal-common.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-thermal-common.c b/drivers/staging/omap-thermal/omap-thermal-common.c
index 5c0c203b..5be66d7 100644
--- a/drivers/staging/omap-thermal/omap-thermal-common.c
+++ b/drivers/staging/omap-thermal/omap-thermal-common.c
@@ -256,12 +256,12 @@ static struct omap_thermal_data
 int omap_thermal_expose_sensor(struct omap_bandgap *bg_ptr, int id,
 			       char *domain)
 {
-	struct omap_thermal_pdata pdata;
+	struct omap_thermal_data *data;
 
 	data = omap_bandgap_get_sensor_data(bg_ptr, id);
 
 	if (!data)
-		data = omap_thermal_build_pdata(bg_ptr, id);
+		data = omap_thermal_build_data(bg_ptr, id);
 
 	if (!data)
 		return -EINVAL;
@@ -359,7 +359,7 @@ int omap_thermal_register_cpu_cooling(struct omap_bandgap *bg_ptr, int id)
 
 	data = omap_bandgap_get_sensor_data(bg_ptr, id);
 	if (!data)
-		data = omap_thermal_build_pdata(bg_ptr, id);
+		data = omap_thermal_build_data(bg_ptr, id);
 
 	if (!data)
 		return -EINVAL;
-- 
1.7.7.1.488.ge8e1c
