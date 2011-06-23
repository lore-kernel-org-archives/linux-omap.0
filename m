From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 25/25] ARM: pm: ensure our temporary page table entry is
 removed from the TLB
Date: Thu, 23 Jun 2011 20:17:28 +0100
Message-ID: <E1QZpP6-0005o1-WB@rmk-PC.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Ensure that our temporary page table entry is flushed from the TLB
before we resume normal operations.  This ensures that userspace
won't trip over the stale TLB entry.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/suspend.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
index 8d5b446..f8db9d0 100644
--- a/arch/arm/include/asm/suspend.h
+++ b/arch/arm/include/asm/suspend.h
@@ -2,6 +2,7 @@
 #define __ASM_ARM_SUSPEND_H
 
 #include <asm/memory.h>
+#include <asm/tlbflush.h>
 
 extern void cpu_resume(void);
 
@@ -14,6 +15,7 @@ static inline void cpu_suspend(unsigned long arg, void (*fn)(unsigned long))
 	extern void __cpu_suspend(int, long, unsigned long,
 				  void (*)(unsigned long));
 	__cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, arg, fn);
+	flush_tlb_all();
 }
 
 #endif
-- 
1.7.4.4
