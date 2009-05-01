From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] onenand_init: Allow disabling sync read and write
	based on flags, v2 (Re: [PATCH 1/4] onenand init: Rename
	board-n800-flash.c to gpmc-onenand.c)
Date: Fri, 1 May 2009 10:38:18 -0700
Message-ID: <20090501173818.GN12986@atomide.com>
References: <40106.192.168.10.89.1241073191.squirrel@dbdmail.itg.ti.com> <20090430140336.GC12986@atomide.com> <20090430185307.GF12986@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MAH+hnPXVZWQ5cD/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59464 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281AbZEARiX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 May 2009 13:38:23 -0400
Content-Disposition: inline
In-Reply-To: <20090430185307.GF12986@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimalsingh@ti.com>
Cc: dedekind@infradead.org, linux-omap@vger.kernel.org, adrian.hunter@nokia.com, Tony Lindgren <tony@atommide.com>


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [090430 11:56]:
> * Tony Lindgren <tony@atomide.com> [090430 07:06]:
> > * vimal singh <vimalsingh@ti.com> [090429 23:33]:
> > > 'gpmc-onenand.c' is still confusing name. This is not going to used in
> > > all boards anyway.
> > 
> > Why do you think this cannot be used for all boards?
> > 
> > The GPMC timings are totally based on the onenand chip features.
> 
> And these two patches make omap3430sdp to work with the gpmc-onenand
> code. Sync mode does not work, but it seems like it was never enabled
> for sdp anyways.
> 
> Similar patch should work for other boards too.

Setting the sync_write depends on flags and processor, not just flags.
Here's a fixed version of this patch.

Tony

--MAH+hnPXVZWQ5cD/
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="onenand-add-flags-v2.patch"

>From 7c9f55ca7dcf9768fee7128fab5f5cf3cacc1e21 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 30 Apr 2009 11:43:19 -0700
Subject: [PATCH] onenand_init: Allow disabling sync read and write based on flags, v2

Allow disabling sync read and write based on flags

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index fc79183..4583c79 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -86,15 +86,18 @@ static void omap2_onenand_writew(unsigned short value, void __iomem *addr)
 }
 
 static void set_onenand_cfg(void __iomem *onenand_base, int latency,
-			    int sync_write, int hf)
+				int sync_read, int sync_write, int hf)
 {
 	u32 reg;
 
 	reg = omap2_onenand_readw(onenand_base + ONENAND_REG_SYS_CFG1);
 	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
 	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
-		ONENAND_SYS_CFG1_SYNC_READ |
 		ONENAND_SYS_CFG1_BL_16;
+	if (sync_read)
+		reg |= ONENAND_SYS_CFG1_SYNC_READ;
+	else
+		reg &= ~ONENAND_SYS_CFG1_SYNC_READ;
 	if (sync_write)
 		reg |= ONENAND_SYS_CFG1_SYNC_WRITE;
 	else
@@ -106,8 +109,9 @@ static void set_onenand_cfg(void __iomem *onenand_base, int latency,
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
@@ -118,9 +122,19 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 	const int t_wph  = 30;
 	int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_ach, t_aavdh, t_rdyo;
 	int tick_ns, div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency;
-	int err, ticks_cez, sync_write = 0, first_time = 0, hf = 0;
+	int err, ticks_cez, sync_read, sync_write, first_time = 0, hf = 0;
+	int cs = cfg->cs;
 	u32 reg;
 
+	if (cfg->flags & ONENAND_DIS_SYNC_READ)
+		sync_read = 0;
+	else
+		sync_read = 1;
+	if (cpu_is_omap24xx() || (cfg->flags & ONENAND_DIS_SYNC_WRITE))
+		sync_write = 0;
+	else
+		sync_write = 1;
+
 	if (!freq) {
 		/* Very first call freq is not known */
 		err = omap2_onenand_set_async_mode(cs, onenand_base);
@@ -160,8 +174,6 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 		t_ach   = 6;
 		t_aavdh = 6;
 		t_rdyo  = 9;
-		if (cpu_is_omap34xx())
-			sync_write = 1;
 		break;
 	case 66:
 		min_gpmc_clk_period = 15; /* 66 MHz */
@@ -171,8 +183,6 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 		t_ach   = 6;
 		t_aavdh = 6;
 		t_rdyo  = 11;
-		if (cpu_is_omap34xx())
-			sync_write = 1;
 		break;
 	default:
 		min_gpmc_clk_period = 18; /* 54 MHz */
@@ -182,6 +192,7 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 		t_ach   = 9;
 		t_aavdh = 7;
 		t_rdyo  = 15;
+		sync_write = 0;
 		break;
 	}
 
@@ -198,7 +209,8 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 		latency = 4;
 
 	if (first_time)
-		set_onenand_cfg(onenand_base, latency, sync_write, hf);
+		set_onenand_cfg(onenand_base, latency,
+					sync_read, sync_write, hf);
 
 	if (div == 1) {
 		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG2);
@@ -272,7 +284,7 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
 			  GPMC_CONFIG1_WRAPBURST_SUPP |
 			  GPMC_CONFIG1_READMULTIPLE_SUPP |
-			  GPMC_CONFIG1_READTYPE_SYNC |
+			  (sync_read ? GPMC_CONFIG1_READTYPE_SYNC : 0) |
 			  (sync_write ? GPMC_CONFIG1_WRITEMULTIPLE_SUPP : 0) |
 			  (sync_write ? GPMC_CONFIG1_WRITETYPE_SYNC : 0) |
 			  GPMC_CONFIG1_CLKACTIVATIONTIME(fclk_offset) |
@@ -288,7 +300,7 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 	if (err)
 		return err;
 
-	set_onenand_cfg(onenand_base, latency, sync_write, hf);
+	set_onenand_cfg(onenand_base, latency, sync_read, sync_write, hf);
 
 	return 0;
 }
@@ -298,7 +310,7 @@ static int gpmc_onenand_setup(void __iomem *onenand_base, int freq)
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

--MAH+hnPXVZWQ5cD/--
