From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH] ARM: Define wfi(), wfe(), sev() macros for pre-v7 processors
Date: Fri,  4 Feb 2011 14:20:43 +0000
Message-ID: <1296829243-21313-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65517 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab1BDOUw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 09:20:52 -0500
Received: by wyb28 with SMTP id 28so2294467wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 06:20:51 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dave Martin <dave.martin@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Russell King <linux@arm.linux.org.uk>

Pre-v7 processors don't have wfe/sev, so these are defined for
consistency as empty barrier asms.

For v6, wfi is architected as a defined MCR instruction, so
use that definition.

Doing a no-op instead of wfi() is probably bad, so for older
processors than v6, wfi() is not defined.  If needed, some CPU-
specific wfi() will have to be defined elsewhere.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/include/asm/system.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 97f6d60..0e1cae3 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -129,7 +129,14 @@ extern unsigned int user_debug;
 #define sev()	__asm__ __volatile__ ("sev" : : : "memory")
 #define wfe()	__asm__ __volatile__ ("wfe" : : : "memory")
 #define wfi()	__asm__ __volatile__ ("wfi" : : : "memory")
+#else /* __LINUX_ARM_ARCH__ < 7 */
+#define sev()	__asm__ __volatile__ ("" : : : "memory")
+#define wfe()	__asm__ __volatile__ ("" : : : "memory")
+#if __LINUX_ARM_ARCH__ == 6
+#define wfi()	__asm__ __volatile__ ("mcr p15, 0, %0, c7, c5, 4" \
+					: : "r" (0) : "memory")
 #endif
+#endif /* __LINUX_ARM_ARCH__ < 7 */
 
 #if __LINUX_ARM_ARCH__ >= 7
 #define isb() __asm__ __volatile__ ("isb" : : : "memory")
-- 
1.7.1

