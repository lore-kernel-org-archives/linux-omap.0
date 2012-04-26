From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFT 1/8] ARM: OMAP: remove unused cpu_is macros that depend on specific IP checks
Date: Thu, 26 Apr 2012 16:29:46 -0700
Message-ID: <1335482993-14035-2-git-send-email-khilman@ti.com>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:60451 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753398Ab2DZX3E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Apr 2012 19:29:04 -0400
Received: by pbbrr13 with SMTP id rr13so413456pbb.33
        for <linux-omap@vger.kernel.org>; Thu, 26 Apr 2012 16:29:03 -0700 (PDT)
In-Reply-To: <1335482993-14035-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

The cpu_is_omap35* macros for 3503, 3515, 3525) are unused.

Remove them in order to start removing IP detection from SoC family
detection.

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |   15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index dc6a86b..41f3e5a 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -291,9 +291,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define cpu_is_omap2422()		0
 #define cpu_is_omap2423()		0
 #define cpu_is_omap2430()		0
-#define cpu_is_omap3503()		0
-#define cpu_is_omap3515()		0
-#define cpu_is_omap3525()		0
 #define cpu_is_omap3530()		0
 #define cpu_is_omap3505()		0
 #define cpu_is_omap3517()		0
@@ -348,9 +345,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 
 #if defined(CONFIG_ARCH_OMAP3)
 # undef cpu_is_omap3430
-# undef cpu_is_omap3503
-# undef cpu_is_omap3515
-# undef cpu_is_omap3525
 # undef cpu_is_omap3530
 # undef cpu_is_omap3505
 # undef cpu_is_omap3517
@@ -360,15 +354,6 @@ IS_OMAP_TYPE(3517, 0x3517)
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
1.7.9.2

