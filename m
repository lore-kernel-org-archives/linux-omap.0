From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 01/13] ARM: OMAP2+: gpmc: platform definitions
Date: Fri, 22 Jun 2012 18:26:30 +0530
Message-ID: <bf4c348fbcbc001ab362097687151f0ac42f7ed5.1340367480.git.afzal@ti.com>
References: <cover.1340367480.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39973 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581Ab2FVNLw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 09:11:52 -0400
In-Reply-To: <cover.1340367480.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

gpmc driver platform definitions

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/plat-omap/include/plat/gpmc.h |   37 ++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index b7c9ea6..4e799b1 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -152,6 +152,43 @@ struct gpmc_timings {
 	struct gpmc_bool_timings bool_timings;
 };
 
+enum {
+	has_none,
+	has_period,
+	has_clock
+};
+
+struct gpmc_time_ctrl {
+	int type;
+	struct gpmc_timings timings;
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
+	unsigned			waitpin_nr;
+	struct gpmc_device_pdata	**device_pdata;
+};
+
 struct gpmc_nand_regs {
 	void __iomem	*gpmc_status;
 	void __iomem	*gpmc_nand_command;
-- 
1.7.10.2

