From: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Subject: [PATCH] 	Support for OMAP3 SDTI (Serial Debug Trace Interface).
Date: Tue, 25 Mar 2008 15:47:38 +0200
Message-ID: <1206452858-29570-1-git-send-email-roman.tereshonkov@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26388 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788AbYCYNrp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Mar 2008 09:47:45 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2PDlGgT022417
	for <linux-omap@vger.kernel.org>; Tue, 25 Mar 2008 15:47:42 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Roman Tereshonkov <roman.tereshonkov@nokia.com>


Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
---
 drivers/misc/Kconfig            |    9 +-
 drivers/misc/sti/Makefile       |    8 +-
 drivers/misc/sti/sdti.c         |  208 +++++++++++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/sti.h |   21 +++-
 4 files changed, 236 insertions(+), 10 deletions(-)
 create mode 100644 drivers/misc/sti/sdti.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 12bbe69..e2e327f 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -319,9 +319,12 @@ config INTEL_MENLOW
 	  If unsure, say N.
 
 config OMAP_STI
-	bool "STI/XTI support"
-	depends on ARCH_OMAP16XX || ARCH_OMAP24XX
-	default n
+        bool "Serial Trace Interface support"
+        depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX
+        default n
+        help
+          Serial Trace Interface. The protocols suported for OMAP1/2/3 are
+          STI/CSTI/XTIv2 correspondingly.
 
 config OMAP_STI_CONSOLE
 	bool "STI console support"
diff --git a/drivers/misc/sti/Makefile b/drivers/misc/sti/Makefile
index 6ad9bb3..aee30bd 100644
--- a/drivers/misc/sti/Makefile
+++ b/drivers/misc/sti/Makefile
@@ -1,4 +1,8 @@
-obj-y += sti.o sti-fifo.o
+ifeq ($(CONFIG_ARCH_OMAP3),y)
+obj-$(CONFIG_OMAP_STI)	+= sdti.o
+else
+obj-$(CONFIG_OMAP_STI)	+= sti.o sti-fifo.o
+obj-$(CONFIG_NET)	+= sti-netlink.o
+endif
 
 obj-$(CONFIG_OMAP_STI_CONSOLE)	+= sti-console.o
-obj-$(CONFIG_NET)		+= sti-netlink.o
diff --git a/drivers/misc/sti/sdti.c b/drivers/misc/sti/sdti.c
new file mode 100644
index 0000000..3d651cc
--- /dev/null
+++ b/drivers/misc/sti/sdti.c
@@ -0,0 +1,208 @@
+/*
+ * Support functions for OMAP3 SDTI (Serial Debug Tracing Interface)
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Written by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <asm/arch/sti.h>
+#include <asm/byteorder.h>
+#include <asm/io.h>
+
+#define SDTI_REVISION		0x000
+#define SDTI_SYSCONFIG		0x010
+#define SDTI_SYSSTATUS		0x014
+#define SDTI_WINCTRL		0x024
+#define SDTI_SCONFIG		0x028
+#define SDTI_TESTCTRL		0x02C
+#define SDTI_LOCK_ACCESS	0xFB0
+
+#define CPU1_TRACE_EN		0x01
+#define CPU2_TRACE_EN		0x02
+
+#define EPM_BASE		0x5401D000
+#define EPM_CONTROL_0		0x50
+#define EPM_CONTROL_1		0x54
+#define EPM_CONTROL_2		0x58
+
+static struct clk *sdti_ck;
+unsigned long sti_base, sti_channel_base, epm_base;
+static DEFINE_SPINLOCK(sdti_lock);
+
+void omap_sti_channel_write_trace(int len, int id, void *data,
+				unsigned int channel)
+{
+	const u8 *tpntr = data;
+
+	spin_lock_irq(&sdti_lock);
+
+	sti_channel_writeb(id, channel);
+	while (len--)
+		sti_channel_writeb(*tpntr++, channel);
+	sti_channel_flush(channel);
+
+	spin_unlock_irq(&sdti_lock);
+}
+EXPORT_SYMBOL(omap_sti_channel_write_trace);
+
+static void omap_sdti_reset(void)
+{
+	int i;
+
+	sti_writel(0x02, SDTI_SYSCONFIG);
+
+	for (i = 0; i < 10000; i++)
+		if (sti_readl(SDTI_SYSSTATUS) & 1)
+			break;
+	if (i == 10000)
+		printk(KERN_WARNING "XTI: no real reset\n");
+}
+
+void init_epm(void)
+{
+	epm_base = (unsigned long)ioremap(EPM_BASE, 256);
+	if (unlikely(!epm_base)) {
+		printk(KERN_ERR "EPM cannot be ioremapped\n");
+		return;
+	}
+
+	__raw_writel(1<<30, epm_base + EPM_CONTROL_2);
+	__raw_writel(0x78, epm_base + EPM_CONTROL_0);
+	__raw_writel(0x80000000, epm_base + EPM_CONTROL_1);
+	__raw_writel(1<<31 | 0x00007770, epm_base + EPM_CONTROL_2);
+}
+
+static int __init omap_sdti_init(void)
+{
+	char buf[64];
+	int i;
+
+	sdti_ck = clk_get(NULL, "emu_per_alwon_ck");
+	if (IS_ERR(sdti_ck)) {
+		printk(KERN_ERR "Cannot get clk emu_per_alwon_ck\n");
+		return PTR_ERR(sdti_ck);
+	}
+	clk_enable(sdti_ck);
+
+	/* Init emulation pin manager */
+	init_epm();
+
+	omap_sdti_reset();
+	sti_writel(0xC5ACCE55, SDTI_LOCK_ACCESS);
+
+	/* Claim SDTI */
+	sti_writel(1 << 30, SDTI_WINCTRL);
+	i = sti_readl(SDTI_WINCTRL);
+	if (!(i & (1 << 30)))
+		printk(KERN_WARNING "SDTI: cannot claim SDTI\n");
+
+	/* 4 bits dual, fclk/3 */
+	sti_writel(0x43, SDTI_SCONFIG);
+
+	/* CPU1 trace enable */
+	sti_writel(i | CPU2_TRACE_EN, SDTI_WINCTRL);
+	i = sti_readl(SDTI_WINCTRL);
+
+	/* Enable SDTI */
+	sti_writel((1 << 31) | (i & 0x3FFFFFFF), SDTI_WINCTRL);
+
+	i = sti_readl(SDTI_REVISION);
+	snprintf(buf, sizeof(buf), "OMAP SDTI support loaded (HW v%u.%u)\n",
+		(i >> 4) & 0x0f, i & 0x0f);
+	printk(KERN_INFO, "%s", buf);
+	omap_sti_channel_write_trace(strlen(buf), 0xc3, buf, 239);
+
+	return 0;
+}
+
+static void omap_sdti_exit(void)
+{
+	sti_writel(0, SDTI_WINCTRL);
+	clk_disable(sdti_ck);
+	clk_put(sdti_ck);
+}
+
+static int __devinit omap_sdti_probe(struct platform_device *pdev)
+{
+	struct resource *res, *cres;
+	unsigned int size;
+
+	if (pdev->num_resources != 2) {
+		dev_err(&pdev->dev, "invalid number of resources: %d\n",
+			pdev->num_resources);
+		return -ENODEV;
+	}
+
+	/* SDTI base */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (unlikely(!res)) {
+		dev_err(&pdev->dev, "invalid mem resource\n");
+		return -ENODEV;
+	}
+
+	/* Channel base */
+	cres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (unlikely(!cres)) {
+		dev_err(&pdev->dev, "invalid channel mem resource\n");
+		return -ENODEV;
+	}
+
+	size = res->end - res->start;
+	sti_base = (unsigned long)ioremap(res->start, size);
+	if (unlikely(!sti_base))
+		return -ENODEV;
+
+	size = cres->end - cres->start;
+	sti_channel_base = (unsigned long)ioremap(cres->start, size);
+	if (unlikely(!sti_channel_base)) {
+		iounmap((void *)sti_base);
+		return -ENODEV;
+	}
+
+	return omap_sdti_init();
+}
+
+static int __devexit omap_sdti_remove(struct platform_device *pdev)
+{
+	iounmap((void *)sti_channel_base);
+	iounmap((void *)sti_base);
+	iounmap((void *)epm_base);
+	omap_sdti_exit();
+
+	return 0;
+}
+
+static struct platform_driver omap_sdti_driver = {
+	.probe		= omap_sdti_probe,
+	.remove		= __devexit_p(omap_sdti_remove),
+	.driver		= {
+		.name	= "sti",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init omap_sdti_module_init(void)
+{
+	return platform_driver_register(&omap_sdti_driver);
+}
+
+static void __exit omap_sdti_module_exit(void)
+{
+	platform_driver_unregister(&omap_sdti_driver);
+}
+subsys_initcall(omap_sdti_module_init);
+module_exit(omap_sdti_module_exit);
+
+MODULE_AUTHOR("Roman Tereshonkov");
+MODULE_LICENSE("GPL");
diff --git a/include/asm-arm/arch-omap/sti.h b/include/asm-arm/arch-omap/sti.h
index e5a383d..d818dc6 100644
--- a/include/asm-arm/arch-omap/sti.h
+++ b/include/asm-arm/arch-omap/sti.h
@@ -4,7 +4,7 @@
 #include <asm/io.h>
 
 /*
- * STI/XTI
+ * STI/SDTI
  */
 #define STI_REVISION		0x00
 #define STI_SYSCONFIG		0x10
@@ -38,7 +38,6 @@
 #define STI_NR_IRQS	10
 
 #define STI_IRQSTATUS_MASK	0x2ff
-#define STI_PERCHANNEL_SIZE	4
 
 #define STI_RXFIFO_EMPTY	(1 << 0)
 
@@ -64,6 +63,12 @@ enum {
 	MemDumpEn	= (1 << 14), /* System memory dump */
 	STIEn		= (1 << 15), /* Global trace enable */
 };
+
+#define STI_PERCHANNEL_SIZE	4
+
+#define to_channel_address(channel) \
+	(sti_channel_base + STI_PERCHANNEL_SIZE * (channel))
+
 #elif defined(CONFIG_ARCH_OMAP2)
 
 /* XTI interrupt bits */
@@ -110,6 +115,15 @@ enum {
 
 #define STI_RXFIFO_EMPTY	(1 << 8)
 
+#define to_channel_address(channel) \
+	(sti_channel_base + STI_PERCHANNEL_SIZE * (channel))
+
+#elif defined(CONFIG_ARCH_OMAP3)
+
+#define STI_PERCHANNEL_SIZE	0x1000
+#define to_channel_address(channel) \
+	(sti_channel_base + STI_PERCHANNEL_SIZE * (channel) + 0x800)
+
 #endif
 
 /* arch/arm/plat-omap/sti/sti.c */
@@ -139,9 +153,6 @@ static inline void sti_writel(unsigned long data, unsigned long reg)
 	__raw_writel(data, sti_base + reg);
 }
 
-#define to_channel_address(channel) \
-	(sti_channel_base + STI_PERCHANNEL_SIZE * (channel))
-
 static inline void sti_channel_writeb(unsigned char data, unsigned int channel)
 {
 	__raw_writeb(data, to_channel_address(channel));
-- 
1.5.3.7

