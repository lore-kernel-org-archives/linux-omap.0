From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv2 08/12] ARM: OMAP4: hwmod data: add SL2IF hardreset line
Date: Thu, 14 Jun 2012 14:55:06 +0200
Message-ID: <4FD9DF2A.3010000@ti.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004614.20034.50895.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40056 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755531Ab2FNMzP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 08:55:15 -0400
In-Reply-To: <20120611004614.20034.50895.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

Hi Paul,

On 6/11/2012 2:46 AM, Paul Walmsley wrote:
> On boot, the sl2if module can't be enabled.  The following message is
> logged:
>
> omap_hwmod: sl2if: cannot be enabled for reset (3)
>
> This is probably because the SL2IF is still being held in hardreset.
> The SL2IF's hardreset line is shared with one of the IVAHD's hardreset
> lines; see for example Table 3-536 "RM_IVAHD_RSTCTRL" in the OMAP4430
> TRM Rev. AA (SWPU231AA).  To work around this, add the SL2IF's
> hardreset line to the hwmod data.  This is correct from a hardware
> perspective and also will prevent the hwmod from attempting to enable
> the SL2IF during reset.  The driver for this IP block will need to
> handle its integration until the appropriate way to handle the IVAHD
> integration can be elucidated.

I don't think we should allow that at hwmod level. This line is already 
handled by the IVAHD hwmod. We will then have some potential issue since 
nothing will prevent the concurrent access.
Moreover that IP is only used by the IVAHD and thus should be handled by 
the same driver. The SL2 being inside the IVA subsystem, it should be 
reset when the IVA will be reset and thus does not require an individual 
control.


I guess, we should just mark the dependency with some external power 
resource to avoid the fmwk to try to enable that automatically.

It is similar to DSS sub IPs and to some extend McPDM for my point of view.

Maybe we should rename HWMOD_EXT_OPT_MAIN_CLK with something more 
generic like HWMOD_EXT_POWER_DEP to highlight the dependency with an 
external resource. It can be a external clock or another module.

Regards,
Benoit


> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 7700d6d..037424f 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -2597,15 +2597,22 @@ static struct omap_hwmod_class omap44xx_sl2if_hwmod_class = {
>   	.name	= "sl2if",
>   };
>
> +static struct omap_hwmod_rst_info omap44xx_sl2if_resets[] = {
> +	{ .name = "logic", .rst_shift = 2 },
> +};
> +
>   /* sl2if */
>   static struct omap_hwmod omap44xx_sl2if_hwmod = {
>   	.name		= "sl2if",
>   	.class		= &omap44xx_sl2if_hwmod_class,
>   	.clkdm_name	= "ivahd_clkdm",
> +	.rst_lines	= omap44xx_sl2if_resets,
> +	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_sl2if_resets),
>   	.prcm = {
>   		.omap4 = {
>   			.clkctrl_offs = OMAP4_CM_IVAHD_SL2_CLKCTRL_OFFSET,
>   			.context_offs = OMAP4_RM_IVAHD_SL2_CONTEXT_OFFSET,
> +			.rstctrl_offs = OMAP4_RM_IVAHD_RSTCTRL_OFFSET,
>   			.modulemode   = MODULEMODE_HWCTRL,
>   		},
>   	},
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


