From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 1/6] Add infrastructure for conditional code and data sections
Date: Tue, 21 Dec 2010 19:19:59 +0100
Message-ID: <1292955604-8809-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44881 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab0LUSUV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 13:20:21 -0500
In-Reply-To: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Petazzoni <tpetazzoni@ti.com>, Thomas Petazzoni <t-petazzoni@ti.com>

From: Thomas Petazzoni <tpetazzoni@ti.com>

WARNING: This is only a proof-of-concept, there are many known
issues. The sole purpose of this patch is to get some feedback on
whether the idea is useful or not, and whether it's worth cleaning up
the remaining issues.

A trend in the kernel support for SoC is to build a single kernel that
works accross a wide range of SoC inside a SoC family, or even in the
future SoC of different families.

While this is very interesting to reduce the number of kernel images
needed to support a large number of hardware platforms, it allows
means that the kernel image size is increasing. Portions of code and
data are specific to a given SoC (clock structures, hwmod structures
on OMAP, etc.) and only the portion relevant for the current SoC the
kernel is running on is actually useful. The rest of the code and data
remains in memory forever.

While __init and __initdata can solve some of those cases, it is not
necessarly easy to use, since the code/data that is actually useful
needs to be copied so that it is kept after the init memory cleanup.

Therefore, we introduce an infrastructure that allows to put code and
data into specific sections, called "conditional sections". All those
sections are compiled into the final kernel image, but at runtime, by
calling a function, we can get rid of the unused sections.

For example, on OMAP, you can declare data as being omap2 specific
this way:

   static int __omap2_data foobar;

Then, in the board code of an OMAP3 or OMAP4 platform, you can call:

   free_unused_cond_section("omap2");

And the memory consumed by the "foobar" variable will be reclaimed.

The way it works is the following :

 * The __NAME_data and __NAME_text macros should be defined using the
   cond_data_section() and cond_text_section() macros. They allow to
   mark a symbol to be part of a given conditional section. There is
   no hardcoded list for the NAME string, so any non-conflicting NAME
   can be used.

 * When the vmlinux.lds linker script is generated, we pass the
   vmlinux.lds.S into the scripts/cond-sections script so that the
   CONDITIONAL_TEXT_SECTIONS and CONDITIONAL_DATA_SECTIONS magic
   values are turned into correct LD script language to page-align
   each section, add starting and ending symbols, and include the
   section into the correct final kernel section (.text or .data).

 * At the end of the kernel link stage, we generate a .tmp_condsecs.S
   file using the same scripts/cond-sections script. This file
   contains an array of structure (cond_section_descs) describing each
   included conditional section.

 * At run-time, the free_unused_cond_section() function will travel
   the cond_section_descs[] array to find the starting and ending
   address of the conditional section to remove. It will poison it,
   and then free the corresponding memory.

The complexity of the link procedure is due to the fact that we do not
want to hardcode a fixed list of NAME for the conditional sections.

Known issues :

 * The kbuild knowledge of the author is limited, and therefore the
   code is horrible.

 * It only works when CONFIG_KALLSYMS is enabled, due to how the
   integration in kbuild was done. This can probably be fixed, with
   hopefully some help of kbuild experts.

 * The shell script scripts/cond-sections can certainly be improved.

 * The case of kernel modules hasn't been considered at all.

Signed-off-by: Thomas Petazzoni <t-petazzoni@ti.com>
---
 Makefile                      |   17 ++++++-
 arch/arm/kernel/vmlinux.lds.S |    3 +
 include/linux/condsections.h  |   19 ++++++++
 kernel/Makefile               |    2 +-
 kernel/condsections.c         |   57 +++++++++++++++++++++++++
 scripts/Makefile.build        |    7 ++-
 scripts/cond-sections         |   93 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 191 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/condsections.h
 create mode 100644 kernel/condsections.c
 create mode 100755 scripts/cond-sections

diff --git a/Makefile b/Makefile
index 6619720..57bb824 100644
--- a/Makefile
+++ b/Makefile
@@ -837,14 +837,25 @@ quiet_cmd_kallsyms = KSYM    $@
 .tmp_kallsyms%.S: .tmp_vmlinux% $(KALLSYMS)
 	$(call cmd,kallsyms)
 
+quiet_cmd_cond_sections_bis = CONDSECS $@
+      cmd_cond_sections_bis = $(NM) -n $< | \
+	grep -E "cond_(data|text)_start"  | \
+	scripts/cond-sections --s-file > $@
+
+.tmp_condsecs.o: %.o: %.S FORCE
+	$(call if_changed_dep,as_o_S)
+
+.tmp_condsecs.S: .tmp_vmlinux1 scripts/cond-sections
+	$(call cmd,cond_sections_bis)
+
 # .tmp_vmlinux1 must be complete except kallsyms, so update vmlinux version
 .tmp_vmlinux1: $(vmlinux-lds) $(vmlinux-all) FORCE
 	$(call if_changed_rule,ksym_ld)
 
-.tmp_vmlinux2: $(vmlinux-lds) $(vmlinux-all) .tmp_kallsyms1.o FORCE
+.tmp_vmlinux2: $(vmlinux-lds) $(vmlinux-all) .tmp_kallsyms1.o .tmp_condsecs.o FORCE
 	$(call if_changed,vmlinux__)
 
-.tmp_vmlinux3: $(vmlinux-lds) $(vmlinux-all) .tmp_kallsyms2.o FORCE
+.tmp_vmlinux3: $(vmlinux-lds) $(vmlinux-all) .tmp_kallsyms2.o .tmp_condsecs.o FORCE
 	$(call if_changed,vmlinux__)
 
 # Needs to visit scripts/ before $(KALLSYMS) can be used.
@@ -876,7 +887,7 @@ define rule_vmlinux-modpost
 endef
 
 # vmlinux image - including updated kernel symbols
-vmlinux: $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) vmlinux.o $(kallsyms.o) FORCE
+vmlinux: $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) vmlinux.o $(kallsyms.o) .tmp_condsecs.o FORCE
 ifdef CONFIG_HEADERS_CHECK
 	$(Q)$(MAKE) -f $(srctree)/Makefile headers_check
 endif
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index cead889..aa0282f 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -105,6 +105,7 @@ SECTIONS
 			SCHED_TEXT
 			LOCK_TEXT
 			KPROBES_TEXT
+			CONDITIONAL_TEXT
 #ifdef CONFIG_MMU
 			*(.fixup)
 #endif
@@ -168,6 +169,8 @@ SECTIONS
 		NOSAVE_DATA
 		CACHELINE_ALIGNED_DATA(32)
 
+		CONDITIONAL_DATA
+
 		/*
 		 * The exception fixup table (might need resorting at runtime)
 		 */
diff --git a/include/linux/condsections.h b/include/linux/condsections.h
new file mode 100644
index 0000000..d657be6
--- /dev/null
+++ b/include/linux/condsections.h
@@ -0,0 +1,19 @@
+/*
+ * Conditional section management
+ *
+ * Copyright (C) 2010 Thomas Petazzoni <t-petazzoni@ti.com>
+ */
+
+#ifndef __CONDSECTIONS_H__
+#define __CONDSECTIONS_H__
+
+/*
+ * Use these macros to define other macros to put code or data into
+ * specific conditional sections.
+ */
+#define cond_data_section(__secname__) __section(.data.conditional.__secname__)
+#define cond_text_section(__secname__) __section(.text.conditional.__secname__)
+
+void free_unused_cond_section(const char *name);
+
+#endif /* __CONDSECTIONS_H__ */
diff --git a/kernel/Makefile b/kernel/Makefile
index 0b5ff08..58b0435 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -10,7 +10,7 @@ obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
 	    hrtimer.o rwsem.o nsproxy.o srcu.o semaphore.o \
 	    notifier.o ksysfs.o pm_qos_params.o sched_clock.o cred.o \
-	    async.o range.o jump_label.o
+	    async.o range.o jump_label.o condsections.o
 obj-y += groups.o
 
 ifdef CONFIG_FUNCTION_TRACER
diff --git a/kernel/condsections.c b/kernel/condsections.c
new file mode 100644
index 0000000..b568549
--- /dev/null
+++ b/kernel/condsections.c
@@ -0,0 +1,57 @@
+/*
+ * Conditional section management
+ *
+ * Copyright (C) 2010 Thomas Petazzoni <t-petazzoni@ti.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+
+/*
+ * This structure must be in sync with the assembly code generated by
+ * scripts/cond-sections.
+ */
+struct cond_section_desc {
+	unsigned long start;
+	unsigned long end;
+	unsigned long type;
+	const char *name;
+};
+
+/*
+ * Symbol defined by assembly code generated in
+ * scripts/cond-sections. Declared as weak because it appears only at
+ * late stage of the link process.
+ */
+extern struct cond_section_desc cond_section_descs[] __attribute__((weak));
+
+static void free_unused_cond_section_area(unsigned long pfn, unsigned long end)
+{
+        for (; pfn < end; pfn++) {
+		struct page *page = pfn_to_page(pfn);
+                ClearPageReserved(page);
+                init_page_count(page);
+                __free_page(page);
+		totalram_pages += 1;
+        }
+}
+
+/*
+ * Free the text and data conditional sections associated to the given
+ * name
+ */
+void free_unused_cond_section(const char *name)
+{
+	struct cond_section_desc *sec;
+
+	for (sec = cond_section_descs; sec->name; sec++) {
+		if (strcmp(sec->name, name))
+			continue;
+		printk(KERN_INFO "Freeing unused conditional section: %s %s 0x%lx -> 0%lx (sz=%ld)\n",
+		       sec->name, (sec->type ? "data" : "text"),
+		       sec->start, sec->end, (sec->end - sec->start));
+		memset((void*) sec->start, POISON_FREE_INITMEM, sec->end - sec->start);
+		free_unused_cond_section_area(__phys_to_pfn(__pa(sec->start)),
+					      __phys_to_pfn(__pa(sec->end)));
+	}
+}
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 5ad25e1..3822751 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -285,10 +285,11 @@ targets += $(extra-y) $(MAKECMDGOALS) $(always)
 # Linker scripts preprocessor (.lds.S -> .lds)
 # ---------------------------------------------------------------------------
 quiet_cmd_cpp_lds_S = LDS     $@
-      cmd_cpp_lds_S = $(CPP) $(cpp_flags) -P -C -U$(ARCH) \
-	                     -D__ASSEMBLY__ -DLINKER_SCRIPT -o $@ $<
+      cmd_cpp_lds_S = cat $< | scripts/cond-sections --lds $(OBJDUMP) | \
+                      $(CPP) $(cpp_flags) -P -C -U$(ARCH) \
+	                     -D__ASSEMBLY__ -DLINKER_SCRIPT -o $@ -
 
-$(obj)/%.lds: $(src)/%.lds.S FORCE
+$(obj)/%.lds: $(src)/%.lds.S scripts/cond-sections FORCE
 	$(call if_changed_dep,cpp_lds_S)
 
 # Build the compiled-in targets
diff --git a/scripts/cond-sections b/scripts/cond-sections
new file mode 100755
index 0000000..c72e932
--- /dev/null
+++ b/scripts/cond-sections
@@ -0,0 +1,93 @@
+#!/bin/sh
+#
+# Conditional section link script and assembly code generation
+#
+# Copyright (C) 2010 Thomas Petazzoni <t-petazzoni@ti.com>
+#
+# This script is used:
+#
+#  *) with a --lds path-to-objdump argument, with the vmlinux.lds.S
+#     file on its standard input, in order to generate the linker
+#     script fragments corresponding to the different conditional
+#     sections included in the kernel image.
+#
+#  *) with a --s-file argument, with the result of a
+#     $(CROSS_COMPILE)nm -n as its standard input, in order to
+#     generate some assembly code that will compile into an array of
+#     structures representing each conditional section.
+
+if [ $# -lt 1 ] ; then
+    echo "Incorrect number of arguments"
+    exit 1
+fi
+
+if [ x$1 = x"--lds" ] ; then
+    OBJDUMP=$(which $2)
+    if [ ! -x $OBJDUMP ] ; then
+	echo "Invalid objdump executable"
+	exit 1
+    fi
+
+    # Get the list of conditional data sections
+    CONDITIONAL_DATA_SECTIONS=$($OBJDUMP -w -h vmlinux.o | \
+	grep "\.data\.conditional\." | cut -f3 -d' ' | tr "\n" " ")
+
+    # Get the list of conditional text sections
+    CONDITIONAL_TEXT_SECTIONS=$($OBJDUMP -w -h vmlinux.o | \
+	grep "\.text\.conditional\." | cut -f3 -d' ' | tr "\n" " ")
+
+    while read line ; do
+	if echo $line | grep -q "CONDITIONAL_TEXT" ; then
+	    for s in $CONDITIONAL_TEXT_SECTIONS ; do
+		sym=$(echo $s | sed 's/\.data\.conditional\.//')
+		echo ". = ALIGN(PAGE_SIZE);"
+		echo "VMLINUX_SYMBOL(__${sym}_cond_text_start) = .;"
+		echo "*(.text.conditional.${sym})"
+		echo ". = ALIGN(PAGE_SIZE);"
+		echo "VMLINUX_SYMBOL(__${sym}_cond_text_end) = .;"
+	    done
+	elif echo $line | grep -q "CONDITIONAL_DATA" ; then
+	    for s in $CONDITIONAL_DATA_SECTIONS ; do
+		sym=$(echo $s | sed 's/\.data\.conditional\.//')
+		echo ". = ALIGN(PAGE_SIZE);"
+		echo "VMLINUX_SYMBOL(__${sym}_cond_data_start) = .;"
+		echo "*(.data.conditional.${sym})"
+		echo ". = ALIGN(PAGE_SIZE);"
+		echo "VMLINUX_SYMBOL(__${sym}_cond_data_end) = .;"
+	    done
+	else
+	    echo "$line"
+	fi
+    done
+elif [ x$1 = x"--s-file" ] ; then
+    echo ".section .rodata, \"a\""
+    echo ".globl cond_section_descs"
+    echo ".align 8"
+    echo "cond_section_descs:"
+    seclist=""
+    while read line ; do
+	sym=$(echo $line | cut -f3 -d' ')
+	secname=$(echo $sym | sed 's/^__\(.*\)_cond_.*/\1/')
+	sectype=$(echo $sym | sed 's/^.*_cond_\([a-z]*\)_start/\1/')
+	echo ".long __${secname}_cond_${sectype}_start"
+	echo ".long __${secname}_cond_${sectype}_end"
+	if [ $sectype = "text" ] ; then
+	    echo ".long 0"
+	else
+	    echo ".long 1"
+	fi
+	echo ".long __${secname}_cond_str"
+	seclist="$seclist $secname"
+    done
+    echo ".long 0"
+    echo ".long 0"
+    echo ".long 0"
+    echo ".long 0"
+    for sec in $seclist ; do
+	echo "__${sec}_cond_str:"
+	echo ".asciz \"${sec}\""
+    done
+else
+    echo "Invalid option"
+    exit 1
+fi
\ No newline at end of file
-- 
1.7.0.4

