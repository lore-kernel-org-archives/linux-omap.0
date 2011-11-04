From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 09/11] omap4: twl: added pmic startup / shutdown times
Date: Fri, 04 Nov 2011 14:21:01 -0700
Message-ID: <877h3f7feq.fsf@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
	<1317835031-8201-10-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:37663 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752747Ab1KDVVF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 17:21:05 -0400
Received: by mail-iy0-f179.google.com with SMTP id i7so2680728iaf.38
        for <linux-omap@vger.kernel.org>; Fri, 04 Nov 2011 14:21:03 -0700 (PDT)
In-Reply-To: <1317835031-8201-10-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Wed, 5 Oct 2011 20:17:09 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Missing descriptive changelog.

> ---
>  arch/arm/mach-omap2/omap_twl.c |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
> index 62ed050..c095cf2 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -55,6 +55,13 @@ static bool __initdata twl_sr_enable_autoinit;
>  #define REG_SMPS_OFFSET         0xE0
>  #define SMARTREFLEX_ENABLE     BIT(3)
>  
> +struct twl_lp_description {
> +	u32 osc_shut_time;
> +	u32 osc_start_time;

These are unused.

Also, how are oscillator setup/shutdown times related to the PMIC?

> +	u32 pmic_shut_time;
> +	u32 pmic_start_time;
> +};
> +
>  static unsigned long twl4030_vsel_to_uv(const u8 vsel)
>  {
>  	return (((vsel * 125) + 6000)) * 100;
> @@ -220,9 +227,15 @@ static struct omap_voltdm_pmic omap4_core_pmic = {
>  	.uv_to_vsel		= twl6030_uv_to_vsel,
>  };
>  
> +static struct twl_lp_description omap4_pmic_lp_desc = {
> +	.pmic_shut_time		= 500,
> +	.pmic_start_time	= 500,
> +};
> +
>  int __init omap4_twl_init(void)
>  {
>  	struct voltagedomain *voltdm;
> +	struct twl_lp_description *desc;
>  
>  	if (!cpu_is_omap44xx())
>  		return -ENODEV;
> @@ -236,6 +249,10 @@ int __init omap4_twl_init(void)
>  	voltdm = voltdm_lookup("core");
>  	omap_voltage_register_pmic(voltdm, &omap4_core_pmic);
>  
> +	desc = &omap4_pmic_lp_desc;
> +
> +	omap_pm_set_pmic_lp_time(desc->pmic_start_time, desc->pmic_shut_time);
> +
>  	return 0;
>  }

See comment on 5/11.  IMO, the PMIC timings should just be going into
omap_voltdm_pmic along with slew_rate, step_size etc.  I don't follow
why we need a different mechanism to customize these timings that is
different from the rest of the PMIC settings.

Kevin
