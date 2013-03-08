From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 05/17] ARM: OMAP2+: Convert ONENAND to use gpmc_cs_program_settings()
Date: Fri, 8 Mar 2013 10:58:26 -0600
Message-ID: <1362761918-8696-6-git-send-email-jon-hunter@ti.com>
References: <1362761918-8696-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43370 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933505Ab3CHQ7L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 11:59:11 -0500
In-Reply-To: <1362761918-8696-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Mark Jackson <mpfj-list@mimc.co.uk>, Jon Hunter <jon-hunter@ti.com>

Convert the OMAP2+ ONENAND code to use the gpmc_cs_program_settings()
function for configuring the various GPMC options instead of directly
programming the CONFIG1 register.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c |   61 +++++++++++++++---------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 261eed1..aa3f53e 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -48,18 +48,22 @@ static struct platform_device gpmc_onenand_device = {
 };
 
 static struct gpmc_settings onenand_async = {
+	.device_width	= GPMC_DEVWIDTH_16BIT,
 	.mux_add_data	= GPMC_MUX_AD,
 };
 
 static struct gpmc_settings onenand_sync = {
 	.burst_read	= true,
+	.burst_wrap	= true,
+	.burst_len	= GPMC_BURST_16,
+	.device_width	= GPMC_DEVWIDTH_16BIT,
 	.mux_add_data	= GPMC_MUX_AD,
+	.wait_pin	= 0,
 };
 
 static void omap2_onenand_calc_async_timings(struct gpmc_timings *t)
 {
 	struct gpmc_device_timings dev_t;
-
 	const int t_cer = 15;
 	const int t_avdp = 12;
 	const int t_aavdh = 7;
@@ -86,16 +90,6 @@ static void omap2_onenand_calc_async_timings(struct gpmc_timings *t)
 	gpmc_calc_timings(t, &onenand_async, &dev_t);
 }
 
-static int gpmc_set_async_mode(int cs, struct gpmc_timings *t)
-{
-	/* Configure GPMC for asynchronous read */
-	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
-			  GPMC_CONFIG1_DEVICESIZE_16 |
-			  GPMC_CONFIG1_MUXADDDATA);
-
-	return gpmc_cs_set_timings(cs, t);
-}
-
 static void omap2_onenand_set_async_mode(void __iomem *onenand_base)
 {
 	u32 reg;
@@ -243,8 +237,11 @@ static void omap2_onenand_calc_sync_timings(struct gpmc_timings *t,
 	/* Set synchronous read timings */
 	memset(&dev_t, 0, sizeof(dev_t));
 
+	if (onenand_flags & ONENAND_FLAG_SYNCREAD)
+		onenand_sync.sync_read = true;
 	if (onenand_flags & ONENAND_FLAG_SYNCWRITE) {
 		onenand_sync.sync_write = true;
+		onenand_sync.burst_write = true;
 	} else {
 		dev_t.t_avdp_w = max(t_avdp, t_cer) * 1000;
 		dev_t.t_wpl = t_wpl * 1000;
@@ -270,29 +267,6 @@ static void omap2_onenand_calc_sync_timings(struct gpmc_timings *t,
 	gpmc_calc_timings(t, &onenand_sync, &dev_t);
 }
 
-static int gpmc_set_sync_mode(int cs, struct gpmc_timings *t)
-{
-	unsigned sync_read = onenand_flags & ONENAND_FLAG_SYNCREAD;
-	unsigned sync_write = onenand_flags & ONENAND_FLAG_SYNCWRITE;
-
-	/* Configure GPMC for synchronous read */
-	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
-			  GPMC_CONFIG1_WRAPBURST_SUPP |
-			  GPMC_CONFIG1_READMULTIPLE_SUPP |
-			  (sync_read ? GPMC_CONFIG1_READTYPE_SYNC : 0) |
-			  (sync_write ? GPMC_CONFIG1_WRITEMULTIPLE_SUPP : 0) |
-			  (sync_write ? GPMC_CONFIG1_WRITETYPE_SYNC : 0) |
-			  GPMC_CONFIG1_PAGE_LEN(2) |
-			  (cpu_is_omap34xx() ? 0 :
-				(GPMC_CONFIG1_WAIT_READ_MON |
-				 GPMC_CONFIG1_WAIT_PIN_SEL(0))) |
-			  GPMC_CONFIG1_DEVICESIZE_16 |
-			  GPMC_CONFIG1_DEVICETYPE_NOR |
-			  GPMC_CONFIG1_MUXADDDATA);
-
-	return gpmc_cs_set_timings(cs, t);
-}
-
 static int omap2_onenand_setup_async(void __iomem *onenand_base)
 {
 	struct gpmc_timings t;
@@ -302,7 +276,11 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
 
 	omap2_onenand_calc_async_timings(&t);
 
-	ret = gpmc_set_async_mode(gpmc_onenand_data->cs, &t);
+	ret = gpmc_cs_program_settings(gpmc_onenand_data->cs, &onenand_async);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+
+	ret = gpmc_cs_set_timings(gpmc_onenand_data->cs, &t);
 	if (IS_ERR_VALUE(ret))
 		return ret;
 
@@ -322,9 +300,20 @@ static int omap2_onenand_setup_sync(void __iomem *onenand_base, int *freq_ptr)
 		set_onenand_cfg(onenand_base);
 	}
 
+	/*
+	 * FIXME: Appears to be legacy code from initial ONENAND commit.
+	 * Unclear what boards this is for and if this can be removed.
+	 */
+	if (!cpu_is_omap34xx())
+		onenand_sync.wait_on_read = true;
+
 	omap2_onenand_calc_sync_timings(&t, gpmc_onenand_data->flags, freq);
 
-	ret = gpmc_set_sync_mode(gpmc_onenand_data->cs, &t);
+	ret = gpmc_cs_program_settings(gpmc_onenand_data->cs, &onenand_sync);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+
+	ret = gpmc_cs_set_timings(gpmc_onenand_data->cs, &t);
 	if (IS_ERR_VALUE(ret))
 		return ret;
 
-- 
1.7.10.4

