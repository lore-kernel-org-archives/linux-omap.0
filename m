From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 09/31] arm: omap: irq: rename omap3_intc_regs
Date: Wed, 20 Nov 2013 12:08:56 -0600
Message-ID: <1384970958-4118-10-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51645 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545Ab3KTSKV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Nov 2013 13:10:21 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

just to make it clearer that it can
be used on all omaps.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index ec97ade..52386e7 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -62,7 +62,7 @@ static void __iomem *omap_irq_base;
 static int omap_nr_irqs = 96;
 
 /* Structure to save interrupt controller context */
-struct omap3_intc_regs {
+struct omap_intc_regs {
 	u32 sysconfig;
 	u32 protection;
 	u32 idle;
@@ -258,7 +258,7 @@ void __init omap_intc_of_init(void)
 }
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
-static struct omap3_intc_regs intc_context;
+static struct omap_intc_regs intc_context;
 
 void omap_intc_save_context(void)
 {
-- 
1.8.4.GIT

