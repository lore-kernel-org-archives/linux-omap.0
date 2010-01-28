From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/4] OMAP2/3: IRQ: ensure valid base address
Date: Thu, 28 Jan 2010 09:17:13 -0800
Message-ID: <1264699036-5491-2-git-send-email-khilman@deeprootsystems.com>
References: <1264699036-5491-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:54167 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756173Ab0A1RRV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 12:17:21 -0500
Received: by mail-pw0-f42.google.com with SMTP id 21so625474pwi.21
        for <linux-omap@vger.kernel.org>; Thu, 28 Jan 2010 09:17:20 -0800 (PST)
In-Reply-To: <1264699036-5491-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Ensure valid base address during IRQ init.  Fixes compiler warning
about potential use of uninitialized variable.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/irq.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 2705402..26aeef5 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -194,7 +194,7 @@ void __init omap_init_irq(void)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
-		unsigned long base;
+		unsigned long base = 0;
 		struct omap_irq_bank *bank = irq_banks + i;
 
 		if (cpu_is_omap24xx())
@@ -202,6 +202,8 @@ void __init omap_init_irq(void)
 		else if (cpu_is_omap34xx())
 			base = OMAP34XX_IC_BASE;
 
+		BUG_ON(!base);
+
 		/* Static mapping, never released */
 		bank->base_reg = ioremap(base, SZ_4K);
 		if (!bank->base_reg) {
-- 
1.6.6

