From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 4/9] dmaengine/ARM: omap-dma: Fix the DMAengine compile test on non OMAP configs
Date: Wed, 21 Sep 2016 13:26:32 +0300
Message-ID: <20160921102637.24845-5-peter.ujfalusi@ti.com>
References: <20160921102637.24845-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160921102637.24845-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: arnd@arndb.de, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

The DMAengine driver for omap-dma use three function calls from the
plat-omap legacy driver. When the DMAengine driver is built when ARCH_OMAP
is not set, the compilation will fail due to missing symbols.
Add empty inline functions to allow the DMAengine driver to be compiled
with COMPILE_TEST.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/omap-dma.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
index 1d99b61adc65..290081620b3e 100644
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -297,6 +297,7 @@ struct omap_system_dma_plat_info {
 #define dma_omap15xx()	__dma_omap15xx(d)
 #define dma_omap16xx()	__dma_omap16xx(d)
 
+#if defined(CONFIG_ARCH_OMAP)
 extern struct omap_system_dma_plat_info *omap_get_plat_info(void);
 
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
@@ -355,4 +356,22 @@ static inline int omap_lcd_dma_running(void)
 }
 #endif
 
+#else /* CONFIG_ARCH_OMAP */
+
+static inline struct omap_system_dma_plat_info *omap_get_plat_info(void)
+{
+	return NULL;
+}
+
+static inline int omap_request_dma(int dev_id, const char *dev_name,
+			void (*callback)(int lch, u16 ch_status, void *data),
+			void *data, int *dma_ch)
+{
+	return -ENODEV;
+}
+
+static inline void omap_free_dma(int ch) { }
+
+#endif /* CONFIG_ARCH_OMAP */
+
 #endif /* __LINUX_OMAP_DMA_H */
-- 
2.10.0
