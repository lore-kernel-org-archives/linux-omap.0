From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3] OMAP4: pm.c extensions for OMAP4 support
Date: Tue, 14 Sep 2010 11:21:41 -0700
Message-ID: <1284488501.2661.72.camel@localhost>
References: <1283328893-14556-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54397 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab0INSVs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 14:21:48 -0400
Received: by eyb6 with SMTP id 6so3269467eyb.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Sep 2010 11:21:47 -0700 (PDT)
In-Reply-To: <1283328893-14556-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com

On Wed, 2010-09-01 at 13:44 +0530, Thara Gopinath wrote:
> OMAP4 has an iva device and a dsp devcice where as OMAP2/3
> has only an iva device. In this file the iva device in the
> system is registered under the name dsp_dev and the API
> to retrieve the iva device is omap2_get_dsp_device.
> This patch renames the dsp_dev to iva_dev, renames
> omap2_get_dsp_device to omap2_get_iva_device,
> registers dsp_dev for OMAP4 and adds a new API
> omap4_get_dsp_device to retrieve the dep_dev.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
> v2: Removed fixing of l3_main hwmod for OMAP4 as Benoit has
>     already submitted a pach fixing the same.
> v3: Put OMAP4 check across dsp_dev init so that on other
>     OMAP's this init does not throw a warn.

Thanks, queuing for 2.6.37 in my pm-next branch.

I changed the subject slightly, and I had to fix up a conflict that
wasn't there when you submitted, so I fixed it myself: basically, there
was already a cpu_is_omap4* check in the function due to the l3_main
name differences, so I just added the dsp check to the existing cpu_is
check. 

Updated patch below for reference.

Kevin

commit fe3d5eec187ad5e1171599f75241ac6649294e4d
Author: Thara Gopinath <thara@ti.com>
Date:   Wed Sep 1 13:44:53 2010 +0530

    OMAP2+: PM: OMAP4 has separate IVA and DSP devices
    
    OMAP4 has an iva device and a dsp devcice where as OMAP2/3
    has only an iva device. In this file the iva device in the
    system is registered under the name dsp_dev and the API
    to retrieve the iva device is omap2_get_dsp_device.
    This patch renames the dsp_dev to iva_dev, renames
    omap2_get_dsp_device to omap2_get_iva_device,
    registers dsp_dev for OMAP4 and adds a new API
    omap4_get_dsp_device to retrieve the dep_dev.
    
    Signed-off-by: Thara Gopinath <thara@ti.com>
    Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 6bbfdd7..7e93726 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -23,8 +23,9 @@ extern int __init omap3_pm_init_opp_table(void);
 static struct omap_device_pm_latency *pm_lats;
 
 static struct device *mpu_dev;
-static struct device *dsp_dev;
+static struct device *iva_dev;
 static struct device *l3_dev;
+static struct device *dsp_dev;
 
 struct device *omap2_get_mpuss_device(void)
 {
@@ -32,10 +33,10 @@ struct device *omap2_get_mpuss_device(void)
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
@@ -44,6 +45,13 @@ struct device *omap2_get_l3_device(void)
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
@@ -72,10 +80,12 @@ static void omap2_init_processor_devices(void)
 {
 	_init_omap_device("mpu", &mpu_dev);
 	_init_omap_device("iva", &dsp_dev);
-	if (cpu_is_omap44xx())
+	if (cpu_is_omap44xx()) {
 		_init_omap_device("l3_main_1", &l3_dev);
-	else
+		_init_omap_device("dsp", &dsp_dev);
+	} else {
 		_init_omap_device("l3_main", &l3_dev);
+	}
 }
 
 static int __init omap2_common_pm_init(void)
diff --git a/arch/arm/plat-omap/include/plat/common.h
b/arch/arm/plat-omap/include/plat/common.h
index 1a36172..159e45c 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -90,7 +90,8 @@ void omap3_map_io(void);
 })
 
 extern struct device *omap2_get_mpuss_device(void);
-extern struct device *omap2_get_dsp_device(void);
+extern struct device *omap2_get_iva_device(void);
 extern struct device *omap2_get_l3_device(void);
+extern struct device *omap4_get_dsp_device(void);
 
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */


