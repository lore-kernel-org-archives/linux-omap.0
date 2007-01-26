From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix OMAP2 dss2 so clk_set_parent works
Date: Fri, 26 Jan 2007 12:09:34 -0800
Message-ID: <20070126200933.GF29286@atomide.com>
References: <3B6D69C3A9EBCA4BA5DA60D91302742932FFC4@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742932FFC4@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [070124 17:08]:
> Hello,
> 
> This adds the delayed application attribute to the dss2 clock.  DSS2
> can't select the 48MHz APLL with properly with out validating the
> configuration as trigged by this flag.
> 
> Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
> 
> diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
> index 8816f5a..094c309 100644
> --- a/arch/arm/mach-omap2/clock.h
> +++ b/arch/arm/mach-omap2/clock.h
> @@ -1013,7 +1013,8 @@ static struct clk dss2_fck = {		/* Alt c
>  	.name		= "dss2_fck",
>  	.parent		= &sys_ck,		/* fixed at sys_ck or
> 48MHz */
>  	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
> -				RATE_CKCTL | CM_CORE_SEL1 | RATE_FIXED,
> +				RATE_CKCTL | CM_CORE_SEL1 | RATE_FIXED |
> 
> +				DELAYED_APP,
>  	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
>  	.enable_bit	= 1,
>  	.src_offset	= 13,
> 

Pushing today.

Tony
