From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 1/8] OMAP4: DSS: HDMI: HDMI clean up to pass base_address
Date: Mon, 20 Jun 2011 19:03:39 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D625B05@dbde02.ent.ti.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308298637-29753-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59739 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841Ab1FTNds convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jun 2011 09:33:48 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5KDXii1028720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 20 Jun 2011 08:33:47 -0500
In-Reply-To: <1308298637-29753-2-git-send-email-mythripk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of K, Mythri P
> Sent: Friday, June 17, 2011 1:47 PM
> To: linux-omap@vger.kernel.org; Valkeinen, Tomi
> Cc: K, Mythri P
> Subject: [PATCH 1/8] OMAP4: DSS: HDMI: HDMI clean up to pass 
> base_address

[sp] HDMI appears twice on the subject. One of these can be removed.
     Also, it isn't clear (though implied) whose base address is being
     passed.

     The changes in the patch aren't limited to DSS alone.
     See updated to hdmi_core_audio_config(), hdmi_wp_audio_config_format(),
     hdmi_wp_audio_config_dma(), etc.

> 
> As the base_address of the HDMI might differ across SoC's, 

[sp] Is 'base_address' a variable? OR did you mean 'base address'? 

> offset of the HDMI
> logical blocks and base address got from the platform data are passed
> dynamically to the functions that modify HDMI IP registers.

[sp] Overall, the sentence can be simplified.

> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.c |  518 
> ++++++++++++++++++++++++----------------
>  drivers/video/omap2/dss/hdmi.h |  292 +++++++++++------------
>  2 files changed, 452 insertions(+), 358 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/hdmi.c 
> b/drivers/video/omap2/dss/hdmi.c
> index 5e5b98b..1d16ee2 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -43,11 +43,17 @@
>  #include "hdmi.h"
>  #include "dss_features.h"
>  
> +#define HDMI_WP			0x0
> +#define HDMI_CORE_SYS		0x400
> +#define HDMI_CORE_AV		0x900
> +#define HDMI_PLLCTRL		0x200
> +#define HDMI_PHY		0x300
> +
>  static struct {
>  	struct mutex lock;
>  	struct omap_display_platform_data *pdata;
>  	struct platform_device *pdev;
> -	void __iomem *base_wp;	/* HDMI wrapper */
> +	struct hdmi_ip_data hdmi_data;
>  	int code;
>  	int mode;
>  	u8 edid[HDMI_EDID_MAX_LENGTH];
> @@ -146,21 +152,51 @@ static const int code_vesa[85] = {
>  
>  static const u8 edid_header[8] = {0x0, 0xff, 0xff, 0xff, 
> 0xff, 0xff, 0xff, 0x0};
>  
> -static inline void hdmi_write_reg(const struct hdmi_reg idx, u32 val)
> +static inline void hdmi_write_reg(void __iomem *base_addr,
> +				const struct hdmi_reg idx, u32 val)
> +{
> +	__raw_writel(val, base_addr + idx.idx);
> +}
> +
> +static inline u32 hdmi_read_reg(void __iomem *base_addr,
> +				const struct hdmi_reg idx)
> +{
> +	return __raw_readl(base_addr + idx.idx);
> +}
> +
> +static inline void __iomem *hdmi_wp_base(struct hdmi_ip_data 
> *ip_data)
> +{
> +	return (void __iomem *) (ip_data->base_wp);
> +}
> +
> +static inline void __iomem *hdmi_phy_base(struct 
> hdmi_ip_data *ip_data)
>  {
> -	__raw_writel(val, hdmi.base_wp + idx.idx);
> +	return (void __iomem *) (ip_data->base_wp + 
> ip_data->hdmi_phy_offset);
>  }
>  
> -static inline u32 hdmi_read_reg(const struct hdmi_reg idx)
> +static inline void __iomem *hdmi_pll_base(struct 
> hdmi_ip_data *ip_data)
>  {
> -	return __raw_readl(hdmi.base_wp + idx.idx);
> +	return (void __iomem *)	(ip_data->base_wp + 
> ip_data->hdmi_pll_offset);
>  }
>  
> -static inline int hdmi_wait_for_bit_change(const struct hdmi_reg idx,
> +static inline void __iomem *hdmi_av_base(struct hdmi_ip_data 
> *ip_data)
> +{
> +	return (void __iomem *)
> +			(ip_data->base_wp + 
> ip_data->hdmi_core_av_offset);
> +}
> +
> +static inline void __iomem *hdmi_core_sys_base(struct 
> hdmi_ip_data *ip_data)
> +{
> +	return (void __iomem *)
> +			(ip_data->base_wp + 
> ip_data->hdmi_core_sys_offset);
> +}
> +
> +static inline int hdmi_wait_for_bit_change(void __iomem *base_addr,
> +				const struct hdmi_reg idx,
>  				int b2, int b1, u32 val)
>  {
>  	u32 t = 0;
> -	while (val != REG_GET(idx, b2, b1)) {
> +	while (val != REG_GET(base_addr, idx, b2, b1)) {
>  		udelay(1);
>  		if (t++ > 10000)
>  			return !val;
> @@ -225,21 +261,22 @@ int hdmi_init_display(struct 
> omap_dss_device *dssdev)
>  	return 0;
>  }
>  
> -static int hdmi_pll_init(enum hdmi_clk_refsel refsel, int dcofreq,
> +static int hdmi_pll_init(struct hdmi_ip_data *ip_data,
> +		enum hdmi_clk_refsel refsel, int dcofreq,
>  		struct hdmi_pll_info *fmt, u16 sd)
>  {
>  	u32 r;
>  
>  	/* PLL start always use manual mode */
> -	REG_FLD_MOD(PLLCTRL_PLL_CONTROL, 0x0, 0, 0);
> +	REG_FLD_MOD(hdmi_pll_base(ip_data), 
> PLLCTRL_PLL_CONTROL, 0x0, 0, 0);
>  
> -	r = hdmi_read_reg(PLLCTRL_CFG1);
> +	r = hdmi_read_reg(hdmi_pll_base(ip_data), PLLCTRL_CFG1);
>  	r = FLD_MOD(r, fmt->regm, 20, 9); /* CFG1_PLL_REGM */
>  	r = FLD_MOD(r, fmt->regn, 8, 1);  /* CFG1_PLL_REGN */
>  
> -	hdmi_write_reg(PLLCTRL_CFG1, r);
> +	hdmi_write_reg(hdmi_pll_base(ip_data), PLLCTRL_CFG1, r);

[sp] hdmi_pll_base(ip_data) is used at many places withing this
     function. Have you checked if saving the result in a local
     variable generates any better code than repetitive ADD operation
     in the function.
     
     Same comment applies to similar use in other functions
     modified in this patch.

[snip]...[snip]

> -static int hdmi_core_ddc_edid(u8 *pedid, int ext)
> +static int hdmi_core_ddc_edid(struct hdmi_ip_data *ip_data,
> +						u8 *pedid, int ext)
>  {
>  	u32 i, j;
>  	char checksum = 0;
>  	u32 offset = 0;
>  
>  	/* Turn on CLK for DDC */
> -	REG_FLD_MOD(HDMI_CORE_AV_DPD, 0x7, 2, 0);
> +	REG_FLD_MOD(hdmi_av_base(ip_data), HDMI_CORE_AV_DPD, 0x7, 2, 0);
>  
>  	/*
>  	 * SW HACK : Without the Delay DDC(i2c bus) reads 0 values /
> @@ -416,21 +462,23 @@ static int hdmi_core_ddc_edid(u8 
> *pedid, int ext)
>  
>  	if (!ext) {
>  		/* Clk SCL Devices */
> -		REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0xA, 3, 0);
> +		REG_FLD_MOD(hdmi_core_sys_base(ip_data),
> +						
> HDMI_CORE_DDC_CMD, 0xA, 3, 0);
>  
>  		/* HDMI_CORE_DDC_STATUS_IN_PROG */
> -		if (hdmi_wait_for_bit_change(HDMI_CORE_DDC_STATUS,
> -						4, 4, 0) != 0) {
> +		if 
> (hdmi_wait_for_bit_change(hdmi_core_sys_base(ip_data),
> +					HDMI_CORE_DDC_STATUS, 
> 4, 4, 0) != 0) {
>  			DSSERR("Failed to program DDC\n");
>  			return -ETIMEDOUT;
>  		}
>  
>  		/* Clear FIFO */
> -		REG_FLD_MOD(HDMI_CORE_DDC_CMD, 0x9, 3, 0);
> +		REG_FLD_MOD(hdmi_core_sys_base(ip_data)
> +						, 
> HDMI_CORE_DDC_CMD, 0x9, 3, 0);

[sp] Misplaced "," at beginning of the line.

[snip]...[snip]

>  static void update_hdmi_timings(struct hdmi_config *cfg,
> @@ -1166,16 +1231,16 @@ static int hdmi_power_on(struct 
> omap_dss_device *dssdev)
>  
>  	hdmi_compute_pll(dssdev, phy, &pll_data);
>  
> -	hdmi_wp_video_start(0);
> +	hdmi_wp_video_start(&hdmi.hdmi_data, 0);
>  
> -	/* config the PLL and PHY first */
> -	r = hdmi_pll_program(&pll_data);
> +	/* config the PLL and PHY hdmi_set_pll_pwrfirst */

[sp] Is the change in comment intended?

[snip]...[snip]

~sanjeev
