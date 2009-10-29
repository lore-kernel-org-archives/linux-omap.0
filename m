From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] omap2: mux: intoduce omap_mux_{read,write}, v2
Date: Thu, 29 Oct 2009 09:51:19 -0700
Message-ID: <20091029165119.GM7180@atomide.com>
References: <cover.1256734115.git.mike@compulab.co.il> <afa6b6ded8db35578a200c71938174a61eaa4ef9.1256734115.git.mike@compulab.co.il> <20091029155010.GI7180@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60185 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755633AbZJ2QvQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 12:51:16 -0400
Content-Disposition: inline
In-Reply-To: <20091029155010.GI7180@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-omap@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [091029 08:50]:
> * Mike Rapoport <mike@compulab.co.il> [091028 06:17]:
> > Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> > ---
> >  arch/arm/mach-omap2/mux.c |   25 +++++++++++++++++++------
> >  1 files changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> > index 32c953e..eb6e202 100644
> > --- a/arch/arm/mach-omap2/mux.c
> > +++ b/arch/arm/mach-omap2/mux.c
> > @@ -37,6 +37,22 @@
> >  
> >  static struct omap_mux_cfg arch_mux_cfg;
> >  
> > +static inline u16 omap_mux_read(u16 reg)
> > +{
> > +	if (cpu_is_omap24xx())
> > +		return omap_ctrl_readb(reg);
> > +	else
> > +		return omap_ctrl_readw(reg);
> > +}
> > +
> > +static inline void omap_mux_write(u16 val, u16 reg)
> > +{
> > +	if (cpu_is_omap24xx())
> > +		return omap_ctrl_writeb(val, reg);
> > +	else
> > +		return omap_ctrl_writew(val, reg);
> > +}
> > +
> 
> The void function should not return any values above..
> 
> I suggest we standardize on:

Here's an updated version of your patch, what do you think?

Tony

--5vNYLRcllDrimb99
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="mux-read-write-v2.patch"

>From db32fbf2e64174568e4ca4019926f9e43bba9b7e Mon Sep 17 00:00:00 2001
From: Mike Rapoport <mike@compulab.co.il>
Date: Wed, 28 Oct 2009 14:36:38 -0700
Subject: [PATCH] omap2: mux: intoduce omap_mux_{read,write}

intoduce omap_mux_{read,write}

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 32c953e..ad8e0d0 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -35,7 +35,27 @@
 
 #ifdef CONFIG_OMAP_MUX
 
+#define OMAP_MUX_BASE_OFFSET		0x30	/* Offset from CTRL_BASE */
+#define OMAP_MUX_BASE_SZ		0x5ca
+
 static struct omap_mux_cfg arch_mux_cfg;
+static void __iomem *mux_base;
+
+static inline u16 omap_mux_read(u16 reg)
+{
+       if (cpu_is_omap24xx())
+               return __raw_readb(mux_base + reg);
+       else
+               return __raw_readw(mux_base + reg);
+}
+
+static inline void omap_mux_write(u16 val, u16 reg)
+{
+       if (cpu_is_omap24xx())
+               __raw_writeb(val, mux_base + reg);
+       else
+               __raw_writew(val, mux_base + reg);
+}
 
 /* NOTE: See mux.h for the enumeration */
 
@@ -566,10 +586,7 @@ static void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u16 r
 	u16 orig;
 	u8 warn = 0, debug = 0;
 
-	if (cpu_is_omap24xx())
-		orig = omap_ctrl_readb(cfg->mux_reg);
-	else
-		orig = omap_ctrl_readw(cfg->mux_reg);
+	orig = omap_mux_read(cfg->mux_reg - OMAP_MUX_BASE_OFFSET);
 
 #ifdef	CONFIG_OMAP_MUX_DEBUG
 	debug = cfg->debug;
@@ -599,7 +616,7 @@ static int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
 	if (cfg->pu_pd_val)
 		reg |= OMAP2_PULL_UP;
 	omap2_cfg_debug(cfg, reg);
-	omap_ctrl_writeb(reg, cfg->mux_reg);
+	omap_mux_write(reg, cfg->mux_reg - OMAP_MUX_BASE_OFFSET);
 	spin_unlock_irqrestore(&mux_spin_lock, flags);
 
 	return 0;
@@ -618,7 +635,7 @@ static int __init_or_module omap34xx_cfg_reg(const struct pin_config *cfg)
 	spin_lock_irqsave(&mux_spin_lock, flags);
 	reg |= cfg->mux_val;
 	omap2_cfg_debug(cfg, reg);
-	omap_ctrl_writew(reg, cfg->mux_reg);
+	omap_mux_write(reg, cfg->mux_reg - OMAP_MUX_BASE_OFFSET);
 	spin_unlock_irqrestore(&mux_spin_lock, flags);
 
 	return 0;
@@ -627,8 +644,27 @@ static int __init_or_module omap34xx_cfg_reg(const struct pin_config *cfg)
 #define omap34xx_cfg_reg	NULL
 #endif
 
+#define OMAP2
+#define OMAP2_CONTROL_PADCONF_MUX_PBASE	0x48002030LU
+#define OMAP3_CONTROL_PADCONF_MUX_PBASE	0x48002030LU
+
 int __init omap2_mux_init(void)
 {
+	u32 mux_pbase;
+
+	if (cpu_is_omap2420())
+		mux_pbase = OMAP2420_CTRL_BASE + OMAP_MUX_BASE_OFFSET;
+	else if (cpu_is_omap2430())
+		mux_pbase = OMAP243X_CTRL_BASE + OMAP_MUX_BASE_OFFSET;
+	else if (cpu_is_omap34xx())
+		mux_pbase = OMAP343X_CTRL_BASE + OMAP_MUX_BASE_OFFSET;
+
+	mux_base = ioremap(mux_pbase, OMAP_MUX_BASE_SZ);
+	if (!mux_base) {
+		printk(KERN_ERR "mux: Could not ioremap\n");
+		return -ENODEV;
+	}
+
 	if (cpu_is_omap24xx()) {
 		arch_mux_cfg.pins	= omap24xx_pins;
 		arch_mux_cfg.size	= OMAP24XX_PINS_SZ;

--5vNYLRcllDrimb99--
