From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 02/10] OMAP4: DSS: HDMI: Move pll and video
 configuration
Date: Thu, 01 Sep 2011 11:27:45 +0300
Message-ID: <1314865665.2169.7.camel@lappyti>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
	 <1314598500-24005-2-git-send-email-mythripk@ti.com>
	 <1314598500-24005-3-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:56297 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755580Ab1IAI17 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 04:27:59 -0400
Received: by mail-bw0-f42.google.com with SMTP id s6so1254252bka.29
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 01:27:58 -0700 (PDT)
In-Reply-To: <1314598500-24005-3-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org

On Mon, 2011-08-29 at 11:44 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
> 
> As the pll and the video configuration info are part of the ip_data those
> structures are moved to the ip_data strtucure.Also the functions are modified
> accordingly to take care of this movement.

structure typoed, and use a space after period.

> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.c |   34 +++++++++++++++-------------------
>  drivers/video/omap2/dss/hdmi.h |   18 ++++++++++--------
>  2 files changed, 25 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
> index 544f93e..084a47e 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -59,7 +59,6 @@ static struct {
>  	u8 edid[HDMI_EDID_MAX_LENGTH];
>  	u8 edid_set;
>  	bool custom_set;
> -	struct hdmi_config cfg;
>  
>  	struct clk *sys_clk;
>  } hdmi;
> @@ -230,11 +229,11 @@ int hdmi_init_display(struct omap_dss_device *dssdev)
>  }
>  
>  static int hdmi_pll_init(struct hdmi_ip_data *ip_data,
> -		enum hdmi_clk_refsel refsel, int dcofreq,
> -		struct hdmi_pll_info *fmt, u16 sd)
> +			enum hdmi_clk_refsel refsel)
>  {
>  	u32 r;
>  	void __iomem *pll_base = hdmi_pll_base(ip_data);
> +	struct hdmi_pll_info *fmt = &ip_data->pll_data;
>  
>  	/* PLL start always use manual mode */
>  	REG_FLD_MOD(pll_base, PLLCTRL_PLL_CONTROL, 0x0, 0, 0);
> @@ -251,9 +250,9 @@ static int hdmi_pll_init(struct hdmi_ip_data *ip_data,
>  	r = FLD_MOD(r, 0x1, 13, 13); /* PLL_REFEN */
>  	r = FLD_MOD(r, 0x0, 14, 14); /* PHY_CLKINEN de-assert during locking */
>  
> -	if (dcofreq) {
> +	if (fmt->dcofreq) {
>  		/* divider programming for frequency beyond 1000Mhz */
> -		REG_FLD_MOD(pll_base, PLLCTRL_CFG3, sd, 17, 10);
> +		REG_FLD_MOD(pll_base, PLLCTRL_CFG3, fmt->regsd, 17, 10);
>  		r = FLD_MOD(r, 0x4, 3, 1); /* 1000MHz and 2000MHz */
>  	} else {
>  		r = FLD_MOD(r, 0x2, 3, 1); /* 500MHz and 1000MHz */
> @@ -379,8 +378,7 @@ static int hdmi_phy_init(struct hdmi_ip_data *ip_data)
>  	return 0;
>  }
>  
> -static int hdmi_pll_program(struct hdmi_ip_data *ip_data,
> -				struct hdmi_pll_info *fmt)
> +static int hdmi_pll_program(struct hdmi_ip_data *ip_data)
>  {
>  	u16 r = 0;
>  	enum hdmi_clk_refsel refsel;
> @@ -399,7 +397,7 @@ static int hdmi_pll_program(struct hdmi_ip_data *ip_data,
>  
>  	refsel = HDMI_REFSEL_SYSCLK;
>  
> -	r = hdmi_pll_init(ip_data, refsel, fmt->dcofreq, fmt, fmt->regsd);
> +	r = hdmi_pll_init(ip_data, refsel);

I don't think I quite understood why refsel is not part of the pll info.
And if it has to be hardcoded, you could as well do that in
hdmi_pll_init().

 Tomi


