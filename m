From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP4: Update timer clock aliases
Date: Thu, 29 Nov 2012 11:02:17 -0600
Message-ID: <50B79519.3080509@ti.com>
References: <1352313782-21602-1-git-send-email-jon-hunter@ti.com> <1352313782-21602-2-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1211291048580.20529@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42928 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069Ab2K2RCW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Nov 2012 12:02:22 -0500
In-Reply-To: <alpine.DEB.2.00.1211291048580.20529@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 11/29/2012 04:53 AM, Paul Walmsley wrote:
> Hi Jon,
> 
> On Wed, 7 Nov 2012, Jon Hunter wrote:
> 
>> Commit "ARM: dts: OMAP4: Update timer addresses" updated the device-tree
>> names of the OMAP4 timers 5-7 because the default address for the timers
>> was changed from the L3 address to the MPU private address. When booting
>> with device-tree, this introduces a regression when attempting to set
>> the parent clock of timers 5-7 to the sys_clk_div_ck. Therefore, update
>> the clock aliases for timer 5-7 to reflect the updated device-tree name
>> for the timers.
> 
> Reviewing my E-mail inbox, just saw that this one is marked as being 
> needed for v3.8.  Is that still the case?  If so, we should ask Tony to 
> take an updated version of this patch, given the recent CCF conversion.

Yes this is still needed for v3.8.

> Following is the updated patch.

Thanks, looks good to me.

Cheers
Jon

> 
> - Paul
> 
> From: Jon Hunter <jon-hunter@ti.com>
> Date: Thu, 29 Nov 2012 03:47:46 -0700
> Subject: [PATCH] ARM: OMAP4: Update timer clock aliases
> 
> Commit "ARM: dts: OMAP4: Update timer addresses" updated the device-tree
> names of the OMAP4 timers 5-7 because the default address for the timers
> was changed from the L3 address to the MPU private address. When booting
> with device-tree, this introduces a regression when attempting to set
> the parent clock of timers 5-7 to the sys_clk_div_ck. Therefore, update
> the clock aliases for timer 5-7 to reflect the updated device-tree name
> for the timers.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> [paul@pwsan.com: updated to apply after the CCF conversion]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/cclock44xx_data.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
> index aa56c3e..a1f0b55 100644
> --- a/arch/arm/mach-omap2/cclock44xx_data.c
> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
> @@ -1935,10 +1935,10 @@ static struct omap_clk omap44xx_clks[] = {
>  	CLK("4803e000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
>  	CLK("48086000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
>  	CLK("48088000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
> -	CLK("49038000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
> -	CLK("4903a000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
> -	CLK("4903c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
> -	CLK("4903e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
> +	CLK("40138000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
> +	CLK("4013a000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
> +	CLK("4013c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
> +	CLK("4013e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
>  	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
>  };
>  
> 
