From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 05/32] OMAPDSS: fix dss_get_ctx_loss_count for DT
Date: Thu, 30 May 2013 13:09:45 +0200
Message-ID: <20130530110945.GI19468@game.jcrosoft.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
 <1369906493-27538-6-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:51348 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752309Ab3E3MJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 08:09:02 -0400
Received: from mail624.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 6E02EFFADB3
	for <linux-omap@vger.kernel.org>; Thu, 30 May 2013 13:13:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1369906493-27538-6-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

On 12:34 Thu 30 May     , Tomi Valkeinen wrote:
> When using DT, dss device does not have platform data. However,
> dss_get_ctx_loss_count() uses dss device's platform data to find the
> get_ctx_loss_count function pointer.
> 
> To fix this, dss_get_ctx_loss_count() needs to be changed to get the
> platform data from the omapdss device, which is a "virtual" device and
> always has platform data.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap2/dss/dss.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> index 94f66f9..bd01608 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -157,7 +157,8 @@ static void dss_restore_context(void)
>  
>  int dss_get_ctx_loss_count(void)
>  {
> -	struct omap_dss_board_info *board_data = dss.pdev->dev.platform_data;
> +	struct platform_device *core_pdev = dss_get_core_pdev();
> +	struct omap_dss_board_info *board_data = core_pdev->dev.platform_data;

	how about store the pdata in the drivers internal struct and if !dt
	you ust do this

	dss_dev->pdata = *pdev->dev.platform_data;

	to copy it and we do not alloc it for dt

Best Regards,
J.
>  	int cnt;
>  
>  	if (!board_data->get_context_loss_count)
> -- 
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
