From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 01/10] ARM: OMAP2+: gpmc: update nand register helper
Date: Wed, 13 Jun 2012 17:02:52 +0530
Message-ID: <b917248067fd437da521f86aacfdd147a3211537.1339586624.git.afzal@ti.com>
References: <cover.1339586624.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48980 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726Ab2FMLsk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 07:48:40 -0400
In-Reply-To: <cover.1339586624.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, artem.bityutskiy@linux.intel.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: ivan.djelic@parrot.com, Afzal Mohammed <afzal@ti.com>

Provide helper function for updating NAND register details for
the necessary chip select. NAND drivers platform data can be
updated with this information so that NAND driver can handle
GPMC NAND operations by itself.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |   20 ++++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpmc.h |   18 ++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 2286410..a2c0588 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -682,6 +682,26 @@ int gpmc_prefetch_reset(int cs)
 }
 EXPORT_SYMBOL(gpmc_prefetch_reset);
 
+void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs)
+{
+	reg->gpmc_status = gpmc_base + GPMC_STATUS;
+	reg->gpmc_nand_command = gpmc_base + GPMC_CS0_OFFSET +
+				GPMC_CS_NAND_COMMAND + GPMC_CS_SIZE * cs;
+	reg->gpmc_nand_address = gpmc_base + GPMC_CS0_OFFSET +
+				GPMC_CS_NAND_ADDRESS + GPMC_CS_SIZE * cs;
+	reg->gpmc_nand_data = gpmc_base + GPMC_CS0_OFFSET +
+				GPMC_CS_NAND_DATA + GPMC_CS_SIZE * cs;
+	reg->gpmc_prefetch_config1 = gpmc_base + GPMC_PREFETCH_CONFIG1;
+	reg->gpmc_prefetch_config2 = gpmc_base + GPMC_PREFETCH_CONFIG2;
+	reg->gpmc_prefetch_control = gpmc_base + GPMC_PREFETCH_CONTROL;
+	reg->gpmc_prefetch_status = gpmc_base + GPMC_PREFETCH_STATUS;
+	reg->gpmc_ecc_config = gpmc_base + GPMC_ECC_CONFIG;
+	reg->gpmc_ecc_control = gpmc_base + GPMC_ECC_CONTROL;
+	reg->gpmc_ecc_size_config = gpmc_base + GPMC_ECC_SIZE_CONFIG;
+	reg->gpmc_ecc1_result = gpmc_base + GPMC_ECC1_RESULT;
+	reg->gpmc_bch_result0 = gpmc_base + GPMC_ECC_BCH_RESULT_0;
+}
+
 static void __init gpmc_mem_init(void)
 {
 	int cs;
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index f37764a..06198a5 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -133,6 +133,24 @@ struct gpmc_timings {
 	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
 };
 
+struct gpmc_nand_regs {
+	void __iomem	*gpmc_status;
+	void __iomem	*gpmc_nand_command;
+	void __iomem	*gpmc_nand_address;
+	void __iomem	*gpmc_nand_data;
+	void __iomem	*gpmc_prefetch_config1;
+	void __iomem	*gpmc_prefetch_config2;
+	void __iomem	*gpmc_prefetch_control;
+	void __iomem	*gpmc_prefetch_status;
+	void __iomem	*gpmc_ecc_config;
+	void __iomem	*gpmc_ecc_control;
+	void __iomem	*gpmc_ecc_size_config;
+	void __iomem	*gpmc_ecc1_result;
+	void __iomem	*gpmc_bch_result0;
+};
+
+extern void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs);
+
 extern unsigned int gpmc_ns_to_ticks(unsigned int time_ns);
 extern unsigned int gpmc_ps_to_ticks(unsigned int time_ps);
 extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
-- 
1.7.10.2

