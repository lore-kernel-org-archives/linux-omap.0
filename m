From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Tue, 25 Jan 2011 12:29:24 +0000
Message-ID: <20110125122924.GF13300@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com> <1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com> <20110125114635.GB13300@n2100.arm.linux.org.uk> <236d45e400a960cc3b32db538b3a79ae@mail.gmail.com> <20110125121655.GD13300@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56058 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab1AYM3k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 07:29:40 -0500
Content-Disposition: inline
In-Reply-To: <20110125121655.GD13300@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ccross@android.com

On Tue, Jan 25, 2011 at 12:16:56PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 25, 2011 at 05:32:57PM +0530, Santosh Shilimkar wrote:
> > I have similar patch implemented but what it does is just
> > prepares the value to be programmed and stores it to a scratchpad.
> > I see your point but below patch may now work well. The reason is the SCU
> > register needs to accessed at the lowest level. May be even when
> > stack is not available. Also this register needs to be cleared in cases
> > where the attempted power state is failed for some reason.
> 
> >From the documentation I have, the power control register has no effect
> until the CPU enters WFI mode - which means that provided we can
> guarantee no one issues a WFI instruction between setting the power mode,
> and executing that instruction, being woken up (or failing) and resetting
> the power mode back... that shouldn't require the power mode to be
> programmed from assembly code.
> 
> In any case, we actually need the help of spinlocks to deal with
> concurrent access to the SCU power control register - something you
> can't do in assembly code.
> 
> On the way down to a WFI low power mode, we can call scu_power_mode(),
> do the rest of the cleanup (which must not schedule) and issue WFI.  On
> the way back up, do whatever needs to be done and call scu_power_mode()
> to reset back to 'normal' mode.
> 
> > Also note that this register can be blocked using trust-zone which
> > again makes it platform dependent because direct write won't be
> > allowed in that case.
> 
> Yes, I did notice.  What's the OMAP SMC interface for that?
> 
> > I would prefer the header export if there is no major
> > objection since there is already a possibility of custom
> > implementation with trust zone.
> > 
> > On OMAP4, on ES1.0 we need to use a secure API to achieve
> > this where as on ES2.0, it can be directly accessed.
> 
> As I say, I'd rather not have each SoC implementing access to this as
> someone's bound to forget the spinlock if they're dealing with more than
> one CPU, which'll make stuff unreliable (just like I did on my initial
> version.)
> 
> We could have a callback to SoC code which does the appropriate SMC call,
> but first I'll need to know what's required for the SMC call.

I did mean to include the updated patch:

 arch/arm/include/asm/smp_scu.h |    5 +++++
 arch/arm/kernel/smp_scu.c      |   23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index 2376835..108f31d 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -1,7 +1,12 @@
 #ifndef __ASMARM_ARCH_SCU_H
 #define __ASMARM_ARCH_SCU_H
 
+#define SCU_PM_NORMAL	0
+#define SCU_PM_DORMANT	2
+#define SCU_PM_POWEROFF	3
+
 unsigned int scu_get_core_count(void __iomem *);
 void scu_enable(void __iomem *);
+int scu_power_mode(unsigned int);
 
 #endif
diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 9ab4149..4c4c90d 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -10,6 +10,7 @@
  */
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/spinlock.h>
 
 #include <asm/smp_scu.h>
 #include <asm/cacheflush.h>
@@ -20,6 +21,8 @@
 #define SCU_INVALIDATE		0x0c
 #define SCU_FPGA_REVISION	0x10
 
+static DEFINE_SPINLOCK(scu_power_lock);
+
 /*
  * Get the number of CPU cores from the SCU configuration
  */
@@ -50,3 +53,23 @@ void __init scu_enable(void __iomem *scu_base)
 	 */
 	flush_cache_all();
 }
+
+int scu_power_mode(unsigned int mode)
+{
+	int cpu = smp_processor_id();
+	int shift;
+	u32 val;
+
+	if (mode > 3 || mode == 1 || cpu > 3)
+		return -EINVAL;
+
+	shift = cpu * 8;
+
+	spin_lock(&scu_power_lock);
+	val = raw_readl(scu_base + SCU_CPU_STATUS) & ~(0x03 << shift);
+	val |= mode << shift;
+	__raw_writel(val, scu_base + SCU_CPU_STATUS);
+	spin_unlock(&scu_power_lock);
+
+	return 0;
+}

If we need a SMC call, that should happen within the spinlock'd region via
a function pointer which the platform can set.  I can't code that into this
patch until I know what the SMC call requires as arguments (cpu number,
power state, or new register value, or mask and bits to set?)
