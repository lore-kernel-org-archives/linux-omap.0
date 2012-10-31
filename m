From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 08/12] OMAPDSS: setup default dss fck
Date: Wed, 31 Oct 2012 12:01:15 +0530
Message-ID: <5090C5B3.6020502@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-9-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40177 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932227Ab2JaGbb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 02:31:31 -0400
In-Reply-To: <1351613409-21186-9-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com

On Tuesday 30 October 2012 09:40 PM, Tomi Valkeinen wrote:
> We don't currently set the dss fck when starting up. This is not a
> problem, as we setup the fck later when configuring the pixel clocks. Or
> this is how it was for omap2, for the rest of the omaps this may not be
> so.
>
> For DSI, HDMI and also for DPI when using DSI PLL, we don't need to
> change the dss fck, and thus it may be left unconfigured. Usually the
> dss fck is already setup fine by default, but we can't trust this.
>
> This patch sets the dss fck to maximum at probe time.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/dss.c |   36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> index 5affa86..034cc1a 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -485,6 +485,36 @@ unsigned long dss_get_dpll4_rate(void)
>   		return 0;
>   }
>
> +static int dss_setup_default_clock(void)
> +{
> +	unsigned long max_dss_fck, prate;
> +	unsigned fck_div;
> +	struct dss_clock_info dss_cinfo = { 0 };
> +	int r;
> +
> +	if (dss.dpll4_m4_ck == NULL)
> +		return 0;
> +
> +	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
> +
> +	prate = dss_get_dpll4_rate();

Not related to this patch, but maybe we could change the 
dss_get_dpll4_rate() name and dss.dpll4_m4_clk to something better. 
Maybe something like dss_fck_parent?

> +
> +	fck_div = DIV_ROUND_UP(prate * dss.feat->dss_fck_multiplier,
> +			max_dss_fck);
> +
> +	dss_cinfo.fck_div = fck_div;
> +
> +	r = dss_calc_clock_rates(&dss_cinfo);
> +	if (r)
> +		return r;
> +
> +	r = dss_set_clock_div(&dss_cinfo);
> +	if (r)
> +		return r;
> +
> +	return 0;
> +}
> +
>   int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
>   		struct dispc_clock_info *dispc_cinfo)
>   {
> @@ -913,6 +943,10 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
>   	dss.lcd_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
>   	dss.lcd_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
>
> +	r = dss_setup_default_clock();
> +	if (r)
> +		goto err_setup_clocks;

Maybe it's safer to call this before we do a dss_runtime_get(). On 
OMAP4, DSS_FCLK is needed to access registers also. Changing it's rate 
might not be liked by the DSS HW. Also, it seems more logical to call it 
after dss_get_clocks() in omap_dsshw_probe(), then we sort of group the 
clock related stuff together.

Archit

> +
>   	rev = dss_read_reg(DSS_REVISION);
>   	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
>   			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
> @@ -923,6 +957,8 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
>
>   	return 0;
>
> +err_setup_clocks:
> +	dss_runtime_put();
>   err_runtime_get:
>   	pm_runtime_disable(&pdev->dev);
>   	dss_put_clocks();
>

