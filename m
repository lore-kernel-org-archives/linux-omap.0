From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/9] OMAP2/3: IRQ: ensure valid base address
Date: Tue, 02 Feb 2010 18:26:07 -0800
Message-ID: <20100203022607.26347.33963.stgit@baageli.muru.com>
References: <20100203022318.26347.34734.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61447 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331Ab0BCCZj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 21:25:39 -0500
In-Reply-To: <20100203022318.26347.34734.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

From: Kevin Hilman <khilman@deeprootsystems.com>

Ensure valid base address during IRQ init.  Fixes compiler warning
about potential use of uninitialized variable.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

