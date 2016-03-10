From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v3 1/6] memory: omap-gpmc: Store handle to GPMC dev
Date: Wed,  9 Mar 2016 22:07:36 -0600
Message-ID: <1457582861-20619-2-git-send-email-fcooper@ti.com>
References: <1457582861-20619-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457582861-20619-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nsekhar@ti.com, dwmw2@infradead.org, computersforpeace@gmail.com, rogerq@ti.com, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

The dma channel information is located within the GPMC node. The NAND
driver requires a handle to the GPMC's dev to properly parse the DMA
properties. Therefore, store a handle to the dev so it can be referenced
within the NAND driver.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/memory/omap-gpmc.c                   | 1 +
 include/linux/platform_data/mtd-nand-omap2.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 6515dfc..2932d13 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -1796,6 +1796,7 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
 
 	gpmc_nand_data->cs = val;
 	gpmc_nand_data->of_node = child;
+	gpmc_nand_data->gpmc_dev = &pdev->dev;
 
 	/* Detect availability of ELM module */
 	gpmc_nand_data->elm_of_node = of_parse_phandle(child, "ti,elm-id", 0);
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 090bbab..534b984 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -80,5 +80,7 @@ struct omap_nand_platform_data {
 	/* for passing the partitions */
 	struct device_node	*of_node;
 	struct device_node	*elm_of_node;
+
+	struct device		*gpmc_dev;
 };
 #endif
-- 
2.7.0
