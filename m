From: Kevin Hilman <khilman@ti.com>
Subject: [RFC/PATCH 1/7] ARM: OMAP: remove unused cpu_is macros that depend on specific IP checks
Date: Wed,  4 Jan 2012 17:16:40 -0800
Message-ID: <1325726206-11199-2-git-send-email-khilman@ti.com>
References: <1325726206-11199-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:53281 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757459Ab2AEBQv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jan 2012 20:16:51 -0500
Received: by mail-gx0-f180.google.com with SMTP id q1so17919ggn.11
        for <linux-omap@vger.kernel.org>; Wed, 04 Jan 2012 17:16:50 -0800 (PST)
In-Reply-To: <1325726206-11199-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>

The cpu_is_omap35* macros for 3503, 3515, 3525) are unused.

Remove them in order to start removing IP detection from SoC family
detection.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 428ccb1..bcad3dc 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -292,9 +292,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define cpu_is_omap2422()		0
 #define cpu_is_omap2423()		0
 #define cpu_is_omap2430()		0
-#define cpu_is_omap3503()		0
-#define cpu_is_omap3515()		0
-#define cpu_is_omap3525()		0
 #define cpu_is_omap3530()		0
 #define cpu_is_omap3505()		0
 #define cpu_is_omap3517()		0
@@ -350,9 +347,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 
 #if defined(CONFIG_ARCH_OMAP3)
 # undef cpu_is_omap3430
-# undef cpu_is_omap3503
-# undef cpu_is_omap3515
-# undef cpu_is_omap3525
 # undef cpu_is_omap3530
 # undef cpu_is_omap3505
 # undef cpu_is_omap3517
@@ -362,15 +356,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 # undef cpu_is_am33xx
 # undef cpu_is_am335x
 # define cpu_is_omap3430()		is_omap3430()
-# define cpu_is_omap3503()		(cpu_is_omap3430() &&		\
-						(!omap3_has_iva()) &&	\
-						(!omap3_has_sgx()))
-# define cpu_is_omap3515()		(cpu_is_omap3430() &&		\
-						(!omap3_has_iva()) &&	\
-						(omap3_has_sgx()))
-# define cpu_is_omap3525()		(cpu_is_omap3430() &&		\
-						(!omap3_has_sgx()) &&	\
-						(omap3_has_iva()))
 # define cpu_is_omap3530()		(cpu_is_omap3430())
 # define cpu_is_omap3517()		is_omap3517()
 # define cpu_is_omap3505()		(cpu_is_omap3517() &&		\
-- 
1.7.8.2

