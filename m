From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 12/17] OMAP2/3: Do not enable AUTOIDLE in interrupt controller
Date: Fri, 16 Oct 2009 13:49:05 +0300
Message-ID: <1255690150-16853-13-git-send-email-tero.kristo@nokia.com>
References: <>
 <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-10-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-11-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-12-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32332 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758611AbZJPLFB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 07:05:01 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB3PX0012236
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:03:32 +0300
In-Reply-To: <1255690150-16853-12-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jouni Hogander <jouni.hogander@nokia.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

OMAP interrupt controller goes to unknown state when there is right
combination of l3,l4 sleep/wake-up transitions, l4 autoidle in
interrupt controller and some interrupt. When this happens, interrupts
are not delivered to ARM anymore and ARM will remain in WFI (wait for
interrupt) until interrupt controller is forced to wake-up
(i.e. lauterbach). Disable AUTOIDLE in INTC for now.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/irq.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 4ed05e9..76179a2 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -167,8 +167,10 @@ static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
 	while (!(intc_bank_read_reg(bank, INTC_SYSSTATUS) & 0x1))
 		/* Wait for reset to complete */;
 
-	/* Enable autoidle */
+	/* Do not enable autoidle as it seems to cause problems */
+#if 0
 	intc_bank_write_reg(1 << 0, bank, INTC_SYSCONFIG);
+#endif
 }
 
 int omap_irq_pending(void)
-- 
1.5.4.3

