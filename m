From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 05/14] ARM: OMAP5: timer: Add clocksource, clockevent support
Date: Fri, 6 Jul 2012 14:51:46 +0530
Message-ID: <1341566515-22665-6-git-send-email-santosh.shilimkar@ti.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38328 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932405Ab2GFJXL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Jul 2012 05:23:11 -0400
In-Reply-To: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, R Sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: R Sricharan <r.sricharan@ti.com>

Adding the Initialisaton for clocksource and clockevent device
on OMAP5 Socs.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/common.h |    1 +
 arch/arm/mach-omap2/timer.c  |    5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 399e5bb..97e8792 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -130,6 +130,7 @@ extern struct sys_timer omap3_timer;
 extern struct sys_timer omap3_secure_timer;
 extern struct sys_timer omap3_am33xx_timer;
 extern struct sys_timer omap4_timer;
+extern struct sys_timer omap5_timer;
 
 void omap2420_init_early(void);
 void omap2430_init_early(void);
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 2b318ec..13d20c8 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -393,6 +393,11 @@ static void __init omap4_timer_init(void)
 OMAP_SYS_TIMER(4)
 #endif
 
+#ifdef CONFIG_SOC_OMAP5
+OMAP_SYS_TIMER_INIT(5, 1, OMAP4_CLKEV_SOURCE, 2, OMAP4_MPU_SOURCE)
+OMAP_SYS_TIMER(5)
+#endif
+
 /**
  * omap_timer_init - build and register timer device with an
  * associated timer hwmod
-- 
1.7.9.5

