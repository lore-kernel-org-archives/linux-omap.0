From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH/RFC] ARM: OMAP: implement CPUfreq frequency table based
	on PRCM table
Date: Thu, 1 Nov 2007 05:33:09 -0700
Message-ID: <20071101123308.GF20403@atomide.com>
References: <20071019172031.226299706@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071019172031.226299706@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Kevin Hilman <khilman@mvista.com> [071019 10:22]:
> This patch adds a CPUfreq frequency-table implementation for OMAP2 by
> walking the PRCM rate-table for available entries and adding them to a
> CPUfreq table.
> 
> CPUfreq can then be used to manage switching between all the available
> entries in the PRCM rate table.  Either use the CPUfreq sysfs
> interface directly, (see Section 3 of Documentation/cpu-freq/user-guide.txt)
> or use the cpufrequtils package:
> http://www.kernel.org/pub/linux/utils/kernel/cpufreq/cpufrequtils.html
> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
> 
> ---
>  arch/arm/mach-omap2/clock24xx.c |   39 ++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/cpu-omap.c   |   52 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 89 insertions(+), 2 deletions(-)
> 
> Index: dev/arch/arm/mach-omap2/clock24xx.c
> ===================================================================
> --- dev.orig/arch/arm/mach-omap2/clock24xx.c
> +++ dev/arch/arm/mach-omap2/clock24xx.c
> @@ -26,6 +26,7 @@
>  #include <linux/clk.h>
>  
>  #include <linux/io.h>
> +#include <linux/cpufreq.h>
>  
>  #include <asm/arch/clock.h>
>  #include <asm/arch/sram.h>
> @@ -461,6 +462,42 @@ static int __init omap2_clk_arch_init(vo
>  }
>  arch_initcall(omap2_clk_arch_init);
>  
> +#ifdef CONFIG_CPU_FREQ
> +/*
> + * Walk PRCM rate table and fillout cpufreq freq_table
> + */
> +static struct cpufreq_frequency_table freq_table[16];
> +struct cpufreq_frequency_table *omap2_cpufreq_table;
> +
> +static void omap2_cpufreq_init_table(void)
> +{
> +	struct prcm_config *prcm;
> +	int i = 0;
> +
> +	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
> +		if (!(prcm->flags & cpu_mask))
> +			continue;
> +		if (prcm->xtal_speed != sys_ck.rate)
> +			continue;
> +
> +		/* don't put bypass rates in table */
> +		if (prcm->dpll_speed == prcm->xtal_speed)
> +			continue;
> +
> +		freq_table[i].index = i;
> +		freq_table[i].frequency = prcm->mpu_speed / 1000;
> +		i++;
> +	}
> +
> +	freq_table[i].index = i;
> +	freq_table[i].frequency = CPUFREQ_TABLE_END;
> +
> +	omap2_cpufreq_table = &freq_table[0];
> +}
> +#else
> +static void omap2_cpufreq_init_table(void) {}
> +#endif
> +
>  int __init omap2_clk_init(void)
>  {
>  	struct prcm_config *prcm;

How about rather call omap2_cpufreq_init_table(freq_table) from cpu-omap.c
init and pass it the freq table from cpu-omap.c?

Also, eventually we should allow board-*.c files specify the rate table too.

Regards,

Tony
