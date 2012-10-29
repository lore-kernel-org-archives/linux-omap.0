From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 11/20] OMAPDSS: HDMI: split power_on/off to two parts
Date: Mon, 29 Oct 2012 15:44:37 +0530
Message-ID: <508E570D.1000101@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com> <1351070951-18616-12-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56076 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758063Ab2J2KOw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 06:14:52 -0400
In-Reply-To: <1351070951-18616-12-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

On Wednesday 24 October 2012 02:59 PM, Tomi Valkeinen wrote:
> There's currently just one power-on function for HDMI, which enables the
> IP and the video output. When reading EDID or detecting if a monitor is
> connected, we don't need the video output.
>
> Enabling the video output for these operations is not a big problem in
> itself, but the quick enable/disable cycles caused by the operations
> seem to cause sync lost errors from time to time. Also, this makes it
> possible to read the EDID before the full video path has been set up.
>
> This patch splits the hdmi_power_on into two parts, hdmi_power_on_core
> and hdmi_power_on_full. The "full" version does what hdmi_power_on does
> currently, and hdmi_power_on_core only enables the core IP. Similar
> changes are made for power_off.
>
> Note that these don't allow the HDMI IP to be first enabled, and later
> enable the video output, but the HDMI IP will first need to be powered
> off before calling the full version. So this is rather limited
> implementation, but it fills the needs for reading EDID.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Ricardo Neri <ricardo.neri@ti.com>
> ---
>   drivers/video/omap2/dss/hdmi.c |   75 ++++++++++++++++++++++++----------------
>   1 file changed, 46 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
> index c1c5488..50d5a10 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -500,12 +500,9 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
>   	DSSDBG("range = %d sd = %d\n", pi->dcofreq, pi->regsd);
>   }
>
> -static int hdmi_power_on(struct omap_dss_device *dssdev)
> +static int hdmi_power_on_core(struct omap_dss_device *dssdev)
>   {
>   	int r;
> -	struct omap_video_timings *p;
> -	struct omap_overlay_manager *mgr = dssdev->output->manager;
> -	unsigned long phy;
>
>   	gpio_set_value(hdmi.ct_cp_hpd_gpio, 1);
>   	gpio_set_value(hdmi.ls_oe_gpio, 1);
> @@ -521,6 +518,46 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
>   	if (r)
>   		goto err_runtime_get;
>
> +	/* Make selection of HDMI in DSS */
> +	dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
> +
> +	/* Select the dispc clock source as PRCM clock, to ensure that it is not
> +	 * DSI PLL source as the clock selected by DSI PLL might not be
> +	 * sufficient for the resolution selected / that can be changed
> +	 * dynamically by user. This can be moved to single location , say
> +	 * Boardfile.
> +	 */
> +	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
> +
> +	return 0;
> +
> +err_runtime_get:
> +	regulator_disable(hdmi.vdda_hdmi_dac_reg);
> +err_vdac_enable:
> +	gpio_set_value(hdmi.ct_cp_hpd_gpio, 0);
> +	gpio_set_value(hdmi.ls_oe_gpio, 0);
> +	return r;
> +}
> +
> +static void hdmi_power_off_core(struct omap_dss_device *dssdev)
> +{
> +	hdmi_runtime_put();
> +	regulator_disable(hdmi.vdda_hdmi_dac_reg);
> +	gpio_set_value(hdmi.ct_cp_hpd_gpio, 0);
> +	gpio_set_value(hdmi.ls_oe_gpio, 0);

We might want to set the DISPC clock source back to DSS_FCK here. Just 
in case it was using something else. Having this still won't make things 
full proof, but probably slightly better.

Archit
