From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 1/1] ARM TCM (Tightly-Coupled Memory) support v1
Date: Fri, 26 Jun 2009 12:43:55 +0200
Message-ID: <1246013035-20520-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linus-embedded@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>
List-Id: linux-omap@vger.kernel.org

This adds the TCM interface to Linux, when active, it will
detect and report TCM memories and sizes early in boot if
present, introduce generic TCM memory handling, provide a
generic TCM memory pool and select TCM memory for the U300
platform.

I use arch/arm/include/asm/cputype.h that defines a
CPUID_TCM register that you can read out from the
system control coprocessor. Documentation from ARM
can be found at http://infocenter.arm.com, search
for "TCM Status Register" to see documents for all CPUs.
Reading this register you can determine if ITCM
(bit 0) and/or DTCM (bit 16) is present in the machine.

This will be used to implement power management
(sleep mode) for the U300 machines.

Tell me if you think this should go into /proc/cpuinfo
as well. Currently it doesn't.

Caveats:

I use the addresses at 0xffff2000 and 0xffff4000 in the
U300 architecture for mapping the TCM with a one-to-one
memory map. This is "reserved" in Russells map, good
suggestions on where else to put this 0x4000 block is
welcome.

No special handling of BSS (uninitialized) sections.
They get converted to generic DATA (and thus
zero-initialized).

Linker is moaning:
arm-none-linux-gnueabi-ld: warning: dot moved backwards before `.bss'
arm-none-linux-gnueabi-ld: warning: dot moved backwards before `.bss'
arm-none-linux-gnueabi-ld: warning: dot moved backwards before `.bss'
Due to my movement of the dot for TCM-relative code. Ideas on how
to solve that are welcome.

A few of the noisy pr_info() calls should probably be
pr_debug() in the final version.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 Documentation/arm/tcm.txt                |  139 +++++++++++++++++
 arch/arm/Kconfig                         |    5 +
 arch/arm/include/asm/cputype.h           |    5 +
 arch/arm/include/asm/tcm.h               |   31 ++++
 arch/arm/kernel/Makefile                 |    1 +
 arch/arm/kernel/setup.c                  |    2 +
 arch/arm/kernel/tcm.c                    |  247 ++++++++++++++++++++++++++++++
 arch/arm/kernel/tcm.h                    |   17 ++
 arch/arm/kernel/vmlinux.lds.S            |   37 +++++
 arch/arm/mach-u300/include/mach/memory.h |    8 +
 10 files changed, 492 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/arm/tcm.txt
 create mode 100644 arch/arm/include/asm/tcm.h
 create mode 100644 arch/arm/kernel/tcm.c
 create mode 100644 arch/arm/kernel/tcm.h

diff --git a/Documentation/arm/tcm.txt b/Documentation/arm/tcm.txt
new file mode 100644
index 0000000..7554511
--- /dev/null
+++ b/Documentation/arm/tcm.txt
@@ -0,0 +1,139 @@
+ARM TCM (Tightly-Coupled Memory) handling in Linux
+----
+Written by Linus Walleij <linus.walleij@stericsson.com>
+
+Some ARM SoC:s have a so-called TCM (Tightly-Coupled Memory).
+This is usually just a few 4-64 KiB inside the ARM processor.
+Due to being embedded inside the CPU The TCM has a
+Harvard-architecture, so there is an ITCM (instruction TCM)
+and a DTCM (data TCM). The DTCM can not contain any
+instructions, but the ITCM can actually contain data.
+The size of DTCM or ITCM is minimum 4KiB so the typical
+minimum configuration is 4KiB ITCM and 4KiB DTCM.
+
+ARM CPU:s have special registers to read out status, physical
+location and size of TCM memories. arch/arm/include/asm/cputype.h
+defines a CPUID_TCM register that you can read out from the
+system control coprocessor. Documentation from ARM can be found
+at http://infocenter.arm.com, search for "TCM Status Register"
+to see documents for all CPUs. Reading this register you can
+determine if ITCM (bit 0) and/or DTCM (bit 16) is present in the
+machine.
+
+There is further a TCM region register (search for "TCM Region
+Registers" that can report and modify the location size of TCM
+memories at runtime. This is used to read out and modify
+TCM location and size.
+
+TCM is used for a few things:
+
+- FIQ and other interrupt handlers that need deterministic
+  timing and cannot wait for cache misses.
+
+- Idle loops where all external RAM is set to self-refresh
+  retention mode, so only on-chip RAM is accessible by
+  the CPU and then we hang inside ITCM waiting for an
+  interrupt.
+
+- Other operations which implies shutting off or reconfiguring
+  the external RAM controller.
+
+Code executing inside the ITCM does not "see" any MMU mappings
+and e.g. register accesses must be made to physical addresses.
+
+There is an interface for using TCM on the ARM architecture
+in <asm/tcm.h>. Using this interface it is possible to:
+
+- Define the physical address and size of ITCM and DTCM.
+
+- Be able to tag functions to be compiled into ITCM.
+
+- Be able to tag data and constants to be allocated to
+  ITCM.
+
+- Have the remaining TCM RAM added to a special
+  allocation pool with gen_pool_create() and gen_pool_add()
+  and provice tcm_alloc() and tcm_free() for this
+  memory. Such a heap is great for things like saving
+  device state when shutting off device power domains.
+
+A machine that has TCM memory shall select HAVE_TCM in
+arch/arm/Kconfig for itself, and then the
+rest of the functionality will depend on the physical
+location and size of ITCM and DTCM to be defined in
+mach/memory.h for the machine. Code that needs to use
+TCM shall #include <asm/tcm.h> If the TCM is not located
+at the place given in memory.h it will be moved using
+the TCM Regiom registers.
+
+Functions to go into itcm can be tagged like this:
+int __tcmfunc foo(int bar);
+
+Variables to go into dtcm can be tagged like this:
+int __tcmdata foo;
+
+Constants can be tagged like this:
+int __tcmconst foo;
+
+To put assembler into TCM just use
+.section ".tcm.text" or .section ".tcm.data"
+respectively.
+
+Example code:
+
+#include <asm/tcm.h>
+
+/* Uninitialized data */
+static u32 __tcmdata tcmvar;
+/* Initialized data */
+static u32 __tcmdata tcmassigned = 0x2BADBABEU;
+/* Constant */
+static const u32 __tcmconst tcmconst = 0xCAFEBABEU;
+
+static void __tcmlocalfunc tcm_to_tcm(void)
+{
+	int i;
+	for (i = 0; i < 100; i++)
+		tcmvar ++;
+}
+
+static void __tcmfunc hello_tcm(void)
+{
+	/* Some abstract code that runs in ITCM */
+	int i;
+	for (i = 0; i < 100; i++) {
+		tcmvar ++;
+	}
+	tcm_to_tcm();
+}
+
+static void __init test_tcm(void)
+{
+	u32 *tcmem;
+	int i;
+
+	hello_tcm();
+	printk("Hello TCM executed from ITCM RAM\n");
+
+	printk("TCM variable from testrun: %u @ %p\n", tcmvar, &tcmvar);
+	tcmvar = 0xDEADBEEFU;
+	printk("TCM variable: 0x%x @ %p\n", tcmvar, &tcmvar);
+
+	printk("TCM assigned variable: 0x%x @ %p\n", tcmassigned, &tcmassigned);
+
+	printk("TCM constant: 0x%x @ %p\n", tcmconst, &tcmconst);
+
+	/* Allocate some TCM memory from the pool */
+	tcmem = tcm_alloc(20);
+	if (tcmem) {
+		printk("TCM Allocated 20 bytes of TCM @ %p\n", tcmem);
+		tcmem[0] = 0xDEADBEEFU;
+		tcmem[1] = 0x2BADBABEU;
+		tcmem[2] = 0xCAFEBABEU;
+		tcmem[3] = 0xDEADBEEFU;
+		tcmem[4] = 0x2BADBABEU;
+		for (i = 0; i < 5; i++)
+			printk("TCM tcmem[%d] = %08x\n", i, tcmem[i]);
+		tcm_free(tcmem, 20);
+	}
+}
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index aef63c8..d2253f4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -50,6 +50,10 @@ config MMU
 	bool
 	default y
 
+config HAVE_TCM
+	bool
+	select GENERIC_ALLOCATOR
+
 config NO_IOPORT
 	bool
 
@@ -602,6 +606,7 @@ config ARCH_U300
 	bool "ST-Ericsson U300 Series"
 	depends on MMU
 	select CPU_ARM926T
+	select HAVE_TCM
 	select ARM_AMBA
 	select ARM_VIC
 	select GENERIC_TIME
diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index b3e656c..54a1f1d 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -63,6 +63,11 @@ static inline unsigned int __attribute_const__ read_cpuid_cachetype(void)
 	return read_cpuid(CPUID_CACHETYPE);
 }
 
+static inline unsigned int __attribute_const__ read_cpuid_tcmstatus(void)
+{
+	return read_cpuid(CPUID_TCM);
+}
+
 /*
  * Intel's XScale3 core supports some v6 features (supersections, L2)
  * but advertises itself as v5 as it does not support the v6 ISA.  For
diff --git a/arch/arm/include/asm/tcm.h b/arch/arm/include/asm/tcm.h
new file mode 100644
index 0000000..5929ef5
--- /dev/null
+++ b/arch/arm/include/asm/tcm.h
@@ -0,0 +1,31 @@
+/*
+ *
+ * Copyright (C) 2008-2009 ST-Ericsson AB
+ * License terms: GNU General Public License (GPL) version 2
+ *
+ * Author: Rickard Andersson <rickard.andersson@stericsson.com>
+ * Author: Linus Walleij <linus.walleij@stericsson.com>
+ *
+ */
+#ifndef __ASMARM_TCM_H
+#define __ASMARM_TCM_H
+
+#ifndef CONFIG_HAVE_TCM
+#error "You should not be including tcm.h unless you have a TCM!"
+#endif
+
+#include <linux/compiler.h>
+
+/* Tag variables with this */
+#define __tcmdata __section(.tcm.data)
+/* Tag constants with this */
+#define __tcmconst __section(.tcm.rodata)
+/* Tag functions inside TCM called from outside TCM with this */
+#define __tcmfunc __attribute__((long_call)) __section(.tcm.text) noinline
+/* Tag function inside TCM called from inside TCM  with this */
+#define __tcmlocalfunc __section(.tcm.text)
+
+void *tcm_alloc(size_t len);
+void tcm_free(void *addr, size_t len);
+
+#endif
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index ff89d0b..9961878 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_OABI_COMPAT)	+= sys_oabi-compat.o
 obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_ARM_UNWIND)	+= unwind.o
+obj-$(CONFIG_HAVE_TCM)		+= tcm.o
 
 obj-$(CONFIG_CRUNCH)		+= crunch.o crunch-bits.o
 AFLAGS_crunch-bits.o		:= -Wa,-mcpu=ep9312
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index bc5e412..efd8af9 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -44,6 +44,7 @@
 
 #include "compat.h"
 #include "atags.h"
+#include "tcm.h"
 
 #ifndef MEM_SIZE
 #define MEM_SIZE	(16*1024*1024)
@@ -735,6 +736,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	cpu_init();
+	tcm_init();
 
 	/*
 	 * Set up various architecture-specific pointers
diff --git a/arch/arm/kernel/tcm.c b/arch/arm/kernel/tcm.c
new file mode 100644
index 0000000..69476ef
--- /dev/null
+++ b/arch/arm/kernel/tcm.c
@@ -0,0 +1,247 @@
+/*
+ * Copyright (C) 2008-2009 ST-Ericsson AB
+ * License terms: GNU General Public License (GPL) version 2
+ * TCM memory handling for ARM systems
+ *
+ * Author: Linus Walleij <linus.walleij@stericsson.com>
+ * Author: Rickard Andersson <rickard.andersson@stericsson.com>
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/stddef.h>
+#include <linux/ioport.h>
+#include <linux/genalloc.h>
+#include <asm/page.h> /* PAGE_SHIFT */
+#include <asm/cputype.h>
+#include <asm/mach/map.h>
+#include <asm/string.h> /* memcpy */
+#include <mach/memory.h>
+#include "tcm.h"
+
+/* Scream and warn about misuse */
+#if !defined(ITCM_OFFSET) || !defined(ITCM_END) || \
+    !defined(DTCM_OFFSET) || !defined(DTCM_END)
+#error "TCM support selected but offsets not defined!"
+#endif
+
+static struct gen_pool *tcm_pool;
+
+/* Definitions from the linker */
+extern char __itcm_start;
+extern char __sitcm_text;
+extern char __eitcm_text;
+
+extern char __dtcm_start;
+extern char __sdtcm_data;
+extern char __edtcm_data;
+
+/*
+ * TCM memory resources
+ */
+static struct resource dtcm_res = {
+	.name = "DTCM RAM",
+	.start = DTCM_OFFSET,
+	.end = DTCM_END,
+	.flags = IORESOURCE_MEM
+};
+
+static struct resource itcm_res = {
+	.name = "ITCM RAM",
+	.start = ITCM_OFFSET,
+	.end = ITCM_END,
+	.flags = IORESOURCE_MEM
+};
+
+static struct map_desc dtcm_iomap[] __initdata = {
+	{
+		.virtual	= DTCM_OFFSET,
+		.pfn		= __phys_to_pfn(DTCM_OFFSET),
+		.length		= (DTCM_END - DTCM_OFFSET + 1),
+		.type		= MT_UNCACHED
+	}
+};
+
+static struct map_desc itcm_iomap[] __initdata = {
+	{
+		.virtual	= ITCM_OFFSET,
+		.pfn		= __phys_to_pfn(ITCM_OFFSET),
+		.length		= (ITCM_END - ITCM_OFFSET + 1),
+		.type		= MT_UNCACHED
+	}
+};
+
+/*
+ * Allocate a chunk of TCM memory
+ */
+void *tcm_alloc(size_t len)
+{
+	unsigned long vaddr;
+
+	if (!tcm_pool)
+		return NULL;
+
+	vaddr = gen_pool_alloc(tcm_pool, len);
+	if (!vaddr)
+		return NULL;
+
+	return (void *) vaddr;
+}
+EXPORT_SYMBOL(tcm_alloc);
+
+/*
+ * Free a chunk of TCM memory
+ */
+void tcm_free(void *addr, size_t len)
+{
+	gen_pool_free(tcm_pool, (unsigned long) addr, len);
+}
+EXPORT_SYMBOL(tcm_free);
+
+
+static void __init setup_tcm_bank(u8 type, u32 offset, u32 expected_size)
+{
+	const int tcm_sizes[16] = { 0, -1, -1, 4, 8, 16, 32, 64, 128,
+				    256, 512, 1024, -1, -1, -1, -1 };
+	u32 tcm_region;
+	int tcm_size;
+
+	/* Read the special TCM region register c9, 0 */
+	if (!type)
+		asm("mrc	p15, 0, %0, c9, c1, 0"
+		    : "=r" (tcm_region));
+	else
+		asm("mrc	p15, 0, %0, c9, c1, 1"
+		    : "=r" (tcm_region));
+
+	tcm_size = tcm_sizes[(tcm_region >> 2) & 0x0f];
+	if (tcm_size < 0) {
+		pr_info("CPU: %sTCM of unknown size!\n",
+			type ? "I" : "D");
+	} else {
+		pr_info("CPU: found %sTCM %dk @ %08x, %senabled\n",
+			type ? "I" : "D",
+			tcm_size,
+			(tcm_region & 0xfffff000U),
+			(tcm_region & 1) ? "" : "not ");
+	}
+
+	if (tcm_size != expected_size) {
+		pr_crit("CPU: %sTCM was detected %dk but expected %dk!\n",
+		       type ? "I" : "D",
+		       tcm_size,
+		       expected_size);
+		/* Adjust to the expected size? what can we do... */
+	}
+
+	/* Force move the TCM band to where we want it, enable */
+	tcm_region = offset | (tcm_region & 0x00000ffeU) | 1;
+
+	if (!type)
+		asm("mcr	p15, 0, %0, c9, c1, 0"
+		    : /* No output operands */
+		    : "r" (tcm_region));
+	else
+		asm("mcr	p15, 0, %0, c9, c1, 1"
+		    : /* No output operands */
+		    : "r" (tcm_region));
+
+	pr_info("CPU: moved %sTCM %dk to %08x, enabled\n",
+		type ? "I" : "D",
+		tcm_size,
+		(tcm_region & 0xfffff000U));
+}
+
+/*
+ * This initializes the TCM memory
+ */
+void __init tcm_init(void)
+{
+	u32 tcm_status = read_cpuid_tcmstatus();
+	char *start;
+	char *end;
+	char *ram;
+
+	/* Setup DTCM if present */
+	if (tcm_status & (1 << 16)) {
+		setup_tcm_bank(0, DTCM_OFFSET,
+			       (DTCM_END - DTCM_OFFSET + 1) >> 10);
+		request_resource(&iomem_resource, &dtcm_res);
+		iotable_init(dtcm_iomap, 1);
+		/* Copy data from RAM to DTCM */
+		start = &__sdtcm_data;
+		end   = &__edtcm_data;
+		ram   = &__dtcm_start;
+		memcpy(start, ram, (end-start));
+		pr_info("CPU DTCM: copied data from %p - %p\n", start, end);
+	}
+
+	/* Setup ITCM if present */
+	if (tcm_status & 1) {
+		setup_tcm_bank(1, ITCM_OFFSET,
+			       (ITCM_END - ITCM_OFFSET + 1) >> 10);
+		request_resource(&iomem_resource, &itcm_res);
+		iotable_init(itcm_iomap, 1);
+		/* Copy code from RAM to ITCM */
+		start = &__sitcm_text;
+		end   = &__eitcm_text;
+		ram   = &__itcm_start;
+		memcpy(start, ram, (end-start));
+		pr_info("CPU ITCM: copied code from %p - %p\n", start, end);
+	}
+}
+
+/*
+ * This creates the TCM memory pool and has to be done later,
+ * during the core_initicalls, since the allocator is not yet
+ * up and running when the first initialization runs.
+ */
+static int __init setup_tcm_pool(void)
+{
+	u32 tcm_status = read_cpuid_tcmstatus();
+	u32 dtcm_pool_start = (u32) &__edtcm_data;
+	u32 itcm_pool_start = (u32) &__eitcm_text;
+	int ret;
+
+	/*
+	 * Set up malloc pool, 2^2 = 4 bytes granularity since
+	 * the TCM is sometimes just 4 KiB. NB: pages and cache
+	 * line alignments does not matter in TCM!
+	 */
+	tcm_pool = gen_pool_create(2, -1);
+
+	pr_info("Setting up TCM memory pool\n");
+
+	/* Add the rest of DTCM to the TCM pool */
+	if (tcm_status & (1 << 16)) {
+		if (dtcm_pool_start < DTCM_END) {
+			ret = gen_pool_add(tcm_pool, dtcm_pool_start,
+					   DTCM_END - dtcm_pool_start + 1, -1);
+			if (ret) {
+				pr_err("CPU DTCM: could not add DTCM remainder to pool!\n");
+				return ret;
+			}
+			pr_info("CPU DTCM: Added %08x bytes @ %08x to the TCM memory pool\n",
+				DTCM_END - dtcm_pool_start + 1,
+				dtcm_pool_start);
+		}
+	}
+
+	/* Add the rest of ITCM to the TCM pool */
+	if (tcm_status & 1) {
+		if (itcm_pool_start < ITCM_END) {
+			ret = gen_pool_add(tcm_pool, itcm_pool_start,
+					   ITCM_END - itcm_pool_start + 1, -1);
+			if (ret) {
+				pr_err("CPU ITCM: could not add ITCM remainder to pool!\n");
+				return ret;
+			}
+			pr_info("CPU ITCM: Added %08x bytes @ %08x to the TCM memory pool\n",
+				ITCM_END - itcm_pool_start + 1,
+				itcm_pool_start);
+		}
+	}
+	return 0;
+}
+
+core_initcall(setup_tcm_pool);
diff --git a/arch/arm/kernel/tcm.h b/arch/arm/kernel/tcm.h
new file mode 100644
index 0000000..9ec43ab
--- /dev/null
+++ b/arch/arm/kernel/tcm.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2008-2009 ST-Ericsson AB
+ * License terms: GNU General Public License (GPL) version 2
+ * TCM memory handling for ARM systems
+ *
+ * Author: Linus Walleij <linus.walleij@stericsson.com>
+ * Author: Rickard Andersson <rickard.andersson@stericsson.com>
+ */
+
+#ifdef CONFIG_HAVE_TCM
+void __init tcm_init(void);
+#else
+/* No TCM support, just blank inlines to be optimized out */
+void inline tcm_init(void)
+{
+}
+#endif
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 4340bf3..0b10b28 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -197,6 +197,43 @@ SECTIONS
 	}
 	_edata_loc = __data_loc + SIZEOF(.data);
 
+#ifdef CONFIG_HAVE_TCM
+	.itcm_start : {
+		__itcm_start = .;
+	}
+
+	/* Link these to the ITCM RAM */
+	.text_itcm ITCM_OFFSET : AT(__itcm_start)
+	{ 
+ 		. = ALIGN(8);
+		__sitcm_text = .;
+		*(.tcm.text)
+		*(.tcm.rodata)
+		. = ALIGN(4);
+		__eitcm_text = .;
+	}
+	
+	/* Reset the . pointer */
+	. = ADDR(.itcm_start) + SIZEOF(.text_itcm);
+	
+	.dtcm_start : {
+		__dtcm_start = .;
+	}
+
+	/* TODO: add remainder of ITCM as well, that can be used for data! */
+	.data_dtcm DTCM_OFFSET : AT(__dtcm_start)
+	{
+ 		. = ALIGN(4);
+		__sdtcm_data = .;
+		*(.tcm.data)
+		. = ALIGN(4);
+		__edtcm_data = .; 
+ 	}
+
+	/* Then reset the current . pointer */
+	. = ADDR(.dtcm_start) + SIZEOF(.data_dtcm);
+#endif
+
 	.bss : {
 		__bss_start = .;	/* BSS				*/
 		*(.bss)
diff --git a/arch/arm/mach-u300/include/mach/memory.h b/arch/arm/mach-u300/include/mach/memory.h
index bf134bc..ab000df 100644
--- a/arch/arm/mach-u300/include/mach/memory.h
+++ b/arch/arm/mach-u300/include/mach/memory.h
@@ -35,6 +35,14 @@
 #endif
 
 /*
+ * TCM memory whereabouts
+ */
+#define ITCM_OFFSET	0xffff2000
+#define ITCM_END	0xffff3fff
+#define DTCM_OFFSET	0xffff4000
+#define DTCM_END	0xffff5fff
+
+/*
  * We enable a real big DMA buffer if need be.
  */
 #define CONSISTENT_DMA_SIZE SZ_4M
-- 
1.6.2.1


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
