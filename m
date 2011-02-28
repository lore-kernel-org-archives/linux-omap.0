From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/3] OMAP: DSS2: Functions to request/release DSI VCs
Date: Mon, 28 Feb 2011 14:17:27 +0530
Message-ID: <1298882849-7432-2-git-send-email-archit@ti.com>
References: <1298882849-7432-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59369 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520Ab1B1Io4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 03:44:56 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1S8iu1Y025417
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 02:44:56 -0600
In-Reply-To: <1298882849-7432-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Introduce functions which request and release VC's. This will be used in panel
drivers in their probes.

omap_dsi_request_vc() takes in the pointer to the omap_dss_device, the VC_ID
parameter which goes into the header of the DSI packets, and returns a Virtual
channel number (or virtual channel register set) which it can use.

omap_dsi_releae_vc() takes the omap_dss_device pointer and frees all VCs which
were used by that device.

Initialisation of VC parameters is done in dsi_init().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    3 ++
 drivers/video/omap2/dss/dsi.c             |   55 ++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index d45f107..0057259 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -560,6 +560,9 @@ int omap_dsi_update(struct omap_dss_device *dssdev,
 		int channel,
 		u16 x, u16 y, u16 w, u16 h,
 		void (*callback)(int, void *), void *data);
+int omap_dsi_request_vc(struct omap_dss_device *dssdev, int vc_id,
+		int *channel);
+void omap_dsi_release_vc(struct omap_dss_device *dssdev);
 
 int omapdss_dsi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_dsi_display_disable(struct omap_dss_device *dssdev);
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index cda83b0..8118f62 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -233,8 +233,11 @@ static struct
 		enum dsi_vc_mode mode;
 		struct omap_dss_device *dssdev;
 		enum fifo_size fifo_size;
+		int vc_id;
 	} vc[4];
 
+	int num_vc_used;
+
 	struct mutex lock;
 	struct semaphore bus_lock;
 
@@ -1778,8 +1781,6 @@ static void dsi_vc_initial_config(int channel)
 	r = FLD_MOD(r, 4, 23, 21); /* DMA_TX_REQ_NB = no dma */
 
 	dsi_write_reg(DSI_VC_CTRL(channel), r);
-
-	dsi.vc[channel].mode = DSI_VC_MODE_L4;
 }
 
 static int dsi_vc_config_l4(int channel)
@@ -1986,7 +1987,7 @@ static inline void dsi_vc_write_long_header(int channel, u8 data_type,
 
 	WARN_ON(!dsi_bus_is_locked());
 
-	data_id = data_type | channel << 6;
+	data_id = data_type | dsi.vc[channel].vc_id << 6;
 
 	val = FLD_VAL(data_id, 7, 0) | FLD_VAL(len, 23, 8) |
 		FLD_VAL(ecc, 31, 24);
@@ -2089,7 +2090,7 @@ static int dsi_vc_send_short(int channel, u8 data_type, u16 data, u8 ecc)
 		return -EINVAL;
 	}
 
-	data_id = data_type | channel << 6;
+	data_id = data_type | dsi.vc[channel].vc_id << 6;
 
 	r = (data_id << 0) | (data << 8) | (ecc << 24);
 
@@ -3264,6 +3265,42 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
+int omap_dsi_request_vc(struct omap_dss_device *dssdev, int vc_id, int *channel)
+{
+	int p = dsi.num_vc_used;
+
+	if (p >= 4) {
+		DSSERR("cannot get VC for display %s", dssdev->name);
+		return -EINVAL;
+	}
+
+	dsi.vc[p].dssdev = dssdev;
+	dsi.vc[p].vc_id = vc_id;
+	*channel = p;
+
+	dsi.num_vc_used += 1;
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_dsi_request_vc);
+
+void omap_dsi_release_vc(struct omap_dss_device *dssdev)
+{
+	int i, num_vc_used_disp = 0;
+
+	for (i = 0; i < 4; i++) {
+		if (dsi.vc[i].dssdev == dssdev) {
+			dsi.vc[i].dssdev = NULL;
+			dsi.vc[i].vc_id = 0;
+			dsi.vc[i].mode = DSI_VC_MODE_L4;
+			num_vc_used_disp++;
+		}
+	}
+
+	dsi.num_vc_used -= num_vc_used_disp;
+}
+EXPORT_SYMBOL(omap_dsi_release_vc);
+
 void dsi_wait_pll_hsdiv_dispc_active(void)
 {
 	if (wait_for_bit_change(DSI_PLL_STATUS, 7, 1) != 1)
@@ -3283,7 +3320,7 @@ void dsi_wait_pll_hsdiv_dsi_active(void)
 static int dsi_init(struct platform_device *pdev)
 {
 	u32 rev;
-	int r;
+	int r, i;
 	struct resource *dsi_mem;
 
 	spin_lock_init(&dsi.errors_lock);
@@ -3337,6 +3374,14 @@ static int dsi_init(struct platform_device *pdev)
 		goto err2;
 	}
 
+	/* DSI VCs initialization */
+	for (i = 0; i < 4; i++) {
+		dsi.vc[i].mode = DSI_VC_MODE_L4;
+		dsi.vc[i].dssdev = NULL;
+		dsi.vc[i].vc_id = 0;
+	}
+
+	dsi.num_vc_used = 0;
 	enable_clocks(1);
 
 	rev = dsi_read_reg(DSI_REVISION);
-- 
1.7.1

