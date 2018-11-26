From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 13/16] remoteproc/pru: add support for configuring GPMUX based on client setup
Date: Mon, 26 Nov 2018 09:52:46 +0200
Message-ID: <1543218769-5507-14-git-send-email-rogerq@ti.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543218769-5507-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

Client device node property ti,pruss-gp-mux-sel can now be used to
configure the GPMUX config value for PRU.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
[s-anna@ti.com: simplify the pru id usage]
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/pru_rproc.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index d8b823d..9a08937 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -72,6 +72,7 @@ enum pru_mem {
  * @sdram_da: device address of secondary Data RAM for this PRU
  * @shrdram_da: device address of shared Data RAM
  * @fw_name: name of firmware image used during loading
+ * @gpmux_save: saved value for gpmux config
  * @lock: mutex to protect client usage
  * @dbg_single_step: debug state variable to set PRU into single step mode
  * @dbg_continuous: debug state variable to restore PRU execution mode
@@ -95,6 +96,7 @@ struct pru_rproc {
 	u32 sdram_da;
 	u32 shrdram_da;
 	const char *fw_name;
+	u8 gpmux_save;
 	struct mutex lock; /* client access lock */
 	u32 dbg_single_step;
 	u32 dbg_continuous;
@@ -184,12 +186,16 @@ struct rproc *pru_rproc_get(struct device_node *np, int index)
 {
 	struct rproc *rproc;
 	struct pru_rproc *pru;
+	struct device *dev;
+	int ret;
+	u32 mux;
 
 	rproc = __pru_rproc_get(np, index);
 	if (IS_ERR(rproc))
 		return rproc;
 
 	pru = rproc->priv;
+	dev = &rproc->dev;
 
 	mutex_lock(&pru->lock);
 
@@ -203,7 +209,27 @@ struct rproc *pru_rproc_get(struct device_node *np, int index)
 
 	mutex_unlock(&pru->lock);
 
+	ret = pruss_cfg_get_gpmux(pru->pruss, pru->id, &pru->gpmux_save);
+	if (ret) {
+		dev_err(dev, "failed to get cfg gpmux: %d\n", ret);
+		goto err;
+	}
+
+	ret = of_property_read_u32_index(np, "ti,pruss-gp-mux-sel", index,
+					 &mux);
+	if (!ret) {
+		ret = pruss_cfg_set_gpmux(pru->pruss, pru->id, mux);
+		if (ret) {
+			dev_err(dev, "failed to set cfg gpmux: %d\n", ret);
+			goto err;
+		}
+	}
+
 	return rproc;
+
+err:
+	pru_rproc_put(rproc);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(pru_rproc_get);
 
@@ -229,6 +255,8 @@ void pru_rproc_put(struct rproc *rproc)
 	if (!pru->client_np)
 		return;
 
+	pruss_cfg_set_gpmux(pru->pruss, pru->id, pru->gpmux_save);
+
 	mutex_lock(&pru->lock);
 	pru->client_np = NULL;
 	mutex_unlock(&pru->lock);
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
