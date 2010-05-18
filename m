From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 1/4] OMAP: mcbsp - add omap_mcbsp_set_dma_op_mode()
Date: Tue, 18 May 2010 21:13:11 +0100
Message-ID: <1274213594-26554-2-git-send-email-lrg@slimlogic.co.uk>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:39291 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806Ab0ERUNt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 16:13:49 -0400
Received: by wwb22 with SMTP id 22so61884wwb.19
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 13:13:48 -0700 (PDT)
In-Reply-To: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>

This adds a method to set the MCBSP DMA OP mode.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |    2 ++
 arch/arm/plat-omap/mcbsp.c              |   31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 1bd7021..f8823f4 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -476,6 +476,7 @@ u16 omap_mcbsp_get_max_rx_threshold(unsigned int id);
 u16 omap_mcbsp_get_tx_delay(unsigned int id);
 u16 omap_mcbsp_get_rx_delay(unsigned int id);
 int omap_mcbsp_get_dma_op_mode(unsigned int id);
+int omap_mcbsp_set_dma_op_mode(unsigned int id, unsigned int mode);
 #else
 static inline void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
 { }
@@ -486,6 +487,7 @@ static inline u16 omap_mcbsp_get_max_rx_threshold(unsigned int id) { return 0; }
 static inline u16 omap_mcbsp_get_tx_delay(unsigned int id) { return 0; }
 static inline u16 omap_mcbsp_get_rx_delay(unsigned int id) { return 0; }
 static inline int omap_mcbsp_get_dma_op_mode(unsigned int id) { return 0; }
+static inline int omap_mcbsp_set_dma_op_mode(unsigned int id, unsigned int mode) {return 0;}
 #endif
 int omap_mcbsp_request(unsigned int id);
 void omap_mcbsp_free(unsigned int id);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 4820cab..cc2b73c 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -635,6 +635,37 @@ int omap_mcbsp_get_dma_op_mode(unsigned int id)
 }
 EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
 
+/*
+ * omap_mcbsp_set_dma_op_mode set the current DMA
+ * operating mode for the mcbsp channel
+ */
+int omap_mcbsp_set_dma_op_mode(unsigned int id, unsigned int mode)
+{
+	struct omap_mcbsp *mcbsp;
+	int ret = 0;
+
+	if (mode > MCBSP_DMA_MODE_FRAME)
+		return -EINVAL;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+
+	spin_lock_irq(&mcbsp->lock);
+	if (!mcbsp->free) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+	mcbsp->dma_op_mode = mode;
+
+unlock:
+	spin_unlock_irq(&mcbsp->lock);
+	return ret;
+}
+EXPORT_SYMBOL(omap_mcbsp_set_dma_op_mode);
+
 static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 {
 	/*
-- 
1.7.0.4

