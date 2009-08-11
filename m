From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv2 04/20] OMAP: McBSP: Add transmit/receive threshold handler
Date: Tue, 11 Aug 2009 16:05:15 +0300
Message-ID: <1249995931-26015-5-git-send-email-eduardo.valentin@nokia.com>
References: <1249995931-26015-1-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-2-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-3-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-4-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46166 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214AbZHKNSj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 09:18:39 -0400
In-Reply-To: <1249995931-26015-4-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch adds a way to handle transmit/receive threshold.
It export to mcbsp users a callback registration procedure.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    9 +++++
 arch/arm/plat-omap/mcbsp.c              |   50 +++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 51908fb..c3dac63 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -389,6 +389,15 @@ int omap_mcbsp_init(void);
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
index 2383b08..4efc6d7 100644
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

