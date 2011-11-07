From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH] OMAP2+: Fix Compilation break on current mainline
Date: Mon, 7 Nov 2011 18:08:28 +0530
Message-ID: <1320669508-32204-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57464 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755374Ab1KGMit (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Nov 2011 07:38:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>

I see below errors and warnings on latest mainline commit
b32fc0a0629bf5894b35f33554c118aacfd0d1e2 with omap2plus_defconfig.

Patch to fix the same.

arch/arm/plat-omap/dmtimer.c:184: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:184: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:184: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:215: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:215: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:215: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:228: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:228: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:228: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:234: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:234: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:234: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:240: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:240: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:240: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:248: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:248: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:248: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:294: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:294: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:294: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:302: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:302: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:302: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:316: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:316: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:316: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:344: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:344: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:344: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:361: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:361: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:361: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:380: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:380: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:380: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:406: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:406: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:406: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:443: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:443: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:443: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:468: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:468: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:468: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:494: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:494: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:494: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:517: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:517: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:517: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:534: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:534: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:534: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:549: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:549: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:549: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:561: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:561: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:561: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:572: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:572: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:572: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:587: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:587: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:587: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:604: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:604: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:604: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:746: error: expected declaration specifiers or '...' before string constant
arch/arm/plat-omap/dmtimer.c:746: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:746: warning: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
arch/arm/plat-omap/dmtimer.c:746: warning: function declaration isn't a prototype
arch/arm/plat-omap/dmtimer.c:747: error: expected declaration specifiers or '...' before string constant
arch/arm/plat-omap/dmtimer.c:747: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:747: warning: type defaults to 'int' in declaration of 'MODULE_LICENSE'
arch/arm/plat-omap/dmtimer.c:747: warning: function declaration isn't a prototype
arch/arm/plat-omap/dmtimer.c:748: error: expected declaration specifiers or '...' before string constant
arch/arm/plat-omap/dmtimer.c:748: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:748: warning: type defaults to 'int' in declaration of 'MODULE_ALIAS'
arch/arm/plat-omap/dmtimer.c:748: warning: function declaration isn't a prototype
arch/arm/plat-omap/dmtimer.c:749: error: expected declaration specifiers or '...' before string constant
arch/arm/plat-omap/dmtimer.c:749: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:749: warning: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
arch/arm/plat-omap/dmtimer.c:749: warning: function declaration isn't a prototype
make[1]: *** [arch/arm/plat-omap/dmtimer.o] Error 1
make: *** [arch/arm/plat-omap] Error 2
make: *** Waiting for unfinished jobs....
arch/arm/mach-omap2/omap_l3_noc.c:240: error: expected ',' or ';' before 'MODULE_DEVICE_TABLE'
arch/arm/mach-omap2/omap_l3_noc.c:250: error: 'THIS_MODULE' undeclared here (not in a function)
make[1]: *** [arch/arm/mach-omap2/omap_l3_noc.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
Sorry for the noise if this is already fixed.

 arch/arm/mach-omap2/omap_l3_noc.c |    3 ++-
 arch/arm/plat-omap/dmtimer.c      |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index c8b1bef..eacbe55 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 
 #include "omap_l3_noc.h"
 
@@ -236,7 +237,7 @@ static int __devexit omap4_l3_remove(struct platform_device *pdev)
 static const struct of_device_id l3_noc_match[] = {
 	{.compatible = "ti,omap4-l3-noc", },
 	{},
-}
+};
 MODULE_DEVICE_TABLE(of, l3_noc_match);
 #else
 #define l3_noc_match NULL
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 2def4e1..b9acaca 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -39,6 +39,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
+#include <linux/module.h>
 
 #include <plat/dmtimer.h>
 
-- 
1.7.4.1

