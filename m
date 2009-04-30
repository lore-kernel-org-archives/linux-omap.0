From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] onenand_init: Allow disabling sync read and write based on
	flags (Re: [PATCH 1/4] onenand init: Rename board-n800-flash.c to
	gpmc-onenand.c)
Date: Thu, 30 Apr 2009 11:53:08 -0700
Message-ID: <20090430185307.GF12986@atomide.com>
References: <40106.192.168.10.89.1241073191.squirrel@dbdmail.itg.ti.com> <20090430140336.GC12986@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0eh6TmSyL6TZE2Uz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53913 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764887AbZD3SxO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Apr 2009 14:53:14 -0400
Content-Disposition: inline
In-Reply-To: <20090430140336.GC12986@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimalsingh@ti.com>
Cc: dedekind@infradead.org, linux-omap@vger.kernel.org, adrian.hunter@nokia.com, Tony Lindgren <tony@atommide.com>


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [090430 07:06]:
> * vimal singh <vimalsingh@ti.com> [090429 23:33]:
> > 'gpmc-onenand.c' is still confusing name. This is not going to used in
> > all boards anyway.
> 
> Why do you think this cannot be used for all boards?
> 
> The GPMC timings are totally based on the onenand chip features.

And these two patches make omap3430sdp to work with the gpmc-onenand
code. Sync mode does not work, but it seems like it was never enabled
for sdp anyways.

Similar patch should work for other boards too.

Tony

--0eh6TmSyL6TZE2Uz
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="onenand-add-flags.patch"

>From 75b228c97d5df66ef5eba81bb6a25627e6e77941 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 30 Apr 2009 11:43:19 -0700
Subject: [PATCH] onenand_init: Allow disabling sync read and write based on flags

Allow disabling sync read and write based on flags

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index fc79183..e9ace8c 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -85,20 +85,24 @@ static void omap2_onenand_writew(unsigned short value, void __iomem *addr)
 	writew(value, addr);
 }
 
-static void set_onenand_cfg(void __iomem *onenand_base, int latency,
-			    int sync_write, int hf)
+static void set_onenand_cfg(struct omap_onenand_platform_data *cfg,
+				void __iomem *onenand_base,
+				int latency, int hf) 
 {
 	u32 reg;
 
 	reg = omap2_onenand_readw(onenand_base + ONENAND_REG_SYS_CFG1);
 	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
 	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
-		ONENAND_SYS_CFG1_SYNC_READ |
 		ONENAND_SYS_CFG1_BL_16;
-	if (sync_write)
-		reg |= ONENAND_SYS_CFG1_SYNC_WRITE;
+	if (cfg->flags & ONENAND_DIS_SYNC_READ)
+		reg &= ~ONENAND_SYS_CFG1_SYNC_READ;
 	else
+		reg |= ONENAND_SYS_CFG1_SYNC_READ;
+	if (cfg->flags & ONENAND_DIS_SYNC_WRITE)
 		reg &= ~ONENAND_SYS_CFG1_SYNC_WRITE;
+	else
+		reg |= ONENAND_SYS_CFG1_SYNC_WRITE;
 	if (hf)
 		reg |= ONENAND_SYS_CFG1_HF;
 	else
@@ -106,8 +110,9 @@ static void set_onenand_cfg(void __iomem *onenand_base, int latency,
 	omap2_onenand_writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
 }
 
-static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
-				       int freq)
+static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
+					void __iomem *onenand_base,
+					int freq)
 {
 	struct gpmc_timings t;
 	const int t_cer  = 15;
@@ -119,6 +124,7 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 	int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_ach, t_aavdh, t_rdyo;
 	int tick_ns, div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency;
 	int err, ticks_cez, sync_write = 0, first_time = 0, hf = 0;
+	int cs = cfg->cs;
 	u32 reg;
 
 	if (!freq) {
@@ -160,7 +166,7 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 		t_ach   = 6;
 		t_aavdh = 6;
 		t_rdyo  = 9;
-		if (cpu_is_omap34xx())
+		if (cpu_is_omap34xx() && !(cfg->flags & ONENAND_DIS_SYNC_WRITE))
 			sync_write = 1;
 		break;
 	case 66:
@@ -171,7 +177,7 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 		t_ach   = 6;
 		t_aavdh = 6;
 		t_rdyo  = 11;
-		if (cpu_is_omap34xx())
+		if (cpu_is_omap34xx() && !(cfg->flags & ONENAND_DIS_SYNC_WRITE))
 			sync_write = 1;
 		break;
 	default:
@@ -198,7 +204,7 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 		latency = 4;
 
 	if (first_time)
-		set_onenand_cfg(onenand_base, latency, sync_write, hf);
+		set_onenand_cfg(cfg, onenand_base, latency, hf);
 
 	if (div == 1) {
 		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG2);
@@ -244,7 +250,7 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 		     ticks_cez);
 
 	/* Write */
-	if (sync_write) {
+	if (!(cfg->flags & ONENAND_DIS_SYNC_WRITE)) {
 		t.adv_wr_off = t.adv_rd_off;
 		t.we_on  = 0;
 		t.we_off = t.cs_rd_off;
@@ -272,7 +278,8 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
 			  GPMC_CONFIG1_WRAPBURST_SUPP |
 			  GPMC_CONFIG1_READMULTIPLE_SUPP |
-			  GPMC_CONFIG1_READTYPE_SYNC |
+			  ((cfg->flags & ONENAND_DIS_SYNC_READ) ? 0 :
+				GPMC_CONFIG1_READTYPE_SYNC) |
 			  (sync_write ? GPMC_CONFIG1_WRITEMULTIPLE_SUPP : 0) |
 			  (sync_write ? GPMC_CONFIG1_WRITETYPE_SYNC : 0) |
 			  GPMC_CONFIG1_CLKACTIVATIONTIME(fclk_offset) |
@@ -288,7 +295,7 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 	if (err)
 		return err;
 
-	set_onenand_cfg(onenand_base, latency, sync_write, hf);
+	set_onenand_cfg(cfg, onenand_base, latency, hf);
 
 	return 0;
 }
@@ -298,7 +305,7 @@ static int gpmc_onenand_setup(void __iomem *onenand_base, int freq)
 	struct device *dev = &gpmc_onenand_device.dev;
 
 	/* Set sync timings in GPMC */
-	if (omap2_onenand_set_sync_mode(gpmc_onenand_data->cs, onenand_base,
+	if (omap2_onenand_set_sync_mode(gpmc_onenand_data, onenand_base,
 			freq) < 0) {
 		dev_err(dev, "Unable to set synchronous mode\n");
 		return -EINVAL;
diff --git a/arch/arm/plat-omap/include/mach/onenand.h b/arch/arm/plat-omap/include/mach/onenand.h
index 2a391fa..562b2a9 100644
--- a/arch/arm/plat-omap/include/mach/onenand.h
+++ b/arch/arm/plat-omap/include/mach/onenand.h
@@ -14,6 +14,9 @@
 
 #ifndef __ASM_ARCH_OMAP_ONENAND_H__
 
+#define ONENAND_DIS_SYNC_READ	(1 << 0)
+#define ONENAND_DIS_SYNC_WRITE	(1 << 1)
+
 struct omap_onenand_platform_data {
 	int			cs;
 	int			gpio_irq;
@@ -21,6 +24,7 @@ struct omap_onenand_platform_data {
 	int			nr_parts;
 	int                     (*onenand_setup)(void __iomem *, int freq);
 	int			dma_channel;
+	u8			flags;
 };
 
 int omap2_onenand_rephase(void);

--0eh6TmSyL6TZE2Uz--
