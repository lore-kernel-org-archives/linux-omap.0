From: Kevin Hilman <khilman@ti.com>
Subject: [RFC/PATCH 6/7] ARM: OMAP: remove unused cpu_is_omap3505()
Date: Wed,  4 Jan 2012 17:16:45 -0800
Message-ID: <1325726206-11199-7-git-send-email-khilman@ti.com>
References: <1325726206-11199-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36285 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751923Ab2AEBRZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jan 2012 20:17:25 -0500
Received: by mail-gx0-f179.google.com with SMTP id v5so11930ggn.10
        for <linux-omap@vger.kernel.org>; Wed, 04 Jan 2012 17:17:03 -0800 (PST)
In-Reply-To: <1325726206-11199-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>

The 3505 check is now unused and can be removed.

There are no longer any cpu_is_* checks that depend on specific IP
detection.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index bcad3dc..8d858c2 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -251,8 +251,7 @@ IS_AM_SUBCLASS(335x, 0x335)
  * cpu_is_omap2430():	True for OMAP2430
  * cpu_is_omap3430():	True for OMAP3430
  * cpu_is_omap4430():	True for OMAP4430
- * cpu_is_omap3505():	True for OMAP3505
- * cpu_is_omap3517():	True for OMAP3517
+ * cpu_is_omap3517():	True for AM35x: OMAP3517, OMAP3505
  */
 #define GET_OMAP_TYPE	((omap_rev() >> 16) & 0xffff)
 
@@ -276,7 +275,6 @@ IS_OMAP_TYPE(2422, 0x2422)
 IS_OMAP_TYPE(2423, 0x2423)
 IS_OMAP_TYPE(2430, 0x2430)
 IS_OMAP_TYPE(3430, 0x3430)
-IS_OMAP_TYPE(3505, 0x3517)
 IS_OMAP_TYPE(3517, 0x3517)
 
 #define cpu_is_omap310()		0
@@ -293,7 +291,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define cpu_is_omap2423()		0
 #define cpu_is_omap2430()		0
 #define cpu_is_omap3530()		0
-#define cpu_is_omap3505()		0
 #define cpu_is_omap3517()		0
 #define cpu_is_omap3430()		0
 #define cpu_is_omap4430()		0
@@ -348,7 +345,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 #if defined(CONFIG_ARCH_OMAP3)
 # undef cpu_is_omap3430
 # undef cpu_is_omap3530
-# undef cpu_is_omap3505
 # undef cpu_is_omap3517
 # undef cpu_is_ti81xx
 # undef cpu_is_ti816x
@@ -358,8 +354,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 # define cpu_is_omap3430()		is_omap3430()
 # define cpu_is_omap3530()		(cpu_is_omap3430())
 # define cpu_is_omap3517()		is_omap3517()
-# define cpu_is_omap3505()		(cpu_is_omap3517() &&		\
-						!omap3_has_sgx())
 # undef cpu_is_omap3630
 # define cpu_is_omap3630()		is_omap363x()
 # define cpu_is_ti81xx()		is_ti81xx()
-- 
1.7.8.2

