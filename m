From: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
Subject: [PATCH] ARM: OMAP: fix IVA2 module base address
Date: Tue, 28 May 2013 15:46:17 +0400
Message-ID: <1369741577-21984-1-git-send-email-aida.mynzhasova@skitlab.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
List-Id: linux-omap@vger.kernel.org

This patch corrects the base address of IVA2 module on omap3430.

Signed-off-by: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
---
 arch/arm/mach-omap2/prcm-common.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index c7d355f..d5ec044 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -37,7 +37,7 @@
 #define OMAP2430_MDM_MOD				0xc00
 
 /* IVA2 module is < base on 3430 */
-#define OMAP3430_IVA2_MOD				-0x800
+#define OMAP3430_IVA2_MOD				0x800
 #define OMAP3430ES2_SGX_MOD				GFX_MOD
 #define OMAP3430_CCR_MOD				PLL_MOD
 #define OMAP3430_DSS_MOD				0x600
-- 
1.7.10.4
