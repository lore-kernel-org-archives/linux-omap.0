From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 1/6] arm: mach-omap2: omap_l3_smx: fix request_irq() error path
Date: Thu, 24 Mar 2011 18:35:30 +0200
Message-ID: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:28699 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973Ab1CXQiX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 12:38:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

The debug irq should be freed on the error path.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/omap_l3_smx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/omap_l3_smx.c
index 265bff3..02528cb 100644
--- a/arch/arm/mach-omap2/omap_l3_smx.c
+++ b/arch/arm/mach-omap2/omap_l3_smx.c
@@ -273,6 +273,7 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
 	goto err0;
 
 err4:
+	free_irq(l3->debug_irq, l3);
 err3:
 	iounmap(l3->rt);
 err2:
-- 
1.5.6.5

