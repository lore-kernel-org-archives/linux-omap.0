From: Russ Dill <Russ.Dill@ti.com>
Subject: [RFC 3/4] Misc: SRAM: Hack for allowing executable code in SRAM.
Date: Tue,  3 Sep 2013 09:44:24 -0700
Message-ID: <1378226665-27090-4-git-send-email-Russ.Dill@ti.com>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:59547 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757068Ab3ICQof (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Sep 2013 12:44:35 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so6301203pdi.28
        for <linux-omap@vger.kernel.org>; Tue, 03 Sep 2013 09:44:34 -0700 (PDT)
In-Reply-To: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, mans@mansr.com

The generic SRAM mechanism does not ioremap memory in a
manner that allows code to be executed from SRAM. There is
currently no generic way to request ioremap to return a
memory area with execution allowed.

Insert a temporary hack for proof of concept on ARM.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 drivers/misc/sram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 08baaab..e059a23 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -31,6 +31,7 @@
 #include <linux/genalloc.h>
 #include <linux/sram.h>
 #include <asm-generic/cacheflush.h>
+#include <asm/io.h>
 
 #define SRAM_GRANULARITY	32
 
@@ -138,7 +139,7 @@ static int sram_probe(struct platform_device *pdev)
 	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	virt_base = devm_ioremap_resource(&pdev->dev, res);
+	virt_base = __arm_ioremap_exec(res->start, resource_size(res), false);
 	if (IS_ERR(virt_base))
 		return PTR_ERR(virt_base);
 
-- 
1.8.3.2

