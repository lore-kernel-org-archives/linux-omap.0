From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP3: cm-t35: fix mux mode for DSS pins
Date: Sun, 06 Nov 2011 11:25:39 +0200
Message-ID: <4EB65293.2050102@compulab.co.il>
References: <1319042779-3449-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:46014
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750942Ab1KFJZs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Nov 2011 04:25:48 -0500
In-Reply-To: <1319042779-3449-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

This one is stand alone and can be applied to fixes.
I will re spin the rest in a couple of hours.

Thanks

On 10/19/11 18:46, Igor Grinberg wrote:
> OMAP pin mux configuration API has been used incorrectly resulting
> in wrong mux mode set for several DSS pins.
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
>  arch/arm/mach-omap2/board-cm-t35.c |   32 ++++++++++++++++++--------------
>  1 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index 3201c9e..023b768 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -600,24 +600,28 @@ static void __init cm_t3x_common_dss_mux_init(int mux_mode)
>  
>  static void __init cm_t35_init_mux(void)
>  {
> -	omap_mux_init_signal("gpio_70", OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT);
> -	omap_mux_init_signal("gpio_71", OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT);
> -	omap_mux_init_signal("gpio_72", OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT);
> -	omap_mux_init_signal("gpio_73", OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT);
> -	omap_mux_init_signal("gpio_74", OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT);
> -	omap_mux_init_signal("gpio_75", OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT);
> -	cm_t3x_common_dss_mux_init(OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT);
> +	int mux_mode = OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT;
> +
> +	omap_mux_init_signal("dss_data0.dss_data0", mux_mode);
> +	omap_mux_init_signal("dss_data1.dss_data1", mux_mode);
> +	omap_mux_init_signal("dss_data2.dss_data2", mux_mode);
> +	omap_mux_init_signal("dss_data3.dss_data3", mux_mode);
> +	omap_mux_init_signal("dss_data4.dss_data4", mux_mode);
> +	omap_mux_init_signal("dss_data5.dss_data5", mux_mode);
> +	cm_t3x_common_dss_mux_init(mux_mode);
>  }
>  
>  static void __init cm_t3730_init_mux(void)
>  {
> -	omap_mux_init_signal("sys_boot0", OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT);
> -	omap_mux_init_signal("sys_boot1", OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT);
> -	omap_mux_init_signal("sys_boot3", OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT);
> -	omap_mux_init_signal("sys_boot4", OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT);
> -	omap_mux_init_signal("sys_boot5", OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT);
> -	omap_mux_init_signal("sys_boot6", OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT);
> -	cm_t3x_common_dss_mux_init(OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT);
> +	int mux_mode = OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT;
> +
> +	omap_mux_init_signal("sys_boot0", mux_mode);
> +	omap_mux_init_signal("sys_boot1", mux_mode);
> +	omap_mux_init_signal("sys_boot3", mux_mode);
> +	omap_mux_init_signal("sys_boot4", mux_mode);
> +	omap_mux_init_signal("sys_boot5", mux_mode);
> +	omap_mux_init_signal("sys_boot6", mux_mode);
> +	cm_t3x_common_dss_mux_init(mux_mode);
>  }
>  #else
>  static inline void cm_t35_init_mux(void) {}

-- 
Regards,
Igor.
