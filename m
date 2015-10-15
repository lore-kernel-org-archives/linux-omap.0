From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH v2 1/3] ARM: catch pending imprecise abort on unmask
Date: Thu, 15 Oct 2015 12:32:20 +0200
Message-ID: <1444905142-21500-2-git-send-email-l.stach@pengutronix.de>
References: <1444905142-21500-1-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444905142-21500-1-git-send-email-l.stach@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Hauke Mehrtens <hauke@hauke-m.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patchwork-lst@pengutronix.de
List-Id: linux-omap@vger.kernel.org

Install a non-faulting handler just before unmasking imprecise aborts
and switch back to the regular one after unmasking is done.

This catches any pending imprecise abort that the firmware/bootloader
may have left behind that would normally crash the kernel at that point.
As there are apparently a lot of bootlaoders out there that do such a
thing it makes sense to handle it in the common startup code.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2:
- move temporary fault handler swapping into fault.c to hide it from
  other parts of the kernel
- print FSR, when warning user about bad firmware/bootloader
---
 arch/arm/mm/fault.c | 22 ++++++++++++++++++++++
 arch/arm/mm/fault.h |  1 +
 arch/arm/mm/mmu.c   |  3 ++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 0d629b8f973f..daafcf121ce0 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -593,6 +593,28 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 	arm_notify_die("", regs, &info, ifsr, 0);
 }
 
+/*
+ * Abort handler to be used only during first unmasking of asynchronous aborts
+ * on the boot CPU. This makes sure that the machine will not die if the
+ * firmware/bootloader left an imprecise abort pending for us to trip over.
+ */
+static int __init early_abort_handler(unsigned long addr, unsigned int fsr,
+				      struct pt_regs *regs)
+{
+	pr_warn("Hit pending asynchronous external abort (FSR=0x%08x) during "
+		"first unmask, this is most likely caused by a "
+		"firmware/bootloader bug.\n", fsr);
+
+	return 0;
+}
+
+void __init early_abt_enable(void)
+{
+	fsr_info[22].fn = early_abort_handler;
+	local_abt_enable();
+	fsr_info[22].fn = do_bad;
+}
+
 #ifndef CONFIG_ARM_LPAE
 static int __init exceptions_init(void)
 {
diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
index cf08bdfbe0d6..05ec5e0df32d 100644
--- a/arch/arm/mm/fault.h
+++ b/arch/arm/mm/fault.h
@@ -24,5 +24,6 @@ static inline int fsr_fs(unsigned int fsr)
 
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs);
 unsigned long search_exception_table(unsigned long addr);
+void early_abt_enable(void);
 
 #endif	/* __ARCH_ARM_FAULT_H */
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f65a6f344b6d..4867f5daf82c 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -38,6 +38,7 @@
 #include <asm/mach/pci.h>
 #include <asm/fixmap.h>
 
+#include "fault.h"
 #include "mm.h"
 #include "tcm.h"
 
@@ -1365,7 +1366,7 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
 	flush_cache_all();
 
 	/* Enable asynchronous aborts */
-	local_abt_enable();
+	early_abt_enable();
 }
 
 static void __init kmap_init(void)
-- 
2.6.1
