From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3] OMAP: DSS2: Support for UMSH-8173MD TFT panel
Date: Fri, 23 Dec 2011 00:03:28 +0100
Message-ID: <4EF3B740.6000306@gmail.com>
References: <1324370436.2042.4.camel@deskari> <1324374872-5132-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47799 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab1LVXDc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Dec 2011 18:03:32 -0500
Received: by eekc4 with SMTP id c4so8863467eek.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 15:03:31 -0800 (PST)
In-Reply-To: <1324374872-5132-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On 12/20/2011 10:54 AM, Daniel Mack wrote:
> This patch adds support for Microtip Technologies' UMSH-8173MD 800x480
> RGB TFT panel. Tested with an OMAP3 board.

Does this version appear more suitable?


Thanks,
Daniel


> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> ---
>  drivers/video/omap2/displays/panel-generic-dpi.c |   25 ++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
> index 519c47d..cbcf164 100644
> --- a/drivers/video/omap2/displays/panel-generic-dpi.c
> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
> @@ -297,6 +297,31 @@ static struct panel_config generic_dpi_panels[] = {
>  
>  		.name			= "apollon",
>  	},
> +
> +	/* Microtips Technologies - UMSH-8173MD */
> +	{
> +		{
> +			.x_res		= 800,
> +			.y_res		= 480,
> +
> +			.pixel_clock	= 34560,
> +
> +			.hsw		= 13,
> +			.hfp		= 101,
> +			.hbp		= 101,
> +
> +			.vsw		= 23,
> +			.vfp		= 1,
> +			.vbp		= 1,
> +		},
> +		.acbi			= 0x0,
> +		.acb			= 0x0,
> +		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> +					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
> +		.power_on_delay		= 0,
> +		.power_off_delay	= 0,
> +		.name			= "UMSH-8173MD",
> +	},
>  };
>  
>  struct panel_drv_data {

