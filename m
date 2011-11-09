From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 1/4] AM35xx: DSS: there is no VDDS_DSI on AM35xx
Date: Wed, 9 Nov 2011 15:40:20 +0530
Message-ID: <4EBA518C.6050405@ti.com>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com> <1320797568-11169-2-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59947 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754149Ab1KIKK6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Nov 2011 05:10:58 -0500
In-Reply-To: <1320797568-11169-2-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

Hi,

On Wednesday 09 November 2011 05:42 AM, Ilya Yanok wrote:
> AM35xx don't have VDDS_DSI regulator.

AM35xx do have vdds_dsi regulator. Are you saying that your particular 
board doesn't have vdds_dsi connected to a regulator?

I assumed that vdds_dsi regulator was required for DPI to function 
properly on omap3 devices.

Archit

>
> Signed-off-by: Ilya Yanok<yanok@emcraft.com>
> ---
>   drivers/video/omap2/dss/dpi.c |    9 +++++----
>   drivers/video/omap2/dss/dsi.c |   18 ++++++++++++------
>   2 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
> index 976ac23..929e451 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -191,7 +191,7 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
>   		goto err_start_dev;
>   	}
>
> -	if (cpu_is_omap34xx()) {
> +	if (cpu_is_omap34xx()&&  !cpu_is_omap3505()&&  !cpu_is_omap3517()) {
>   		r = regulator_enable(dpi.vdds_dsi_reg);
>   		if (r)
>   			goto err_reg_enable;
> @@ -238,7 +238,7 @@ err_get_dsi:
>   err_get_dispc:
>   	dss_runtime_put();
>   err_get_dss:
> -	if (cpu_is_omap34xx())
> +	if (cpu_is_omap34xx()&&  !cpu_is_omap3505()&&  !cpu_is_omap3517())
>   		regulator_disable(dpi.vdds_dsi_reg);
>   err_reg_enable:
>   	omap_dss_stop_device(dssdev);
> @@ -260,7 +260,7 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
>   	dispc_runtime_put();
>   	dss_runtime_put();
>
> -	if (cpu_is_omap34xx())
> +	if (cpu_is_omap34xx()&&  !cpu_is_omap3505()&&  !cpu_is_omap3517())
>   		regulator_disable(dpi.vdds_dsi_reg);
>
>   	omap_dss_stop_device(dssdev);
> @@ -348,7 +348,8 @@ int dpi_init_display(struct omap_dss_device *dssdev)
>   {
>   	DSSDBG("init_display\n");
>
> -	if (cpu_is_omap34xx()&&  dpi.vdds_dsi_reg == NULL) {
> +	if (cpu_is_omap34xx()&&  (dpi.vdds_dsi_reg == NULL)&&
> +			!cpu_is_omap3505()&&  !cpu_is_omap3517()) {
>   		struct regulator *vdds_dsi;
>
>   		vdds_dsi = dss_get_vdds_dsi();
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index 5abf8e7..7f38ab6 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -1610,7 +1610,8 @@ int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
>
>   	DSSDBG("PLL init\n");
>
> -	if (dsi->vdds_dsi_reg == NULL) {
> +	if ((dsi->vdds_dsi_reg == NULL)&&
> +			!cpu_is_omap3517()&&  !cpu_is_omap3505()) {
>   		struct regulator *vdds_dsi;
>
>   		vdds_dsi = regulator_get(&dsi->pdev->dev, "vdds_dsi");
> @@ -1629,7 +1630,8 @@ int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
>   	 */
>   	dsi_enable_scp_clk(dsidev);
>
> -	if (!dsi->vdds_dsi_enabled) {
> +	if (!dsi->vdds_dsi_enabled&&
> +			!cpu_is_omap3517()&&  !cpu_is_omap3505()) {
>   		r = regulator_enable(dsi->vdds_dsi_reg);
>   		if (r)
>   			goto err0;
> @@ -1668,7 +1670,8 @@ int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
>
>   	return 0;
>   err1:
> -	if (dsi->vdds_dsi_enabled) {
> +	if (dsi->vdds_dsi_enabled&&
> +			!cpu_is_omap3517()&&  !cpu_is_omap3505()) {
>   		regulator_disable(dsi->vdds_dsi_reg);
>   		dsi->vdds_dsi_enabled = false;
>   	}
> @@ -1684,7 +1687,8 @@ void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes)
>
>   	dsi->pll_locked = 0;
>   	dsi_pll_power(dsidev, DSI_PLL_POWER_OFF);
> -	if (disconnect_lanes) {
> +	if (disconnect_lanes&&
> +			!cpu_is_omap3517()&&  !cpu_is_omap3505()) {
>   		WARN_ON(!dsi->vdds_dsi_enabled);
>   		regulator_disable(dsi->vdds_dsi_reg);
>   		dsi->vdds_dsi_enabled = false;
> @@ -4530,7 +4534,8 @@ int dsi_init_display(struct omap_dss_device *dssdev)
>   			OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
>   	}
>
> -	if (dsi->vdds_dsi_reg == NULL) {
> +	if ((dsi->vdds_dsi_reg == NULL)&&
> +			!cpu_is_omap3517()&&  !cpu_is_omap3505()) {
>   		struct regulator *vdds_dsi;
>
>   		vdds_dsi = regulator_get(&dsi->pdev->dev, "vdds_dsi");
> @@ -4799,7 +4804,8 @@ static int omap_dsihw_remove(struct platform_device *dsidev)
>
>   	dsi_put_clocks(dsidev);
>
> -	if (dsi->vdds_dsi_reg != NULL) {
> +	if ((dsi->vdds_dsi_reg != NULL)&&
> +			!cpu_is_omap3517()&&  !cpu_is_omap3505()) {
>   		if (dsi->vdds_dsi_enabled) {
>   			regulator_disable(dsi->vdds_dsi_reg);
>   			dsi->vdds_dsi_enabled = false;

