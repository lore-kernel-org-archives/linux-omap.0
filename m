From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCHv2 20/28] OMAP: DSS2: Use PM runtime & HWMOD support
Date: Fri, 10 Jun 2011 05:03:37 +0900
Message-ID: <20110609200335.GD26006@linux-sh.org>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com> <1307627810-3768-21-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:44572 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683Ab1FIUDp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jun 2011 16:03:45 -0400
Content-Disposition: inline
In-Reply-To: <1307627810-3768-21-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com, khilman@ti.com

On Thu, Jun 09, 2011 at 04:56:42PM +0300, Tomi Valkeinen wrote:
> +int dispc_runtime_get(void)
> +{
> +	int r;
> +
> +	DSSDBG("dispc_runtime_get\n");
> +
> +	r = pm_runtime_get_sync(&dispc.pdev->dev);
> +	WARN_ON(r < 0);
> +	return r < 0 ? r : 0;
> +}
> +
> +void dispc_runtime_put(void)
> +{
> +	int r;
> +
> +	DSSDBG("dispc_runtime_put\n");
> +
> +	r = pm_runtime_put(&dispc.pdev->dev);
> +	WARN_ON(r < 0);
>  }
>  
This seems a bit odd. Your runtime_get wrapper is explicitly synchronous
while your put wrapper is explicitly asynchronous, although these details
(if intentional) are not at all obvious from the wrapper naming. From
the use in the error paths and so on you will definitely need to be using
pm_runtime_put_sync() at least some of the time.

In the interest of avoiding confusion, I would in general just get rid of
these wrappers and use the pm_runtime calls openly, as you already do for
some of the other parts of the API. The runtime PM framework has pretty
verbose debugging already that goes well beyond what you presently have,
too.

You seem to have adopted this sync/async pattern for all of the users:

> +int dsi_runtime_get(struct platform_device *dsidev)
>  {
> -	if (enable)
> -		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
> -	else
> -		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
> +	int r;
> +	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
> +
> +	DSSDBG("dsi_runtime_get\n");
> +
> +	r = pm_runtime_get_sync(&dsi->pdev->dev);
> +	WARN_ON(r < 0);
> +	return r < 0 ? r : 0;
> +}
> +
> +void dsi_runtime_put(struct platform_device *dsidev)
> +{
> +	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
> +	int r;
> +
> +	DSSDBG("dsi_runtime_put\n");
> +
> +	r = pm_runtime_put(&dsi->pdev->dev);
> +	WARN_ON(r < 0);
>  }
>  
Here.

> -void dss_clk_disable(enum dss_clock clks)
> -{
..
> -	dss_clk_disable_no_ctx(clks);
> +	r = pm_runtime_get_sync(&dss.pdev->dev);
> +	WARN_ON(r < 0);
> +	return r < 0 ? r : 0;
>  }
>  
> -static void dss_clk_enable_all_no_ctx(void)
> +void dss_runtime_put(void)
>  {
..
> +	r = pm_runtime_put(&dss.pdev->dev);
> +	WARN_ON(r < 0);
>  }
>  
And here.

> +static int hdmi_runtime_get(void)
> +{
> +	int r;
> +
> +	DSSDBG("hdmi_runtime_get\n");
> +
> +	r = pm_runtime_get_sync(&hdmi.pdev->dev);
> +	WARN_ON(r < 0);
> +	return r < 0 ? r : 0;
> +}
> +
> +static void hdmi_runtime_put(void)
> +{
> +	int r;
> +
> +	DSSDBG("hdmi_runtime_put\n");
> +
> +	r = pm_runtime_put(&hdmi.pdev->dev);
> +	WARN_ON(r < 0);
> +}
> +
And here.

> -static void rfbi_enable_clocks(bool enable)
> +static int rfbi_runtime_get(void)
>  {
> -	if (enable)
> -		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
> -	else
> -		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
> +	int r;
> +
> +	DSSDBG("rfbi_runtime_get\n");
> +
> +	r = pm_runtime_get_sync(&rfbi.pdev->dev);
> +	WARN_ON(r < 0);
> +	return r < 0 ? r : 0;
> +}
> +
> +static void rfbi_runtime_put(void)
> +{
> +	int r;
> +
> +	DSSDBG("rfbi_runtime_put\n");
> +
> +	r = pm_runtime_put(&rfbi.pdev->dev);
> +	WARN_ON(r < 0);
>  }
>  
And here.

> +static int venc_runtime_get(void)
>  {
> -	if (enable) {
> -		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK | DSS_CLK_TVFCK);
> -		if (dss_has_feature(FEAT_VENC_REQUIRES_TV_DAC_CLK))
> -			dss_clk_enable(DSS_CLK_VIDFCK);
> -	} else {
> -		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK | DSS_CLK_TVFCK);
> -		if (dss_has_feature(FEAT_VENC_REQUIRES_TV_DAC_CLK))
> -			dss_clk_disable(DSS_CLK_VIDFCK);
> -	}
> +	int r;
> +
> +	DSSDBG("venc_runtime_get\n");
> +
> +	r = pm_runtime_get_sync(&venc.pdev->dev);
> +	WARN_ON(r < 0);
> +	return r < 0 ? r : 0;
> +}
> +
> +static void venc_runtime_put(void)
> +{
> +	int r;
> +
> +	DSSDBG("venc_runtime_put\n");
> +
> +	r = pm_runtime_put(&venc.pdev->dev);
> +	WARN_ON(r < 0);
>  }
>  
And here.
