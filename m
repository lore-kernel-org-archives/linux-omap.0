From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 05/12] omap: mcbsp: Move out omap_mcbsp_register_board_cfg from plat-omap/devices.c
Date: Fri,  1 Jul 2011 11:52:29 +0300
Message-ID: <1309510356-27147-6-git-send-email-jhnikula@gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58452 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755721Ab1GAIxD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 04:53:03 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so2453487bwd.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 01:53:03 -0700 (PDT)
In-Reply-To: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

Only OMAP1s are using omap_mcbsp_register_board_cfg after OMAP2+ hwmod
conversion so it can be moved to mach-omap1/mcbsp.c.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap1/mcbsp.c             |   32 +++++++++++++++++++++
 arch/arm/plat-omap/devices.c            |   46 -------------------------------
 arch/arm/plat-omap/include/plat/mcbsp.h |    2 -
 3 files changed, 32 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index ab7395d..3c985ac 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -31,6 +31,7 @@
 static int dsp_use;
 static struct clk *api_clk;
 static struct clk *dsp_clk;
+static struct platform_device **omap_mcbsp_devices;
 
 static void omap1_mcbsp_request(unsigned int id)
 {
@@ -369,6 +370,37 @@ static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
 #define OMAP16XX_MCBSP_COUNT		0
 #endif
 
+static void omap_mcbsp_register_board_cfg(struct resource *res, int res_count,
+			struct omap_mcbsp_platform_data *config, int size)
+{
+	int i;
+
+	omap_mcbsp_devices = kzalloc(size * sizeof(struct platform_device *),
+				     GFP_KERNEL);
+	if (!omap_mcbsp_devices) {
+		printk(KERN_ERR "Could not register McBSP devices\n");
+		return;
+	}
+
+	for (i = 0; i < size; i++) {
+		struct platform_device *new_mcbsp;
+		int ret;
+
+		new_mcbsp = platform_device_alloc("omap-mcbsp", i + 1);
+		if (!new_mcbsp)
+			continue;
+		platform_device_add_resources(new_mcbsp, &res[i * res_count],
+					res_count);
+		new_mcbsp->dev.platform_data = &config[i];
+		ret = platform_device_add(new_mcbsp);
+		if (ret) {
+			platform_device_put(new_mcbsp);
+			continue;
+		}
+		omap_mcbsp_devices[i] = new_mcbsp;
+	}
+}
+
 static int __init omap1_mcbsp_init(void)
 {
 	if (!cpu_class_is_omap1())
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index ea28f98..bd9a06b 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -26,54 +26,8 @@
 #include <plat/mmc.h>
 #include <mach/gpio.h>
 #include <plat/menelaus.h>
-#include <plat/mcbsp.h>
 #include <plat/omap44xx.h>
 
-/*-------------------------------------------------------------------------*/
-
-#if defined(CONFIG_OMAP_MCBSP) || defined(CONFIG_OMAP_MCBSP_MODULE)
-
-static struct platform_device **omap_mcbsp_devices;
-
-void omap_mcbsp_register_board_cfg(struct resource *res, int res_count,
-			struct omap_mcbsp_platform_data *config, int size)
-{
-	int i;
-
-	omap_mcbsp_devices = kzalloc(size * sizeof(struct platform_device *),
-				     GFP_KERNEL);
-	if (!omap_mcbsp_devices) {
-		printk(KERN_ERR "Could not register McBSP devices\n");
-		return;
-	}
-
-	for (i = 0; i < size; i++) {
-		struct platform_device *new_mcbsp;
-		int ret;
-
-		new_mcbsp = platform_device_alloc("omap-mcbsp", i + 1);
-		if (!new_mcbsp)
-			continue;
-		platform_device_add_resources(new_mcbsp, &res[i * res_count],
-					res_count);
-		new_mcbsp->dev.platform_data = &config[i];
-		ret = platform_device_add(new_mcbsp);
-		if (ret) {
-			platform_device_put(new_mcbsp);
-			continue;
-		}
-		omap_mcbsp_devices[i] = new_mcbsp;
-	}
-}
-
-#else
-void omap_mcbsp_register_board_cfg(struct resource *res, int res_count,
-			struct omap_mcbsp_platform_data *config, int size)
-{  }
-#endif
-
-/*-------------------------------------------------------------------------*/
-
 #if defined(CONFIG_SND_OMAP_SOC_MCPDM) || \
 		defined(CONFIG_SND_OMAP_SOC_MCPDM_MODULE)
 
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 6db02b3..2202457 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -376,8 +376,6 @@ extern int omap_mcbsp_count, omap_mcbsp_cache_size;
 #define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
 
 int omap_mcbsp_init(void);
-void omap_mcbsp_register_board_cfg(struct resource *res, int res_count,
-			struct omap_mcbsp_platform_data *config, int size);
 void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config);
 #ifdef CONFIG_ARCH_OMAP3
 void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
-- 
1.7.0.4

