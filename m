From: Tim Bird <tim.bird@am.sony.com>
Subject: [PATCH 2/2] ftrace - add ftrace function_graph support on ARM
Date: Fri, 5 Mar 2010 16:36:47 -0800
Message-ID: <4B91A39F.8050502@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:17858
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751641Ab0CFAgx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 19:36:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

Sorry - had wrong lists on original message

Add ftrace function-graph tracer support for ARM.

This includes adding code in mcount to check for
(and call) a registered function graph trace entry
routine, and adding code to support a return
trampoline, to catch the function exit.

IRQENTRY_TEXT was added to vmlinux.lds.S (to eliminate
a compiler error on kernel/trace/trace_functions_graph.c),
although no routines were marked as __irq_entry.

Signed-off-by: Tim Bird <tim.bird@am.sony.com>
---
 arch/arm/Kconfig               |    1
 arch/arm/kernel/Makefile       |    4 +--
 arch/arm/kernel/entry-common.S |   36 +++++++++++++++++++++++++++++++-
 arch/arm/kernel/ftrace_graph.c |   46 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/vmlinux.lds.S  |    1
 5 files changed, 85 insertions(+), 3 deletions(-)

--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -18,6 +18,7 @@ config ARM
 	select HAVE_KPROBES if (!XIP_KERNEL)
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
+	select HAVE_FUNCTION_GRAPH_TRACER if (!XIP_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -5,9 +5,8 @@
 CPPFLAGS_vmlinux.lds := -DTEXT_OFFSET=$(TEXT_OFFSET)
 AFLAGS_head.o        := -DTEXT_OFFSET=$(TEXT_OFFSET)

-ifdef CONFIG_DYNAMIC_FTRACE
 CFLAGS_REMOVE_ftrace.o = -pg
-endif
+CFLAGS_REMOVE_ftrace_graph.o = -pg

 CFLAGS_REMOVE_return_address.o = -pg

@@ -31,6 +30,7 @@ obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
 obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
+obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace_graph.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-decode.o
 obj-$(CONFIG_ATAGS_PROC)	+= atags.o
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -98,6 +98,11 @@ ENTRY(mcount)
 	mov r0, lr
 	sub r0, r0, #MCOUNT_INSN_SIZE

+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	@ FIXTHIS - DYNAMIC_FTRACE does not support function graph tracing
+	@ when the dynamic work is revived, this should be supported as well
+#endif
+
 	.globl mcount_call
 mcount_call:
 	bl ftrace_stub
@@ -144,8 +149,16 @@ ENTRY(mcount)
 	adr r0, ftrace_stub
 	cmp r0, r2
 	bne trace
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	ldr r1, =ftrace_graph_return
+	ldr r2, [r1]
+	cmp r0, r2		@ if *ftrace_graph_return != ftrace_stub
+	bne ftrace_graph_caller
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
 	ldr lr, [fp, #-4]			@ restore lr
-	ldmia sp!, {r0-r3, pc}
+	ldmia sp!, {r0-r3, pc}			@ return doing nothing

 trace:
 	ldr r1, [fp, #-4]			@ lr of instrumented routine
@@ -156,6 +169,27 @@ trace:
 	ldr lr, [fp, #-4]			@ restore lr
 	ldmia sp!, {r0-r3, pc}

+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+ENTRY(ftrace_graph_caller)
+	sub r0, fp, #4			@ &lr of instrumented routine (&parent)
+	mov r1, lr			@ instrumented routine (func)
+	sub r1, r1, #MCOUNT_INSN_SIZE
+	mov r2, fp			@ frame pointer
+	bl prepare_ftrace_return
+	ldr lr, [fp, #-4]		@ restore lr
+	ldmia sp!, {r0-r3, pc}
+
+	.globl return_to_handler
+return_to_handler:
+	stmdb sp!, {r0-r3}
+	mov r0, fp			@ frame pointer
+	bl ftrace_return_to_handler
+	mov lr, r0			@ r0 has real ret addr
+	ldmia sp!, {r0-r3}
+	mov pc, lr
+
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
 #endif /* CONFIG_DYNAMIC_FTRACE */

 	.globl ftrace_stub
--- /dev/null
+++ b/arch/arm/kernel/ftrace_graph.c
@@ -0,0 +1,46 @@
+/*
+ * function graph tracing support.
+ *
+ * Copyright (C) 2009 Tim Bird <tim.bird@am.sony.com>
+ *
+ * For licencing details, see COPYING.
+ *
+ * Defines routine needed for ARM return trampoline for tracing
+ * function exits.
+ */
+
+#include <linux/ftrace.h>
+
+/*
+ * Hook the return address and push it in the stack of return addrs
+ * in current thread info.
+ */
+void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
+			   unsigned long frame_pointer)
+{
+	unsigned long old;
+
+	struct ftrace_graph_ent trace;
+	unsigned long return_hooker = (unsigned long)
+				&return_to_handler;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	old = *parent;
+	*parent = return_hooker;
+
+	if (ftrace_push_return_trace(old, self_addr, &trace.depth,
+		    frame_pointer) == -EBUSY) {
+		*parent = old;
+		return;
+	}
+
+	trace.func = self_addr;
+
+	/* Only trace if the calling function expects to */
+	if (!ftrace_graph_entry(&trace)) {
+		current->curr_ret_stack--;
+		*parent = old;
+	}
+}
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -91,6 +91,7 @@ SECTIONS
 			SCHED_TEXT
 			LOCK_TEXT
 			KPROBES_TEXT
+			IRQENTRY_TEXT
 #ifdef CONFIG_MMU
 			*(.fixup)
 #endif

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


