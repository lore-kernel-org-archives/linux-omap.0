From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Remove legacy DSS initialization for
 omap4
Date: Fri, 2 Aug 2013 07:56:49 -0500
Message-ID: <51FBAC91.8040401@ti.com>
References: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com> <1374570405-8301-3-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38966 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751590Ab3HBM5L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 08:57:11 -0400
In-Reply-To: <1374570405-8301-3-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07/23/2013 04:06 AM, Tomi Valkeinen wrote:
> This is no longer needed as omap4 is now booted using device tree.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   arch/arm/mach-omap2/dss-common.c | 47 ----------------------------------------
>   arch/arm/mach-omap2/dss-common.h |  2 --
>   2 files changed, 49 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
> index 043e570..00c0492 100644
> --- a/arch/arm/mach-omap2/dss-common.c
> +++ b/arch/arm/mach-omap2/dss-common.c
> @@ -80,24 +80,6 @@ static struct omap_dss_board_info omap4_panda_dss_data = {
>   	.default_device	= &omap4_panda_dvi_device,
>   };
>
> -void __init omap4_panda_display_init(void)
> -{
> -	omap_display_init(&omap4_panda_dss_data);
> -
> -	/*
> -	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
> -	 * later have external pull up on the HDMI I2C lines
> -	 */
> -	if (cpu_is_omap446x() || omap_rev() > OMAP4430_REV_ES2_2)
> -		omap_hdmi_init(OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP);
> -	else
> -		omap_hdmi_init(0);
> -
> -	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
> -	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
> -	omap_mux_init_gpio(HDMI_GPIO_HPD, OMAP_PIN_INPUT_PULLDOWN);
> -}
> -
>   void __init omap4_panda_display_init_of(void)
>   {
>   	omap_display_init(&omap4_panda_dss_data);
> @@ -204,35 +186,6 @@ static struct omap_dss_board_info sdp4430_dss_data = {
>    * used by picodlp on the 4430sdp platform. Keep this gpio disabled as LCD2 is
>    * selected by default
>    */
> -void __init omap_4430sdp_display_init(void)
> -{
> -	int r;
> -
> -	r = gpio_request_one(DISPLAY_SEL_GPIO, GPIOF_OUT_INIT_HIGH,
> -			"display_sel");
> -	if (r)
> -		pr_err("%s: Could not get display_sel GPIO\n", __func__);
> -
> -	r = gpio_request_one(DLP_POWER_ON_GPIO, GPIOF_OUT_INIT_LOW,
> -		"DLP POWER ON");
> -	if (r)
> -		pr_err("%s: Could not get DLP POWER ON GPIO\n", __func__);
> -
> -	omap_display_init(&sdp4430_dss_data);
> -	/*
> -	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
> -	 * later have external pull up on the HDMI I2C lines
> -	 */
> -	if (cpu_is_omap446x() || omap_rev() > OMAP4430_REV_ES2_2)
> -		omap_hdmi_init(OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP);
> -	else
> -		omap_hdmi_init(0);
> -
> -	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
> -	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
> -	omap_mux_init_gpio(HDMI_GPIO_HPD, OMAP_PIN_INPUT_PULLDOWN);
> -}
> -
>   void __init omap_4430sdp_display_init_of(void)
>   {
>   	int r;
> diff --git a/arch/arm/mach-omap2/dss-common.h b/arch/arm/mach-omap2/dss-common.h
> index 915f6ff..c28fe3c 100644
> --- a/arch/arm/mach-omap2/dss-common.h
> +++ b/arch/arm/mach-omap2/dss-common.h
> @@ -6,9 +6,7 @@
>    * This file will be removed when DSS supports DT.
>    */
>
> -void __init omap4_panda_display_init(void);
>   void __init omap4_panda_display_init_of(void);
> -void __init omap_4430sdp_display_init(void);
>   void __init omap_4430sdp_display_init_of(void);
>
>   #endif
>

Am I missing some series which introduces dts entries for the pinctrl 
and gpios for omap4 support?


-- 
Regards,
Nishanth Menon
