From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Tue, 25 Jan 2011 11:46:35 +0000
Message-ID: <20110125114635.GB13300@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com> <1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51360 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894Ab1AYLrJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 06:47:09 -0500
Content-Disposition: inline
In-Reply-To: <1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, ccross@android.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org

On Mon, Jan 24, 2011 at 02:21:18PM +0530, Santosh Shilimkar wrote:
> This patch moves SCU register defines from smp_scu.c to smp_scu.h
> so that its available for platforms to use
> 
> The SCU CPU power status registers is used for power management
> on OMAP4.

Could we instead have an API inside smp_scu.c rather than having each
SoC implement its own SCU PM stuff?

Maybe this.  Note that scu_power_mode() needs to be called from a non-
preemptible context, which is sane as we don't want to be rescheduled
onto a different CPU between scu_power_mode() and the wfi/wfe required
to enter the selected mode.

 arch/arm/include/asm/smp_scu.h |    5 +++++
 arch/arm/kernel/smp_scu.c      |   11 +++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index 2376835..ec11a92 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -1,7 +1,12 @@
 #ifndef __ASMARM_ARCH_SCU_H
 #define __ASMARM_ARCH_SCU_H
 
+#define	SCU_PM_NORMAL	0
+#define SCU_PM_DORMANT	2
+#define SCU_PM_POWEROFF	3
+
 unsigned int scu_get_core_count(void __iomem *);
 void scu_enable(void __iomem *);
+int scu_power_mode(unsigned int);
 
 #endif
diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 9ab4149..bbb9b1c 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -50,3 +50,14 @@ void __init scu_enable(void __iomem *scu_base)
 	 */
 	flush_cache_all();
 }
+
+int scu_power_mode(unsigned int mode)
+{
+	int cpu = smp_processor_id();
+
+	if (mode > 3 || mode == 1 || cpu > 3)
+		return -EINVAL;
+
+	__raw_writel(mode << (8 * cpu), scu_base + SCU_CPU_STATUS);
+	return 0;
+}

