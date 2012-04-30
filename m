From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/6] ARM: OMAP4: hwmod: rename _enable_module to _omap4_enable_module()
Date: Mon, 30 Apr 2012 10:15:52 -0700
Message-ID: <877gwxw37b.fsf@ti.com>
References: <1335557140-10854-1-git-send-email-khilman@ti.com>
	<1335557140-10854-2-git-send-email-khilman@ti.com>
	<alpine.DEB.2.00.1204300821290.10308@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:51803 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754078Ab2D3RP4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 13:15:56 -0400
Received: by pbcwy7 with SMTP id wy7so749415pbc.31
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 10:15:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204300821290.10308@utopia.booyaka.com> (Paul
	Walmsley's message of "Mon, 30 Apr 2012 08:22:25 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin,
>
> On Fri, 27 Apr 2012, Kevin Hilman wrote:
>
>> _enable_module is specific to OMAP4-class SoCs, so rename it to
>> be consistend with the corresponding _omap4_disable_module.
>> 
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> I tweaked the commit message here a little bit - please let me know if you 
> have any comments.

Yes, that's better.   I wrote OMAP4-class SoCs, I meant OMAP4-class
PRCM, so the updated changelog looks good.  Thanks.

Also, the rest of your changes to the series look good to me.

Thanks,

Kevin

> From: Kevin Hilman <khilman@ti.com>
> Date: Fri, 27 Apr 2012 22:25:59 -0600
> Subject: [PATCH 1/6] ARM: OMAP4: hwmod: rename _enable_module to
>  _omap4_enable_module()
>
> _enable_module is specific to SoCs with PRCM interfaces similar to
> that of the OMAP4, so rename it to be consistent with the
> corresponding _omap4_disable_module.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> [paul@pwsan.com: tweaked commit message]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index bf86f7e..939032a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -771,13 +771,13 @@ static void _disable_optional_clocks(struct omap_hwmod *oh)
>  }
>  
>  /**
> - * _enable_module - enable CLKCTRL modulemode on OMAP4
> + * _omap4_enable_module - enable CLKCTRL modulemode on OMAP4
>   * @oh: struct omap_hwmod *
>   *
>   * Enables the PRCM module mode related to the hwmod @oh.
>   * No return value.
>   */
> -static void _enable_module(struct omap_hwmod *oh)
> +static void _omap4_enable_module(struct omap_hwmod *oh)
>  {
>  	/* The module mode does not exist prior OMAP4 */
>  	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> @@ -786,8 +786,8 @@ static void _enable_module(struct omap_hwmod *oh)
>  	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
>  		return;
>  
> -	pr_debug("omap_hwmod: %s: _enable_module: %d\n",
> -		 oh->name, oh->prcm.omap4.modulemode);
> +	pr_debug("omap_hwmod: %s: %s: %d\n",
> +		 oh->name, __func__, oh->prcm.omap4.modulemode);
>  
>  	omap4_cminst_module_enable(oh->prcm.omap4.modulemode,
>  				   oh->clkdm->prcm_partition,
> @@ -1814,7 +1814,7 @@ static int _enable(struct omap_hwmod *oh)
>  	}
>  
>  	_enable_clocks(oh);
> -	_enable_module(oh);
> +	_omap4_enable_module(oh);
>  
>  	r = _wait_target_ready(oh);
>  	if (!r) {
