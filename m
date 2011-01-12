From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH 0/0] RFC: ARM: Thumb-2: Symbol manipulation macros for function body copying
Date: Tue, 11 Jan 2011 18:02:30 -0600
Message-ID: <1294790551-17069-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37367 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932697Ab1ALACr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jan 2011 19:02:47 -0500
Received: by ywl5 with SMTP id 5so4024ywl.19
        for <linux-omap@vger.kernel.org>; Tue, 11 Jan 2011 16:02:47 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org

For at least one board (omap3), some functions are copied from
their link-time location into other memory at run-time.

This is a plausible thing to do if, for example, the board
might need to do something like manipulating the SDRAM 
controller configuration during power management operations.
Such code may not be able to execute from the SDRAM itself.


In Thumb-2, copying function bodies is not straightforward:
for Thumb symbols, bit 0 is set by the toolchain, and so
a function symbol can't be used directly as a base address
for memcpy: this leads to an off-by-one error, resulting in
garbage instructions in the destination buffer.


The obvious solution is to mask off this bit when calling
memcpy() and then insert the bit into the address of the
target buffer, in order to derive a pointer which can be
used to call the copied function in the correct instruction
set.  However, in practice the compiler may optimise this
operation away.  This seems wrong, but having discussed this
with compiler folks I believe it's not a compiler bug: rather,
C doesn't specifiy what happens when casting function pointers
and attempting to do arithmetic on them.  So some surprising
optimisations can happen.


To make it easier to deal with cases like this, I've had a
go at writing some macros to make copying function bodies
easier, while being robust for ARM and Thumb-2.

In particular, the required type-casts are implemented as
empty asm() blocks, to ensure that the compiler makes no
assumptions about the result.

These macros just help with the address manipulations: e.g.:

    extern int scary_function(int a, char *b);
    extern const int size_of_scary_function;
    extern void *scary_memory_buf;

    int (*runtime_scary_function)(int a, char *b);

    runtime_scary_function = FSYM_REBASE(
        scary_function, 
	memcpy(scary_memory_buf, FSYM_BASE(scary_function),
            size_of_scary_function));

This is quite a lot more readable than the explicit code,
and gives the correct result (modulo bugs in my patch...)

It's still necessary to do the appropriate cache-flushing
before runtime_scary_function is actually called.  Also,
it's not possible to determine the size of a function from
C code.  This must be done by other means, such as adding
extra symbols in the assembler code where scary_function is
defined.


I can't comment on how widespread the requirement for function
body copying is in the arch/arm/ tree, however.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
KernelVersion: next-20110111

 arch/arm/include/asm/unified.h |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
index bc63116..636a765 100644
--- a/arch/arm/include/asm/unified.h
+++ b/arch/arm/include/asm/unified.h
@@ -24,6 +24,32 @@
 	.syntax unified
 #endif
 
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+#define __funcp_to_uint(funcp) ({				\
+		uintptr_t __result;				\
+								\
+		asm("" : "=r" (__result) : "0" (funcp));	\
+		__result;					\
+	})
+#define __uint_to_funcp(i, funcp) ({			\
+		typeof(funcp) __result;			\
+							\
+		asm("" : "=r" (__result) : "0" (i));	\
+		__result;				\
+	})
+#define FSYM_REBASE(funcp, dest_buf)					\
+	__uint_to_funcp((uintptr_t)(dest_buf) | FSYM_TYPE(funcp), funcp)
+
+#ifdef CONFIG_THUMB2_KERNEL
+#define FSYM_BASE(funcp) ((void *)(__funcp_to_uint(funcp) & ~(uintptr_t)1))
+#define FSYM_TYPE(funcp) (__funcp_to_uint(funcp) & 1)
+#else /* !CONFIG_THUMB2_KERNEL */
+#define FSYM_BASE(funcp) ((void *)__funcp_to_uint(funcp))
+#define FSYM_TYPE(funcp) 0
+#endif /* !CONFIG_THUMB2_KERNEL */
+#endif /* !__ASSEMBLY__ */
+
 #ifdef CONFIG_THUMB2_KERNEL
 
 #if __GNUC__ < 4
-- 
1.7.1

*** BLURB HERE ***

Dave Martin (1):
  ARM: Thumb-2: Symbol manipulation macros for function body copying

 arch/arm/include/asm/unified.h |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

