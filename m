From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] OMAP: mach-omap2/io.c: fix function declarations
Date: Wed,  3 Mar 2010 18:24:53 +0200
Message-ID: <1267633493-8635-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38632 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab0CCQWv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 11:22:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com

Get rid of the following warnings:

	warning: non-ANSI function declaration of function [...]

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/io.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 402e8f0..ae89d55 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -237,7 +237,7 @@ static void __init _omap2_map_common_io(void)
 }
 
 #ifdef CONFIG_ARCH_OMAP2420
-void __init omap242x_map_common_io()
+void __init omap242x_map_common_io(void)
 {
 	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
 	iotable_init(omap242x_io_desc, ARRAY_SIZE(omap242x_io_desc));
@@ -246,7 +246,7 @@ void __init omap242x_map_common_io()
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2430
-void __init omap243x_map_common_io()
+void __init omap243x_map_common_io(void)
 {
 	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
 	iotable_init(omap243x_io_desc, ARRAY_SIZE(omap243x_io_desc));
@@ -255,7 +255,7 @@ void __init omap243x_map_common_io()
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
-void __init omap34xx_map_common_io()
+void __init omap34xx_map_common_io(void)
 {
 	iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
 	_omap2_map_common_io();
@@ -263,7 +263,7 @@ void __init omap34xx_map_common_io()
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
-void __init omap44xx_map_common_io()
+void __init omap44xx_map_common_io(void)
 {
 	iotable_init(omap44xx_io_desc, ARRAY_SIZE(omap44xx_io_desc));
 	_omap2_map_common_io();
-- 
1.5.6.5

