From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 23/32] OMAP3: PM: Fix INTC context save/restore
Date: Thu, 22 Oct 2009 16:09:44 -0700
Message-ID: <1256252993-24328-24-git-send-email-khilman@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-2-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-3-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-4-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-14-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-15-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-16-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-17-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-18-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-19-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-20-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-21-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-22-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-23-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:37878 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbZJVXLR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 19:11:17 -0400
Received: by mail-qy0-f194.google.com with SMTP id 32so5544712qyk.4
        for <linux-omap@vger.kernel.org>; Thu, 22 Oct 2009 16:11:22 -0700 (PDT)
In-Reply-To: <1256252993-24328-23-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Aaro Koskinen <Aaro.Koskinen@nokia.com>

From: Aaro Koskinen <Aaro.Koskinen@nokia.com>

Wrong index was used for ILR.

Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index ebd3538..e9bc782 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -241,7 +241,7 @@ void omap_intc_save_context(void)
 			intc_bank_read_reg(bank, INTC_THRESHOLD);
 		for (i = 0; i < INTCPS_NR_IRQS; i++)
 			intc_context[ind].ilr[i] =
-				intc_bank_read_reg(bank, (0x100 + 0x4*ind));
+				intc_bank_read_reg(bank, (0x100 + 0x4*i));
 		for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
 			intc_context[ind].mir[i] =
 				intc_bank_read_reg(&irq_banks[0], INTC_MIR0 +
@@ -267,7 +267,7 @@ void omap_intc_restore_context(void)
 					bank, INTC_THRESHOLD);
 		for (i = 0; i < INTCPS_NR_IRQS; i++)
 			intc_bank_write_reg(intc_context[ind].ilr[i],
-				bank, (0x100 + 0x4*ind));
+				bank, (0x100 + 0x4*i));
 		for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
 			intc_bank_write_reg(intc_context[ind].mir[i],
 				 &irq_banks[0], INTC_MIR0 + (0x20 * i));
-- 
1.6.4.3

