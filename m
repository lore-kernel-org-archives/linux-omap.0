From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH] drivers: bus: omap_interconnect: Fix rand-config build warning
Date: Wed, 17 Oct 2012 18:58:39 +0530
Message-ID: <1350480519-1890-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41210 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756086Ab2JQN2w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 09:28:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, santosh.shilimkar@ti.com, lokeshvutla@ti.com

When building omap_l3_noc/smx drivers as modules, the following
warning appears:

CC [M]  drivers/bus/omap_l3_smx.o
drivers/bus/omap_l3_smx.c:291: warning: data definition has no type or storage class
drivers/bus/omap_l3_smx.c:291: warning: type defaults to 'int' in declaration of 'postcore_initcall_sync'
drivers/bus/omap_l3_smx.c:291: warning: parameter names (without types) in function declaration
drivers/bus/omap_l3_smx.c:287: warning: 'omap3_l3_init' defined but not used
CC [M]  drivers/bus/omap_l3_noc.o
drivers/bus/omap_l3_noc.c:260: warning: data definition has no type or storage class
drivers/bus/omap_l3_noc.c:260: warning: type defaults to 'int' in declaration of 'arch_initcall_sync'
drivers/bus/omap_l3_noc.c:260: warning: parameter names (without types) in function declaration
drivers/bus/omap_l3_noc.c:256: warning: 'omap4_l3_init' defined but not used

Adding module_init() and macros in omap_l3_noc/smx drivers when building
as modules to remove the above warning.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/bus/omap_l3_noc.c |    9 +++++++++
 drivers/bus/omap_l3_smx.c |   10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index d15225f..8222a33 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -257,10 +257,19 @@ static int __init omap4_l3_init(void)
 {
 	return platform_driver_register(&omap4_l3_driver);
 }
+#ifndef CONFIG_OMAP_INTERCONNECT_MODULE
 postcore_initcall_sync(omap4_l3_init);
+#else
+module_init(omap4_l3_init);
+#endif
 
 static void __exit omap4_l3_exit(void)
 {
 	platform_driver_unregister(&omap4_l3_driver);
 }
 module_exit(omap4_l3_exit);
+
+MODULE_ALIAS("platform: omap_l3_noc");
+MODULE_AUTHOR("Texas Instruments Inc.");
+MODULE_DESCRIPTION("OMAP4XXX L3 Interconnect Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
index acc2164..00f712d 100644
--- a/drivers/bus/omap_l3_smx.c
+++ b/drivers/bus/omap_l3_smx.c
@@ -22,6 +22,7 @@
  * USA
  */
 
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
@@ -288,10 +289,19 @@ static int __init omap3_l3_init(void)
 {
 	return platform_driver_probe(&omap3_l3_driver, omap3_l3_probe);
 }
+#ifndef CONFIG_OMAP_INTERCONNECT_MODULE
 postcore_initcall_sync(omap3_l3_init);
+#else
+module_init(omap3_l3_init);
+#endif
 
 static void __exit omap3_l3_exit(void)
 {
 	platform_driver_unregister(&omap3_l3_driver);
 }
 module_exit(omap3_l3_exit);
+
+MODULE_ALIAS("platform: omap_l3_smx");
+MODULE_AUTHOR("Texas Instruments Inc.");
+MODULE_DESCRIPTION("OMAP3XXX L3 Interconnect Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.10.4

