From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 08/14] ARM: v6k: select cmpxchg code sequences according to V6 variants
Date: Mon, 17 Jan 2011 19:23:42 +0000
Message-ID: <E1Peug2-0003Sl-IM@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51091 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab1AQTX7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 14:23:59 -0500
In-Reply-To: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

If CONFIG_CPU_V6 is enabled, we must avoid the byte/halfword/doubleword
exclusive operations, which aren't implemented before V6K.  Use the
generic versions (or omit them) instead.

If CONFIG_CPU_V6 is not set, but CONFIG_CPU_32v6K is enabled, we have
the K extnesions, so use these new instructions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/system.h |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 97f6d60..9a87823 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -347,6 +347,7 @@ void cpu_idle_wait(void);
 #include <asm-generic/cmpxchg-local.h>
 
 #if __LINUX_ARM_ARCH__ < 6
+/* min ARCH < ARMv6 */
 
 #ifdef CONFIG_SMP
 #error "SMP is not supported on this platform"
@@ -365,7 +366,7 @@ void cpu_idle_wait(void);
 #include <asm-generic/cmpxchg.h>
 #endif
 
-#else	/* __LINUX_ARM_ARCH__ >= 6 */
+#else	/* min ARCH >= ARMv6 */
 
 extern void __bad_cmpxchg(volatile void *ptr, int size);
 
@@ -379,7 +380,7 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	unsigned long oldval, res;
 
 	switch (size) {
-#ifdef CONFIG_CPU_32v6K
+#ifndef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
 	case 1:
 		do {
 			asm volatile("@ __cmpxchg1\n"
@@ -404,7 +405,7 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 				: "memory", "cc");
 		} while (res);
 		break;
-#endif /* CONFIG_CPU_32v6K */
+#endif
 	case 4:
 		do {
 			asm volatile("@ __cmpxchg4\n"
@@ -450,12 +451,12 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 	unsigned long ret;
 
 	switch (size) {
-#ifndef CONFIG_CPU_32v6K
+#ifdef CONFIG_CPU_V6	/* min ARCH == ARMv6 */
 	case 1:
 	case 2:
 		ret = __cmpxchg_local_generic(ptr, old, new, size);
 		break;
-#endif	/* !CONFIG_CPU_32v6K */
+#endif
 	default:
 		ret = __cmpxchg(ptr, old, new, size);
 	}
@@ -469,7 +470,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 				       (unsigned long)(n),		\
 				       sizeof(*(ptr))))
 
-#ifdef CONFIG_CPU_32v6K
+#ifndef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
 
 /*
  * Note : ARMv7-M (currently unsupported by Linux) does not support
@@ -524,11 +525,11 @@ static inline unsigned long long __cmpxchg64_mb(volatile void *ptr,
 					 (unsigned long long)(o),	\
 					 (unsigned long long)(n)))
 
-#else	/* !CONFIG_CPU_32v6K */
+#else /* min ARCH = ARMv6 */
 
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
 
-#endif	/* CONFIG_CPU_32v6K */
+#endif
 
 #endif	/* __LINUX_ARM_ARCH__ >= 6 */
 
-- 
1.6.2.5

