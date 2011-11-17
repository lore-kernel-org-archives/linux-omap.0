From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH 2/4] omap_dss: add FocalTech ETM070003DH6 display support
Date: Thu, 17 Nov 2011 04:28:37 +0400
Message-ID: <4EC45535.9060708@emcraft.com>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com> <1320797568-11169-3-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:56788 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684Ab1KQA2d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Nov 2011 19:28:33 -0500
In-Reply-To: <1320797568-11169-3-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

Hi guys,

what about this patch? Can it be applied? It's pretty independent from
other ones.

Regards, Ilya.

On 09.11.2011 04:12, Ilya Yanok wrote:
> Add data for the FocalTech ETM070003DH6 display to the generic_dpi_panel
> display driver.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
>  drivers/video/omap2/displays/panel-generic-dpi.c |   24 ++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
> index 519c47d..42bfe47 100644
> --- a/drivers/video/omap2/displays/panel-generic-dpi.c
> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
> @@ -297,6 +297,30 @@ static struct panel_config generic_dpi_panels[] = {
>  
>  		.name			= "apollon",
>  	},
> +	/* FocalTech ETM070003DH6 */
> +	{
> +		{
> +			.x_res		= 800,
> +			.y_res		= 480,
> +
> +			.pixel_clock	= 28000,
> +
> +			.hsw		= 48,
> +			.hfp		= 40,
> +			.hbp		= 40,
> +
> +			.vsw		= 3,
> +			.vfp		= 13,
> +			.vbp		= 29,
> +		},
> +		.acbi			= 0x0,
> +		.acb			= 0x28,
> +		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> +					  OMAP_DSS_LCD_IHS,
> +		.power_on_delay		= 50,
> +		.power_off_delay	= 100,
> +		.name			= "focaltech_etm070003dh6",
> +	},
>  };
>  
>  struct panel_drv_data {

