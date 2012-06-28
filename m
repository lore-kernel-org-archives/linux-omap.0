From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: GPMC: Remove unused OneNAND get_freq() platform function
Date: Thu, 28 Jun 2012 13:41:29 -0500
Message-ID: <1340908890-28612-2-git-send-email-jon-hunter@ti.com>
References: <1340908890-28612-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57067 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab2F1Sle (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 14:41:34 -0400
In-Reply-To: <1340908890-28612-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

A platform function pointer for getting the frequency of a OneNAND device
was added so that a platform could specify a custom function for returning
the frequency and not just rely on the OneNAND version to determine the
frequency. However, this platform function pointer is not currently being
used and I am not sure if it ever has.

OneNAND devices are not so common these days and as far as I know not being
used with new devices. Therefore, it is most likely that this get_freq()
function pointer will not be used and so remove it.

Given that the get_freq() function pointer is not used, neither is the
clk_dep variable and so all references to it can also be removed.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c        |   39 ++++-------------------------
 arch/arm/plat-omap/include/plat/onenand.h |    8 ------
 2 files changed, 5 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index c8a9487..0f3b5b9 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -139,21 +139,10 @@ static void set_onenand_cfg(void __iomem *onenand_base)
 }
 
 static int omap2_onenand_get_freq(struct omap_onenand_platform_data *cfg,
-				  void __iomem *onenand_base, bool *clk_dep)
+				  void __iomem *onenand_base)
 {
 	u16 ver = readw(onenand_base + ONENAND_REG_VERSION_ID);
-	int freq = 0;
-
-	if (cfg->get_freq) {
-		struct onenand_freq_info fi;
-
-		fi.maf_id = readw(onenand_base + ONENAND_REG_MANUFACTURER_ID);
-		fi.dev_id = readw(onenand_base + ONENAND_REG_DEVICE_ID);
-		fi.ver_id = ver;
-		freq = cfg->get_freq(&fi, clk_dep);
-		if (freq)
-			return freq;
-	}
+	int freq;
 
 	switch ((ver >> 4) & 0xf) {
 	case 0:
@@ -181,7 +170,7 @@ static int omap2_onenand_get_freq(struct omap_onenand_platform_data *cfg,
 
 static struct gpmc_timings
 omap2_onenand_calc_sync_timings(struct omap_onenand_platform_data *cfg,
-						int freq, bool clk_dep)
+						int freq)
 {
 	struct gpmc_timings t;
 	const int t_cer  = 15;
@@ -259,22 +248,6 @@ omap2_onenand_calc_sync_timings(struct omap_onenand_platform_data *cfg,
 	else
 		latency = 4;
 
-	if (clk_dep) {
-		if (gpmc_clk_ns < 12) { /* >83Mhz */
-			t_ces   = 3;
-			t_avds  = 4;
-		} else if (gpmc_clk_ns < 15) { /* >66Mhz */
-			t_ces   = 5;
-			t_avds  = 4;
-		} else if (gpmc_clk_ns < 25) { /* >40Mhz */
-			t_ces   = 6;
-			t_avds  = 5;
-		} else {
-			t_ces   = 7;
-			t_avds  = 7;
-		}
-	}
-
 	/* Set synchronous read timings */
 	memset(&t, 0, sizeof(t));
 
@@ -379,16 +352,14 @@ static int omap2_onenand_setup_sync(void __iomem *onenand_base, int *freq_ptr)
 {
 	int ret, freq = *freq_ptr;
 	struct gpmc_timings t;
-	bool clk_dep = false;
 
 	if (!freq) {
 		/* Very first call freq is not known */
-		freq = omap2_onenand_get_freq(gpmc_onenand_data,
-						onenand_base, &clk_dep);
+		freq = omap2_onenand_get_freq(gpmc_onenand_data, onenand_base);
 		set_onenand_cfg(onenand_base);
 	}
 
-	t = omap2_onenand_calc_sync_timings(gpmc_onenand_data, freq, clk_dep);
+	t = omap2_onenand_calc_sync_timings(gpmc_onenand_data, freq);
 
 	ret = gpmc_set_sync_mode(gpmc_onenand_data->cs, &t);
 	if (IS_ERR_VALUE(ret))
diff --git a/arch/arm/plat-omap/include/plat/onenand.h b/arch/arm/plat-omap/include/plat/onenand.h
index 2858667..21bb0ff 100644
--- a/arch/arm/plat-omap/include/plat/onenand.h
+++ b/arch/arm/plat-omap/include/plat/onenand.h
@@ -15,20 +15,12 @@
 #define ONENAND_SYNC_READ	(1 << 0)
 #define ONENAND_SYNC_READWRITE	(1 << 1)
 
-struct onenand_freq_info {
-	u16			maf_id;
-	u16			dev_id;
-	u16			ver_id;
-};
-
 struct omap_onenand_platform_data {
 	int			cs;
 	int			gpio_irq;
 	struct mtd_partition	*parts;
 	int			nr_parts;
 	int			(*onenand_setup)(void __iomem *, int *freq_ptr);
-	int		(*get_freq)(const struct onenand_freq_info *freq_info,
-				    bool *clk_dep);
 	int			dma_channel;
 	u8			flags;
 	u8			regulator_can_sleep;
-- 
1.7.9.5

