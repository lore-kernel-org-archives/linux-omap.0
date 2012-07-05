From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v1 06/14] ARM: OMAP5: gpmc: Update gpmc_init()
Date: Thu, 5 Jul 2012 17:38:48 +0530
Message-ID: <1341490136-25901-11-git-send-email-santosh.shilimkar@ti.com>
References: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33866 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821Ab2GEMKX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jul 2012 08:10:23 -0400
In-Reply-To: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, R Sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: R Sricharan <r.sricharan@ti.com>

GPMC module is the same as in OMAP4.
Just update the base address and irq number.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 2286410..fa21b4b 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -727,7 +727,8 @@ static int __init gpmc_init(void)
 		ck = "gpmc_fck";
 		l = OMAP34XX_GPMC_BASE;
 		gpmc_irq = INT_34XX_GPMC_IRQ;
-	} else if (cpu_is_omap44xx()) {
+	} else if (cpu_is_omap44xx() || cpu_is_omap54xx()) {
+		/* Base address and irq number are same for OMAP4/5 */
 		ck = "gpmc_ck";
 		l = OMAP44XX_GPMC_BASE;
 		gpmc_irq = OMAP44XX_IRQ_GPMC;
-- 
1.7.9.5

