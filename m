From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH/RFC 2] ARM: OMAP: implement CPUfreq frequency table
	based on PRCM table
Date: Thu, 15 Nov 2007 12:48:33 -0800
Message-ID: <20071115204832.GF20686@atomide.com>
References: <20071101174648.893572116@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071101174648.893572116@mvista.com>
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

* Kevin Hilman <khilman@mvista.com> [071101 10:49]:
> [Tony, the cpu-omap code now passes in a table pointer which gets set
>  to the one filled out in the clock code.  Is this what you meant? ]

Yeh, looks good. Just one more thing below.

> This patch adds a CPUfreq frequency-table implementation for OMAP2 by
> walking the PRCM rate-table for available entries and adding them to a
> CPUfreq table.
> 
> CPUfreq can then be used to manage switching between all the available
> entries in the PRCM rate table.  Either use the CPUfreq sysfs
> interface directly, (see Section 3 of Documentation/cpu-freq/user-guide.txt)
> or use the cpufrequtils package:
> http://www.kernel.org/pub/linux/utils/kernel/cpufreq/cpufrequtils.html

<snip>

> Index: dev/arch/arm/plat-omap/cpu-omap.c
> ===================================================================
> --- dev.orig/arch/arm/plat-omap/cpu-omap.c
> +++ dev/arch/arm/plat-omap/cpu-omap.c
> @@ -30,6 +30,11 @@
>  #ifdef CONFIG_ARCH_OMAP1
>  #define MPU_CLK		"mpu"
>  #else
> +
> +#define USE_FREQ_TABLE
> +void omap2_cpufreq_init_table(struct cpufreq_frequency_table **table);
> +static struct cpufreq_frequency_table *freq_table;
> +
>  #define MPU_CLK		"virt_prcm_set"
>  #endif
>  

How about calling omap2_cpufreq_init_table clk_init_cpufreq_table
instead? Then export it and define it in clock.h for omap?
It should be possible to have cpufreq as a module.

Regards,

Tony
