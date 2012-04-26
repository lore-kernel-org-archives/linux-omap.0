From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFT 6/8] ARM: OMAP: remove unused cpu_is_omap3505()
Date: Thu, 26 Apr 2012 16:29:51 -0700
Message-ID: <1335482993-14035-7-git-send-email-khilman@ti.com>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:59622 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759505Ab2DZX3Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Apr 2012 19:29:24 -0400
Received: by dadz8 with SMTP id z8so171290dad.38
        for <linux-omap@vger.kernel.org>; Thu, 26 Apr 2012 16:29:23 -0700 (PDT)
In-Reply-To: <1335482993-14035-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

The 3505 check is now unused and can be removed.

There are no longer any cpu_is_* checks that depend on specific IP
detection.

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 41f3e5a..b34bf6c 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -250,8 +250,7 @@ IS_AM_SUBCLASS(335x, 0x335)
  * cpu_is_omap2423():	True for OMAP2423
  * cpu_is_omap2430():	True for OMAP2430
  * cpu_is_omap3430():	True for OMAP3430
- * cpu_is_omap3505():	True for OMAP3505
- * cpu_is_omap3517():	True for OMAP3517
+ * cpu_is_omap3517():	True for AM35x: OMAP3517, OMAP3505
  */
 #define GET_OMAP_TYPE	((omap_rev() >> 16) & 0xffff)
 
@@ -275,7 +274,6 @@ IS_OMAP_TYPE(2422, 0x2422)
 IS_OMAP_TYPE(2423, 0x2423)
 IS_OMAP_TYPE(2430, 0x2430)
 IS_OMAP_TYPE(3430, 0x3430)
-IS_OMAP_TYPE(3505, 0x3517)
 IS_OMAP_TYPE(3517, 0x3517)
 
 #define cpu_is_omap310()		0
@@ -292,7 +290,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define cpu_is_omap2423()		0
 #define cpu_is_omap2430()		0
 #define cpu_is_omap3530()		0
-#define cpu_is_omap3505()		0
 #define cpu_is_omap3517()		0
 #define cpu_is_omap3430()		0
 #define cpu_is_omap3630()		0
@@ -346,7 +343,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 #if defined(CONFIG_ARCH_OMAP3)
 # undef cpu_is_omap3430
 # undef cpu_is_omap3530
-# undef cpu_is_omap3505
 # undef cpu_is_omap3517
 # undef cpu_is_ti81xx
 # undef cpu_is_ti816x
@@ -356,8 +352,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 # define cpu_is_omap3430()		is_omap3430()
 # define cpu_is_omap3530()		(cpu_is_omap3430())
 # define cpu_is_omap3517()		is_omap3517()
-# define cpu_is_omap3505()		(cpu_is_omap3517() &&		\
-						!omap3_has_sgx())
 # undef cpu_is_omap3630
 # define cpu_is_omap3630()		is_omap363x()
 # define cpu_is_ti81xx()		is_ti81xx()
-- 
1.7.9.2

