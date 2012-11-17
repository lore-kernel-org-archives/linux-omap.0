From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] AM33XX: Clock: Fix JTAG disconnect during kernel boot
Date: Fri, 16 Nov 2012 18:12:34 -0600
Message-ID: <50A6D672.1020104@ti.com>
References: <1353109482-26478-1-git-send-email-joelagnel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55343 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab2KQAMi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Nov 2012 19:12:38 -0500
In-Reply-To: <1353109482-26478-1-git-send-email-joelagnel@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel A Fernandes <joelagnel@ti.com>
Cc: linux-omap@vger.kernel.org, Russ Dill <Russ.Dill@ti.com>, Matt Porter <mporter@ti.com>, Steve Kipisz <s-kipisz2@ti.com>, Jason Kridner <jkridner@beagleboard.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>


On 11/16/2012 05:44 PM, Joel A Fernandes wrote:
> Set ENABLE_ON_INIT for debugss clock so that it is on during init and the usecount is incremented.
> Not doing so causes kernel to disable debugss clock to save power when CONFIG_OMAP_RESET_CLOCKS
> is set, causing a JTAG disconnect.
> 
> Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
> Cc: Russ Dill <Russ.Dill@ti.com>
> Cc: Matt Porter <mporter@ti.com>
> Cc: Steve Kipisz <s-kipisz2@ti.com>
> Cc: Jason Kridner <jkridner@beagleboard.org>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> Resending, as Cc list was dropped.
> 
>  arch/arm/mach-omap2/clock33xx_data.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
> index b7b7995..d0b4313 100644
> --- a/arch/arm/mach-omap2/clock33xx_data.c
> +++ b/arch/arm/mach-omap2/clock33xx_data.c
> @@ -585,6 +585,7 @@ static struct clk debugss_ick = {
>  	.clkdm_name	= "l3_aon_clkdm",
>  	.parent		= &dpll_core_m4_ck,
>  	.ops		= &clkops_omap2_dflt,
> +	.flags		= ENABLE_ON_INIT,
>  	.enable_reg	= AM33XX_CM_WKUP_DEBUGSS_CLKCTRL,
>  	.enable_bit	= AM33XX_MODULEMODE_SWCTRL,
>  	.recalc		= &followparent_recalc,

Does this mean this clock will always be enabled, even when not using
JTAG? If so, is that what you want?

I was not sure if you are concerned about power at all. Or if having
that always enabled can inhibit low power states for suspend/idle etc.

May be worth adding more details to the changelog about if there are
side-effects to this change or not.

Adding Paul as he is the maintainer of clocks and clock data.

Cheers
Jon



