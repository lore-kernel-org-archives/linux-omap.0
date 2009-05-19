From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/4] ARM: OMAP: Remove unnecessary omap2_globals.
Date: Tue, 19 May 2009 18:59:12 +0530
Message-ID: <1242739752-12303-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36402 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753456AbZESN3U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 May 2009 09:29:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch removes unnecessary omap2_globals and pass the global structures
directly as function argument.

The proposed cleanup was suggested by Russell King <rmk+kernel@arm.linux.org.uk>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/common.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 433021f..cee12c6 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -240,9 +240,7 @@ arch_initcall(omap_init_clocksource_32k);
 
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 
-static struct omap_globals *omap2_globals;
-
-static void __init __omap2_set_globals(void)
+static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
 {
 	omap2_set_globals_tap(omap2_globals);
 	omap2_set_globals_sdrc(omap2_globals);
@@ -266,8 +264,7 @@ static struct omap_globals omap242x_globals = {
 
 void __init omap2_set_globals_242x(void)
 {
-	omap2_globals = &omap242x_globals;
-	__omap2_set_globals();
+	__omap2_set_globals(&omap242x_globals);
 }
 #endif
 
@@ -285,8 +282,7 @@ static struct omap_globals omap243x_globals = {
 
 void __init omap2_set_globals_243x(void)
 {
-	omap2_globals = &omap243x_globals;
-	__omap2_set_globals();
+	__omap2_set_globals(&omap243x_globals);
 }
 #endif
 
@@ -304,8 +300,7 @@ static struct omap_globals omap343x_globals = {
 
 void __init omap2_set_globals_343x(void)
 {
-	omap2_globals = &omap343x_globals;
-	__omap2_set_globals();
+	__omap2_set_globals(&omap343x_globals);
 }
 #endif
 
-- 
1.5.4.7

