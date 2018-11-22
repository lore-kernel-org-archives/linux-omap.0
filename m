From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 13/17] soc: ti: pruss: export pruss_intc_configure/unconfigure APIs
Date: Thu, 22 Nov 2018 13:39:09 +0200
Message-ID: <1542886753-17625-14-git-send-email-rogerq@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542886753-17625-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

The PRU remoteproc driver will need to configure the
Interrupt controller based on the application specific
interrupt map.

Export pruss_intc_configure() and pruss_intc_unconfigure()
to linux/pruss.h

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/soc/ti/pruss.h | 21 -------------------
 include/linux/pruss.h  | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/ti/pruss.h b/drivers/soc/ti/pruss.h
index 45de1be..ce3f96a 100644
--- a/drivers/soc/ti/pruss.h
+++ b/drivers/soc/ti/pruss.h
@@ -9,12 +9,6 @@
 #ifndef _PRUSS_H_
 #define _PRUSS_H_
 
-/* maximum number of system events */
-#define MAX_PRU_SYS_EVENTS	64
-
-/* maximum number of interrupt channels */
-#define MAX_PRU_CHANNELS	10
-
 /* minimum starting host interrupt number for MPU */
 #define MIN_PRU_HOST_INT	2
 
@@ -22,16 +16,6 @@
 #define MAX_PRU_HOST_INT	10
 
 /**
- * struct pruss_intc_config - INTC configuration info
- * @sysev_to_ch: system events to channel mapping information
- * @ch_to_host: interrupt channel to host interrupt information
- */
-struct pruss_intc_config {
-	s8 sysev_to_ch[MAX_PRU_SYS_EVENTS];
-	s8 ch_to_host[MAX_PRU_CHANNELS];
-};
-
-/**
  * struct pruss - PRUSS parent structure
  * @dev: pruss device pointer
  * @cfg: regmap for config region
@@ -49,9 +33,4 @@ struct pruss {
 	struct mutex lock; /* PRU resource lock */
 };
 
-int pruss_intc_configure(struct pruss *pruss,
-			 struct pruss_intc_config *intc_config);
-int pruss_intc_unconfigure(struct pruss *pruss,
-			   struct pruss_intc_config *intc_config);
-
 #endif	/* _PRUSS_H_ */
diff --git a/include/linux/pruss.h b/include/linux/pruss.h
index 3ed175a..c797fb1 100644
--- a/include/linux/pruss.h
+++ b/include/linux/pruss.h
@@ -118,6 +118,22 @@ struct pruss_mem_region {
 	size_t size;
 };
 
+/* maximum number of system events */
+#define MAX_PRU_SYS_EVENTS	64
+
+/* maximum number of interrupt channels */
+#define MAX_PRU_CHANNELS	10
+
+/**
+ * struct pruss_intc_config - INTC configuration info
+ * @sysev_to_ch: system events to channel mapping information
+ * @ch_to_host: interrupt channel to host interrupt information
+ */
+struct pruss_intc_config {
+	s8 sysev_to_ch[MAX_PRU_SYS_EVENTS];
+	s8 ch_to_host[MAX_PRU_CHANNELS];
+};
+
 struct pruss;
 
 #if IS_ENABLED(CONFIG_TI_PRUSS)
@@ -136,6 +152,34 @@ int pruss_cfg_read(struct pruss *pruss, unsigned int reg, unsigned int *val);
 int pruss_cfg_update(struct pruss *pruss, unsigned int reg,
 		     unsigned int mask, unsigned int val);
 
+/**
+ * pruss_intc_configure() - configure the PRUSS INTC
+ * @pruss: the pruss instance
+ * @intc_config: PRU core-specific INTC configuration
+ *
+ * Configures the PRUSS INTC with the provided configuration from
+ * a PRU core. Any existing event to channel mappings or channel to
+ * host interrupt mappings are checked to make sure there are no
+ * conflicting configuration between both the PRU cores. The function
+ * is intended to be used only by the PRU remoteproc driver.
+ *
+ * Returns 0 on success, or a suitable error code otherwise
+ */
+int pruss_intc_configure(struct pruss *pruss,
+			 struct pruss_intc_config *intc_config);
+
+/**
+ * pruss_intc_unconfigure() - unconfigure the PRUSS INTC
+ * @pruss: the pruss instance
+ * @intc_config: PRU core specific INTC configuration
+ *
+ * Undo whatever was done in pruss_intc_configure() for a PRU core.
+ * It should be sufficient to just mark the resources free in the
+ * global map and disable the host interrupts and sysevents.
+ */
+int pruss_intc_unconfigure(struct pruss *pruss,
+			   struct pruss_intc_config *intc_config);
+
 #else
 
 static inline struct pruss *pruss_get(struct rproc *rproc)
@@ -174,6 +218,18 @@ int pruss_cfg_update(struct pruss *pruss, unsigned int reg,
 	return -ENOTSUPP;
 }
 
+int pruss_intc_configure(struct pruss *pruss,
+			 struct pruss_intc_config *intc_config)
+{
+	return -ENOTSUPP;
+}
+
+int pruss_intc_unconfigure(struct pruss *pruss,
+			   struct pruss_intc_config *intc_config)
+{
+	return -ENOTSUPP;
+}
+
 #endif /* CONFIG_TI_PRUSS */
 
 #endif /* __LINUX_PRUSS_H */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
