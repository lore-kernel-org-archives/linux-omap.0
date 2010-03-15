From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/6 Revised] SPI omap2_mcspi: Add
 max_clk_div field to mcspi platform config
Date: Mon, 15 Mar 2010 09:32:46 -0700
Message-ID: <20100315163246.GT2900@atomide.com>
References: <1268407307.14445.51.camel@quad>
	<20100312172148.GG2900@atomide.com>
	<1268587548.30878.11.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1268587548.30878.11.camel@quad>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Scott Ellis <scott-oZqG5KApg2M/jFmSBShxMA@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Aaro Koskinen <Aaro.Koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Scott Ellis <scott-oZqG5KApg2M/jFmSBShxMA@public.gmane.org> [100314 10:22]:
> The McSPI_CHxCONF.CLKD register field has different limits for
> the OMAP3 then the OMAP24xx. New max_clk_div field added to
> mcspi platform config structure to keep track of this.
> 
> Revised patch to not break multi-omap booting.
> 
> Signed-off-by: Scott Ellis <scott-oZqG5KApg2M/jFmSBShxMA@public.gmane.org>
> 
>  arch/arm/mach-omap2/devices.c           |   14 ++++++++++++++
>  arch/arm/plat-omap/include/plat/mcspi.h |    1 +
>  2 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 23e4d77..200f382 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -415,6 +415,11 @@ static inline void omap4_mcspi_fixup(void)
>  	defined(CONFIG_ARCH_OMAP4)
>  static inline void omap2_mcspi3_init(void)
>  {
> +	if (cpu_is_omap343x() || cpu_is_omap44xx())
> +		omap2_mcspi3_config.max_clk_div = 0x0c;
> +	else
> +		omap2_mcspi3_config.max_clk_div = 0x0f;
> +
>  	platform_device_register(&omap2_mcspi3);
>  }
>  #else

Hmm now it looks like you're missing 3630 handling?

If the max_clk_div is 0x0f for 2420 and 2430, then you
can just check for cpu_is_omap24xx(). If it's only
different for 2420, then you can check for cpu_is_omap2420().

That way it should be more future proof, and you don't
need to change it for new processors.

Regards,

Tony

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
