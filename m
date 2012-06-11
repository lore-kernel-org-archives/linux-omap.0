From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v5 01/14] ARM: OMAP2+: gpmc: platform definitions
Date: Mon, 11 Jun 2012 19:56:18 +0530
Message-ID: <139eb951817b4bee8ea91083b0d572c7421078f0.1339419492.git.afzal@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47270 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398Ab2FKOl5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 10:41:57 -0400
In-Reply-To: <cover.1339419492.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

gpmc driver platform definitions

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/plat-omap/include/plat/gpmc.h |   49 ++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 802fb22..21a8cce 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -139,6 +139,55 @@ struct gpmc_timings {
 	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
 };
 
+/* bool type time settings */
+struct gpmc_misc_timings {
+	bool cycle2cyclediffcsen;
+	bool cycle2cyclesamecsen;
+	bool we_extra_delay;
+	bool oe_extra_delay;
+	bool adv_extra_delay;
+	bool cs_extra_delay;
+	bool time_para_granularity;
+};
+
+enum {
+	has_none,
+	has_period,
+	has_clock
+};
+
+struct gpmc_time_ctrl {
+	int type;
+	struct gpmc_timings timings;
+	struct gpmc_misc_timings bool_timings;
+};
+
+struct gpmc_cs_data {
+	unsigned		cs;
+	unsigned long		mem_size;
+	unsigned long		mem_offset;
+	bool			have_config;
+	unsigned		config;
+	struct gpmc_time_ctrl	time_ctrl;
+	unsigned		irq_config;
+};
+
+struct gpmc_device_pdata {
+	char			*name;
+	int			id;
+	void			*pdata;
+	unsigned		pdata_size;
+	struct resource		*per_res;
+	unsigned		per_res_cnt;
+	struct gpmc_cs_data	*cs_data;
+	unsigned		num_cs;
+};
+
+struct gpmc_pdata {
+	unsigned			num_device;
+	struct gpmc_device_pdata	**device_pdata;
+};
+
 struct gpmc_nand_regs {
 	void __iomem	*gpmc_status;
 	void __iomem	*gpmc_nand_command;
-- 
1.7.10.2

