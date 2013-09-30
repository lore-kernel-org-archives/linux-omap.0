From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] ARM: OMAP2+: timer: build with DRA7xx enable but without OMAP5
Date: Mon, 30 Sep 2013 11:15:31 +0200
Message-ID: <1380532531-21021-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56914 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab3I3JPi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Sep 2013 05:15:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, R Sricharan <r.sricharan@ti.com>, Rajendra Nayak <rnayak@ti.com>

with DRA7xx and without OMAP5 selected we get
|arch/arm/mach-omap2/built-in.o:(.arch.info.init+0x40): undefined reference to `omap5_realtime_timer_init'
|make[1]: *** [vmlinux] Error 1

since ARM: DRA7: board-generic: Add basic DT support ("439bf39e").

Cc: Tony Lindgren <tony@atomide.com>
Cc: R Sricharan <r.sricharan@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mach-omap2/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index fa74a06..4fd1816 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -628,7 +628,7 @@ void __init omap4_local_timer_init(void)
 #endif /* CONFIG_HAVE_ARM_TWD */
 #endif /* CONFIG_ARCH_OMAP4 */
 
-#ifdef CONFIG_SOC_OMAP5
+#if defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX)
 void __init omap5_realtime_timer_init(void)
 {
 	omap4_sync32k_timer_init();
-- 
1.8.4.rc3

