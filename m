From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v5 1/5] OMAP: McBSP: Function to query the FIFO size
Date: Thu,  3 Jun 2010 07:39:32 +0300
Message-ID: <1275539976-2075-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1275539976-2075-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37191 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab0FCEjz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 00:39:55 -0400
In-Reply-To: <1275539976-2075-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, tony@atomide.com
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, jhnikula@gmail.com, ext-eero.nurkkala@nokia.com, eduardo.valentin@nokia.com

Users of McBSP can use the omap_mcbsp_get_fifo_size function to query
the size of the McBSP FIFO.
The function will return the FIFO size in words (the HW maximum).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
Acked-by: Mark Brown <broonie@opensource.wolsfonmicro.com>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |    2 ++
 arch/arm/plat-omap/mcbsp.c              |   14 ++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 1bd7021..e126951 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -473,6 +473,7 @@ void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
 void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold);
 u16 omap_mcbsp_get_max_tx_threshold(unsigned int id);
 u16 omap_mcbsp_get_max_rx_threshold(unsigned int id);
+u16 omap_mcbsp_get_fifo_size(unsigned int id);
 u16 omap_mcbsp_get_tx_delay(unsigned int id);
 u16 omap_mcbsp_get_rx_delay(unsigned int id);
 int omap_mcbsp_get_dma_op_mode(unsigned int id);
@@ -483,6 +484,7 @@ static inline void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
 { }
 static inline u16 omap_mcbsp_get_max_tx_threshold(unsigned int id) { return 0; }
 static inline u16 omap_mcbsp_get_max_rx_threshold(unsigned int id) { return 0; }
+static inline u16 omap_mcbsp_get_fifo_size(unsigned int id) { return 0; }
 static inline u16 omap_mcbsp_get_tx_delay(unsigned int id) { return 0; }
 static inline u16 omap_mcbsp_get_rx_delay(unsigned int id) { return 0; }
 static inline int omap_mcbsp_get_dma_op_mode(unsigned int id) { return 0; }
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 4820cab..51d8abf 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -559,6 +559,20 @@ u16 omap_mcbsp_get_max_rx_threshold(unsigned int id)
 }
 EXPORT_SYMBOL(omap_mcbsp_get_max_rx_threshold);
 
+u16 omap_mcbsp_get_fifo_size(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+
+	return mcbsp->pdata->buffer_size;
+}
+EXPORT_SYMBOL(omap_mcbsp_get_fifo_size);
+
 #define MCBSP2_FIFO_SIZE	0x500 /* 1024 + 256 locations */
 #define MCBSP1345_FIFO_SIZE	0x80  /* 128 locations */
 /*
-- 
1.7.1

