From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+ Add Primview dispalys to panel-generic
Date: Thu, 04 Aug 2011 15:18:59 +0300
Message-ID: <1312460339.2143.23.camel@deskari>
References: <1310122034-6561-1-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:37761 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751658Ab1HEGvt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 02:51:49 -0400
In-Reply-To: <1310122034-6561-1-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org

Hi,

On Fri, 2011-07-08 at 12:47 +0200, Jan Weitzel wrote:
> Add displays to panel-generic-dpi.c
> Prime View PD035VL1 (640 x 480)
> Prime View PD050VL1 (640 x 480)
> Prime View PD104SLF (800 x 600)
> Prime View PM070WL4 (800 x 480)

Did you copy the acb and power_on/off_delay values from the sharp panel?
acbi and acb are not needed at all, and you should check if
power_on/off_delay are needed and if they are, what they should be.

Also, the first two panels look identical. While there's nothing wrong
with that, I wonder if could be a more generic "family" name for the
panels, and there would be need to define the timings only once.

 Tomi

> Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
> ---
>  drivers/video/omap2/displays/panel-generic-dpi.c |  100 ++++++++++++++++++++++
>  1 files changed, 100 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
> index 9c90f75..87d9ba1 100644
> --- a/drivers/video/omap2/displays/panel-generic-dpi.c
> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
> @@ -232,6 +232,106 @@ static struct panel_config generic_dpi_panels[] = {
>  		.power_off_delay	= 0,
>  		.name			= "powertip_ph480272t",
>  	},
> +
> +	/* Prime-View PD035VL1 */
> +	{
> +		{
> +			.x_res		= 640,
> +			.y_res		= 480,
> +
> +			.pixel_clock	= 25000,
> +
> +			.hsw		= 96,
> +			.hfp		= 18,
> +			.hbp		= 46,
> +
> +			.vsw		= 2,
> +			.vfp		= 10,
> +			.vbp		= 33,
> +		},
> +		.acbi			= 0x0,
> +		.acb			= 0x28,
> +		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> +					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
> +		.power_on_delay		= 50,
> +		.power_off_delay	= 100,
> +		.name			= "pd035vl1",
> +	},
> +
> +	/* Prime-View PD050VL1 */
> +	{
> +		{
> +			.x_res		= 640,
> +			.y_res		= 480,
> +
> +			.pixel_clock	= 25000,
> +
> +			.hsw		= 96,
> +			.hfp		= 18,
> +			.hbp		= 46,
> +
> +			.vsw		= 2,
> +			.vfp		= 10,
> +			.vbp		= 33,
> +		},
> +		.acbi			= 0x0,
> +		.acb			= 0x28,
> +		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> +					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
> +		.power_on_delay		= 50,
> +		.power_off_delay	= 100,
> +		.name			= "pd050vl1",
> +	},
> +
> +	/* Prime-View PM070WL4 */
> +	{
> +		{
> +			.x_res		= 800,
> +			.y_res		= 480,
> +
> +			.pixel_clock	= 32000,
> +
> +			.hsw		= 128,
> +			.hfp		= 42,
> +			.hbp		= 86,
> +
> +			.vsw		= 2,
> +			.vfp		= 10,
> +			.vbp		= 33,
> +		},
> +		.acbi			= 0x0,
> +		.acb			= 0x28,
> +		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> +					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
> +		.power_on_delay		= 50,
> +		.power_off_delay	= 100,
> +		.name			= "pm070wl4",
> +	},
> +
> +	/* Prime-View PD104SLF */
> +	{
> +		{
> +			.x_res		= 800,
> +			.y_res		= 600,
> +
> +			.pixel_clock	= 40000,
> +
> +			.hsw		= 128,
> +			.hfp		= 42,
> +			.hbp		= 86,
> +
> +			.vsw		= 4,
> +			.vfp		= 1,
> +			.vbp		= 23,
> +		},
> +		.acbi			= 0x0,
> +		.acb			= 0x28,
> +		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> +					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
> +		.power_on_delay		= 50,
> +		.power_off_delay	= 100,
> +		.name			= "pd104slf",
> +	},
>  };
>  
>  struct panel_drv_data {


