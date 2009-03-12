From: Aaro Koskinen <Aaro.Koskinen@nokia.com>
Subject: [PM PATCH] OMAP3: PM: Fix INTC context save/restore
Date: Thu, 12 Mar 2009 18:12:29 +0200
Message-ID: <1236874349-31261-1-git-send-email-Aaro.Koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23895 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633AbZCLQMn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 12:12:43 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2CGCOev021540
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 18:12:37 +0200
Received: from localhost.localdomain (esdhcp043221.research.nokia.com [172.21.43.221])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n2CGCTWk019644
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 18:12:29 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Wrong index was used for ILR.

Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
---
 arch/arm/mach-omap2/irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 6cc5757..f813916 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -244,7 +244,7 @@ void omap3_intc_save_context(void)
 			intc_bank_read_reg(bank, INTC_THRESHOLD);
 		for (i = 0; i < INTCPS_NR_IRQS; i++)
 			intc_context[ind].ilr[i] =
-				intc_bank_read_reg(bank, (0x100 + 0x4*ind));
+				intc_bank_read_reg(bank, (0x100 + 0x4*i));
 		for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
 			intc_context[ind].mir[i] =
 				intc_bank_read_reg(&irq_banks[0], INTC_MIR0 +
@@ -270,7 +270,7 @@ void omap3_intc_restore_context(void)
 					bank, INTC_THRESHOLD);
 		for (i = 0; i < INTCPS_NR_IRQS; i++)
 			intc_bank_write_reg(intc_context[ind].ilr[i],
-				bank, (0x100 + 0x4*ind));
+				bank, (0x100 + 0x4*i));
 		for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
 			intc_bank_write_reg(intc_context[ind].mir[i],
 				 &irq_banks[0], INTC_MIR0 + (0x20 * i));
-- 
1.5.4.3

