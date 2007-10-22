From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: fix default sys_ck.rate for boot-time DPLL
	detection
Date: Sun, 21 Oct 2007 17:11:53 -0700
Message-ID: <20071022001153.GG6984@atomide.com>
References: <20071019211415.183990583@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071019211415.183990583@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [071019 14:16]:
> In the clock init code, the DPLL value set by the bootloader is
> queried, but always turns zero due it's parent clock (sys_ck) having
> no default rate.  This results in the improper setting of the default
> PRCM rate-table entry and any queries of virt_prcm_set rate to return 0.
> 
> Following the example of the TI kernel, set the default sys_ck rate to
> 13MHz.  Could then be overridden in board setup code.
> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
> 
> ---
>  arch/arm/mach-omap2/clock24xx.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: dev/arch/arm/mach-omap2/clock24xx.h
> ===================================================================
> --- dev.orig/arch/arm/mach-omap2/clock24xx.h
> +++ dev/arch/arm/mach-omap2/clock24xx.h
> @@ -581,6 +581,7 @@ static struct clk osc_ck = {		/* (*12, *
>  /* With out modem likely 12MHz, with modem likely 13MHz */
>  static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
>  	.name		= "sys_ck",		/* ~ ref_clk also */
> +	.rate           = 13000000,
>  	.parent		= &osc_ck,
>  	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
>  				ALWAYS_ENABLED | RATE_PROPAGATES,

Pushing today.

Tony
