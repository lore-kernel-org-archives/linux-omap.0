From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rfc/rft/patch 1/9] arm: omap: kill compile warning in irq.c
Date: Tue,  1 Dec 2009 15:03:47 +0200
Message-ID: <1259672635-12306-2-git-send-email-felipe.balbi@nokia.com>
References: <1259672635-12306-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20671 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbZLANFB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 08:05:01 -0500
In-Reply-To: <1259672635-12306-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Kalle Valo <kalle.valo@iki.fi>, Jean Pihet <jpihet@mvista.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

intc_context is only used when omap3 is to be built,
so also put it under ifdef CONFIG_ARM_OMAP3 to avoid
the compile warning.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/irq.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index e9bc782..d370052 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -62,7 +62,9 @@ struct omap3_intc_regs {
 	u32 mir[INTCPS_NR_MIR_REGS];
 };
 
+#ifdef CONFIG_ARCH_OMAP3
 static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];
+#endif
 
 /* INTC bank register get/set */
 
-- 
1.6.6.rc0

