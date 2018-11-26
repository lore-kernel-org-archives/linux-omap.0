From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 10/16] remoteproc/pru: add pru_rproc_get_id() API to retrieve the PRU id
Date: Mon, 26 Nov 2018 09:52:43 +0200
Message-ID: <1543218769-5507-11-git-send-email-rogerq@ti.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543218769-5507-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Export an API pru_rproc_get_id() to allow other PRUSS platform
drivers to clients to retrieve the PRU id from a remoteproc handle
associated with a PRU. The new function takes in a struct rproc
pointer as argument.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/pru_rproc.c | 27 +++++++++++++++++++++++++--
 include/linux/pruss.h          | 15 +++++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 2aa05b0..d8b823d 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -238,6 +238,29 @@ void pru_rproc_put(struct rproc *rproc)
 EXPORT_SYMBOL_GPL(pru_rproc_put);
 
 /**
+ * pru_rproc_get_id() - get PRU id from a previously acquired PRU remoteproc
+ * @rproc: the rproc instance of the PRU
+ *
+ * Returns the PRU id of the PRU remote processor that has been acquired through
+ * a pru_rproc_get(), or a negative value on error
+ */
+enum pruss_pru_id pru_rproc_get_id(struct rproc *rproc)
+{
+	struct pru_rproc *pru;
+
+	if (IS_ERR_OR_NULL(rproc) || !rproc->dev.parent)
+		return -EINVAL;
+
+	/* TODO: replace the crude string based check to make sure it is PRU */
+	if (!strstr(dev_name(rproc->dev.parent), "pru"))
+		return -EINVAL;
+
+	pru = rproc->priv;
+	return pru->id;
+}
+EXPORT_SYMBOL_GPL(pru_rproc_get_id);
+
+/**
  * pru_rproc_set_ctable() - set the constant table index for the PRU
  * @rproc: the rproc instance of the PRU
  * @c: constant table index to set
@@ -643,9 +666,9 @@ static int pru_rproc_set_id(struct pru_rproc *pru)
 	u32 mask2 = 0x38000;
 
 	if ((pru->mem_regions[0].pa & mask1) == mask1)
-		pru->id = 0;
+		pru->id = PRUSS_PRU0;
 	else if ((pru->mem_regions[0].pa & mask2) == mask2)
-		pru->id = 1;
+		pru->id = PRUSS_PRU1;
 	else
 		ret = -EINVAL;
 
diff --git a/include/linux/pruss.h b/include/linux/pruss.h
index 405039a..c0a3b3e 100644
--- a/include/linux/pruss.h
+++ b/include/linux/pruss.h
@@ -10,6 +10,15 @@
 #ifndef __LINUX_PRUSS_H
 #define __LINUX_PRUSS_H
 
+/**
+ * enum pruss_pru_id - PRU core identifiers
+ */
+enum pruss_pru_id {
+	PRUSS_PRU0 = 0,
+	PRUSS_PRU1,
+	PRUSS_NUM_PRUS,
+};
+
 /*
  * PRU_ICSS_CFG registers
  * SYSCFG, ISRP, ISP, IESP, IECP, SCRP applicable on AMxxxx devices only
@@ -251,6 +260,7 @@ int pruss_intc_unconfigure(struct pruss *pruss,
 
 struct rproc *pru_rproc_get(struct device_node *node, int index);
 void pru_rproc_put(struct rproc *rproc);
+enum pruss_pru_id pru_rproc_get_id(struct rproc *rproc);
 int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr);
 
 #else
@@ -262,6 +272,11 @@ static inline struct rproc *pru_rproc_get(struct device_node *node, int index)
 
 static inline void pru_rproc_put(struct rproc *rproc) { }
 
+static inline enum pruss_pru_id pru_rproc_get_id(struct rproc *rproc)
+{
+	return -ENOTSUPP;
+}
+
 static inline int pru_rproc_set_ctable(struct rproc *rproc,
 				       enum pru_ctable_idx c, u32 addr)
 {
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
