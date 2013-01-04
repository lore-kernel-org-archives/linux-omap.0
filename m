From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP4: clock data: Lock ABE DPLL on all revisions
Date: Fri, 4 Jan 2013 09:10:02 -0600
Message-ID: <50E6F0CA.60309@ti.com>
References: <1357294163-4317-1-git-send-email-peter.ujfalusi@ti.com> <1357294163-4317-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41961 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754889Ab3ADPKI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jan 2013 10:10:08 -0500
In-Reply-To: <1357294163-4317-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>


On 01/04/2013 04:09 AM, Peter Ujfalusi wrote:
> To avoid issues with audio caused by non locked ABE DPLL we should
> make sure it is locked in all OMAP4 revisions.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> asda d

Not sure what the above is ;-)

> ---
>  arch/arm/mach-omap2/cclock44xx_data.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
> index 5789a5e..a2cc046 100644
> --- a/arch/arm/mach-omap2/cclock44xx_data.c
> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
> @@ -2026,14 +2026,13 @@ int __init omap4xxx_clk_init(void)
>  	 * On OMAP4460 the ABE DPLL fails to turn on if in idle low-power
>  	 * state when turning the ABE clock domain. Workaround this by
>  	 * locking the ABE DPLL on boot.
> +	 * Lock the ABE DPLL in any case to avoid issues with audio.
>  	 */
> -	if (cpu_is_omap446x()) {
> -		rc = clk_set_parent(&abe_dpll_refclk_mux_ck, &sys_32k_ck);
> -		if (!rc)
> -			rc = clk_set_rate(&dpll_abe_ck, OMAP4_DPLL_ABE_DEFFREQ);
> -		if (rc)
> -			pr_err("%s: failed to configure ABE DPLL!\n", __func__);
> -	}
> +	rc = clk_set_parent(&abe_dpll_refclk_mux_ck, &sys_32k_ck);
> +	if (!rc)
> +		rc = clk_set_rate(&dpll_abe_ck, OMAP4_DPLL_ABE_DEFFREQ);
> +	if (rc)
> +		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
>  
>  	return 0;
>  }

Acked-by: Jon Hunter <jon-hunter@ti.com>

Cheers
Jon

