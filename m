From: =?UTF-8?q?Lo=C3=AFc=20Minier?= <loic.minier@linaro.org>
Subject: [PATCH] OMAP: PM: Fix build when CONFIG_PM_DEBUG isn't set
Date: Sat, 25 Sep 2010 15:36:57 +0200
Message-ID: <1285421817-6431-1-git-send-email-loic.minier@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from duck.dooz.org ([194.146.227.125]:39595 "EHLO duck.dooz.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317Ab0IYNhp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 25 Sep 2010 09:37:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Thara Gopinath <thara@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, =?UTF-8?q?Lo=C3=AFc=20Minier?= <loic.minier@linaro.org>

Since 6cdee91257bee23a46dc869ca62469b67cba2c7e the references to
enable_off_mode and sleep_while_idle can't be resolved when CONFIG_PM_DEBUG
isn't set:
arch/arm/mach-omap2/built-in.o: In function `omap_uart_restore_context':
arch/arm/mach-omap2/serial.c:253: undefined reference to `enable_off_mode'
arch/arm/mach-omap2/built-in.o: In function `omap3_can_sleep':
arch/arm/mach-omap2/pm34xx.c:479: undefined reference to `sleep_while_idle'

Simply #define these in pm.h just like omap2_pm_debug.
---
 arch/arm/mach-omap2/pm.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 77770a1..68db3a7 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -13,8 +13,13 @@
 
 #include <plat/powerdomain.h>
 
+#ifdef CONFIG_PM_DEBUG
 extern u32 enable_off_mode;
 extern u32 sleep_while_idle;
+#else
+#define enable_off_mode 0
+#define sleep_while_idle 0
+#endif
 
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
-- 
1.7.1

