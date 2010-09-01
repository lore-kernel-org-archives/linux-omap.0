From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v3] OMAP4: pm.c extensions for OMAP4 support
Date: Wed,  1 Sep 2010 13:44:53 +0530
Message-ID: <1283328893-14556-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49606 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205Ab0IAIPE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Sep 2010 04:15:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

OMAP4 has an iva device and a dsp devcice where as OMAP2/3
has only an iva device. In this file the iva device in the
system is registered under the name dsp_dev and the API
to retrieve the iva device is omap2_get_dsp_device.
This patch renames the dsp_dev to iva_dev, renames
omap2_get_dsp_device to omap2_get_iva_device,
registers dsp_dev for OMAP4 and adds a new API
omap4_get_dsp_device to retrieve the dep_dev.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
v2: Removed fixing of l3_main hwmod for OMAP4 as Benoit has
    already submitted a pach fixing the same.
v3: Put OMAP4 check across dsp_dev init so that on other
    OMAP's this init does not throw a warn.

 arch/arm/mach-omap2/pm.c                 |   20 +++++++++++++++-----
 arch/arm/plat-omap/include/plat/common.h |    3 ++-
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 68f9f2e..c93921d 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -21,8 +21,9 @@
 static struct omap_device_pm_latency *pm_lats;
 
 static struct device *mpu_dev;
-static struct device *dsp_dev;
+static struct device *iva_dev;
 static struct device *l3_dev;
+static struct device *dsp_dev;
 
 struct device *omap2_get_mpuss_device(void)
 {
@@ -30,10 +31,10 @@ struct device *omap2_get_mpuss_device(void)
 	return mpu_dev;
 }
 
-struct device *omap2_get_dsp_device(void)
+struct device *omap2_get_iva_device(void)
 {
-	WARN_ON_ONCE(!dsp_dev);
-	return dsp_dev;
+	WARN_ON_ONCE(!iva_dev);
+	return iva_dev;
 }
 
 struct device *omap2_get_l3_device(void)
@@ -42,6 +43,13 @@ struct device *omap2_get_l3_device(void)
 	return l3_dev;
 }
 
+struct device *omap4_get_dsp_device(void)
+{
+	WARN_ON_ONCE(!dsp_dev);
+	return dsp_dev;
+}
+EXPORT_SYMBOL(omap4_get_dsp_device);
+
 /* static int _init_omap_device(struct omap_hwmod *oh, void *user) */
 static int _init_omap_device(char *name, struct device **new_dev)
 {
@@ -69,7 +77,9 @@ static int _init_omap_device(char *name, struct device **new_dev)
 static void omap2_init_processor_devices(void)
 {
 	_init_omap_device("mpu", &mpu_dev);
-	_init_omap_device("iva", &dsp_dev);
+	_init_omap_device("iva", &iva_dev);
+	if (cpu_is_omap44xx())
+		_init_omap_device("dsp", &dsp_dev);
 	_init_omap_device("l3_main", &l3_dev);
 }
 
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 9776b41..c45dbb9 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -91,7 +91,8 @@ void omap3_map_io(void);
 })
 
 extern struct device *omap2_get_mpuss_device(void);
-extern struct device *omap2_get_dsp_device(void);
+extern struct device *omap2_get_iva_device(void);
 extern struct device *omap2_get_l3_device(void);
+extern struct device *omap4_get_dsp_device(void);
 
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
-- 
1.7.0.4

