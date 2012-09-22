From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP4+: wakeupgen: fix memory corruption
Date: Sat, 22 Sep 2012 08:11:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209220732400.23491@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35668 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754418Ab2IVIL0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Sep 2012 04:11:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, santosh.shilimkar@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Fix a memory corruption bug caused by commit
247c445c0fbd52c77e497ff5bfcf0dceb8afea8d ("ARM: OMAP5: Add the
WakeupGen IP updates") and commit
ec2c0825ca3183a646a24717966cc7752e8b0393 ("ARM: OMAP2+: Remove
hardcoded IRQs and enable SPARSE_IRQ").

The first commit, in the OMAP4+ wakeupgen code, has an implicit
dependency on !SPARSE_IRQ.  It allocates a static array with NR_IRQS
elements, then proceeds to iterate over 128 or 160 elements of
that array, clearing them to zero.

The second commit switched OMAP2+ to use sparse IRQs, but missed the
NR_IRQS reference in the wakeupgen code.  Before the second commit,
NR_IRQS was 474 on OMAP4430; but afterwards, it became 16.

This resulted in the wakeupgen code allocating a 16 element array, and
then attempting to write to 128 or 160 of those elements, depending on the
type of SoC.  This trashed a chunk of whatever was allocated after the
array.

The immediate manifestation was a set of boot warnings similar to the
following:

   WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1941 _enable+0x1bc/0x204()
   omap_hwmod: mpu: could not enable clockdomain mpuss_clkdm: -22
   ...

since it blew away arch_clkdm.  Ultimately the kernel crashed during boot.

Fix the problem in the OMAP4+ wakeupgen code by removing the reference to
NR_IRQS, allocating a larger array, and warning if the iteration is larger
than the array.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Applies on arm-soc omap/cleanup-sparseirq and should ideally be merged 
there before the 3.7 merge window.

Test logs are here:

   http://www.pwsan.com/omap/testlogs/broken_sparseirq_fix_3.7/20120922012656/

 arch/arm/mach-omap2/omap-wakeupgen.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index b54427d..869f16c 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -47,7 +47,7 @@
 static void __iomem *wakeupgen_base;
 static void __iomem *sar_base;
 static DEFINE_SPINLOCK(wakeupgen_lock);
-static unsigned int irq_target_cpu[NR_IRQS];
+static unsigned int irq_target_cpu[MAX_IRQS];
 static unsigned int irq_banks = MAX_NR_REG_BANKS;
 static unsigned int max_irqs = MAX_IRQS;
 static unsigned int omap_secure_apis;
@@ -446,6 +446,12 @@ int __init omap_wakeupgen_init(void)
 	 * GIC code has necessary hooks in place.
 	 */
 
+	/*
+	 * If you see this warning, then the subsequent loop just
+	 * corrupted some memory
+	 */
+	WARN_ON(max_irqs > ARRAY_SIZE(irq_target_cpu));
+
 	/* Associate all the IRQs to boot CPU like GIC init does. */
 	for (i = 0; i < max_irqs; i++)
 		irq_target_cpu[i] = boot_cpu;
-- 
1.7.10.4
