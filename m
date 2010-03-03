From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCHv2 4/5] OMAP3: McBSP: Add interface for FIFO caused delay query
Date: Wed,  3 Mar 2010 15:08:08 +0200
Message-ID: <1267621689-30337-6-git-send-email-peter.ujfalusi@nokia.com>
References: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32540 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab0CCNIf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 08:08:35 -0500
In-Reply-To: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, tony@atomide.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, jhnikula@gmail.com, ext-eero.nurkkala@nokia.com

New functions for querying the FIFO caused delay on both
TX and RX path.
On TX path the return value shows the number of used
locations in the FIFO.
On RX papth it returns the number of locations to be filled
to reach the threshold value (DMA will be triggered to read
the data out from the FIFO).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |    6 +++
 arch/arm/plat-omap/mcbsp.c              |   55 +++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 3974835..1bd7021 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -149,6 +149,8 @@
 #define OMAP_MCBSP_REG_WAKEUPEN	0xA8
 #define OMAP_MCBSP_REG_XCCR	0xAC
 #define OMAP_MCBSP_REG_RCCR	0xB0
+#define OMAP_MCBSP_REG_XBUFFSTAT	0xB4
+#define OMAP_MCBSP_REG_RBUFFSTAT	0xB8
 #define OMAP_MCBSP_REG_SSELCR	0xBC
 
 #define OMAP_ST_REG_REV		0x00
@@ -471,6 +473,8 @@ void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
 void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold);
 u16 omap_mcbsp_get_max_tx_threshold(unsigned int id);
 u16 omap_mcbsp_get_max_rx_threshold(unsigned int id);
+u16 omap_mcbsp_get_tx_delay(unsigned int id);
+u16 omap_mcbsp_get_rx_delay(unsigned int id);
 int omap_mcbsp_get_dma_op_mode(unsigned int id);
 #else
 static inline void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
@@ -479,6 +483,8 @@ static inline void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
 { }
 static inline u16 omap_mcbsp_get_max_tx_threshold(unsigned int id) { return 0; }
 static inline u16 omap_mcbsp_get_max_rx_threshold(unsigned int id) { return 0; }
+static inline u16 omap_mcbsp_get_tx_delay(unsigned int id) { return 0; }
+static inline u16 omap_mcbsp_get_rx_delay(unsigned int id) { return 0; }
 static inline int omap_mcbsp_get_dma_op_mode(unsigned int id) { return 0; }
 #endif
 int omap_mcbsp_request(unsigned int id);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index e47686e..5e6d309 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -561,6 +561,61 @@ u16 omap_mcbsp_get_max_rx_threshold(unsigned int id)
 }
 EXPORT_SYMBOL(omap_mcbsp_get_max_rx_threshold);
 
+#define MCBSP2_FIFO_SIZE	0x500 /* 1024 + 256 locations */
+#define MCBSP1345_FIFO_SIZE	0x80  /* 128 locations */
+/*
+ * omap_mcbsp_get_tx_delay returns the number of used slots in the McBSP FIFO
+ */
+u16 omap_mcbsp_get_tx_delay(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+	u16 buffstat;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+
+	/* Returns the number of free locations in the buffer */
+	buffstat = MCBSP_READ(mcbsp, XBUFFSTAT);
+
+	/* Number of slots are different in McBSP ports */
+	if (mcbsp->id == 2)
+		return MCBSP2_FIFO_SIZE - buffstat;
+	else
+		return MCBSP1345_FIFO_SIZE - buffstat;
+}
+EXPORT_SYMBOL(omap_mcbsp_get_tx_delay);
+
+/*
+ * omap_mcbsp_get_rx_delay returns the number of free slots in the McBSP FIFO
+ * to reach the threshold value (when the DMA will be triggered to read it)
+ */
+u16 omap_mcbsp_get_rx_delay(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+	u16 buffstat, threshold;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+
+	/* Returns the number of used locations in the buffer */
+	buffstat = MCBSP_READ(mcbsp, RBUFFSTAT);
+	/* RX threshold */
+	threshold = MCBSP_READ(mcbsp, THRSH1);
+
+	/* Return the number of location till we reach the threshold limit */
+	if (threshold <= buffstat)
+		return 0;
+	else
+		return threshold - buffstat;
+}
+EXPORT_SYMBOL(omap_mcbsp_get_rx_delay);
+
 /*
  * omap_mcbsp_get_dma_op_mode just return the current configured
  * operating mode for the mcbsp channel
-- 
1.7.0

