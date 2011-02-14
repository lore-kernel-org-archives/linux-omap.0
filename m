From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v10 18/18] OMAP2,3: DSS2: Get DSS IRQ from platform
 device
Date: Mon, 14 Feb 2011 16:09:33 +0200
Message-ID: <1297692573.2951.16.camel@deskari>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com>
	 <1295850125-21405-19-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48934 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754581Ab1BNOJm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 09:09:42 -0500
In-Reply-To: <1295850125-21405-19-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sumit Semwal <sumit.semwal@ti.com>, archit@ti.com
Cc: paul@pwsan.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Senthilvadivu Guruswamy <svadivu@ti.com>

Hi,

On Mon, 2011-01-24 at 11:52 +0530, ext Sumit Semwal wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> DSS IRQ number can be obtained from platform_get_irq().  This API in turn
> picks the right IRQ number belonging to HW IP from the hwmod database.
> So hardcoding of IRQ number could be removed.
> 
> Reviewed-by: Paul Walmsley <paul@pwsan.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Tested-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> ---
>  drivers/video/omap2/dss/dss.c |   21 ++++++++++++++-------
>  1 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> index 4d7a816..f9390b4 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -563,7 +563,7 @@ void dss_set_dac_pwrdn_bgz(bool enable)
>  
>  static int dss_init(bool skip_init)
>  {
> -	int r;
> +	int r, dss_irq;
>  	u32 rev;
>  	struct resource *dss_mem;
>  
> @@ -609,11 +609,18 @@ static int dss_init(bool skip_init)
>  	REG_FLD_MOD(DSS_CONTROL, 0, 2, 2);	/* venc clock mode = normal */
>  #endif
>  
> -	r = request_irq(INT_24XX_DSS_IRQ,
> -			cpu_is_omap24xx()
> -			? dss_irq_handler_omap2
> -			: dss_irq_handler_omap3,
> -			0, "OMAP DSS", NULL);
> +	dss_irq = platform_get_irq(dss.pdev, 0);
> +	if (dss_irq < 0) {
> +		DSSERR("omap2 dss: platform_get_irq failed\n");
> +		r = -ENODEV;
> +		goto fail1;
> +	}
> +
> +	r = request_irq(dss_irq,
> +		cpu_is_omap24xx()
> +		? dss_irq_handler_omap2
> +		: dss_irq_handler_omap3,
> +		0, "OMAP DSS", NULL);
>  
>  	if (r < 0) {
>  		DSSERR("omap2 dss: request_irq failed\n");
> @@ -641,7 +648,7 @@ static int dss_init(bool skip_init)
>  	return 0;
>  
>  fail2:
> -	free_irq(INT_24XX_DSS_IRQ, NULL);
> +	free_irq(dss_irq, NULL);

You change this free_irq, as you should, but you missed another a few
lines later.

Archit fixes it in his "OMAP: DSS2: Common IRQ handler for all OMAPs"
patch silently, but I think it should be fixed here already, as the
patches haven't been pulled to anywhere yet.

Perhaps you could use the same method as Archit used, create a new field
"irq" in the dss struct which can be used in the dss_exit's free_irq
call.

 Tomi


