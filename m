From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 6/7] arm: omap2: irq: fix compile warning:
Date: Mon, 17 Jan 2011 06:31:19 +0200
Message-ID: <1295238680-26738-7-git-send-email-balbi@ti.com>
References: <1295238680-26738-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:41858 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752338Ab1AQEcL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 16 Jan 2011 23:32:11 -0500
Received: by yws5 with SMTP id 5so1638205yws.29
        for <linux-omap@vger.kernel.org>; Sun, 16 Jan 2011 20:32:10 -0800 (PST)
In-Reply-To: <1295238680-26738-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Fix the following compile warning:
arch/arm/mach-omap2/irq.c:64:31: warning: 'intc_context' defined but not
used

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 23049c4..d151aac 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -61,8 +61,6 @@ struct omap3_intc_regs {
 	u32 mir[INTCPS_NR_MIR_REGS];
 };
 
-static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];
-
 /* INTC bank register get/set */
 
 static void intc_bank_write_reg(u32 val, struct omap_irq_bank *bank, u16 reg)
@@ -229,6 +227,8 @@ void __init omap_init_irq(void)
 }
 
 #ifdef CONFIG_ARCH_OMAP3
+static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];
+
 void omap_intc_save_context(void)
 {
 	int ind = 0, i = 0;
-- 
1.7.3.4.598.g85356

