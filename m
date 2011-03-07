From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP4: DSS2: Clock source changes for OMAP4
Date: Mon, 7 Mar 2011 09:23:55 +0200
Message-ID: <1299482635.2281.27.camel@deskari>
References: <1299236564-1021-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43050 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972Ab1CGHYA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 02:24:00 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p277NxWj009133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 01:23:59 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p277Nx2R023279
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 01:23:59 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p277NxhZ026407
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 01:23:59 -0600 (CST)
In-Reply-To: <1299236564-1021-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Fri, 2011-03-04 at 05:02 -0600, Taneja, Archit wrote:
> On OMAP3, the pixel clock for the LCD manager was derived through DISPC_FCLK as:
> 
> Lcd Pixel clock = DISPC_FCLK / lcd / pcd
> 
> Where lcd and pcd are divisors in the DISPC_DIVISOR register.
> 
> On OMAP4, the pixel clocks for LCD1 and LCD2 managers are derived from 2 new
> clocks named LCD1_CLK and LCD2_CLK. The pixel clocks are calculated as:
> 
> Lcd_o Pixel clock = LCDo_CLK / lcdo /pcdo, o = 1, 2
> 
> Where lcdo and pcdo registers are divisors in DISPC_DIVISORo registers.
> 
> LCD1_CLK and LCD2_CLK can have DSS_FCLK, and the M4 divider clocks of DSI1 PLL
> and DSI2 PLL as clock sources respectively. Introduce functions to select and
> get the clock source for these new clocks. Modify DISPC functions get the
> correct lck and pck rates based on the clock source of these clocks.
> 
> Currently, LCD2_CLK can only have DSS_FCLK as its clock source as DSI2 PLL
> functionality hasn't been introduced yet. BUG for now if DSI2 PLL is selected as
> clock.
> 
> Also, clean up some of the DSS functions which select clock sources to switch on
> clock source members as more clock sources will be introduced later on.

Usually having "also" in a patch description means that the patch could
be split in two =).

This patch is slightly hard to chew, as the clocking of OMAP4 DSS is not
the simplest one. Please check if you see that there's a possibility to
split this easily and cleanly.

> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
> Note: Applies over:
> 
> http://gitorious.org/linux-omap-dss2/linux/commits/master
> 
>  drivers/video/omap2/dss/dispc.c        |   48 ++++++++++++++++---
>  drivers/video/omap2/dss/dss.c          |   78 ++++++++++++++++++++++++++------
>  drivers/video/omap2/dss/dss.h          |   26 +++++++----
>  drivers/video/omap2/dss/dss_features.c |   13 +++++-
>  drivers/video/omap2/dss/dss_features.h |    3 +
>  5 files changed, 135 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index dae9686..7b4392b 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -2341,14 +2341,21 @@ unsigned long dispc_fclk_rate(void)
>  {
>  	unsigned long r = 0;
>  
> -	if (dss_get_dispc_clk_source() == DSS_CLK_SRC_FCK)
> +	switch (dss_get_dispc_clk_source()) {
> +	case DSS_CLK_SRC_FCK:
>  		r = dss_clk_get_rate(DSS_CLK_FCK);
> -	else
> +		break;
>  #ifdef CONFIG_OMAP2_DSS_DSI
> +	case DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
>  		r = dsi_get_pll_hsdiv_dispc_rate();
> +		break;
>  #else
> -	BUG();
> +	case DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
> +		BUG();
>  #endif

I think we should get rid of these ifdefs by having a dummy inline
dsi_get_pll_hsdiv_dispc_rate() function in case CONFIG_OMAP2_DSS_DSI is
not defined.

> +	default:
> +		BUG();
> +	}
>  	return r;
>  }
>  
> @@ -2362,25 +2369,35 @@ unsigned long dispc_lclk_rate(enum omap_channel channel)
>  
>  	lcd = FLD_GET(l, 23, 16);
>  
> -	r = dispc_fclk_rate();
> +	if (dss_has_feature(FEAT_LCD_CLK_SRC)) {
> +		if (dss_get_lcd_clk_source(channel) == DSS_CLK_SRC_FCK)
> +			r = dss_clk_get_rate(DSS_CLK_FCK);
> +		else
> +#ifdef CONFIG_OMAP2_DSS_DSI
> +			r = dsi_get_pll_hsdiv_dispc_rate();
> +#else
> +			BUG();
> +#endif
> +	} else {
> +		r = dispc_fclk_rate();
> +	}

Could we use the same dss_get_lcd_clk_source() system even on omap2/3?
We would have a hardcoded clk source for the channel, of course. What
I'm aiming at is to get this cleaner, if there would be no need to check
for the feature. Also the same comment about ifdefs as above.

>  
>  	return r / lcd;
>  }
>  
>  unsigned long dispc_pclk_rate(enum omap_channel channel)
>  {
> -	int lcd, pcd;
> +	int pcd;
>  	unsigned long r;
>  	u32 l;
>  
>  	l = dispc_read_reg(DISPC_DIVISORo(channel));
>  
> -	lcd = FLD_GET(l, 23, 16);
>  	pcd = FLD_GET(l, 7, 0);
>  
> -	r = dispc_fclk_rate();
> +	r = dispc_lclk_rate(channel);
>  
> -	return r / lcd / pcd;
> +	return r / pcd;
>  }
>  
>  void dispc_dump_clocks(struct seq_file *s)
> @@ -2388,6 +2405,7 @@ void dispc_dump_clocks(struct seq_file *s)
>  	int lcd, pcd;
>  	u32 l;
>  	enum dss_clk_source dispc_clk_src = dss_get_dispc_clk_source();
> +	enum dss_clk_source lcd_clk_src;
>  
>  	enable_clocks(1);
>  
> @@ -2409,6 +2427,14 @@ void dispc_dump_clocks(struct seq_file *s)
>  	}
>  	seq_printf(s, "- LCD1 -\n");
>  
> +	if (dss_has_feature(FEAT_LCD_CLK_SRC)) {
> +		lcd_clk_src = dss_get_lcd_clk_source(OMAP_DSS_CHANNEL_LCD);
> +
> +		seq_printf(s, "lcd1_clk source = %s (%s)\n",
> +			dss_get_generic_clk_source_name(lcd_clk_src),
> +			dss_feat_get_clk_source_name(lcd_clk_src));
> +	}
> +
>  	dispc_get_lcd_divisor(OMAP_DSS_CHANNEL_LCD, &lcd, &pcd);
>  
>  	seq_printf(s, "lck\t\t%-16lulck div\t%u\n",
> @@ -2418,6 +2444,12 @@ void dispc_dump_clocks(struct seq_file *s)
>  	if (dss_has_feature(FEAT_MGR_LCD2)) {
>  		seq_printf(s, "- LCD2 -\n");
>  
> +		lcd_clk_src = dss_get_lcd_clk_source(OMAP_DSS_CHANNEL_LCD2);
> +
> +		seq_printf(s, "lcd2_clk source = %s (%s)\n",
> +			dss_get_generic_clk_source_name(lcd_clk_src),
> +			dss_feat_get_clk_source_name(lcd_clk_src));
> +
>  		dispc_get_lcd_divisor(OMAP_DSS_CHANNEL_LCD2, &lcd, &pcd);
>  
>  		seq_printf(s, "lck\t\t%-16lulck div\t%u\n",
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> index 2be4d03..cfffa88 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -77,6 +77,7 @@ static struct {
>  
>  	enum dss_clk_source dsi_clk_source;
>  	enum dss_clk_source dispc_clk_source;
> +	enum dss_clk_source lcd_clk_source[MAX_DSS_LCD_MANAGERS];
>  
>  	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
>  } dss;
> @@ -292,16 +293,23 @@ void dss_dump_regs(struct seq_file *s)
>  void dss_select_dispc_clk_source(enum dss_clk_source clk_src)
>  {
>  	int b;
> -
> -	BUG_ON(clk_src != DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC &&
> -			clk_src != DSS_CLK_SRC_FCK);
> -
> -	b = clk_src == DSS_CLK_SRC_FCK ? 0 : 1;
> -
> -	if (clk_src == DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC)
> +	u8 start, end;
> +
> +	switch (clk_src) {
> +	case DSS_CLK_SRC_FCK:
> +		b = 0;
> +		break;
> +	case DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
> +		b = 1;
>  		dsi_wait_pll_hsdiv_dispc_active();
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	dss_feat_get_reg_field(FEAT_REG_DISPC_CLK_SWITCH, &start, &end);
>  
> -	REG_FLD_MOD(DSS_CONTROL, b, 0, 0);	/* DISPC_CLK_SWITCH */
> +	REG_FLD_MOD(DSS_CONTROL, b, start, end);	/* DISPC_CLK_SWITCH */
>  
>  	dss.dispc_clk_source = clk_src;
>  }
> @@ -310,19 +318,50 @@ void dss_select_dsi_clk_source(enum dss_clk_source clk_src)
>  {
>  	int b;
>  
> -	BUG_ON(clk_src != DSS_CLK_SRC_DSI_PLL_HSDIV_DSI &&
> -			clk_src != DSS_CLK_SRC_FCK);
> -
> -	b = clk_src == DSS_CLK_SRC_FCK ? 0 : 1;
> -
> -	if (clk_src == DSS_CLK_SRC_DSI_PLL_HSDIV_DSI)
> +	switch (clk_src) {
> +	case DSS_CLK_SRC_FCK:
> +		b = 0;
> +		break;
> +	case DSS_CLK_SRC_DSI_PLL_HSDIV_DSI:
> +		b = 1;
>  		dsi_wait_pll_hsdiv_dsi_active();
> +		break;
> +	default:
> +		BUG();
> +	}
>  
>  	REG_FLD_MOD(DSS_CONTROL, b, 1, 1);	/* DSI_CLK_SWITCH */
>  
>  	dss.dsi_clk_source = clk_src;
>  }
>  
> +void dss_select_lcd_clk_source(enum omap_channel channel,
> +		enum dss_clk_source clk_src)
> +{
> +	int b, ix, pos;
> +
> +	switch (clk_src) {
> +	case DSS_CLK_SRC_FCK:
> +		b = 0;
> +		break;
> +	case DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
> +		BUG_ON(channel != OMAP_DSS_CHANNEL_LCD);
> +		b = 1;
> +		dsi_wait_pll_hsdiv_dispc_active();
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	pos = channel == OMAP_DSS_CHANNEL_LCD ? 0 : 12;
> +
> +	REG_FLD_MOD(DSS_CONTROL, b, pos, pos);	/* LCDx_CLK_SWITCH */
> +
> +	ix = channel == OMAP_DSS_CHANNEL_LCD ? 0 : 1;
> +
> +	dss.lcd_clk_source[ix] = clk_src;
> +}
> +
>  enum dss_clk_source dss_get_dispc_clk_source(void)
>  {
>  	return dss.dispc_clk_source;
> @@ -333,6 +372,12 @@ enum dss_clk_source dss_get_dsi_clk_source(void)
>  	return dss.dsi_clk_source;
>  }
>  
> +enum dss_clk_source dss_get_lcd_clk_source(enum omap_channel channel)
> +{
> +	int ix = channel == OMAP_DSS_CHANNEL_LCD ? 0 : 1;
> +	return dss.lcd_clk_source[ix];
> +}
> +
>  /* calculate clock rates using dividers in cinfo */
>  int dss_calc_clock_rates(struct dss_clock_info *cinfo)
>  {
> @@ -617,6 +662,11 @@ static int dss_init(void)
>  	dss.dsi_clk_source = DSS_CLK_SRC_FCK;
>  	dss.dispc_clk_source = DSS_CLK_SRC_FCK;
>  
> +	if (dss_has_feature(FEAT_LCD_CLK_SRC)) {
> +		dss.lcd_clk_source[0] = DSS_CLK_SRC_FCK;
> +		dss.lcd_clk_source[1] = DSS_CLK_SRC_FCK;
> +	}
> +
>  	dss_save_context();
>  
>  	rev = dss_read_reg(DSS_REVISION);
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
> index 85d4141..8d5c2a4 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -118,9 +118,12 @@ enum dss_clock {
>  };
>  
>  enum dss_clk_source {
> -	DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC,	/* DSI1_PLL_FCLK */
> -	DSS_CLK_SRC_DSI_PLL_HSDIV_DSI,		/* DSI2_PLL_FCLK */
> -	DSS_CLK_SRC_FCK,			/* DSS1_ALWON_FCLK */
> +	DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC,	/* OMAP3: DSI1_PLL_FCLK
> +						 * OMAP4: PLL1_CLK1 */
> +	DSS_CLK_SRC_DSI_PLL_HSDIV_DSI,		/* OMAP3: DSI2_PLL_FCLK
> +						 * OMAP4: PLL1_CLK2 */
> +	DSS_CLK_SRC_FCK,			/* OMAP2/3: DSS1_ALWON_FCLK
> +						 * OMAP4: DSS_FCLK */
>  };
>  
>  /* Correlates clock source name and dss_clk_source member */
> @@ -152,17 +155,19 @@ struct dsi_clock_info {
>  	unsigned long fint;
>  	unsigned long clkin4ddr;
>  	unsigned long clkin;
> -	unsigned long dsi_pll_hsdiv_dispc_clk;	/* DSI1_PLL_CLK */
> -	unsigned long dsi_pll_hsdiv_dsi_clk;	/* DSI2_PLL_CLK */
> -
> +	unsigned long dsi_pll_hsdiv_dispc_clk;	/* OMAP3: DSI1_PLL_CLK
> +						 * OMAP4: PLLx_CLK1 */
> +	unsigned long dsi_pll_hsdiv_dsi_clk;	/* OMAP3: DSI2_PLL_CLK
> +						 * OMAP4: PLLx_CLK2 */
>  	unsigned long lp_clk;
>  
>  	/* dividers */
>  	u16 regn;
>  	u16 regm;
> -	u16 regm_dispc;	/* REGM3 */
> -	u16 regm_dsi;	/* REGM4 */
> -
> +	u16 regm_dispc;	/* OMAP3: REGM3
> +			 * OMAP4: REGM4 */
> +	u16 regm_dsi;	/* OMAP3: REGM4
> +			 * OMAP4: REGM5 */
>  	u16 lp_clk_div;
>  
>  	u8 highfreq;
> @@ -235,8 +240,11 @@ void dss_sdi_disable(void);
>  
>  void dss_select_dispc_clk_source(enum dss_clk_source clk_src);
>  void dss_select_dsi_clk_source(enum dss_clk_source clk_src);
> +void dss_select_lcd_clk_source(enum omap_channel channel,
> +		enum dss_clk_source clk_src);
>  enum dss_clk_source dss_get_dispc_clk_source(void);
>  enum dss_clk_source dss_get_dsi_clk_source(void);
> +enum dss_clk_source dss_get_lcd_clk_source(enum omap_channel channel);
>  
>  void dss_set_venc_output(enum omap_dss_venc_type type);
>  void dss_set_dac_pwrdn_bgz(bool enable);
> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
> index dc170ad..6eb6ec6 100644
> --- a/drivers/video/omap2/dss/dss_features.c
> +++ b/drivers/video/omap2/dss/dss_features.c
> @@ -59,6 +59,7 @@ static const struct dss_reg_field omap2_dss_reg_fields[] = {
>  	{ FEAT_REG_FIFOSIZE, 8, 0 },
>  	{ FEAT_REG_HORIZONTALACCU, 9, 0 },
>  	{ FEAT_REG_VERTICALACCU, 25, 16 },
> +	{ FEAT_REG_DISPC_CLK_SWITCH, 0, 0 },
>  };
>  
>  static const struct dss_reg_field omap3_dss_reg_fields[] = {
> @@ -69,6 +70,7 @@ static const struct dss_reg_field omap3_dss_reg_fields[] = {
>  	{ FEAT_REG_FIFOSIZE, 10, 0 },
>  	{ FEAT_REG_HORIZONTALACCU, 9, 0 },
>  	{ FEAT_REG_VERTICALACCU, 25, 16 },
> +	{ FEAT_REG_DISPC_CLK_SWITCH, 0, 0 },
>  };
>  
>  static const struct dss_reg_field omap4_dss_reg_fields[] = {
> @@ -79,6 +81,7 @@ static const struct dss_reg_field omap4_dss_reg_fields[] = {
>  	{ FEAT_REG_FIFOSIZE, 15, 0 },
>  	{ FEAT_REG_HORIZONTALACCU, 10, 0 },
>  	{ FEAT_REG_VERTICALACCU, 26, 16 },
> +	{ FEAT_REG_DISPC_CLK_SWITCH, 9, 8 },
>  };
>  
>  static const enum omap_display_type omap2_dss_supported_displays[] = {
> @@ -171,6 +174,12 @@ static const struct dss_clk_source_name omap3_dss_clk_source_names[] = {
>  	{ DSS_CLK_SRC_FCK, "DSS1_ALWON_FCLK" },
>  };
>  
> +static const struct dss_clk_source_name omap4_dss_clk_source_names[] = {
> +	{ DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC, "PLL1_CLK1" },
> +	{ DSS_CLK_SRC_DSI_PLL_HSDIV_DSI, "PLL1_CLK2" },
> +	{ DSS_CLK_SRC_FCK, "DSS_FCLK" },
> +};
> +
>  /* OMAP2 DSS Features */
>  static struct omap_dss_features omap2_dss_features = {
>  	.reg_fields = omap2_dss_reg_fields,
> @@ -235,14 +244,14 @@ static struct omap_dss_features omap4_dss_features = {
>  	.has_feature	=
>  		FEAT_GLOBAL_ALPHA | FEAT_PRE_MULT_ALPHA |
>  		FEAT_MGR_LCD2 | FEAT_GLOBAL_ALPHA_VID1 |
> -		FEAT_CORE_CLK_DIV,
> +		FEAT_CORE_CLK_DIV | FEAT_LCD_CLK_SRC,
>  
>  	.num_mgrs = 3,
>  	.num_ovls = 3,
>  	.max_dss_fck = 186000000,
>  	.supported_displays = omap4_dss_supported_displays,
>  	.supported_color_modes = omap3_dss_supported_color_modes,
> -	.clksrc_names = omap3_dss_clk_source_names,
> +	.clksrc_names = omap4_dss_clk_source_names,
>  };
>  
>  /* Functions returning values related to a DSS feature */
> diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
> index 569d1b2..3302247 100644
> --- a/drivers/video/omap2/dss/dss_features.h
> +++ b/drivers/video/omap2/dss/dss_features.h
> @@ -22,6 +22,7 @@
>  
>  #define MAX_DSS_MANAGERS	3
>  #define MAX_DSS_OVERLAYS	3
> +#define MAX_DSS_LCD_MANAGERS	(MAX_DSS_MANAGERS - 1)

I wouldn't write it like this. The number of LCD managers is not related
to DSS managers (except being smaller or the same, or course). Just make
it 2.

 Tomi


