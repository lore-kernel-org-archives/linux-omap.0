From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [PATCH v2 2/2] PM / AVS: SmartReflex/class3: Fix order of initialization of SR class and SR driver
Date: Tue, 4 Jun 2013 12:58:33 +0300
Message-ID: <1370339913-16135-3-git-send-email-andrii.tseglytskyi@ti.com>
References: <1370339913-16135-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370339913-16135-1-git-send-email-andrii.tseglytskyi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@linaro.org, j-keerthy@ti.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

SmartReflex consists of three entities: SR device, SR class and
SR driver. SmartReflex driver depends on SmartReflex class, but
order of their initialization is not clear. They both use
late_initcall(), and order depends on Makefile calls.
Patch moves initialization of SR class to device_initcall(),
and removes redundant call of sr_late_init().

This provides predictable order of SmartReflex initcalls:
1. device_initcall() -> SmartReflex class init
2. late_initcall() -> SmartReflex driver init

Signed-off-by: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |    2 +-
 drivers/power/avs/smartreflex.c          |    9 ---------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index aee3c89..50523b8 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -59,4 +59,4 @@ static int __init sr_class3_init(void)
 	pr_info("SmartReflex Class3 initialized\n");
 	return sr_register_class(&class3_data);
 }
-omap_late_initcall(sr_class3_init);
+omap_device_initcall(sr_class3_init);
diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index fd71d5a..42eed34 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -650,8 +650,6 @@ void sr_disable(struct voltagedomain *voltdm)
  */
 int sr_register_class(struct omap_sr_class_data *class_data)
 {
-	struct omap_sr *sr_info;
-
 	if (!class_data) {
 		pr_warning("%s:, Smartreflex class data passed is NULL\n",
 			__func__);
@@ -666,13 +664,6 @@ int sr_register_class(struct omap_sr_class_data *class_data)
 
 	sr_class = class_data;
 
-	/*
-	 * Call into late init to do intializations that require
-	 * both sr driver and sr class driver to be initiallized.
-	 */
-	list_for_each_entry(sr_info, &sr_list, node)
-		sr_late_init(sr_info);
-
 	return 0;
 }
 
-- 
1.7.9.5
