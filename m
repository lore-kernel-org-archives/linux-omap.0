From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 1/8] OMAPDSS: HDMI: Move GPIO handling to HDMI driver
Date: Fri, 24 Aug 2012 11:30:57 +0530
Message-ID: <50371899.6030706@ti.com>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com> <1345729514-2441-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52574 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753781Ab2HXGCb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Aug 2012 02:02:31 -0400
In-Reply-To: <1345729514-2441-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Thursday 23 August 2012 07:15 PM, Tomi Valkeinen wrote:
> We currently manage HDMI GPIOs in the board files via
> platform_enable/disable calls. This won't work with device tree, and in
> any case the correct place to manage the GPIOs is in the HDMI driver.
>
> This patch moves the handling of the GPIOs to the HDMI driver. The GPIO
> handling is moved to the common hdmi.c file, and this probably needs to
> be revisited when adding OMAP5 HDMI support to see if the GPIO handling
> needs to be moved to IP specific files.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>   arch/arm/mach-omap2/board-4430sdp.c    |   27 +-----------
>   arch/arm/mach-omap2/board-omap4panda.c |   27 +-----------
>   drivers/video/omap2/dss/hdmi.c         |   75 +++++++++++++++++++++++---------
>   include/video/omapdss.h                |    2 +
>   4 files changed, 61 insertions(+), 70 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 8e17284..852e05c 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -601,29 +601,6 @@ static void __init omap_sfh7741prox_init(void)
>   			__func__, OMAP4_SFH7741_ENABLE_GPIO, error);
>   }
>
> -static struct gpio sdp4430_hdmi_gpios[] = {
> -	{ HDMI_GPIO_CT_CP_HPD, GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ct_cp_hpd" },
> -	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH,	"hdmi_gpio_ls_oe" },
> -	{ HDMI_GPIO_HPD, GPIOF_DIR_IN, "hdmi_gpio_hpd" },
> -};
> -
> -static int sdp4430_panel_enable_hdmi(struct omap_dss_device *dssdev)
> -{
> -	int status;
> -
> -	status = gpio_request_array(sdp4430_hdmi_gpios,
> -				    ARRAY_SIZE(sdp4430_hdmi_gpios));
> -	if (status)
> -		pr_err("%s: Cannot request HDMI GPIOs\n", __func__);
> -
> -	return status;
> -}
> -
> -static void sdp4430_panel_disable_hdmi(struct omap_dss_device *dssdev)
> -{
> -	gpio_free_array(sdp4430_hdmi_gpios, ARRAY_SIZE(sdp4430_hdmi_gpios));
> -}
> -
>   static struct nokia_dsi_panel_data dsi1_panel = {
>   		.name		= "taal",
>   		.reset_gpio	= 102,
> @@ -718,6 +695,8 @@ static struct omap_dss_device sdp4430_lcd2_device = {
>   };
>
>   static struct omap_dss_hdmi_data sdp4430_hdmi_data = {
> +	.ct_cp_hpd_gpio = HDMI_GPIO_CT_CP_HPD,
> +	.ls_oe_gpio = HDMI_GPIO_LS_OE,
>   	.hpd_gpio = HDMI_GPIO_HPD,
>   };
>
> @@ -725,8 +704,6 @@ static struct omap_dss_device sdp4430_hdmi_device = {
>   	.name = "hdmi",
>   	.driver_name = "hdmi_panel",
>   	.type = OMAP_DISPLAY_TYPE_HDMI,
> -	.platform_enable = sdp4430_panel_enable_hdmi,
> -	.platform_disable = sdp4430_panel_disable_hdmi,
>   	.channel = OMAP_DSS_CHANNEL_DIGIT,
>   	.data = &sdp4430_hdmi_data,
>   };
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index 982fb26..5415faa 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -405,30 +405,9 @@ static struct omap_dss_device omap4_panda_dvi_device = {
>   	.channel		= OMAP_DSS_CHANNEL_LCD2,
>   };
>
> -static struct gpio panda_hdmi_gpios[] = {
> -	{ HDMI_GPIO_CT_CP_HPD, GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ct_cp_hpd" },
> -	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ls_oe" },
> -	{ HDMI_GPIO_HPD, GPIOF_DIR_IN, "hdmi_gpio_hpd" },
> -};
> -
> -static int omap4_panda_panel_enable_hdmi(struct omap_dss_device *dssdev)
> -{
> -	int status;
> -
> -	status = gpio_request_array(panda_hdmi_gpios,
> -				    ARRAY_SIZE(panda_hdmi_gpios));
> -	if (status)
> -		pr_err("Cannot request HDMI GPIOs\n");
> -
> -	return status;
> -}
> -
> -static void omap4_panda_panel_disable_hdmi(struct omap_dss_device *dssdev)
> -{
> -	gpio_free_array(panda_hdmi_gpios, ARRAY_SIZE(panda_hdmi_gpios));
> -}
> -
>   static struct omap_dss_hdmi_data omap4_panda_hdmi_data = {
> +	.ct_cp_hpd_gpio = HDMI_GPIO_CT_CP_HPD,
> +	.ls_oe_gpio = HDMI_GPIO_LS_OE,
>   	.hpd_gpio = HDMI_GPIO_HPD,
>   };
>
> @@ -436,8 +415,6 @@ static struct omap_dss_device  omap4_panda_hdmi_device = {
>   	.name = "hdmi",
>   	.driver_name = "hdmi_panel",
>   	.type = OMAP_DISPLAY_TYPE_HDMI,
> -	.platform_enable = omap4_panda_panel_enable_hdmi,
> -	.platform_disable = omap4_panda_panel_disable_hdmi,
>   	.channel = OMAP_DSS_CHANNEL_DIGIT,
>   	.data = &omap4_panda_hdmi_data,
>   };
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
> index 0cdf246..4fbe271 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -32,6 +32,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/clk.h>
> +#include <linux/gpio.h>
>   #include <video/omapdss.h>
>
>   #include "ti_hdmi.h"
> @@ -61,6 +62,10 @@ static struct {
>   	struct hdmi_ip_data ip_data;
>
>   	struct clk *sys_clk;
> +
> +	int ct_cp_hpd_gpio;
> +	int ls_oe_gpio;
> +	int hpd_gpio;
>   } hdmi;
>
>   /*
> @@ -314,12 +319,34 @@ static void hdmi_runtime_put(void)
>
>   static int __init hdmi_init_display(struct omap_dss_device *dssdev)
>   {
> +	int r;
> +
> +	struct gpio gpios[] = {
> +		{ hdmi.ct_cp_hpd_gpio, GPIOF_OUT_INIT_LOW, "hdmi_ct_cp_hpd" },
> +		{ hdmi.ls_oe_gpio, GPIOF_OUT_INIT_LOW, "hdmi_ls_oe" },
> +		{ hdmi.hpd_gpio, GPIOF_DIR_IN, "hdmi_hpd" },
> +	};
> +
>   	DSSDBG("init_display\n");
>
>   	dss_init_hdmi_ip_ops(&hdmi.ip_data);
> +
> +	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
> +	if (r)
> +		return r;
> +

Is there a reason to request these gpios in hdmi_init_display()? Why 
can't these be requested simply in the probe of the hdmi platform 
device. These gpios are sort of specific to the hdmi output on OMAP, 
aren't they?

<snip>

Archit

