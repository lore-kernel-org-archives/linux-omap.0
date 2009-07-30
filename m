From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 07/20] OMAP: McBSP: Add transmit/receive threshold handler
Date: Thu, 30 Jul 2009 15:49:30 +0300
Message-ID: <1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:35081 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbZG3NBC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 09:01:02 -0400
In-Reply-To: <1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

This patch adds a way to handle transmit/receive threshold.
It export to mcbsp users a callback registration procedure.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |   13 ++++++++
 arch/arm/plat-omap/mcbsp.c              |   50 +++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index e3b300c..26bcab8 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -259,6 +259,10 @@
 #define ENAWAKEUP		0x0004
 #define SOFTRST			0x0002
 
+/********************** McBSP IRQSTATUS bit definitions ********************/
+#define IRQST_XRDY		(1<<10)
+#define IRQST_RRDY		(1<<3)
+
 /********************** McBSP WAKEUPEN bit definitions *********************/
 #define XEMPTYEOFEN		0x4000
 #define XRDYEN			0x0400
@@ -405,6 +409,15 @@ int omap_mcbsp_init(void);
 void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 					int size);
 void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config);
+#ifdef CONFIG_ARCH_OMAP34XX
+void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
+void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold);
+#else
+static inline void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
+{ }
+static inline void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
+{ }
+#endif
 int omap_mcbsp_request(unsigned int id);
 void omap_mcbsp_free(unsigned int id);
 void omap_mcbsp_start(unsigned int id);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 373926d..60e9254 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -198,6 +198,56 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 }
 EXPORT_SYMBOL(omap_mcbsp_config);
 
+#ifdef CONFIG_ARCH_OMAP34XX
+/*
+ * omap_mcbsp_set_tx_threshold configures how to deal
+ * with transmit threshold. the threshold value and handler can be
+ * configure in here.
+ */
+void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
+
+	if (!cpu_is_omap34xx())
+		return;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base = mcbsp->io_base;
+
+	OMAP_MCBSP_WRITE(io_base, THRSH2, threshold);
+}
+EXPORT_SYMBOL(omap_mcbsp_set_tx_threshold);
+
+/*
+ * omap_mcbsp_set_rx_threshold configures how to deal
+ * with receive threshold. the threshold value and handler can be
+ * configure in here.
+ */
+void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
+
+	if (!cpu_is_omap34xx())
+		return;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base = mcbsp->io_base;
+
+	OMAP_MCBSP_WRITE(io_base, THRSH1, threshold);
+}
+EXPORT_SYMBOL(omap_mcbsp_set_rx_threshold);
+#endif
+
 /*
  * We can choose between IRQ based or polled IO.
  * This needs to be called before omap_mcbsp_request().
-- 
1.6.2.GIT

