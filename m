From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V7 1/3] ARM: OMAP1: FIX: check possible error condition in timer_init
Date: Thu, 3 May 2012 13:28:59 +0530
Message-ID: <1336031941-23651-2-git-send-email-hvaibhav@ti.com>
References: <1336031941-23651-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48364 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab2ECH7P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 03:59:15 -0400
In-Reply-To: <1336031941-23651-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

On OMAP1, omap_32k_timer_init() function always returns "true",
irrespective of whether error occurred while initializing 32k sync
counter as a kernel clocksource or not and execution will never
fallback to mpu_timer clocksource init code.

This patch adds check for return value from function
omap_init_clocksource_32k(), and fallback to omap_mpu_timer_init()
in case of failure/error from omap_init_clocksource_32k().

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Acked-by: Kevin Hilman <khilman@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
No Functional code change compared to V6 version, only 'inline'
prefix added to the function omap_32k_timer_init(), required to
fix warning (Thanks to Kevin).

 arch/arm/mach-omap1/common.h   |   10 +++++++++-
 arch/arm/mach-omap1/time.c     |   16 +---------------
 arch/arm/mach-omap1/timer32k.c |   13 +++++++++----
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index 8cc616e..cc83251 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -63,7 +63,15 @@ extern void omap1_nand_cmd_ctl(struct mtd_info *mtd, int cmd,
 			       unsigned int ctrl);

 extern struct sys_timer omap1_timer;
-extern bool omap_32k_timer_init(void);
+
+#ifdef CONFIG_OMAP_32K_TIMER
+extern int omap_32k_timer_init(void);
+#else
+static inline int __init omap_32k_timer_init(void)
+{
+	return -ENODEV;
+}
+#endif

 extern u32 omap_irq_flags;

diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index 4d8dd9a..4062480 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -232,20 +232,6 @@ static inline void omap_mpu_timer_init(void)
 }
 #endif	/* CONFIG_OMAP_MPU_TIMER */

-static inline int omap_32k_timer_usable(void)
-{
-	int res = false;
-
-	if (cpu_is_omap730() || cpu_is_omap15xx())
-		return res;
-
-#ifdef CONFIG_OMAP_32K_TIMER
-	res = omap_32k_timer_init();
-#endif
-
-	return res;
-}
-
 /*
  * ---------------------------------------------------------------------------
  * Timer initialization
@@ -253,7 +239,7 @@ static inline int omap_32k_timer_usable(void)
  */
 static void __init omap1_timer_init(void)
 {
-	if (!omap_32k_timer_usable())
+	if (omap_32k_timer_init() != 0)
 		omap_mpu_timer_init();
 }

diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 325b9a0..e3613a8 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -182,10 +182,15 @@ static __init void omap_init_32k_timer(void)
  * Timer initialization
  * ---------------------------------------------------------------------------
  */
-bool __init omap_32k_timer_init(void)
+int __init omap_32k_timer_init(void)
 {
-	omap_init_clocksource_32k();
-	omap_init_32k_timer();
+	int ret = -ENODEV;

-	return true;
+	if (cpu_is_omap16xx())
+		ret = omap_init_clocksource_32k();
+
+	if (!ret)
+		omap_init_32k_timer();
+
+	return ret;
 }
--
1.7.0.4

