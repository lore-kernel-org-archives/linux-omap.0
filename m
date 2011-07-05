From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [PATCH] ARM: omap4: rename gpmc clock to gpmc_ick
Date: Tue, 5 Jul 2011 14:19:37 +0200
Message-ID: <1309868377-22379-1-git-send-email-j.weitzel@phytec.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.phytec.co.uk ([217.6.246.34]:60080 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932147Ab1GEMTl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Jul 2011 08:19:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, tony@atomide.com, Jan Weitzel <j.weitzel@phytec.de>

The gpmc clock on omap44xx is called gpmc_ick not gpmc_ck in
clock44xx_data.c

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
 arch/arm/mach-omap2/gpmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 130034b..34bcd17 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -708,7 +708,7 @@ static int __init gpmc_init(void)
 		l = OMAP34XX_GPMC_BASE;
 		gpmc_irq = INT_34XX_GPMC_IRQ;
 	} else if (cpu_is_omap44xx()) {
-		ck = "gpmc_ck";
+		ck = "gpmc_ick";
 		l = OMAP44XX_GPMC_BASE;
 		gpmc_irq = OMAP44XX_IRQ_GPMC;
 	}
-- 
1.7.0.4

