From: Alexander Shishkin <virtuoso@slind.org>
Subject: [PATCH v1 1/2] arm: a driver for on-chip ETM and ETB
Date: Sun, 11 Oct 2009 19:41:25 +0300
Message-ID: <1255279286-8904-1-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Alexander Shishkin <virtuoso@slind.org>, Juha Leppanen <juha_motorsportcom@luukku.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This driver implements support for on-chip Embedded Tracing Macrocell and
Embedded Trace Buffer. It allows to trigger tracing of kernel execution flow
and exporting trace output to userspace via character device and a sysrq
combo.

Trace output can then be decoded by a fairly simple open source tool [1]
which is already sufficient to get the idea of what the kernel is doing.

[1]: http://github.com/virtuoso/etm2human

Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
Signed-off-by: "Juha Leppanen" <juha_motorsportcom@luukku.com>
---
Changes:
v1 -- fixed comments from Juha Leppanen
v0 -- initial implementation, has been sent to linux-omap only

 arch/arm/Kconfig.debug                    |    8 +
 arch/arm/include/asm/hardware/coresight.h |  164 ++++++++
 arch/arm/kernel/Makefile                  |    2 +
 arch/arm/kernel/etm.c                     |  588 +++++++++++++++++++++++++++++
 4 files changed, 762 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/hardware/coresight.h
 create mode 100644 arch/arm/kernel/etm.c

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 1a6f70e..ac83c03 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -83,6 +83,14 @@ config DEBUG_ICEDCC
 	  It does include a timeout to ensure that the system does not
 	  totally freeze when there is nothing connected to read.
 
+config OC_ETM
+	tristate "On-chip ETM and ETB"
+	depends on ARCH_OMAP3
+	help
+	  Enables the on-chip embedded trace macrocell and embedded trace
+	  buffer driver that will allow you to collect traces of the
+	  kernel code.
+
 config DEBUG_DC21285_PORT
 	bool "Kernel low-level debugging messages via footbridge serial port"
 	depends on DEBUG_LL && FOOTBRIDGE
diff --git a/arch/arm/include/asm/hardware/coresight.h b/arch/arm/include/asm/hardware/coresight.h
new file mode 100644
index 0000000..ba22df9
--- /dev/null
+++ b/arch/arm/include/asm/hardware/coresight.h
@@ -0,0 +1,164 @@
+/*
+ * linux/arch/arm/include/asm/hardware/coresight.h
+ *
+ * CoreSight components' registers
+ *
+ * Copyright (C) 2009 Nokia Corporation.
+ * Alexander Shishkin
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_HARDWARE_CORESIGHT_H
+#define __ASM_HARDWARE_CORESIGHT_H
+
+#define TRACER_ACCESSED_BIT	0
+#define TRACER_RUNNING_BIT	1
+#define TRACER_CYCLE_ACC_BIT	2
+#define TRACER_ACCESSED		BIT(TRACER_ACCESSED_BIT)
+#define TRACER_RUNNING		BIT(TRACER_RUNNING_BIT)
+#define TRACER_CYCLE_ACC	BIT(TRACER_CYCLE_ACC_BIT)
+
+struct tracectx {
+	unsigned int etb_bufsz;
+	void __iomem *etb_regs;
+	void __iomem *etm_regs;
+	unsigned long flags;
+	int ncmppairs;
+	int etm_portsz;
+	struct device *dev;
+	struct mutex mutex;
+};
+
+#define TRACER_TIMEOUT 10000
+
+#define etm_writel(t, v, x) \
+	(__raw_writel((v), (t)->etm_regs + (x)))
+#define etm_readl(t, x) (__raw_readl((t)->etm_regs + (x)))
+
+/* CoreSight Management Registers */
+#define CSMR_LOCKACCESS 0xfb0
+#define CSMR_LOCKSTATUS 0xfb4
+#define CSMR_AUTHSTATUS 0xfb8
+#define CSMR_DEVID	0xfc8
+#define CSMR_DEVTYPE	0xfcc
+/* CoreSight Component Registers */
+#define CSCR_CLASS	0xff4
+
+#define CSCR_PRSR	0x314
+
+#define UNLOCK_MAGIC	0xc5acce55
+
+/* ETM control register, "ETM Architecture", 3.3.1 */
+#define ETMR_CTRL		0
+#define ETMCTRL_POWERDOWN	1
+#define ETMCTRL_PROGRAM		(1 << 10)
+#define ETMCTRL_PORTSEL		(1 << 11)
+#define ETMCTRL_DO_CONTEXTID	(3 << 14)
+#define ETMCTRL_PORTMASK1	(7 << 4)
+#define ETMCTRL_PORTMASK2	(1 << 21)
+#define ETMCTRL_PORTMASK	(ETMCTRL_PORTMASK1 | ETMCTRL_PORTMASK2)
+#define ETMCTRL_PORTSIZE(x) ((((x) & 7) << 4) | (!!((x) & 8)) << 21)
+#define ETMCTRL_DO_CPRT		(1 << 1)
+#define ETMCTRL_DATAMASK	(3 << 2)
+#define ETMCTRL_DATA_DO_DATA	(1 << 2)
+#define ETMCTRL_DATA_DO_ADDR	(1 << 3)
+#define ETMCTRL_DATA_DO_BOTH	(ETMCTRL_DATA_DO_DATA | ETMCTRL_DATA_DO_ADDR)
+#define ETMCTRL_BRANCH_OUTPUT	(1 << 8)
+#define ETMCTRL_CYCLEACCURATE	(1 << 12)
+
+/* ETM configuration code register */
+#define ETMR_CONFCODE		(0x04)
+
+/* ETM trace start/stop resource control register */
+#define ETMR_TRACESSCTRL	(0x18)
+
+/* ETM trigger event register */
+#define ETMR_TRIGEVT		(0x08)
+
+/* address access type register bits, "ETM architecture",
+ * table 3-27 */
+/* - access type */
+#define ETMAAT_IFETCH		0
+#define ETMAAT_IEXEC		1
+#define ETMAAT_IEXECPASS	2
+#define ETMAAT_IEXECFAIL	3
+#define ETMAAT_DLOADSTORE	4
+#define ETMAAT_DLOAD		5
+#define ETMAAT_DSTORE		6
+/* - comparison access size */
+#define ETMAAT_JAVA		(0 << 3)
+#define ETMAAT_THUMB		(1 << 3)
+#define ETMAAT_ARM		(3 << 3)
+/* - data value comparison control */
+#define ETMAAT_NOVALCMP		(0 << 5)
+#define ETMAAT_VALMATCH		(1 << 5)
+#define ETMAAT_VALNOMATCH	(3 << 5)
+/* - exact match */
+#define ETMAAT_EXACTMATCH	(1 << 7)
+/* - context id comparator control */
+#define ETMAAT_IGNCONTEXTID	(0 << 8)
+#define ETMAAT_VALUE1		(1 << 8)
+#define ETMAAT_VALUE2		(2 << 8)
+#define ETMAAT_VALUE3		(3 << 8)
+/* - security level control */
+#define ETMAAT_IGNSECURITY	(0 << 10)
+#define ETMAAT_NSONLY		(1 << 10)
+#define ETMAAT_SONLY		(2 << 10)
+
+#define ETMR_COMP_VAL(x)	(0x40 + (x) * 4)
+#define ETMR_COMP_ACC_TYPE(x)	(0x80 + (x) * 4)
+
+/* ETM status register, "ETM Architecture", 3.3.2 */
+#define ETMR_STATUS		(0x10)
+#define ETMST_OVERFLOW		(1 << 0)
+#define ETMST_PROGBIT		(1 << 1)
+#define ETMST_STARTSTOP		(1 << 2)
+#define ETMST_TRIGGER		(1 << 3)
+
+#define etm_progbit(t)		(etm_readl((t), ETMR_STATUS) & ETMST_PROGBIT)
+#define etm_started(t)		(etm_readl((t), ETMR_STATUS) & ETMST_STARTSTOP)
+#define etm_triggered(t)	(etm_readl((t), ETMR_STATUS) & ETMST_TRIGGER)
+
+#define ETMR_TRACEENCTRL2	0x1c
+#define ETMR_TRACEENCTRL	0x24
+#define ETMTE_INCLEXCL		(1 << 24)
+#define ETMR_TRACEENEVT		0x20
+#define ETMCTRL_OPTS		(ETMCTRL_DO_CPRT | \
+				ETMCTRL_DATA_DO_ADDR | \
+				ETMCTRL_BRANCH_OUTPUT | \
+				ETMCTRL_DO_CONTEXTID)
+
+/* ETB registers, "CoreSight Components TRM", 9.3 */
+#define ETBR_DEPTH		0x04
+#define ETBR_STATUS		0x0c
+#define ETBR_READMEM		0x10
+#define ETBR_READADDR		0x14
+#define ETBR_WRITEADDR		0x18
+#define ETBR_TRIGGERCOUNT	0x1c
+#define ETBR_CTRL		0x20
+#define ETBR_FORMATTERCTRL	0x304
+#define ETBFF_ENFTC		1
+#define ETBFF_ENFCONT		(1 << 1)
+#define ETBFF_FONFLIN		(1 << 4)
+#define ETBFF_MANUAL_FLUSH	(1 << 6)
+#define ETBFF_TRIGIN		(1 << 8)
+#define ETBFF_TRIGEVT		(1 << 9)
+#define ETBFF_TRIGFL		(1 << 10)
+
+#define etb_writel(t, v, x) \
+	(__raw_writel((v), (t)->etb_regs + (x)))
+#define etb_readl(t, x) (__raw_readl((t)->etb_regs + (x)))
+
+#define etm_lock(t) do { etm_writel((t), 0, CSMR_LOCKACCESS); } while (0)
+#define etm_unlock(t) \
+	do { etm_writel((t), UNLOCK_MAGIC, CSMR_LOCKACCESS); } while (0)
+
+#define etb_lock(t) do { etb_writel((t), 0, CSMR_LOCKACCESS); } while (0)
+#define etb_unlock(t) \
+	do { etb_writel((t), UNLOCK_MAGIC, CSMR_LOCKACCESS); } while (0)
+
+#endif /* __ASM_HARDWARE_CORESIGHT_H */
+
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 79087dd..e7ccf7e 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -17,6 +17,8 @@ obj-y		:= compat.o elf.o entry-armv.o entry-common.o irq.o \
 		   process.o ptrace.o return_address.o setup.o signal.o \
 		   sys_arm.o stacktrace.o time.o traps.o
 
+obj-$(CONFIG_OC_ETM)		+= etm.o
+
 obj-$(CONFIG_ISA_DMA_API)	+= dma.o
 obj-$(CONFIG_ARCH_ACORN)	+= ecard.o 
 obj-$(CONFIG_FIQ)		+= fiq.o
diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
new file mode 100644
index 0000000..3e7b431
--- /dev/null
+++ b/arch/arm/kernel/etm.c
@@ -0,0 +1,588 @@
+/*
+ * linux/arch/arm/kernel/etm.c
+ *
+ * Driver for ARM's Embedded Trace Macrocell and Embedded Trace Buffer.
+ *
+ * Copyright (C) 2009 Nokia Corporation.
+ * Alexander Shishkin
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/sysrq.h>
+#include <linux/platform_device.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/miscdevice.h>
+#include <linux/vmalloc.h>
+#include <linux/mutex.h>
+#include <asm/hardware/coresight.h>
+#include <asm/sections.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alexander Shishkin");
+
+static struct tracectx tracer;
+
+static inline bool trace_isrunning(struct tracectx *t)
+{
+	return !!(t->flags & TRACER_RUNNING);
+}
+
+static int etm_setup_address_range(struct tracectx *t, int n,
+		unsigned long start, unsigned long end, int exclude, int data)
+{
+	u32 flags = ETMAAT_ARM | ETMAAT_IGNCONTEXTID | ETMAAT_NSONLY | \
+		    ETMAAT_NOVALCMP;
+
+	if (n < 1 || n > t->ncmppairs)
+		return -EINVAL;
+
+	/* comparators and ranges are numbered starting with 1 as opposed
+	 * to bits in a word */
+	n--;
+
+	if (data)
+		flags |= ETMAAT_DLOADSTORE;
+	else
+		flags |= ETMAAT_IEXEC;
+
+	/* first comparator for the range */
+	etm_writel(t, flags, ETMR_COMP_ACC_TYPE(n * 2));
+	etm_writel(t, start, ETMR_COMP_VAL(n * 2));
+
+	/* second comparator is right next to it */
+	etm_writel(t, flags, ETMR_COMP_ACC_TYPE(n * 2 + 1));
+	etm_writel(t, end, ETMR_COMP_VAL(n * 2 + 1));
+
+	flags = exclude ? ETMTE_INCLEXCL : 0;
+	etm_writel(t, flags | (1 << n), ETMR_TRACEENCTRL);
+
+	return 0;
+}
+
+static int trace_start(struct tracectx *t)
+{
+	u32 v;
+	unsigned long timeout = TRACER_TIMEOUT;
+
+	etb_unlock(t);
+
+	etb_writel(t, 0, ETBR_FORMATTERCTRL);
+	etb_writel(t, 1, ETBR_CTRL);
+
+	etb_lock(t);
+
+	/* configure etm */
+	v = ETMCTRL_OPTS | ETMCTRL_PROGRAM | ETMCTRL_PORTSIZE(t->etm_portsz);
+
+	if (t->flags & TRACER_CYCLE_ACC)
+		v |= ETMCTRL_CYCLEACCURATE;
+
+	etm_unlock(t);
+
+	etm_writel(t, v, ETMR_CTRL);
+
+	while (!(etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM) && --timeout)
+		;
+	if (!timeout) {
+		dev_dbg(t->dev, "Waiting for progbit to assert timed out\n");
+		etm_lock(t);
+		return -EFAULT;
+	}
+
+	etm_setup_address_range(t, 1, (unsigned long)_stext,
+			(unsigned long)_etext, 0, 0);
+	etm_writel(t, 0, ETMR_TRACEENCTRL2);
+	etm_writel(t, 0, ETMR_TRACESSCTRL);
+	etm_writel(t, 0x6f, ETMR_TRACEENEVT);
+
+	v &= ~ETMCTRL_PROGRAM;
+	v |= ETMCTRL_PORTSEL;
+
+	etm_writel(t, v, ETMR_CTRL);
+
+	timeout = TRACER_TIMEOUT;
+	while (etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM && --timeout)
+		;
+	if (!timeout) {
+		dev_dbg(t->dev, "Waiting for progbit to deassert timed out\n");
+		etm_lock(t);
+		return -EFAULT;
+	}
+
+	etm_lock(t);
+
+	t->flags |= TRACER_RUNNING;
+
+	return 0;
+}
+
+static int trace_stop(struct tracectx *t)
+{
+	unsigned long timeout = TRACER_TIMEOUT;
+
+	etm_unlock(t);
+
+	etm_writel(t, 0x440, ETMR_CTRL);
+	while (!(etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM) && --timeout)
+		;
+	if (!timeout) {
+		dev_dbg(t->dev, "Waiting for progbit to assert timed out\n");
+		etm_lock(t);
+		return -EFAULT;
+	}
+
+	etm_lock(t);
+
+	etb_unlock(t);
+	etb_writel(t, ETBFF_MANUAL_FLUSH, ETBR_FORMATTERCTRL);
+
+	timeout = TRACER_TIMEOUT;
+	while (etb_readl(t, ETBR_FORMATTERCTRL) &
+			ETBFF_MANUAL_FLUSH && --timeout)
+		;
+	if (!timeout) {
+		dev_dbg(t->dev, "Waiting for formatter flush to commence "
+				"timed out\n");
+		etb_lock(t);
+		return -EFAULT;
+	}
+
+	etb_writel(t, 0, ETBR_CTRL);
+
+	etb_lock(t);
+
+	t->flags &= ~TRACER_RUNNING;
+
+	return 0;
+}
+
+static int etb_getdatalen(struct tracectx *t)
+{
+	u32 v;
+	int rp, wp;
+
+	v = etb_readl(t, ETBR_STATUS);
+
+	if (v & 1)
+		return t->etb_bufsz;
+
+	rp = etb_readl(t, ETBR_READADDR);
+	wp = etb_readl(t, ETBR_WRITEADDR);
+
+	if (rp > wp) {
+		etb_writel(t, 0, ETBR_READADDR);
+		etb_writel(t, 0, ETBR_WRITEADDR);
+
+		return 0;
+	}
+
+	return wp - rp;
+}
+
+/* sysrq+v will always stop the running trace and leave it at that */
+static void etm_dump(void)
+{
+	struct tracectx *t = &tracer;
+	u32 first = 0;
+	int length;
+
+	if (!t->etb_regs) {
+		printk(KERN_INFO "No tracing hardware found\n");
+		return;
+	}
+
+	if (!mutex_trylock(&t->mutex))
+		return;
+
+	if (trace_isrunning(t))
+		trace_stop(t);
+
+	etb_unlock(t);
+
+	length = etb_getdatalen(t);
+
+	if (length == t->etb_bufsz)
+		first = etb_readl(t, ETBR_WRITEADDR);
+
+	etb_writel(t, first, ETBR_READADDR);
+
+	printk(KERN_INFO "Trace buffer contents length: %d\n", length);
+	printk(KERN_INFO "--- ETB buffer begin ---\n");
+	for (; length; length--)
+		printk("%08x", cpu_to_be32(etb_readl(t, ETBR_READMEM)));
+	printk(KERN_INFO "\n--- ETB buffer end ---\n");
+
+	etb_writel(t, 0, ETBR_TRIGGERCOUNT);
+	etb_writel(t, 0, ETBR_READADDR);
+	etb_writel(t, 0, ETBR_WRITEADDR);
+
+	etb_lock(t);
+
+	mutex_unlock(&t->mutex);
+}
+
+static void sysrq_etm_dump(int key, struct tty_struct *tty)
+{
+	dev_dbg(tracer.dev, "Dumping ETB buffer\n");
+	etm_dump();
+}
+
+static struct sysrq_key_op sysrq_etm_op = {
+	.handler = sysrq_etm_dump,
+	.help_msg = "ETM buffer dump",
+	.action_msg = "etm",
+};
+
+static int etb_open(struct inode *inode, struct file *file)
+{
+	if (!tracer.etb_regs)
+		return -ENODEV;
+
+	file->private_data = &tracer;
+
+	return nonseekable_open(inode, file);
+}
+
+static ssize_t etb_read(struct file *file, char __user *data,
+		size_t len, loff_t *ppos)
+{
+	int total, i;
+	long length;
+	struct tracectx *t = file->private_data;
+	u32 first = 0;
+	u32 *buf;
+
+	mutex_lock(&t->mutex);
+
+	if (trace_isrunning(t)) {
+		length = 0;
+		goto out;
+	}
+
+	etb_unlock(t);
+
+	total = etb_getdatalen(t);
+	if (total == t->etb_bufsz)
+		first = etb_readl(t, ETBR_WRITEADDR);
+
+	etb_writel(t, first, ETBR_READADDR);
+
+	length = min(total * 4, (int)len);
+	buf = vmalloc(length);
+
+	dev_dbg(t->dev, "ETB buffer length: %d\n", total);
+	dev_dbg(t->dev, "ETB status reg: %x\n", etb_readl(t, ETBR_STATUS));
+	for (i = 0; i < length / 4; i++)
+		buf[i] = etb_readl(t, ETBR_READMEM);
+
+	/* the only way to deassert overflow bit in ETB status is this */
+	etb_writel(t, 1, ETBR_CTRL);
+	etb_writel(t, 0, ETBR_CTRL);
+
+	etb_writel(t, 0, ETBR_WRITEADDR);
+	etb_writel(t, 0, ETBR_READADDR);
+	etb_writel(t, 0, ETBR_TRIGGERCOUNT);
+
+	etb_lock(t);
+
+	length = copy_to_user(data, buf, length);
+	vfree(buf);
+
+out:
+	mutex_unlock(&t->mutex);
+
+	return length;
+}
+
+static int etb_release(struct inode *inode, struct file *file)
+{
+	/* there's nothing to do here, actually */
+	return 0;
+}
+
+static struct file_operations etb_fops = {
+	.owner = THIS_MODULE,
+	.read = etb_read,
+	.open = etb_open,
+	.release = etb_release,
+};
+
+static struct miscdevice etb_miscdev = {
+	.name = "tracebuf",
+	.minor = 0,
+	.fops = &etb_fops,
+};
+
+static int __devinit etb_drv_probe(struct platform_device *pdev)
+{
+	struct tracectx *t = platform_get_drvdata(pdev);
+	struct resource *res;
+	struct clk *clk;
+	int ret = 0;
+
+	if (t && t->etb_regs) {
+		dev_dbg(&pdev->dev, "ETB already initialized\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (!request_mem_region(res->start, SZ_4K, "etb")) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (!t) {
+		t = &tracer;
+		platform_set_drvdata(pdev, t);
+	}
+
+	t->etb_regs = ioremap_nocache(res->start, SZ_4K);
+	if (!t->etb_regs) {
+		ret = -ENOMEM;
+		platform_set_drvdata(pdev, NULL);
+		release_mem_region(res->start, SZ_4K);
+		goto out;
+	}
+
+	etb_miscdev.parent = &pdev->dev;
+
+	ret = misc_register(&etb_miscdev);
+	if (ret) {
+		platform_set_drvdata(pdev, NULL);
+		iounmap(t->etb_regs);
+		release_mem_region(res->start, SZ_4K);
+		goto out;
+	}
+
+	clk = clk_get(&pdev->dev, "emu_core_alwon_ck");
+	clk_enable(clk);
+
+	clk = clk_get(&pdev->dev, "emu_per_alwon_ck");
+	clk_enable(clk);
+
+	clk = clk_get(&pdev->dev, "emu_mpu_alwon_ck");
+	clk_enable(clk);
+
+	clk = clk_get(&pdev->dev, "emu_src_ck");
+	clk_enable(clk);
+
+	etb_unlock(t);
+	t->etb_bufsz = etb_readl(t, ETBR_DEPTH);
+	dev_dbg(&pdev->dev, "Size: %x\n", t->etb_bufsz);
+
+	/* make sure trace capture is disabled */
+	etb_writel(t, 0, ETBR_CTRL);
+	etb_writel(t, 0x1000, ETBR_FORMATTERCTRL);
+	etb_lock(t);
+
+	dev_dbg(&pdev->dev, "ETB platform driver initialized.\n");
+
+	ret = 0;
+out:
+	return ret;
+}
+
+static struct platform_driver etb_driver = {
+	.probe		 = etb_drv_probe,
+	.driver	 = {
+		.name	 = "etb",
+		.owner	= THIS_MODULE,
+	},
+};
+
+/* use a sysfs file "trace_running" to start/stop tracing */
+static ssize_t trace_running_show(struct kobject *kobj,
+				  struct kobj_attribute *attr,
+				  char *buf)
+{
+	return sprintf(buf, "%x\n", trace_isrunning(&tracer));
+}
+
+static ssize_t trace_running_store(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   const char *buf, size_t n)
+{
+	unsigned int value;
+	int ret;
+
+	if (sscanf(buf, "%u", &value) != 1)
+		return -EINVAL;
+
+	mutex_lock(&tracer.mutex);
+	ret = value ? trace_start(&tracer) : trace_stop(&tracer);
+	mutex_unlock(&tracer.mutex);
+
+	return ret ? : n;
+}
+
+static struct kobj_attribute trace_running_attr =
+	__ATTR(trace_running, 0644, trace_running_show, trace_running_store);
+
+static ssize_t trace_info_show(struct kobject *kobj,
+				  struct kobj_attribute *attr,
+				  char *buf)
+{
+	u32 etb_wa, etb_ra, etb_st, etb_fc, etm_ctrl, etm_st;
+	int datalen;
+
+	etb_unlock(&tracer);
+	datalen = etb_getdatalen(&tracer);
+	etb_wa = etb_readl(&tracer, ETBR_WRITEADDR);
+	etb_ra = etb_readl(&tracer, ETBR_READADDR);
+	etb_st = etb_readl(&tracer, ETBR_STATUS);
+	etb_fc = etb_readl(&tracer, ETBR_FORMATTERCTRL);
+	etb_lock(&tracer);
+
+	etm_unlock(&tracer);
+	etm_ctrl = etm_readl(&tracer, ETMR_CTRL);
+	etm_st = etm_readl(&tracer, ETMR_STATUS);
+	etm_lock(&tracer);
+
+	return sprintf(buf, "Trace buffer len: %d\nComparator pairs: %d\n"
+			"ETBR_WRITEADDR:\t%08x\n"
+			"ETBR_READADDR:\t%08x\n"
+			"ETBR_STATUS:\t%08x\n"
+			"ETBR_FORMATTERCTRL:\t%08x\n"
+			"ETMR_CTRL:\t%08x\n"
+			"ETMR_STATUS:\t%08x\n",
+			datalen,
+			tracer.ncmppairs,
+			etb_wa,
+			etb_ra,
+			etb_st,
+			etb_fc,
+			etm_ctrl,
+			etm_st
+			);
+}
+
+static struct kobj_attribute trace_info_attr =
+	__ATTR(trace_info, 0444, trace_info_show, NULL);
+
+static ssize_t trace_mode_show(struct kobject *kobj,
+				  struct kobj_attribute *attr,
+				  char *buf)
+{
+	return sprintf(buf, "%d %d\n",
+			!!(tracer.flags & TRACER_CYCLE_ACC),
+			tracer.etm_portsz);
+}
+
+static ssize_t trace_mode_store(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   const char *buf, size_t n)
+{
+	unsigned int cycacc, portsz;
+
+	if (sscanf(buf, "%u %u", &cycacc, &portsz) != 2)
+		return -EINVAL;
+
+	mutex_lock(&tracer.mutex);
+	if (cycacc)
+		tracer.flags |= TRACER_CYCLE_ACC;
+	else
+		tracer.flags &= ~TRACER_CYCLE_ACC;
+
+	tracer.etm_portsz = portsz & 0x0f;
+	mutex_unlock(&tracer.mutex);
+
+	return n;
+}
+
+static struct kobj_attribute trace_mode_attr =
+	__ATTR(trace_mode, 0644, trace_mode_show, trace_mode_store);
+
+static int __devinit etm_drv_probe(struct platform_device *pdev)
+{
+	struct tracectx *t = platform_get_drvdata(pdev);
+	struct resource *res;
+	int ret = 0;
+
+	if (t && t->etm_regs) {
+		dev_dbg(&pdev->dev, "ETM already initialized\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (!request_mem_region(res->start, SZ_4K, "etm")) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (!t) {
+		t = &tracer;
+		platform_set_drvdata(pdev, t);
+	}
+
+	t->etm_regs = ioremap_nocache(res->start, SZ_4K);
+	if (!t->etm_regs) {
+		ret = -ENOMEM;
+		release_mem_region(res->start, SZ_4K);
+		platform_set_drvdata(pdev, NULL);
+		goto out;
+	}
+
+	mutex_init(&t->mutex);
+	t->dev = &pdev->dev;
+	t->flags = TRACER_CYCLE_ACC;
+	t->etm_portsz = 1;
+
+	etm_unlock(t);
+	ret = etm_readl(t, CSCR_PRSR);
+
+	t->ncmppairs = etm_readl(t, ETMR_CONFCODE) & 0xf;
+	etm_writel(t, 0x440, ETMR_CTRL);
+	etm_lock(t);
+
+	ret = sysfs_create_file(&pdev->dev.kobj,
+			&trace_running_attr.attr);
+	ret = sysfs_create_file(&pdev->dev.kobj,
+			&trace_info_attr.attr);
+	ret = sysfs_create_file(&pdev->dev.kobj,
+			&trace_mode_attr.attr);
+	dev_dbg(t->dev, "ETM platform driver initialized.\n");
+
+out:
+	return ret;
+}
+
+static struct platform_driver etm_driver = {
+	.probe           = etm_drv_probe,
+	.driver  = {
+		.name    = "etm",
+		.owner   = THIS_MODULE,
+	},
+};
+
+static int __init etm_init(void)
+{
+	platform_driver_register(&etb_driver);
+	platform_driver_register(&etm_driver);
+	register_sysrq_key('v', &sysrq_etm_op);
+
+	return 0;
+}
+
+module_init(etm_init);
+
-- 
1.6.3.3
