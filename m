From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 4/6] OMAP2+: pm: Remove static devices variable for mpu, dsp, iva and l3 PM
Date: Fri, 2 Sep 2011 16:25:18 +0200
Message-ID: <1314973520-3585-5-git-send-email-b-cousson@ti.com>
References: <1314973520-3585-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51242 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467Ab1IBO0Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Sep 2011 10:26:24 -0400
In-Reply-To: <1314973520-3585-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Since the device pointer is now retrieved using the hwmod name, remove
the static variables used to store the device pointers for DSP, MPU, IVA
and L3 devices for PM/DVFS usage.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm.c |   47 ++++++---------------------------------------
 1 files changed, 7 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 17725d2..832577a 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -26,38 +26,7 @@
 
 static struct omap_device_pm_latency *pm_lats;
 
-static struct device *mpu_dev;
-static struct device *iva_dev;
-static struct device *l3_dev;
-static struct device *dsp_dev;
-
-struct device *omap2_get_mpuss_device(void)
-{
-	WARN_ON_ONCE(!mpu_dev);
-	return mpu_dev;
-}
-
-struct device *omap2_get_iva_device(void)
-{
-	WARN_ON_ONCE(!iva_dev);
-	return iva_dev;
-}
-
-struct device *omap2_get_l3_device(void)
-{
-	WARN_ON_ONCE(!l3_dev);
-	return l3_dev;
-}
-
-struct device *omap4_get_dsp_device(void)
-{
-	WARN_ON_ONCE(!dsp_dev);
-	return dsp_dev;
-}
-EXPORT_SYMBOL(omap4_get_dsp_device);
-
-/* static int _init_omap_device(struct omap_hwmod *oh, void *user) */
-static int _init_omap_device(char *name, struct device **new_dev)
+static int _init_omap_device(char *name)
 {
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
@@ -72,8 +41,6 @@ static int _init_omap_device(char *name, struct device **new_dev)
 		 __func__, name))
 		return -ENODEV;
 
-	*new_dev = &pdev->dev;
-
 	return 0;
 }
 
@@ -82,16 +49,16 @@ static int _init_omap_device(char *name, struct device **new_dev)
  */
 static void omap2_init_processor_devices(void)
 {
-	_init_omap_device("mpu", &mpu_dev);
+	_init_omap_device("mpu");
 	if (omap3_has_iva())
-		_init_omap_device("iva", &iva_dev);
+		_init_omap_device("iva");
 
 	if (cpu_is_omap44xx()) {
-		_init_omap_device("l3_main_1", &l3_dev);
-		_init_omap_device("dsp", &dsp_dev);
-		_init_omap_device("iva", &iva_dev);
+		_init_omap_device("l3_main_1");
+		_init_omap_device("dsp");
+		_init_omap_device("iva");
 	} else {
-		_init_omap_device("l3_main", &l3_dev);
+		_init_omap_device("l3_main");
 	}
 }
 
-- 
1.7.0.4

