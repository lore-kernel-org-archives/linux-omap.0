From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 7/9] ARM: OMAP2+: gpmc-smsc911x: runtime time calculation
Date: Mon, 11 Jun 2012 20:29:52 +0530
Message-ID: <54a062928c5018dfe1613d8247ab79e9d688e138.1339419379.git.afzal@ti.com>
References: <cover.1339419379.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33403 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab2FKPPh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 11:15:37 -0400
In-Reply-To: <cover.1339419379.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

OMAP Peripherals using SMSC911X driver were not configured
in Kernel. Here timing has been calculated so that it is
runtime configurable. As different SMSC devices like 9115,
9220, 9221 can be used with smsc911x driver, option has been
given for the boards to provide timing as per the part used,
if it is not provided, default one used is that of 9220.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-smsc911x.c             |   53 +++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpmc-smsc911x.h |   14 ++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index 93a534e..4bfe721 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -100,6 +100,53 @@ free1:
 	pr_err("Could not initialize smsc911x device\n");
 }
 
+static void gpmc_smsc911x_timing(struct gpmc_time_ctrl *time_ctrl,
+					struct smsc911x_timing *timing)
+{
+	struct gpmc_timings t;
+	/* SMSC 9220 timings */
+	unsigned tcycle_r = 165;
+	unsigned tcsl_r = 32;
+	unsigned tcsh_r = 133;
+	unsigned tcsdv_r = 30;
+	unsigned tdoff_r = 9;
+	unsigned tcycle_w = 165;
+	unsigned tcsl_w = 32;
+	unsigned tcsh_w = 133;
+	unsigned tdsu_w = 7;
+
+	/* take timings from board, else use default */
+	if (timing) {
+		tcycle_r = timing->tcycle_r;
+		tcsl_r = timing->tcsl_r;
+		tcsh_r = timing->tcsh_r;
+		tcsdv_r = timing->tcsdv_r;
+		tdoff_r = tdoff_r;
+		tcycle_w = timing->tcycle_r;
+		tcsl_w = timing->tcsl_w;
+		tcsh_w = timing->tcsh_w;
+		tdsu_w = timing->tdsu_w;
+	}
+
+	memset(&t, sizeof(t), 0);
+
+	t.cs_on = 0;
+	t.oe_on = 0;
+	t.access = tcsdv_r;
+	t.oe_off = max_t(unsigned, t.access + gpmc_ticks_to_ns(1), tcsl_r);
+	t.cs_rd_off = t.oe_off;
+	t.rd_cycle = tcsl_r + max(tcsh_r, tdoff_r);
+	t.rd_cycle = max_t(unsigned, tcycle_r, t.rd_cycle);
+
+	t.we_on = 0;
+	t.we_off = max(tcsl_w, tdsu_w);
+	t.cs_wr_off = t.we_off;
+	t.wr_cycle = max_t(unsigned, t.we_off + gpmc_ticks_to_ns(1), tcycle_w);
+
+	time_ctrl->type = has_period;
+	time_ctrl->timings = t;
+}
+
 struct gpmc_device_pdata *
 __init gpmc_smsc911x_update(struct omap_smsc911x_platform_data *gpmc_cfg)
 {
@@ -127,6 +174,12 @@ __init gpmc_smsc911x_update(struct omap_smsc911x_platform_data *gpmc_cfg)
 	gpmc_cs->cs = gpmc_cfg->cs;
 	gpmc_cs->mem_size = 0x100;
 
+	gpmc_cs->have_config = true;
+	gpmc_cs->config = GPMC_CONFIG1_DEVICESIZE_16 |
+		GPMC_CONFIG1_DEVICETYPE_NOR;
+
+	gpmc_smsc911x_timing(&gpmc_cs->time_ctrl, gpmc_cfg->timing);
+
 	gpmc_pdev->per_res = gpmc_smsc911x_resources + 1;
 	gpmc_pdev->per_res_cnt = 1;
 
diff --git a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
index 50af49e..8be3343 100644
--- a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
+++ b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
@@ -13,12 +13,26 @@
 
 #ifndef __ASM_ARCH_OMAP_GPMC_SMSC911X_H__
 
+/* timing in ns */
+struct smsc911x_timing {
+	unsigned tcycle_r;
+	unsigned tcsl_r;
+	unsigned tcsh_r;
+	unsigned tcsdv_r;
+	unsigned tdoff_r;
+	unsigned tcycle_w;
+	unsigned tcsl_w;
+	unsigned tcsh_w;
+	unsigned tdsu_w;
+};
+
 struct omap_smsc911x_platform_data {
 	int	id;
 	int	cs;
 	int	gpio_irq;
 	int	gpio_reset;
 	u32	flags;
+	struct smsc911x_timing *timing;
 };
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
-- 
1.7.10.2

