From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 11/14] PM / AVR32: Use struct syscore_ops instead of sysdevs
	for PM
Date: Sun, 17 Apr 2011 23:13:09 +0200
Message-ID: <201104172313.09712.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201104172301.54115.rjw@sisk.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Kevin Hilman <khilman@ti.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Russell King <linux@arm.linux.org.uk>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg KH <gregkh@suse.de>, Ralf Baechle <ralf@linux-mips.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Ben Dooks <ben-linux@fluff.org>, Jiri Kosina <jkosina@suse.cz>, Kay Sievers <kay.sievers@suse.de>, Mike Frysinger <vapier@gentoo.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Convert some AVR32 architecture's code to using struct syscore_ops
objects for power management instead of sysdev classes and sysdevs.

This simplifies the code and reduces the kernel's memory footprint.
It also is necessary for removing sysdevs from the kernel entirely in
the future.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/avr32/mach-at32ap/intc.c |   38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

Index: linux-2.6/arch/avr32/mach-at32ap/intc.c
===================================================================
--- linux-2.6.orig/arch/avr32/mach-at32ap/intc.c
+++ linux-2.6/arch/avr32/mach-at32ap/intc.c
@@ -12,7 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/io.h>
 
@@ -21,7 +21,6 @@
 struct intc {
 	void __iomem		*regs;
 	struct irq_chip		chip;
-	struct sys_device	sysdev;
 #ifdef CONFIG_PM
 	unsigned long		suspend_ipr;
 	unsigned long		saved_ipr[64];
@@ -146,9 +145,8 @@ void intc_set_suspend_handler(unsigned l
 	intc0.suspend_ipr = offset;
 }
 
-static int intc_suspend(struct sys_device *sdev, pm_message_t state)
+static int intc_suspend(void)
 {
-	struct intc *intc = container_of(sdev, struct intc, sysdev);
 	int i;
 
 	if (unlikely(!irqs_disabled())) {
@@ -156,28 +154,25 @@ static int intc_suspend(struct sys_devic
 		return -EINVAL;
 	}
 
-	if (unlikely(!intc->suspend_ipr)) {
+	if (unlikely(!intc0.suspend_ipr)) {
 		pr_err("intc_suspend: suspend_ipr not initialized\n");
 		return -EINVAL;
 	}
 
 	for (i = 0; i < 64; i++) {
-		intc->saved_ipr[i] = intc_readl(intc, INTPR0 + 4 * i);
-		intc_writel(intc, INTPR0 + 4 * i, intc->suspend_ipr);
+		intc0.saved_ipr[i] = intc_readl(&intc0, INTPR0 + 4 * i);
+		intc_writel(&intc0, INTPR0 + 4 * i, intc0.suspend_ipr);
 	}
 
 	return 0;
 }
 
-static int intc_resume(struct sys_device *sdev)
+static int intc_resume(void)
 {
-	struct intc *intc = container_of(sdev, struct intc, sysdev);
 	int i;
 
-	WARN_ON(!irqs_disabled());
-
 	for (i = 0; i < 64; i++)
-		intc_writel(intc, INTPR0 + 4 * i, intc->saved_ipr[i]);
+		intc_writel(&intc0, INTPR0 + 4 * i, intc0.saved_ipr[i]);
 
 	return 0;
 }
@@ -186,27 +181,18 @@ static int intc_resume(struct sys_device
 #define intc_resume	NULL
 #endif
 
-static struct sysdev_class intc_class = {
-	.name		= "intc",
+static struct syscore_ops intc_syscore_ops = {
 	.suspend	= intc_suspend,
 	.resume		= intc_resume,
 };
 
-static int __init intc_init_sysdev(void)
+static int __init intc_init_syscore(void)
 {
-	int ret;
-
-	ret = sysdev_class_register(&intc_class);
-	if (ret)
-		return ret;
+	register_syscore_ops(&intc_syscore_ops);
 
-	intc0.sysdev.id = 0;
-	intc0.sysdev.cls = &intc_class;
-	ret = sysdev_register(&intc0.sysdev);
-
-	return ret;
+	return 0;
 }
-device_initcall(intc_init_sysdev);
+device_initcall(intc_init_syscore);
 
 unsigned long intc_get_pending(unsigned int group)
 {
