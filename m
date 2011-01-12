From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH 1/1] ARM: Thumb-2: Symbol manipulation macros for function body copying
Date: Tue, 11 Jan 2011 18:02:31 -0600
Message-ID: <1294790551-17069-2-git-send-email-dave.martin@linaro.org>
References: <1294790551-17069-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38508 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932697Ab1ALACt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jan 2011 19:02:49 -0500
Received: by gxk9 with SMTP id 9so8470gxk.19
        for <linux-omap@vger.kernel.org>; Tue, 11 Jan 2011 16:02:48 -0800 (PST)
In-Reply-To: <1294790551-17069-1-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org

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

