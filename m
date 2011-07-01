From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 11/12] omap: mcbsp: Remove conditional compilation for OMAP3
Date: Fri,  1 Jul 2011 11:52:35 +0300
Message-ID: <1309510356-27147-12-git-send-email-jhnikula@gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58452 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755760Ab1GAIxQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 04:53:16 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so2453487bwd.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 01:53:15 -0700 (PDT)
In-Reply-To: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

Although this increases the build size a little for !OMAP3 builds it makes
the code one step more generic. For instance the threshold based DMA
transfers seems to be possible with OMAP4 too from quick look of the TRM.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |   35 ++++--------------------------
 arch/arm/plat-omap/mcbsp.c              |   13 -----------
 2 files changed, 5 insertions(+), 43 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 2a7e8d5..720461c 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -26,9 +26,6 @@
 
 #include <linux/spinlock.h>
 
-#include <mach/hardware.h>
-#include <plat/clock.h>
-
 /* macro for building platform_device for McBSP ports */
 #define OMAP_MCBSP_PLATFORM_DEVICE(port_nr)		\
 static struct platform_device omap_mcbsp##port_nr = {	\
@@ -314,11 +311,11 @@ struct omap_mcbsp_platform_data {
 	u8 dma_rx_sync, dma_tx_sync;
 	u16 rx_irq, tx_irq;
 	struct omap_mcbsp_ops *ops;
-#ifdef CONFIG_ARCH_OMAP3
+
 	/* Sidetone block for McBSP 2 and 3 */
 	unsigned long phys_base_st;
 	int (*enable_st_clock)(unsigned int, bool);
-#endif
+
 	u16 buffer_size;
 	unsigned int mcbsp_config_type;
 	u8 reg_size;
@@ -354,12 +351,12 @@ struct omap_mcbsp {
 	spinlock_t lock;
 	struct omap_mcbsp_platform_data *pdata;
 	struct clk *fclk;
-#ifdef CONFIG_ARCH_OMAP3
+
 	struct omap_mcbsp_st_data *st_data;
 	int dma_op_mode;
 	u16 max_tx_thres;
 	u16 max_rx_thres;
-#endif
+
 	void *reg_cache;
 	unsigned int mcbsp_config_type;
 };
@@ -380,7 +377,6 @@ extern int omap_mcbsp_count, omap_mcbsp_cache_size;
 
 int omap_mcbsp_init(void);
 void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config);
-#ifdef CONFIG_ARCH_OMAP3
 void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
 void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold);
 u16 omap_mcbsp_get_max_tx_threshold(unsigned int id);
@@ -389,18 +385,7 @@ u16 omap_mcbsp_get_fifo_size(unsigned int id);
 u16 omap_mcbsp_get_tx_delay(unsigned int id);
 u16 omap_mcbsp_get_rx_delay(unsigned int id);
 int omap_mcbsp_get_dma_op_mode(unsigned int id);
-#else
-static inline void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
-{ }
-static inline void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
-{ }
-static inline u16 omap_mcbsp_get_max_tx_threshold(unsigned int id) { return 0; }
-static inline u16 omap_mcbsp_get_max_rx_threshold(unsigned int id) { return 0; }
-static inline u16 omap_mcbsp_get_fifo_size(unsigned int id) { return 0; }
-static inline u16 omap_mcbsp_get_tx_delay(unsigned int id) { return 0; }
-static inline u16 omap_mcbsp_get_rx_delay(unsigned int id) { return 0; }
-static inline int omap_mcbsp_get_dma_op_mode(unsigned int id) { return 0; }
-#endif
+
 int omap_mcbsp_request(unsigned int id);
 void omap_mcbsp_free(unsigned int id);
 void omap_mcbsp_start(unsigned int id, int tx, int rx);
@@ -416,21 +401,11 @@ void omap2_mcbsp1_mux_fsr_src(u8 mux);
 int omap_mcbsp_dma_ch_params(unsigned int id, unsigned int stream);
 int omap_mcbsp_dma_reg_params(unsigned int id, unsigned int stream);
 
-#ifdef CONFIG_ARCH_OMAP3
 /* Sidetone specific API */
 int omap_st_set_chgain(unsigned int id, int channel, s16 chgain);
 int omap_st_get_chgain(unsigned int id, int channel, s16 *chgain);
 int omap_st_enable(unsigned int id);
 int omap_st_disable(unsigned int id);
 int omap_st_is_enabled(unsigned int id);
-#else
-static inline int omap_st_set_chgain(unsigned int id, int channel,
-				     s16 chgain) { return 0; }
-static inline int omap_st_get_chgain(unsigned int id, int channel,
-				     s16 *chgain) { return 0; }
-static inline int omap_st_enable(unsigned int id) { return 0; }
-static inline int omap_st_disable(unsigned int id) { return 0; }
-static inline int omap_st_is_enabled(unsigned int id) {  return 0; }
-#endif
 
 #endif
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 1a7cfb3..d565b36 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -63,7 +63,6 @@ static int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache)
 	}
 }
 
-#ifdef CONFIG_ARCH_OMAP3
 static void omap_mcbsp_st_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
 {
 	__raw_writel(val, mcbsp->st_data->io_base_st + reg);
@@ -73,7 +72,6 @@ static int omap_mcbsp_st_read(struct omap_mcbsp *mcbsp, u16 reg)
 {
 	return __raw_readl(mcbsp->st_data->io_base_st + reg);
 }
-#endif
 
 #define MCBSP_READ(mcbsp, reg) \
 		omap_mcbsp_read(mcbsp, OMAP_MCBSP_REG_##reg, 0)
@@ -258,7 +256,6 @@ int omap_mcbsp_dma_reg_params(unsigned int id, unsigned int stream)
 }
 EXPORT_SYMBOL(omap_mcbsp_dma_reg_params);
 
-#ifdef CONFIG_ARCH_OMAP3
 static void omap_st_on(struct omap_mcbsp *mcbsp)
 {
 	unsigned int w;
@@ -657,11 +654,6 @@ int omap_mcbsp_get_dma_op_mode(unsigned int id)
 }
 EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
 
-#else
-static inline void omap_st_start(struct omap_mcbsp *mcbsp) {}
-static inline void omap_st_stop(struct omap_mcbsp *mcbsp) {}
-#endif
-
 int omap_mcbsp_request(unsigned int id)
 {
 	struct omap_mcbsp *mcbsp;
@@ -935,7 +927,6 @@ void omap2_mcbsp1_mux_fsr_src(u8 mux)
 }
 #endif
 
-#ifdef CONFIG_ARCH_OMAP3
 #define max_thres(m)			(mcbsp->pdata->buffer_size)
 #define valid_threshold(m, val)		((val) <= max_thres(m))
 #define THRESHOLD_PROP_BUILDER(prop)					\
@@ -1205,10 +1196,6 @@ static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp)
 			omap_st_remove(mcbsp);
 	}
 }
-#else
-static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp) {}
-static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp) {}
-#endif /* CONFIG_ARCH_OMAP3 */
 
 /*
  * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
-- 
1.7.0.4

