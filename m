From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v7 07/11] ARM: OMAP2+: gpmc: remove cs# in sync clk div calc
Date: Wed, 19 Sep 2012 18:53:30 +0530
Message-ID: <0ccfe383826be0ac4123f97665c7797aebf0a1c2.1348058726.git.afzal@ti.com>
References: <cover.1348058726.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48939 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755518Ab2ISNXh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 09:23:37 -0400
In-Reply-To: <cover.1348058726.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

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
index 1e6fce6..f2bf9d2 100644
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
index d0916e9..35e4e7d 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -321,7 +321,7 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 		return -1
 #endif
 
-int gpmc_cs_calc_divider(int cs, unsigned int sync_clk)
+int gpmc_calc_divider(unsigned int sync_clk)
 {
 	int div;
 	u32 l;
@@ -341,7 +341,7 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
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

