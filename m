From: "Girish. S. G." <girishsg@ti.com>
Subject: [PATCH 1/2] driver: irda support 3430
Date: Thu, 3 Jul 2008 12:15:09 +0530 (IST)
Message-ID: <63319.192.168.10.89.1215067509.squirrel@dbdmail.itg.ti.com>
Reply-To: girishsg@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52375 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755397AbYGCGpP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jul 2008 02:45:15 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m636jAW3012250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 3 Jul 2008 01:45:15 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m636j8W0000630
	for <linux-omap@vger.kernel.org>; Thu, 3 Jul 2008 01:45:09 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Irda driver changes to support on 3430

Signed-off-by: Girish S G <girishsg@ti.com>
---
 drivers/net/irda/omap-ir.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

Index: linux-omap-2.6_today/drivers/net/irda/omap-ir.c
===================================================================
--- linux-omap-2.6_today.orig/drivers/net/irda/omap-ir.c	2008-07-03
10:33:57.000000000 +0530
+++ linux-omap-2.6_today/drivers/net/irda/omap-ir.c	2008-07-03
10:35:30.000000000 +0530
@@ -217,7 +217,7 @@
 	struct net_device *dev = data;
 	struct omap_irda *omap_ir = netdev_priv(dev);

-	/*Stop DMA controller */
+	/* Stop DMA controller */
 	omap_stop_dma(omap_ir->tx_dma_channel);
 }

@@ -378,8 +378,12 @@

 		skb_reserve(skb, 1);

-		w = omap_get_dma_dst_pos(omap_ir->rx_dma_channel) -
-						omap_ir->rx_buf_dma_phys;
+		w = OMAP_DMA4_CDAC(omap_ir->rx_dma_channel);
+
+		if (cpu_is_omap16xx())
+			w -= OMAP1_DMA_CDSA_L(omap_ir->rx_dma_channel);
+		if (cpu_is_omap24xx() || cpu_is_omap34xx())
+			w -= OMAP_DMA4_CDSA(omap_ir->rx_dma_channel);

 		if (!IS_FIR(omap_ir))
 			/* Copy DMA buffer to skb */
@@ -604,6 +608,8 @@
 err_irlap:
 	omap_ir->open = 0;
 	omap_irda_shutdown(omap_ir);
+	if (omap_ir->pdata->select_irda)
+		omap_ir->pdata->select_irda(omap_ir->dev, ~IR_SEL);
 err_startup:
 	dma_free_coherent(NULL, IRDA_SIR_MAX_FRAME,
 			omap_ir->tx_buf_dma_virt, omap_ir->tx_buf_dma_phys);
@@ -636,6 +642,8 @@
 				omap_ir->tx_buf_dma_phys);

 	omap_irda_shutdown(omap_ir);
+	if (omap_ir->pdata->select_irda)
+		omap_ir->pdata->select_irda(omap_ir->dev, ~IR_SEL);

 	/* Stop IrLAP */
 	if (omap_ir->irlap) {

