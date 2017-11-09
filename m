From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v3 1/7] memory: omap-gpmc: Refactor OneNAND support
Date: Thu, 9 Nov 2017 10:12:53 +0100
Message-ID: <20171109091253.lvrzi5kbaykkxlcb@lenoch>
References: <20171109091155.6a6azfvjarwvlfh2@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171109091155.6a6azfvjarwvlfh2@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Kyungmin Park <kyungmin.park@samsung.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Use generic probe function to deal with OneNAND node and remove now useless
gpmc_probe_onenand_child function.
Import sync mode timing calculation function from mach-omap2/gpmc-onenand.c
and prepare for MTD driver DTfication.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 -v2: add gpmc_omap_onenand_set_timings description
 -v3: none

 drivers/memory/omap-gpmc.c | 158 +++++++++++++++++++++++++++++++++------------
 include/linux/omap-gpmc.h  |  25 +++++++
 2 files changed, 142 insertions(+), 41 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 0e30ee1c8677..90a66b3f7ae1 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -32,7 +32,6 @@
 #include <linux/pm_runtime.h>
 
 #include <linux/platform_data/mtd-nand-omap2.h>
-#include <linux/platform_data/mtd-onenand-omap2.h>
 
 #include <asm/mach-types.h>
 
@@ -1138,6 +1137,112 @@ struct gpmc_nand_ops *gpmc_omap_get_nand_ops(struct gpmc_nand_regs *reg, int cs)
 }
 EXPORT_SYMBOL_GPL(gpmc_omap_get_nand_ops);
 
+static void gpmc_omap_onenand_calc_sync_timings(struct gpmc_timings *t,
+						struct gpmc_settings *s,
+						int freq, int latency)
+{
+	struct gpmc_device_timings dev_t;
+	const int t_cer  = 15;
+	const int t_avdp = 12;
+	const int t_cez  = 20; /* max of t_cez, t_oez */
+	const int t_wpl  = 40;
+	const int t_wph  = 30;
+	int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_ach, t_aavdh, t_rdyo;
+
+	switch (freq) {
+	case 104:
+		min_gpmc_clk_period = 9600; /* 104 MHz */
+		t_ces   = 3;
+		t_avds  = 4;
+		t_avdh  = 2;
+		t_ach   = 3;
+		t_aavdh = 6;
+		t_rdyo  = 6;
+		break;
+	case 83:
+		min_gpmc_clk_period = 12000; /* 83 MHz */
+		t_ces   = 5;
+		t_avds  = 4;
+		t_avdh  = 2;
+		t_ach   = 6;
+		t_aavdh = 6;
+		t_rdyo  = 9;
+		break;
+	case 66:
+		min_gpmc_clk_period = 15000; /* 66 MHz */
+		t_ces   = 6;
+		t_avds  = 5;
+		t_avdh  = 2;
+		t_ach   = 6;
+		t_aavdh = 6;
+		t_rdyo  = 11;
+		break;
+	default:
+		min_gpmc_clk_period = 18500; /* 54 MHz */
+		t_ces   = 7;
+		t_avds  = 7;
+		t_avdh  = 7;
+		t_ach   = 9;
+		t_aavdh = 7;
+		t_rdyo  = 15;
+		break;
+	}
+
+	/* Set synchronous read timings */
+	memset(&dev_t, 0, sizeof(dev_t));
+
+	if (!s->sync_write) {
+		dev_t.t_avdp_w = max(t_avdp, t_cer) * 1000;
+		dev_t.t_wpl = t_wpl * 1000;
+		dev_t.t_wph = t_wph * 1000;
+		dev_t.t_aavdh = t_aavdh * 1000;
+	}
+	dev_t.ce_xdelay = true;
+	dev_t.avd_xdelay = true;
+	dev_t.oe_xdelay = true;
+	dev_t.we_xdelay = true;
+	dev_t.clk = min_gpmc_clk_period;
+	dev_t.t_bacc = dev_t.clk;
+	dev_t.t_ces = t_ces * 1000;
+	dev_t.t_avds = t_avds * 1000;
+	dev_t.t_avdh = t_avdh * 1000;
+	dev_t.t_ach = t_ach * 1000;
+	dev_t.cyc_iaa = (latency + 1);
+	dev_t.t_cez_r = t_cez * 1000;
+	dev_t.t_cez_w = dev_t.t_cez_r;
+	dev_t.cyc_aavdh_oe = 1;
+	dev_t.t_rdyo = t_rdyo * 1000 + min_gpmc_clk_period;
+
+	gpmc_calc_timings(t, s, &dev_t);
+}
+
+int gpmc_omap_onenand_set_timings(struct device *dev, int cs, int freq,
+				  int latency,
+				  struct gpmc_onenand_info *info)
+{
+	int ret;
+	struct gpmc_timings gpmc_t;
+	struct gpmc_settings gpmc_s;
+
+	gpmc_read_settings_dt(dev->of_node, &gpmc_s);
+
+	info->sync_read = gpmc_s.sync_read;
+	info->sync_write = gpmc_s.sync_write;
+	info->burst_len = gpmc_s.burst_len;
+
+	if (!gpmc_s.sync_read && !gpmc_s.sync_write)
+		return 0;
+
+	gpmc_omap_onenand_calc_sync_timings(&gpmc_t, &gpmc_s, freq, latency);
+
+	ret = gpmc_cs_program_settings(cs, &gpmc_s);
+	if (ret < 0)
+		return ret;
+
+	return gpmc_cs_set_timings(cs, &gpmc_t, &gpmc_s);
+}
+EXPORT_SYMBOL_GPL(gpmc_omap_onenand_set_timings);
+
 int gpmc_get_client_irq(unsigned irq_config)
 {
 	if (!gpmc_irq_domain) {
@@ -1916,41 +2021,6 @@ static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
 		of_property_read_bool(np, "gpmc,time-para-granularity");
 }
 
-#if IS_ENABLED(CONFIG_MTD_ONENAND)
-static int gpmc_probe_onenand_child(struct platform_device *pdev,
-				 struct device_node *child)
-{
-	u32 val;
-	struct omap_onenand_platform_data *gpmc_onenand_data;
-
-	if (of_property_read_u32(child, "reg", &val) < 0) {
-		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
-			child);
-		return -ENODEV;
-	}
-
-	gpmc_onenand_data = devm_kzalloc(&pdev->dev, sizeof(*gpmc_onenand_data),
-					 GFP_KERNEL);
-	if (!gpmc_onenand_data)
-		return -ENOMEM;
-
-	gpmc_onenand_data->cs = val;
-	gpmc_onenand_data->of_node = child;
-	gpmc_onenand_data->dma_channel = -1;
-
-	if (!of_property_read_u32(child, "dma-channel", &val))
-		gpmc_onenand_data->dma_channel = val;
-
-	return gpmc_onenand_init(gpmc_onenand_data);
-}
-#else
-static int gpmc_probe_onenand_child(struct platform_device *pdev,
-				    struct device_node *child)
-{
-	return 0;
-}
-#endif
-
 /**
  * gpmc_probe_generic_child - configures the gpmc for a child device
  * @pdev:	pointer to gpmc platform device
@@ -2053,6 +2123,16 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		}
 	}
 
+	if (of_node_cmp(child->name, "onenand") == 0) {
+		/* Warn about older DT blobs with no compatible property */
+		if (!of_property_read_bool(child, "compatible")) {
+			dev_warn(&pdev->dev,
+				 "Incompatible OneNAND node: missing compatible");
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+
 	if (of_device_is_compatible(child, "ti,omap2-nand")) {
 		/* NAND specific setup */
 		val = 8;
@@ -2189,11 +2269,7 @@ static void gpmc_probe_dt_children(struct platform_device *pdev)
 		if (!child->name)
 			continue;
 
-		if (of_node_cmp(child->name, "onenand") == 0)
-			ret = gpmc_probe_onenand_child(pdev, child);
-		else
-			ret = gpmc_probe_generic_child(pdev, child);
-
+		ret = gpmc_probe_generic_child(pdev, child);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to probe DT child '%s': %d\n",
 				child->name, ret);
diff --git a/include/linux/omap-gpmc.h b/include/linux/omap-gpmc.h
index edfa280c3d56..067bea5e98c4 100644
--- a/include/linux/omap-gpmc.h
+++ b/include/linux/omap-gpmc.h
@@ -25,15 +25,40 @@ struct gpmc_nand_ops {
 
 struct gpmc_nand_regs;
 
+struct gpmc_onenand_info {
+	bool sync_read;
+	bool sync_write;
+	int burst_len;
+};
+
 #if IS_ENABLED(CONFIG_OMAP_GPMC)
 struct gpmc_nand_ops *gpmc_omap_get_nand_ops(struct gpmc_nand_regs *regs,
 					     int cs);
+/**
+ * gpmc_omap_onenand_set_timings - set optimized sync timings.
+ * @cs:      Chip Select Region
+ * @freq:    Chip frequency
+ * @latency: Burst latency cycle count
+ * @info:    Structure describing parameters used
+ */
+int gpmc_omap_onenand_set_timings(struct device *dev, int cs, int freq,
+				  int latency,
+				  struct gpmc_onenand_info *info);
+
 #else
 static inline struct gpmc_nand_ops *gpmc_omap_get_nand_ops(struct gpmc_nand_regs *regs,
 							   int cs)
 {
 	return NULL;
 }
+
+static inline
+int gpmc_omap_onenand_set_timings(struct device *dev, int cs, int freq,
+				  int latency,
+				  struct gpmc_onenand_info *info)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_OMAP_GPMC */
 
 extern int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
-- 
2.11.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
