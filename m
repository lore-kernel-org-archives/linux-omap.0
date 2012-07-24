From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 5/5] arm: omap: debug-leds: switch to resource_size()
Date: Tue, 24 Jul 2012 11:54:02 +0300
Message-ID: <1343120042-16695-6-git-send-email-balbi@ti.com>
References: <1343120042-16695-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:50445 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751965Ab2GXI50 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jul 2012 04:57:26 -0400
Received: by lagw12 with SMTP id w12so666060lag.24
        for <linux-omap@vger.kernel.org>; Tue, 24 Jul 2012 01:57:23 -0700 (PDT)
In-Reply-To: <1343120042-16695-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

instead of hardcoding the address space size, we
can calculate it using resource_size() helper.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/debug-leds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
index 08fbb85..ebc0317 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -272,7 +272,7 @@ static int __devinit fpga_probe(struct platform_device *pdev)
 	if (!iomem)
 		return -ENODEV;
 
-	fpga = ioremap(iomem->start, H2P2_DBG_FPGA_SIZE);
+	fpga = ioremap(iomem->start, resource_size(iomem));
 	__raw_writew(~0, &fpga->leds);
 
 #ifdef	CONFIG_LEDS
-- 
1.7.11

