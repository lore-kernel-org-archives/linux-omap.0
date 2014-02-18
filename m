From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: use DISPC register to detect context loss
Date: Tue, 18 Feb 2014 17:09:19 +0530
Message-ID: <53034667.80603@ti.com>
References: <1392366572-31729-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53272 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809AbaBRLjn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Feb 2014 06:39:43 -0500
In-Reply-To: <1392366572-31729-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>

On Friday 14 February 2014 01:59 PM, Tomi Valkeinen wrote:
> Instead of relying on the OMAP specific
> omap_pm_get_dev_context_loss_count() to detect register context loss, we
> can achieve the same in a much simpler way by just observing the DISPC
> registers.
>
> We always set DISPC's load mode to LOAD_FRAME_ONLY, which is not the
> reset value. Thus we can just observe the load mode to see if we have
> lost register context.

Nice trick :p

Reviewed-by: Archit Taneja <archit@ti.com>

Archit

>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/dispc.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index bbeb8dd7f108..1659aa912d2b 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -100,8 +100,6 @@ static struct {
>   	struct platform_device *pdev;
>   	void __iomem    *base;
>
> -	int		ctx_loss_cnt;
> -
>   	int irq;
>
>   	unsigned long core_clk_rate;
> @@ -357,29 +355,20 @@ static void dispc_save_context(void)
>   	if (dss_has_feature(FEAT_CORE_CLK_DIV))
>   		SR(DIVISOR);
>
> -	dispc.ctx_loss_cnt = dss_get_ctx_loss_count();
>   	dispc.ctx_valid = true;
>
> -	DSSDBG("context saved, ctx_loss_count %d\n", dispc.ctx_loss_cnt);
> +	DSSDBG("context saved\n");
>   }
>
>   static void dispc_restore_context(void)
>   {
> -	int i, j, ctx;
> +	int i, j;
>
>   	DSSDBG("dispc_restore_context\n");
>
>   	if (!dispc.ctx_valid)
>   		return;
>
> -	ctx = dss_get_ctx_loss_count();
> -
> -	if (ctx >= 0 && ctx == dispc.ctx_loss_cnt)
> -		return;
> -
> -	DSSDBG("ctx_loss_count: saved %d, current %d\n",
> -			dispc.ctx_loss_cnt, ctx);
> -
>   	/*RR(IRQENABLE);*/
>   	/*RR(CONTROL);*/
>   	RR(CONFIG);
> @@ -3768,6 +3757,15 @@ static int dispc_runtime_suspend(struct device *dev)
>
>   static int dispc_runtime_resume(struct device *dev)
>   {
> +	/*
> +	 * The reset value for load mode is 0 (OMAP_DSS_LOAD_CLUT_AND_FRAME)
> +	 * but we always initialize it to 2 (OMAP_DSS_LOAD_FRAME_ONLY) in
> +	 * _omap_dispc_initial_config(). We can thus use it to detect if
> +	 * we have lost register context.
> +	 */
> +	if (REG_GET(DISPC_CONFIG, 2, 1) == OMAP_DSS_LOAD_FRAME_ONLY)
> +		return 0;
> +
>   	_omap_dispc_initial_config();
>
>   	dispc_restore_context();
>

