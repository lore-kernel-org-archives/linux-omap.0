From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 03/15] remoteproc/omap: Add a sanity check for DSP boot address alignment
Date: Tue, 19 Nov 2019 16:16:33 +0200
Message-ID: <20191119141645.19777-4-t-kristo@ti.com>
References: <20191119141645.19777-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119141645.19777-1-t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, s-anna@ti.com, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The DSP remote processors on OMAP SoCs require a boot register to
be programmed with a boot address, and this boot address needs to
be on a 1KB boundary. The current code is simply masking the boot
address appropriately without performing any sanity checks before
releasing the resets. An unaligned boot address results in an
undefined execution behavior and can result in various bus errors
like MMU Faults or L3 NoC errors. Such errors are hard to debug and
can be easily avoided by adding a sanity check for the alignment
before booting a DSP remote processor.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/omap_remoteproc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 558634624590..d80f5d7b5931 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -124,13 +124,22 @@ static void omap_rproc_kick(struct rproc *rproc, int vqid)
  *
  * Set boot address for a supported DSP remote processor.
  */
-static void omap_rproc_write_dsp_boot_addr(struct rproc *rproc)
+static int omap_rproc_write_dsp_boot_addr(struct rproc *rproc)
 {
+	struct device *dev = rproc->dev.parent;
 	struct omap_rproc *oproc = rproc->priv;
 	struct omap_rproc_boot_data *bdata = oproc->boot_data;
 	u32 offset = bdata->boot_reg;
 
+	if (rproc->bootaddr & (SZ_1K - 1)) {
+		dev_err(dev, "invalid boot address 0x%x, must be aligned on a 1KB boundary\n",
+			rproc->bootaddr);
+		return -EINVAL;
+	}
+
 	regmap_write(bdata->syscon, offset, rproc->bootaddr);
+
+	return 0;
 }
 
 /*
@@ -147,8 +156,11 @@ static int omap_rproc_start(struct rproc *rproc)
 	int ret;
 	struct mbox_client *client = &oproc->client;
 
-	if (oproc->boot_data)
-		omap_rproc_write_dsp_boot_addr(rproc);
+	if (oproc->boot_data) {
+		ret = omap_rproc_write_dsp_boot_addr(rproc);
+		if (ret)
+			return ret;
+	}
 
 	client->dev = dev;
 	client->tx_done = NULL;
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
