From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/6] arm: Disable outer (L2) cache in kexec
Date: Tue,  7 Sep 2010 13:27:18 +0530
Message-ID: <1283846243-11600-2-git-send-email-santosh.shilimkar@ti.com>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42696 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878Ab0IGH5v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Sep 2010 03:57:51 -0400
In-Reply-To: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: tglx@linutronix.de, catalin.marinas@arm.com, linux-omap@vger.kernel.orgtglx@linutronix.de@vger.kernel.org

From: Thomas Gleixner <[tglx@linutronix.de]>

kexec does not disable the outer cache before disabling the inner
caches in cpu_proc_fin(). So L2 is enabled across the kexec jump. When
the new kernel enables chaches again, it randomly crashes.

Disabling L2 before calling cpu_proc_fin() cures the problem.

Disabling L2 requires the following new functions: flush_all(),
inv_all() and disable(). Add them to outer_cache_fns and call them
from the kexec code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/outercache.h |   24 ++++++++++++++++++++++++
 arch/arm/kernel/machine_kexec.c   |    3 +++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index 25f76ba..fc19009 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -25,6 +25,9 @@ struct outer_cache_fns {
 	void (*inv_range)(unsigned long, unsigned long);
 	void (*clean_range)(unsigned long, unsigned long);
 	void (*flush_range)(unsigned long, unsigned long);
+	void (*flush_all)(void);
+	void (*inv_all)(void);
+	void (*disable)(void);
 #ifdef CONFIG_OUTER_CACHE_SYNC
 	void (*sync)(void);
 #endif
@@ -50,6 +53,24 @@ static inline void outer_flush_range(unsigned long start, unsigned long end)
 		outer_cache.flush_range(start, end);
 }
 
+static inline void outer_flush_all(void)
+{
+	if (outer_cache.flush_all)
+		outer_cache.flush_all();
+}
+
+static inline void outer_inv_all(void)
+{
+	if (outer_cache.inv_all)
+		outer_cache.inv_all();
+}
+
+static inline void outer_disable(void)
+{
+	if (outer_cache.disable)
+		outer_cache.disable();
+}
+
 #else
 
 static inline void outer_inv_range(unsigned long start, unsigned long end)
@@ -58,6 +79,9 @@ static inline void outer_clean_range(unsigned long start, unsigned long end)
 { }
 static inline void outer_flush_range(unsigned long start, unsigned long end)
 { }
+static inline void outer_flush_all(void) { }
+static inline void outer_inv_all(void) { }
+static inline void outer_disable(void) { }
 
 #endif
 
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 1fc74cb..3a8fd51 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -78,7 +78,10 @@ void machine_kexec(struct kimage *image)
 	local_fiq_disable();
 	setup_mm_for_reboot(0); /* mode is not used, so just pass 0*/
 	flush_cache_all();
+	outer_flush_all();
+	outer_disable();
 	cpu_proc_fin();
+	outer_inv_all();
 	flush_cache_all();
 	cpu_reset(reboot_code_buffer_phys);
 }
-- 
1.6.0.4

