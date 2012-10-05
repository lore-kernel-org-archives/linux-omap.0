From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v8 6/6] ARM: OMAP2+: gpmc: remove cs# in sync clk div calc
Date: Fri, 5 Oct 2012 21:09:49 +0530
Message-ID: <b2bb21b3849eb457d12141bd1f7c9bb689fcfb5c.1349444936.git.afzal@ti.com>
References: <cover.1349444935.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51728 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461Ab2JEPj6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Oct 2012 11:39:58 -0400
In-Reply-To: <cover.1349444935.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

Divider value for a certain sync clk is determined solely
based on gpmc fclk. CS# does not have any role here, thus
remove presence of CS# in clock divider calculation API.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Reviewed-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c     | 3 +--
 arch/arm/mach-omap2/gpmc.c             | 4 ++--
 arch/arm/plat-omap/include/plat/gpmc.h | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index ac06e90..544d501 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -182,7 +182,6 @@ omap2_onenand_calc_sync_timings(struct omap_onenand_platform_data *cfg,
 	int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_ach, t_aavdh, t_rdyo;
 	int div, fclk_offset_ns, fclk_offset, gpmc_clk_ns;
 	int ticks_cez;
-	int cs = cfg->cs;
 
 	if (cfg->flags & ONENAND_SYNC_READ)
 		onenand_flags = ONENAND_FLAG_SYNCREAD;
@@ -229,7 +228,7 @@ omap2_onenand_calc_sync_timings(struct omap_onenand_platform_data *cfg,
 		break;
 	}
 
-	div = gpmc_cs_calc_divider(cs, min_gpmc_clk_period);
+	div = gpmc_calc_divider(min_gpmc_clk_period);
 	gpmc_clk_ns = gpmc_ticks_to_ns(div);
 	if (gpmc_clk_ns < 15) /* >66Mhz */
 		onenand_flags |= ONENAND_FLAG_HF;
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index c2d90f6..2cbdcb9 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -328,7 +328,7 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 		return -1
 #endif
 
-int gpmc_cs_calc_divider(int cs, unsigned int sync_clk)
+int gpmc_calc_divider(unsigned int sync_clk)
 {
 	int div;
 	u32 l;
@@ -348,7 +348,7 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 	int div;
 	u32 l;
 
-	div = gpmc_cs_calc_divider(cs, t->sync_clk);
+	div = gpmc_calc_divider(t->sync_clk);
 	if (div < 0)
 		return div;
 
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index b7c9ea6..1cafbfd 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -179,7 +179,7 @@ extern unsigned long gpmc_get_fclk_period(void);
 
 extern void gpmc_cs_write_reg(int cs, int idx, u32 val);
 extern u32 gpmc_cs_read_reg(int cs, int idx);
-extern int gpmc_cs_calc_divider(int cs, unsigned int sync_clk);
+extern int gpmc_calc_divider(unsigned int sync_clk);
 extern int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t);
 extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
 extern void gpmc_cs_free(int cs);
-- 
1.7.12

