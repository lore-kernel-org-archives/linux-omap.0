From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 6/8] OMAPDSS: DSI: calculate dsi clock
Date: Fri, 24 Aug 2012 11:46:39 +0530
Message-ID: <50371C47.30708@ti.com>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com> <1345729514-2441-7-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53212 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754071Ab2HXGSN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Aug 2012 02:18:13 -0400
In-Reply-To: <1345729514-2441-7-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 23 August 2012 07:15 PM, Tomi Valkeinen wrote:
> Currently the way to configure clocks related to DSI (both DSI and DISPC
> clocks) happens via omapdss platform data. The reason for this is that
> configuring the DSS clocks is a very complex problem, and it's
> impossible for the SW to know requirements about things like
> interference.
>
> However, for general cases it should be fine to calculate the dividers
> for clocks in the SW. The calculated clocks are probably not perfect,
> but should work.
>
> This patch adds support to calculate the dividers when using DSI command
> mode panels. The panel gives the required DDR clock rate and LP clock
> rate, and the DSI driver configures itself and DISPC accordingly.
>
> This patch is somewhat ugly, though. The code does its job by modifying
> the platform data where the clock dividers would be if the board file
> gave them. This is not how it's going to be in the future, but allows us
> to have quite simple patch and keep the backward compatibility.
>
> It also allows the developer to still give the exact dividers from the
> board file when there's need for that, as long as the panel driver does
> not override them.
>
> There are also other areas for improvement. For example, it would be
> better if the panel driver could ask for a DSI clock in a certain range,
> as, at least command mode panels, the panel can work fine with many
> different clock speeds.
>
> While the patch is not perfect, it allows us to remove the hardcoded
> clock dividers from the board file, making it easier to bring up a new
> panel and to use device tree from omapdss.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/displays/panel-taal.c |    6 ++
>   drivers/video/omap2/dss/dsi.c             |  126 +++++++++++++++++++++++++++++
>   include/video/omapdss.h                   |    2 +
>   3 files changed, 134 insertions(+)
>
> diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
> index 77aed0e..ddda96a 100644
> --- a/drivers/video/omap2/displays/panel-taal.c
> +++ b/drivers/video/omap2/displays/panel-taal.c
> @@ -1065,6 +1065,12 @@ static int taal_power_on(struct omap_dss_device *dssdev)
>   	omapdss_dsi_set_pixel_format(dssdev, OMAP_DSS_DSI_FMT_RGB888);
>   	omapdss_dsi_set_operation_mode(dssdev, OMAP_DSS_DSI_CMD_MODE);
>
> +	r = omapdss_dsi_set_clocks(dssdev, 216000000, 10000000);
> +	if (r) {
> +		dev_err(&dssdev->dev, "failed to set HS and LP clocks\n");
> +		goto err0;
> +	}
> +
>   	r = omapdss_dsi_display_enable(dssdev);
>   	if (r) {
>   		dev_err(&dssdev->dev, "failed to enable DSI\n");
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index 96d0024..340c832 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -1454,6 +1454,68 @@ found:
>   	return 0;
>   }
>
> +static int dsi_pll_calc_ddrfreq(struct platform_device *dsidev,
> +		unsigned long req_clk, struct dsi_clock_info *cinfo)
> +{
> +	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
> +	struct dsi_clock_info cur, best;
> +	unsigned long dss_sys_clk, max_dss_fck, max_dsi_fck;
> +	unsigned long req_clkin4ddr;
> +
> +	DSSDBG("dsi_pll_calc_ddrfreq\n");
> +
> +	dss_sys_clk = clk_get_rate(dsi->sys_clk);
> +
> +	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
> +	max_dsi_fck = dss_feat_get_param_max(FEAT_PARAM_DSI_FCK);
> +
> +	memset(&best, 0, sizeof(best));
> +	memset(&cur, 0, sizeof(cur));
> +
> +	cur.clkin = dss_sys_clk;
> +
> +	req_clkin4ddr = req_clk * 4;
> +
> +	for (cur.regn = 1; cur.regn < dsi->regn_max; ++cur.regn) {
> +		cur.fint = cur.clkin / cur.regn;
> +
> +		if (cur.fint > dsi->fint_max || cur.fint < dsi->fint_min)
> +			continue;
> +
> +		/* DSIPHY(MHz) = (2 * regm / regn) * clkin */
> +		for (cur.regm = 1; cur.regm < dsi->regm_max; ++cur.regm) {
> +			unsigned long a, b;
> +
> +			a = 2 * cur.regm * (cur.clkin/1000);
> +			b = cur.regn;
> +			cur.clkin4ddr = a / b * 1000;
> +
> +			if (cur.clkin4ddr > 1800 * 1000 * 1000)
> +				break;
> +
> +			if (abs(cur.clkin4ddr - req_clkin4ddr) <
> +					abs(best.clkin4ddr - req_clkin4ddr)) {
> +				best = cur;
> +				DSSDBG("best %ld\n", best.clkin4ddr);
> +			}
> +
> +			if (cur.clkin4ddr == req_clkin4ddr)
> +				goto found;
> +		}
> +	}
> +found:
> +	best.regm_dispc = DIV_ROUND_UP(best.clkin4ddr, max_dss_fck);
> +	best.dsi_pll_hsdiv_dispc_clk = best.clkin4ddr / best.regm_dispc;
> +
> +	best.regm_dsi = DIV_ROUND_UP(best.clkin4ddr, max_dsi_fck);
> +	best.dsi_pll_hsdiv_dsi_clk = best.clkin4ddr / best.regm_dsi;
> +
> +	if (cinfo)
> +		*cinfo = best;
> +
> +	return 0;
> +}
> +
>   int dsi_pll_set_clock_div(struct platform_device *dsidev,
>   		struct dsi_clock_info *cinfo)
>   {
> @@ -4110,6 +4172,70 @@ int omapdss_dsi_configure_pins(struct omap_dss_device *dssdev,
>   }
>   EXPORT_SYMBOL(omapdss_dsi_configure_pins);
>
> +int omapdss_dsi_set_clocks(struct omap_dss_device *dssdev,
> +		unsigned long ddr_clk, unsigned long lp_clk)
> +{
> +	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
> +	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
> +	struct dsi_clock_info cinfo;
> +	struct dispc_clock_info dispc_cinfo;
> +	unsigned lp_clk_div;
> +	unsigned long dsi_fclk;
> +	int bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
> +	unsigned long pck;
> +	int r;
> +
> +	DSSDBGF("ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
> +
> +	mutex_lock(&dsi->lock);
> +
> +	r = dsi_pll_calc_ddrfreq(dsidev, ddr_clk, &cinfo);
> +	if (r)
> +		goto err;
> +
> +	dssdev->clocks.dsi.regn = cinfo.regn;
> +	dssdev->clocks.dsi.regm = cinfo.regm;
> +	dssdev->clocks.dsi.regm_dispc = cinfo.regm_dispc;
> +	dssdev->clocks.dsi.regm_dsi = cinfo.regm_dsi;
> +
> +
> +	dsi_fclk = cinfo.dsi_pll_hsdiv_dsi_clk;
> +	lp_clk_div = DIV_ROUND_UP(dsi_fclk, lp_clk * 2);
> +
> +	dssdev->clocks.dsi.lp_clk_div = lp_clk_div;
> +
> +	/* pck = TxByteClkHS * datalanes * 8 / bitsperpixel */

This formula looks a bit simplified, we aren't considering the header 
and footers of long packets that will add to the DDR clock. But I guess 
not considering these would only give a higher pixel clock than needed, 
which isn't that bad.

> +
> +	pck = cinfo.clkin4ddr / 16 * (dsi->num_lanes_used - 1) * 8 / bpp;
> +
> +	DSSDBG("finding dispc dividers for pck %lu\n", pck);
> +
> +	dispc_find_clk_divs(pck, cinfo.dsi_pll_hsdiv_dispc_clk, &dispc_cinfo);
> +
> +	dssdev->clocks.dispc.channel.lck_div = dispc_cinfo.lck_div;
> +	dssdev->clocks.dispc.channel.pck_div = dispc_cinfo.pck_div;
> +
> +

one unnecessary new line above.

<snip>

Archit

