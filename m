From: "chandra shekhar" <x0044955@ti.com>
Subject: [PATCH 1/2] Dynamic allocation for mcbsp devices. and related
     changes
Date: Wed, 25 Jun 2008 20:27:27 +0530 (IST)
Message-ID: <55227.192.168.10.88.1214405847.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52422 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbYFYO5t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jun 2008 10:57:49 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m5PEvS6o004417
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2008 09:57:38 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id m5PEvQuU010043
	for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2008 09:57:27 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Signed-off-by: Tony Lindgren <tony@atomide.com>

---
 arch/arm/plat-omap/devices.c |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)

Index: linux-omap-2.6/arch/arm/plat-omap/devices.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/devices.c	2008-06-25
15:54:09.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/devices.c	2008-06-25 15:55:06.000000000
+0530
@@ -153,8 +153,7 @@
 /*-------------------------------------------------------------------------*/
 #if defined(CONFIG_OMAP_MCBSP) || defined(CONFIG_OMAP_MCBSP_MODULE)

-static struct platform_device omap_mcbsp_devices[OMAP_MAX_MCBSP_COUNT];
-static int mcbsps_configured;
+static struct platform_device **omap_mcbsp_devices;

 void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 					int size)
@@ -168,29 +167,32 @@
 		size = OMAP_MAX_MCBSP_COUNT;
 	}

+	omap_mcbsp_devices = kzalloc(size * sizeof(struct platform_device *),
+								GFP_KERNEL);
+	if (!omap_mcbsp_devices) {
+		printk(KERN_ERR "Could not register McBSP devices\n");
+		return;
+	}
 	for (i = 0; i < size; i++) {
-		struct platform_device *new_mcbsp = &omap_mcbsp_devices[i];
-		new_mcbsp->name = "omap-mcbsp";
-		new_mcbsp->id = i + 1;
+		struct platform_device *new_mcbsp;
+		int ret;
+		new_mcbsp = platform_device_alloc("omap-mcbsp", i + 1);
+		if (!new_mcbsp)
+		continue;
 		new_mcbsp->dev.platform_data = &config[i];
+		ret = platform_device_add(new_mcbsp);
+		if (ret) {
+			platform_device_put(new_mcbsp);
+			continue;
+		}
+		omap_mcbsp_devices[i] = new_mcbsp;
 	}
-	mcbsps_configured = size;
 }

-static void __init omap_init_mcbsp(void)
-{
-	int i;
-
-	for (i = 0; i < mcbsps_configured; i++)
-		platform_device_register(&omap_mcbsp_devices[i]);
-}
 #else
 void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 					int size)
 {  }
-
-static inline void __init omap_init_mcbsp(void)
-{  }
 #endif

 /*-------------------------------------------------------------------------*/
@@ -555,7 +557,6 @@
 	 */
 	omap_init_dsp();
 	omap_init_kp();
-	omap_init_mcbsp();
 	omap_init_mmc();
 	omap_init_uwire();
 	omap_init_wdt();


