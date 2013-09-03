From: Russ Dill <Russ.Dill@ti.com>
Subject: [RFC 2/4] ARM: SRAM: Add macro for generating SRAM resume trampoline
Date: Tue,  3 Sep 2013 09:44:23 -0700
Message-ID: <1378226665-27090-3-git-send-email-Russ.Dill@ti.com>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:53538 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757068Ab3ICQoc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Sep 2013 12:44:32 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so6209212pbb.41
        for <linux-omap@vger.kernel.org>; Tue, 03 Sep 2013 09:44:32 -0700 (PDT)
In-Reply-To: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, mans@mansr.com

Add a helper that generates a short snippet of code that loads
the stack pointer and calls a c (or asm) function. The code gets
placed into a SRAM section for loading into SRAM.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 arch/arm/include/asm/suspend.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
index cd20029..d23d004 100644
--- a/arch/arm/include/asm/suspend.h
+++ b/arch/arm/include/asm/suspend.h
@@ -9,4 +9,18 @@ struct sleep_save_sp {
 extern void cpu_resume(void);
 extern int cpu_suspend(unsigned long, int (*)(unsigned long));
 
+/*
+ * Generate a SRAM trampoline for resume.
+ * @proc: SoC, should match argument used with SRAM_SECTIONS().
+ * @func: C or asm function to call at resume.
+ * @stack: Stack to use before calling func.
+ */
+#define ARM_SRAM_RESUME(proc, func, stack)				\
+void __naked __noreturn __sram_##proc proc##_resume_trampoline(void)	\
+{									\
+	__asm__ __volatile__("mov sp, %0" : : "r"((stack)) : "sp");	\
+	func();								\
+}
+
+
 #endif
-- 
1.8.3.2

