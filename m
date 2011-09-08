From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 6/9] TEMP: power: omap-prm: added omap3 static init
Date: Thu, 8 Sep 2011 18:22:21 +0300
Message-ID: <1315495344-23133-7-git-send-email-t-kristo@ti.com>
References: <1315495344-23133-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37213 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754023Ab1IHPWl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 11:22:41 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1315495344-23133-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, govindraj.raja@ti.com

This is a temporary hack until PRM hwmod data is available.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/power/omap_prm.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/power/omap_prm.c b/drivers/power/omap_prm.c
index ce0a872..7d59d92 100644
--- a/drivers/power/omap_prm.c
+++ b/drivers/power/omap_prm.c
@@ -264,14 +264,16 @@ static int __devexit omap_prm_complete(struct platform_device *pdev)
 
 static int __init omap_prm_probe(struct platform_device *pdev)
 {
-	/* XXX: prm_dev.irq_setup should be populated here */
+	prm_dev.irq_setup.ack = 0xb2000000 + 0x48306818;
+	prm_dev.irq_setup.mask = 0xb2000000 + 0x4830681c;
+	prm_dev.irq_setup.irq = INT_34XX_PRCM_MPU_IRQ;
+	prm_dev.irq_setup.nr_regs = 1;
+	prm_dev.irq_setup.nr_irqs = 32;
 
-	/* XXX: following calls should be enabled once irq_setup is done */
-#if 0
 	omap_prcm_irq_init();
 
 	prm_dev.irq_setup.io_irq = omap_prcm_event_to_irq("io");
-#endif
+
 	return 0;
 }
 
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

