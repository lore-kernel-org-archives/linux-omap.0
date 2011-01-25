From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Tue, 25 Jan 2011 13:06:11 +0000
Message-ID: <20110125130611.GA15663@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com> <1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com> <20110125114635.GB13300@n2100.arm.linux.org.uk> <236d45e400a960cc3b32db538b3a79ae@mail.gmail.com> <20110125121655.GD13300@n2100.arm.linux.org.uk> <4534e82bf14eeea9f96769df760df5ae@mail.gmail.com> <20110125125656.GG13300@n2100.arm.linux.org.uk> <20110125130422.GH13300@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42693 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045Ab1AYNG0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 08:06:26 -0500
Content-Disposition: inline
In-Reply-To: <20110125130422.GH13300@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ccross@android.com

On Tue, Jan 25, 2011 at 01:04:22PM +0000, Russell King - ARM Linux wrote:
> Actually, we can do this safely - byte stores are permitted to SCU
> registers probably for this very reason.

3rd revision of the patch:

 arch/arm/include/asm/smp_scu.h |    5 +++++
 arch/arm/kernel/smp_scu.c      |   16 ++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

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
index 9ab4149..c956984 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -50,3 +50,19 @@ void __init scu_enable(void __iomem *scu_base)
 	 */
 	flush_cache_all();
 }
+
+int scu_power_mode(unsigned int mode)
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

