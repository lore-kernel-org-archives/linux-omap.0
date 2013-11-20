From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 14/31] arm: omap: irq: make intc_of_init static
Date: Wed, 20 Nov 2013 12:09:01 -0600
Message-ID: <1384970958-4118-15-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48472 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754678Ab3KTSKh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Nov 2013 13:10:37 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

nobody uses that function outside of this file,
so we don't need to expose it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/common.h | 10 ----------
 arch/arm/mach-omap2/irq.c    |  2 +-
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 4d90328..89e73fe 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -209,16 +209,6 @@ extern void __iomem *omap4_get_l2cache_base(void);
 #endif
 
 struct device_node;
-#ifdef CONFIG_OF
-int __init intc_of_init(struct device_node *node,
-			     struct device_node *parent);
-#else
-int __init intc_of_init(struct device_node *node,
-			     struct device_node *parent)
-{
-	return 0;
-}
-#endif
 
 #ifdef CONFIG_SMP
 extern void __iomem *omap4_get_scu_base(void);
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index f290f16..8ef2bfd 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -298,7 +298,7 @@ asmlinkage void __exception_irq_entry omap2_intc_handle_irq(struct pt_regs *regs
 	omap_intc_handle_irq(regs);
 }
 
-int __init intc_of_init(struct device_node *node,
+static int __init intc_of_init(struct device_node *node,
 			     struct device_node *parent)
 {
 	struct resource res;
-- 
1.8.4.GIT

