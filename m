From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH v4 1/5] ARM: omap4: Provide do_wfi() for Thumb-2
Date: Wed,  9 Feb 2011 15:01:19 +0000
Message-ID: <1297263683-10621-2-git-send-email-dave.martin@linaro.org>
References: <1297263683-10621-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50678 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793Ab1BIPBr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 10:01:47 -0500
Received: by wyb28 with SMTP id 28so265094wyb.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Feb 2011 07:01:45 -0800 (PST)
In-Reply-To: <1297263683-10621-1-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dave Martin <dave.martin@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

For CONFIG_THUMB2_KERNEL, the existing definition of do_wfi() will
insert invalid code into the instruction stream.

Any assembler which can assemble Thumb-2 is guaranteed to accept
the "wfi" mnemonic, so for the Thumb-2 case, just use the mnemonic.

The ARM case is left as-is.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 5b0270b..de441c0 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -17,8 +17,12 @@
  * wfi used in low power code. Directly opcode is used instead
  * of instruction to avoid mulit-omap build break
  */
+#ifdef CONFIG_THUMB2_KERNEL
+#define do_wfi() __asm__ __volatile__ ("wfi" : : : "memory")
+#else
 #define do_wfi()			\
 		__asm__ __volatile__ (".word	0xe320f003" : : : "memory")
+#endif
 
 #ifdef CONFIG_CACHE_L2X0
 extern void __iomem *l2cache_base;
-- 
1.7.1

