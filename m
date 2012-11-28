From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH] OMAPDSS: Use only "omapdss_dss" platform device to get
 context lost count
Date: Wed, 28 Nov 2012 17:19:34 +0530
Message-ID: <50B5FA4E.1050005@ti.com>
References: <1354102299-4928-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57682 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754033Ab2K1LuH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 06:50:07 -0500
In-Reply-To: <1354102299-4928-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vgerk.kernel.org, t-kristo@ti.com, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

On Wednesday 28 November 2012 05:01 PM, Archit Taneja wrote:
> When enabling a hwmod, omap_hwmod refers to the register mentioned in the
> hwmod struct's member 'prcm.omap4.context_offs' to see whether context was
> lost or not. It increments the context lost count for the hwmod and then clears
> the register.
>
> All the DSS hwmods have the same register(RM_DSS_DSS_CONTEXT) as context_offs.
> When DSS is enabled, the first hwmod to be enabled is the "dss_core" hwmod since
> it's corresponding platform device is the parent platform device("omapdss_dss").
> The dss_core hwmod updates it's context lost count correctly and clears the
> register. When the hwmods corresponding to the children platform devices are
> enabled, they see that the register is clear, and don't increment their context
> lost count. Therefore, all the children platform devices never report a loss in
> context.
>
> The DISPC driver currently gets the context lost count for DSS power domain from
> it's corresponding platform device instance("omapdss_dispc"). The DISPC platform
> device is one of the child devices, and it's corresponding hwmod("dss_dispc")
> doesn't report the context lost count correctly.
>
> Modify dss_get_ctx_loss_count() such that it always takes the "omapdss_dss"
> platform device as it's input, move the function to dss.c so that it has access
> to that platform device.

I tested this on 4430sdp, panda and beagle. I forgot to mention that in 
the commit message. On beagle, I don't see the context lost count 
increase, but DVI works fine, it could be some problem with DSS PM on omap3.

Archit

>
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>   drivers/video/omap2/dss/core.c  |   15 ---------------
>   drivers/video/omap2/dss/dispc.c |    4 ++--
>   drivers/video/omap2/dss/dss.c   |   15 +++++++++++++++
>   drivers/video/omap2/dss/dss.h   |    3 ++-
>   4 files changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
> index d94ef9e..ceb912b 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -93,21 +93,6 @@ struct regulator *dss_get_vdds_sdi(void)
>   	return reg;
>   }
>
> -int dss_get_ctx_loss_count(struct device *dev)
> -{
> -	struct omap_dss_board_info *board_data = core.pdev->dev.platform_data;
> -	int cnt;
> -
> -	if (!board_data->get_context_loss_count)
> -		return -ENOENT;
> -
> -	cnt = board_data->get_context_loss_count(dev);
> -
> -	WARN_ONCE(cnt < 0, "get_context_loss_count failed: %d\n", cnt);
> -
> -	return cnt;
> -}
> -
>   int dss_dsi_enable_pads(int dsi_id, unsigned lane_mask)
>   {
>   	struct omap_dss_board_info *board_data = core.pdev->dev.platform_data;
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index a5ab354..67d4497 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -374,7 +374,7 @@ static void dispc_save_context(void)
>   	if (dss_has_feature(FEAT_CORE_CLK_DIV))
>   		SR(DIVISOR);
>
> -	dispc.ctx_loss_cnt = dss_get_ctx_loss_count(&dispc.pdev->dev);
> +	dispc.ctx_loss_cnt = dss_get_ctx_loss_count();
>   	dispc.ctx_valid = true;
>
>   	DSSDBG("context saved, ctx_loss_count %d\n", dispc.ctx_loss_cnt);
> @@ -389,7 +389,7 @@ static void dispc_restore_context(void)
>   	if (!dispc.ctx_valid)
>   		return;
>
> -	ctx = dss_get_ctx_loss_count(&dispc.pdev->dev);
> +	ctx = dss_get_ctx_loss_count();
>
>   	if (ctx >= 0 && ctx == dispc.ctx_loss_cnt)
>   		return;
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> index 602102c..d2cbee2 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -151,6 +151,21 @@ static void dss_restore_context(void)
>   #undef SR
>   #undef RR
>
> +int dss_get_ctx_loss_count(void)
> +{
> +	struct omap_dss_board_info *board_data = dss.pdev->dev.platform_data;
> +	int cnt;
> +
> +	if (!board_data->get_context_loss_count)
> +		return -ENOENT;
> +
> +	cnt = board_data->get_context_loss_count(&dss.pdev->dev);
> +
> +	WARN_ONCE(cnt < 0, "get_context_loss_count failed: %d\n", cnt);
> +
> +	return cnt;
> +}
> +
>   void dss_sdi_init(int datapairs)
>   {
>   	u32 l;
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
> index 6728892..5577660 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -190,7 +190,6 @@ const char *dss_get_default_display_name(void);
>   struct bus_type *dss_get_bus(void);
>   struct regulator *dss_get_vdds_dsi(void);
>   struct regulator *dss_get_vdds_sdi(void);
> -int dss_get_ctx_loss_count(struct device *dev);
>   int dss_dsi_enable_pads(int dsi_id, unsigned lane_mask);
>   void dss_dsi_disable_pads(int dsi_id, unsigned lane_mask);
>   int dss_set_min_bus_tput(struct device *dev, unsigned long tput);
> @@ -309,6 +308,8 @@ void dss_dump_clocks(struct seq_file *s);
>   void dss_debug_dump_clocks(struct seq_file *s);
>   #endif
>
> +int dss_get_ctx_loss_count(void);
> +
>   void dss_sdi_init(int datapairs);
>   int dss_sdi_enable(void);
>   void dss_sdi_disable(void);
>

