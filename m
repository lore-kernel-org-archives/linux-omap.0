From: jean.pihet@newoldbits.com
Subject: [PATCH 3/3] OMAP: use PM QOS for wake-up constraints from I2C
Date: Mon, 28 Feb 2011 18:41:24 +0100
Message-ID: <1298914884-16468-4-git-send-email-j-pihet@ti.com>
References: <1298914884-16468-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:65329 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab1B1Rlq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 12:41:46 -0500
Received: by mail-ew0-f46.google.com with SMTP id 6so1371532ewy.19
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 09:41:46 -0800 (PST)
In-Reply-To: <1298914884-16468-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vishwanath.bs@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Implements the PM QOS API for the wake-up constraints on the MPU.

Note: the caller shall allocate and store the PM QOS handle for future use
(update/removal of the constraint).

Based on the original patch from Vishwanath,
cf. https://patchwork.kernel.org/patch/327312/

Cc: Vishwanath BS <vishwanath.bs@ti.com>

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/plat-omap/i2c.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 3341ca4..207a320 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -117,10 +117,15 @@ static inline int omap1_i2c_add_bus(int bus_id)
  * XXX This function is a temporary compatibility wrapper - only
  * needed until the I2C driver can be converted to call
  * omap_pm_set_max_dev_wakeup_lat() and handle a return code.
+ *
+ * The PM QOS handle is stored in the corresponding omap_device struct.
  */
 static void omap_pm_set_max_mpu_wakeup_lat_compat(struct device *dev, long t)
 {
-	omap_pm_set_max_mpu_wakeup_lat(dev, t);
+	struct omap_device *od = to_omap_device(to_platform_device(dev));
+
+	if (od->pm_qos_request)
+		omap_pm_set_max_mpu_wakeup_lat(od->pm_qos_request, t);
 }
 
 static struct omap_device_pm_latency omap_i2c_latency[] = {
@@ -160,11 +165,26 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	 */
 	if (cpu_is_omap34xx())
 		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
+
 	od = omap_device_build(name, bus_id, oh, pdata,
 			sizeof(struct omap_i2c_bus_platform_data),
 			omap_i2c_latency, ARRAY_SIZE(omap_i2c_latency), 0);
 	WARN(IS_ERR(od), "Could not build omap_device for %s\n", name);
 
+	/* Allocate the PM QOS handle and initialize it */
+	if ((!(IS_ERR(od))) && cpu_is_omap34xx()) {
+		od->pm_qos_request = kzalloc(sizeof(struct pm_qos_request_list),
+				       GFP_KERNEL);
+		if (od->pm_qos_request) {
+			pm_qos_add_request(od->pm_qos_request,
+					   PM_QOS_CPU_DMA_LATENCY,
+					   PM_QOS_DEFAULT_VALUE);
+		} else {
+			WARN(1, "%s: could not reserve memory for "
+			     "pm_qos_request\n", __func__);
+		}
+	}
+
 	return PTR_ERR(od);
 }
 #else
-- 
1.7.2.3

