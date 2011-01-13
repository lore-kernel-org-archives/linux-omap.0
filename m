From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH 1/1 v2] ARM: Thumb-2: Symbol manipulation macros for function body copying
Date: Thu, 13 Jan 2011 14:51:45 -0600
Message-ID: <1294951905-23748-2-git-send-email-dave.martin@linaro.org>
References: <1294951905-23748-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57175 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757163Ab1AMUwA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jan 2011 15:52:00 -0500
Received: by mail-gw0-f46.google.com with SMTP id 20so854719gwj.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 12:51:59 -0800 (PST)
In-Reply-To: <1294951905-23748-1-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

In low-level board support code, there is sometimes a need to
copy a function body to another location at run-time.

A straightforward call to memcpy doesn't work in Thumb-2,
because bit 0 of external Thumb function symbols is set to 1,
indicating that the function is Thumb.  Without corrective
measures, this will cause an off-by-one copy, and the copy
may be called using the wrong instruction set.

This patch adds macros to help with such cases.

Particular care is needed, because C doesn't guarantee any
defined behaviour when casting a function pointer to any other
type.  This has been observed to lead to strange optimisation
side-effects when doing the arithmetic which is required in
order to copy/move function bodies correctly in Thumb-2.

Thanks to Russell King for his input on this patch.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
KernelVersion: v2.6.37

 arch/arm/include/asm/fncpy.h |  111 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 111 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/fncpy.h

diff --git a/arch/arm/include/asm/fncpy.h b/arch/arm/include/asm/fncpy.h
new file mode 100644
index 0000000..a155fb7
--- /dev/null
+++ b/arch/arm/include/asm/fncpy.h
@@ -0,0 +1,111 @@
+/*
+ * arch/arm/include/asm/fncpy.h - helper macros for function body copying
+ *
+ * Copyright (C) 2011 Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+/*
+ * These macros are intended for use when there is a need to copy a low-level
+ * function body into special memory.
+ *
+ * For example, when reconfiguring the SDRAM controller, the code doing the
+ * reconfiguration may need to run from SRAM.
+ *
+ * NOTE: that the copied function body must be entirely self-contained and
+ * position-independent in order for this to work properly.
+ *
+ *
+ * Typical usage example:
+ *
+ * extern int f(args);
+ * extern uint32_t size_of_f;
+ * int (*copied_f)(args);
+ * void *sram_buffer;
+ *
+ * copied_f = fncpy(sram_buffer, &f, size_of_f);
+ *
+ * ... do any required D-side/I-side synchronisation ...
+ *
+ * ... later, call the function: ...
+ *
+ * copied_f(args);
+ *
+ * The size of the function to be copied can't be determined from C:
+ * this must be determined by other means, such as adding assmbler directives
+ * in the file where f is defined.
+ */
+
+ */
+
+#ifndef __ASM_FNCPY_H
+#define __ASM_FNCPY_H
+
+#include <linux/types.h>
+#include <linux/string.h>
+
+#include <asm/cacheflush.h>
+
+/* Function pointer casting macros */
+
+/* Cast function pointer to integer: */
+#define __funcp_to_uint(funcp) ({				\
+		uintptr_t __result;				\
+								\
+		asm("" : "=r" (__result) : "0" (funcp));	\
+		__result;					\
+	})
+
+/* Cast integer to function pointer with type matching funcp: */
+#define __uint_to_funcp(i, funcp) ({			\
+		typeof(funcp) __result;			\
+							\
+		asm("" : "=r" (__result) : "0" (i));	\
+		__result;				\
+	})
+
+
+/* Function symbol manipulation macros */
+
+/*
+ * FSYM_REBASE: Determine the correct function pointer for funcp,
+ * after the function has been copied to dest_buf:
+ */
+#define FSYM_REBASE(funcp, dest_buf)					\
+	__uint_to_funcp((uintptr_t)(dest_buf) | FSYM_TYPE(funcp), funcp)
+
+/*
+ * FSYM_BASE: Determine the base address in memory of the function funcp
+ * FSYM_TYPE: Determine the instruction set type (ARM/Thumb) of funcp
+ * (both defined below)
+ */
+
+#ifdef CONFIG_THUMB2_KERNEL
+#define FSYM_BASE(funcp) ((void *)(__funcp_to_uint(funcp) & ~(uintptr_t)1))
+#define FSYM_TYPE(funcp) (__funcp_to_uint(funcp) & 1)
+#else /* !CONFIG_THUMB2_KERNEL */
+#define FSYM_BASE(funcp) ((void *)__funcp_to_uint(funcp))
+#define FSYM_TYPE(funcp) 0
+#endif /* !CONFIG_THUMB2_KERNEL */
+
+/* Function copy helper */
+#define fncpy(dest_buf, funcp, size) ({					\
+		memcpy(dest_buf, FSYM_BASE(funcp), size);		\
+		flush_icache_range(dest_buf, (char *)(dest_buf) + size); \
+									\
+		FSYM_REBASE(funcp, dest_buf);				\
+	})
+
+#endif /* !__ASM_FNCPY_H */
-- 
1.7.1

