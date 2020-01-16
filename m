From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 05/14] remoteproc/omap: Add the rproc ops .da_to_va() implementation
Date: Thu, 16 Jan 2020 15:53:23 +0200
Message-ID: <20200116135332.7819-6-t-kristo@ti.com>
References: <20200116135332.7819-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200116135332.7819-1-t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, s-anna@ti.com, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

An implementation for the rproc ops .da_to_va() has been added
that provides the address translation between device addresses
to kernel virtual addresses for internal RAMs present on that
particular remote processor device. The implementation provides
the translations based on the addresses parsed and stored during
the probe.

This ops gets invoked by the exported rproc_da_to_va() function
and allows the remoteproc core's ELF loader to be able to load
program data directly into the internal memories.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
v5: no changes

 drivers/remoteproc/omap_remoteproc.c | 39 ++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index a99e542da364..0846839b2c97 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -245,10 +245,49 @@ static int omap_rproc_stop(struct rproc *rproc)
 	return 0;
 }
 
+/**
+ * omap_rproc_da_to_va() - internal memory translation helper
+ * @rproc: remote processor to apply the address translation for
+ * @da: device address to translate
+ * @len: length of the memory buffer
+ *
+ * Custom function implementing the rproc .da_to_va ops to provide address
+ * translation (device address to kernel virtual address) for internal RAMs
+ * present in a DSP or IPU device). The translated addresses can be used
+ * either by the remoteproc core for loading, or by any rpmsg bus drivers.
+ * Returns the translated virtual address in kernel memory space, or NULL
+ * in failure.
+ */
+static void *omap_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
+{
+	struct omap_rproc *oproc = rproc->priv;
+	int i;
+	u32 offset;
+
+	if (len <= 0)
+		return NULL;
+
+	if (!oproc->num_mems)
+		return NULL;
+
+	for (i = 0; i < oproc->num_mems; i++) {
+		if (da >= oproc->mem[i].dev_addr && da + len <=
+		    oproc->mem[i].dev_addr + oproc->mem[i].size) {
+			offset = da - oproc->mem[i].dev_addr;
+			/* __force to make sparse happy with type conversion */
+			return (__force void *)(oproc->mem[i].cpu_addr +
+						offset);
+		}
+	}
+
+	return NULL;
+}
+
 static const struct rproc_ops omap_rproc_ops = {
 	.start		= omap_rproc_start,
 	.stop		= omap_rproc_stop,
 	.kick		= omap_rproc_kick,
+	.da_to_va	= omap_rproc_da_to_va,
 };
 
 static const struct omap_rproc_mem_data ipu_mems[] = {
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
