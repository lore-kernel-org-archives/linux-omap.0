From: "HU TAO-TGHK48" <taohu@motorola.com>
Subject: [PATCH] Fix race condition in omap_request_dma()
Date: Fri, 30 Oct 2009 11:30:04 +0800
Message-ID: <F12CE1A68F023D498A2691C7B539311503B17F61@ZMY16EXM66.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail128.messagelabs.com ([216.82.250.131]:39342 "EHLO
	mail128.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694AbZJ3DaY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 23:30:24 -0400
Received: from il27exr04.cig.mot.com (il27exr04.mot.com [10.17.196.73])
	by motgate2.mot.com (8.14.3/8.14.3) with ESMTP id n9U3USkO005973
	for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 20:30:28 -0700 (MST)
Received: from il27vts01 (il27vts01.cig.mot.com [10.17.196.85])
	by il27exr04.cig.mot.com (8.13.1/Vontu) with SMTP id n9U3USh8002121
	for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 22:30:28 -0500 (CDT)
Received: from ZMY16EXM66.ds.mot.com (zmy16exm66.ap.mot.com [10.179.4.26])
	by il27exr04.cig.mot.com (8.13.1/8.13.0) with ESMTP id n9U3UQ4i002111
	for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 22:30:27 -0500 (CDT)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Yang Fei-AFY095 <fei.yang@motorola.com>, jon-hunter@ti.com, Zhou Ming-a17711 <a17711@motorola.com>, "Ye Yuan.Bo-A22116" <yuan-bo.ye@motorola.com>

>From a36dac7ee6140ffa23f0adc024964aaf3e266e5f Mon Sep 17 00:00:00 2001
From: Tao Hu <taohu@motorola.com>
Date: Thu, 29 Oct 2009 17:17:21 -0500
Subject: [PATCH] Fix race condition in omap_request_dma()

The bug could cause irq enable bit of one DMA channel is
cleared unexpectedly when 2 (or more) drivers are calling
omap_request_dma() simultaneously

Signed-off-by: Fei Yang <AFY095@motorola.com>
Signed-off-by: Tao Hu  <taohu@motorola.com>
---
 arch/arm/plat-omap/dma.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index cd53b28..6895484 100755
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -749,11 +749,13 @@ int omap_request_dma(int dev_id, const char
*dev_name,
 	}
 
 	if (cpu_class_is_omap2()) {
+		spin_lock_irqsave(&dma_chan_lock, flags);
 		omap2_enable_irq_lch(free_ch);
 		omap_enable_channel_irq(free_ch);
 		/* Clear the CSR register and IRQ status register */
 		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(free_ch));
 		dma_write(1 << free_ch, IRQSTATUS_L0);
+		spin_unlock_irqrestore(&dma_chan_lock, flags);
 	}
 
 	*dma_ch_out = free_ch;
-- 
1.5.4.3


