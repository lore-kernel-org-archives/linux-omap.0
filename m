From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] [ARM] video/omap2/tdo35s: fix visual artefacts
Date: Wed, 21 Jul 2010 17:36:11 +0300
Message-ID: <4C4705DB.4000402@compulab.co.il>
References: <1278931370-19912-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:34657 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758320Ab0GUOgT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Jul 2010 10:36:19 -0400
In-Reply-To: <1278931370-19912-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

ping!
> TDO35S samples the data on the falling adge of the pixel clock,
> therefore the data strobe should be on the raising edge.
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
>  .../video/omap2/displays/panel-toppoly-tdo35s.c    |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/omap2/displays/panel-toppoly-tdo35s.c b/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
> index fa434ca..e320e67 100644
> --- a/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
> +++ b/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
> @@ -73,8 +73,12 @@ static void toppoly_tdo_panel_power_off(struct omap_dss_device *dssdev)
>  
>  static int toppoly_tdo_panel_probe(struct omap_dss_device *dssdev)
>  {
> -	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> -		OMAP_DSS_LCD_IHS;
> +	dssdev->panel.config = OMAP_DSS_LCD_TFT |
> +			       OMAP_DSS_LCD_IVS |
> +			       OMAP_DSS_LCD_IHS |
> +			       OMAP_DSS_LCD_IPC |
> +			       OMAP_DSS_LCD_ONOFF;
> +
>  	dssdev->panel.timings = toppoly_tdo_panel_timings;
>  
>  	return 0;
>   

-- 
Regards,
Igor.

