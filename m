From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Fri, 4 Feb 2011 11:30:53 +0000
Message-ID: <20110204113053.GF15004@n2100.arm.linux.org.uk>
References: <20110125114635.GB13300@n2100.arm.linux.org.uk> <236d45e400a960cc3b32db538b3a79ae@mail.gmail.com> <20110125121655.GD13300@n2100.arm.linux.org.uk> <4534e82bf14eeea9f96769df760df5ae@mail.gmail.com> <20110125125656.GG13300@n2100.arm.linux.org.uk> <20110125130422.GH13300@n2100.arm.linux.org.uk> <20110125130611.GA15663@n2100.arm.linux.org.uk> <627ff975140c8e4afbad281105b29d35@mail.gmail.com> <20110204104113.GD15004@n2100.arm.linux.org.uk> <c703383234131695d040a1e5b8a79413@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42920 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975Ab1BDLbO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 06:31:14 -0500
Content-Disposition: inline
In-Reply-To: <c703383234131695d040a1e5b8a79413@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ccross@android.com

On Fri, Feb 04, 2011 at 04:16:07PM +0530, Santosh Shilimkar wrote:
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Sent: Friday, February 04, 2011 4:11 PM
> > To: Santosh Shilimkar
> > Cc: catalin.marinas@arm.com; linus.ml.walleij@gmail.com; linux-
> > omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > ccross@android.com
> > Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header
> > file
> >
> > On Tue, Jan 25, 2011 at 11:53:35PM +0530, Santosh Shilimkar wrote:
> > > After fixing the 3rd version for base address break, I was able to
> > > use this patch and test it. Seems to work. SMC related stuff can
> > > be ignored because OMAP4 ES1.0 doesn't have functional PM hardware
> > > support.
> >
> > I think I'd prefer to do as the other functions do, and pass in the
> > scu base address from the platform code.  It's potentially more
> > efficient for platforms which have a fixed SCU base address.
> Ok. I can fix that

8<------
Subject: [PATCH] ARM: smp: add function to set WFI low-power mode for SMP CPUs

Add a function to set the SCU low-power mode for SMP CPUs.  This
centralizes this functionality rather than having to expose the
SCU register definitions to each platform.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/smp_scu.h |    5 +++++
 arch/arm/kernel/smp_scu.c      |   24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index 2376835..800860d 100644
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
+int scu_power_mode(void __iomem *, unsigned int);
 
 #endif
diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 9ab4149..0ba329a 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -50,3 +50,27 @@ void __init scu_enable(void __iomem *scu_base)
 	 */
 	flush_cache_all();
 }
+
+/*
+ * Set the executing CPUs power mode as defined.  This will be in
+ * preparation for it executing a WFI instruction.
+ *
+ * This function must be called with preemption disabled, and as it
+ * has the side effect of disabling coherency, caches must have been
+ * flushed.  Interrupts must also have been disabled.
+ */
+int scu_power_mode(void __iomem *scu_base, unsigned int mode)
+{
+	unsigned int val;
+	int cpu = smp_processor_id();
+	int shift;
+
+	if (mode > 3 || mode == 1 || cpu > 3)
+		return -EINVAL;
+
+	val = __raw_readb(scu_base + SCU_CPU_STATUS + cpu) & ~0x03;
+	val |= mode;
+	__raw_writeb(val, scu_base + SCU_CPU_STATUS + cpu);
+
+	return 0;
+}
-- 
1.6.2.5

