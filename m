From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 3/9] ARM: DRA7: Resue the clocksource, clockevent support
Date: Sun, 4 Aug 2013 21:57:31 +0530
Message-ID: <1375633657-6835-4-git-send-email-rnayak@ti.com>
References: <1375633657-6835-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47592 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653Ab3HDQ2c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Aug 2013 12:28:32 -0400
In-Reply-To: <1375633657-6835-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com, santosh.shilimkar@ti.com, nm@ti.com, balbi@ti.com, Rajendra Nayak <rnayak@ti.com>

From: R Sricharan <r.sricharan@ti.com>

All of OMAP5 timer support for clocksource and clockevent is completely
reused across DRA7.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    2 +-
 arch/arm/mach-omap2/timer.c |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 3eed000..fc6ec23 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -132,7 +132,7 @@ config SOC_HAS_OMAP2_SDRC
 
 config SOC_HAS_REALTIME_COUNTER
 	bool "Real time free running counter"
-	depends on SOC_OMAP5
+	depends on SOC_OMAP5 || SOC_DRA7XX
 	default y
 
 comment "OMAP Core Type"
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index b37e1fc..1e77f11 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -594,7 +594,8 @@ OMAP_SYS_GP_TIMER_INIT(3, 2, "timer_sys_ck", NULL,
 		       1, "timer_sys_ck", "ti,timer-alwon");
 #endif
 
-#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
+	defined(CONFIG_SOC_DRA7XX)
 static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
 			       2, "sys_clkin_ck", NULL);
 #endif
-- 
1.7.9.5

