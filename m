From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] OMAP2: Fix dss_54m_fck enable_bit
Date: Thu, 21 Jun 2007 04:51:02 -0700
Message-ID: <20070621115101.GG20283@atomide.com>
References: <20070619234600.427958900@pwsan.com>
	<20070619234629.190236844@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070619234629.190236844@pwsan.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [070619 16:55]:
> Fix an incorrect enable_bit for the OMAP2 clock dss_54m_fck; prevents 
> the LCD backlight from lighting up on 2430 SDP.  Problem noted by Kevin
> Hilman <khilman@mvista.com>; debugging assistance from Khasim Syed Mohammed
> <x0khasim@ti.com> and Richard Woodruff <r-woodruff2@ti.com>.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> ---
>  arch/arm/mach-omap2/clock.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-omap/arch/arm/mach-omap2/clock.h
> ===================================================================
> --- linux-omap.orig/arch/arm/mach-omap2/clock.h
> +++ linux-omap/arch/arm/mach-omap2/clock.h
> @@ -1071,7 +1071,7 @@ static struct clk dss_54m_fck = {	/* Alt
>  	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
>  				RATE_FIXED | RATE_PROPAGATES,
>  	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
> -	.enable_bit	= OMAP24XX_EN_DSS2_SHIFT,
> +	.enable_bit	= OMAP24XX_EN_TV_SHIFT,
>  	.recalc		= &omap2_propagate_rate,
>  };

Thanks, pushing today.

Tony
