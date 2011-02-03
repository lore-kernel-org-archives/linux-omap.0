From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH v2 1/5] ARM: omap4: Correct definition of do_wfi() for CONFIG_THUMB2_KERNEL
Date: Thu,  3 Feb 2011 18:02:37 +0000
Message-ID: <1296756161-26092-2-git-send-email-dave.martin@linaro.org>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49592 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756502Ab1BCSDW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 13:03:22 -0500
Received: by mail-ww0-f44.google.com with SMTP id 36so1470092wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 10:03:21 -0800 (PST)
In-Reply-To: <1296756161-26092-1-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dave Martin <dave.martin@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

For the Thumb-2 case, the "wfi" mnemonic is used, since in this
case the tools will necessarily be new enough to support it.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 5b0270b..68ce058 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -17,8 +17,13 @@
  * wfi used in low power code. Directly opcode is used instead
  * of instruction to avoid mulit-omap build break
  */
+#ifdef CONFIG_THUMB2_KERNEL
+#define do_wfi()			\
+		__asm__ __volatile__ ("wfi" : : : "memory")
+#else
 #define do_wfi()			\
 		__asm__ __volatile__ (".word	0xe320f003" : : : "memory")
+#endif
 
 #ifdef CONFIG_CACHE_L2X0
 extern void __iomem *l2cache_base;
-- 
1.7.1

