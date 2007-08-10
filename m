From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: full-retention fix for 2430
Date: Fri, 10 Aug 2007 03:08:02 -0700
Message-ID: <20070810100801.GU8658@atomide.com>
References: <20070724223650.978943750@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070724223650.978943750@mvista.com>
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

* Kevin Hilman <khilman@mvista.com> [070724 15:38]:
> This fixes a bug where the 2430 crashes upon entering full-retention 
> due to a register difference between 2420 and 2430.
> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
> 
> ---
>  arch/arm/mach-omap2/pm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: dev/arch/arm/mach-omap2/pm.c
> ===================================================================
> --- dev.orig/arch/arm/mach-omap2/pm.c
> +++ dev/arch/arm/mach-omap2/pm.c
> @@ -346,7 +346,7 @@ static struct subsys_attribute sleep_whi
>  
>  static struct clk *osc_ck, *emul_ck;
>  
> -#define CONTROL_DEVCONF		__REG32(0x48000274)
> +#define CONTROL_DEVCONF		__REG32(OMAP2_CTRL_BASE + 0x274)
>  
>  static int omap2_fclks_active(void)
>  {

Pushing today.

Tony
