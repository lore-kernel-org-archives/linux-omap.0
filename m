From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Use dynamic detection for setting default
	sys_ck
Date: Mon, 22 Oct 2007 17:35:23 -0700
Message-ID: <20071023003523.GG17318@atomide.com>
References: <20071023001701.324618342@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5I6of5zJg18YgZEa"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071023001701.324618342@mvista.com>
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


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Kevin Hilman <khilman@mvista.com> [071022 17:18]:
> A cleaner way than my previous static fix...  Rather than setting a
> static sys_ck.rate, detect the correct value at boot time.
> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
> 
> ---
>  arch/arm/mach-omap2/clock24xx.c |    1 +
>  arch/arm/mach-omap2/clock24xx.h |    1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: dev/arch/arm/mach-omap2/clock24xx.c
> ===================================================================
> --- dev.orig/arch/arm/mach-omap2/clock24xx.c
> +++ dev/arch/arm/mach-omap2/clock24xx.c
> @@ -475,6 +475,7 @@ int __init omap2_clk_init(void)
>  	clk_init(&omap2_clk_functions);
>  
>  	omap2_osc_clk_recalc(&osc_ck);
> +	omap2_sys_clk_recalc(&sys_ck);
>  
>  	for (clkp = onchip_24xx_clks;
>  	     clkp < onchip_24xx_clks + ARRAY_SIZE(onchip_24xx_clks);
> Index: dev/arch/arm/mach-omap2/clock24xx.h
> ===================================================================
> --- dev.orig/arch/arm/mach-omap2/clock24xx.h
> +++ dev/arch/arm/mach-omap2/clock24xx.h
> @@ -581,7 +581,6 @@ static struct clk osc_ck = {		/* (*12, *
>  /* With out modem likely 12MHz, with modem likely 13MHz */
>  static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
>  	.name		= "sys_ck",		/* ~ ref_clk also */
> -	.rate           = 13000000,
>  	.parent		= &osc_ck,
>  	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
>  				ALWAYS_ENABLED | RATE_PROPAGATES,
> --

I'll undo your earlier patch and apply first part of this if you don't
mind. Also merged comments from your first patch, hope that's OK with
you, see attached.

Regards,

Tony

--5I6of5zJg18YgZEa
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="kevin.patch"

>From 3e02c8300f5a7900e91bb6da219faa6cf27b64f7 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@mvista.com>
Date: Fri, 19 Oct 2007 14:14:15 -0700
Subject: [PATCH] ARM: OMAP: fix default sys_ck.rate for boot-time DPLL detection

In the clock init code, the DPLL value set by the bootloader is
queried, but always turns zero due it's parent clock (sys_ck) having
no default rate.  This results in the improper setting of the default
PRCM rate-table entry and any queries of virt_prcm_set rate to return 0.

Rather than setting a static sys_ck.rate, detect the correct value at
boot time.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- dev.orig/arch/arm/mach-omap2/clock24xx.c
+++ dev/arch/arm/mach-omap2/clock24xx.c
@@ -475,6 +475,7 @@ int __init omap2_clk_init(void)
 	clk_init(&omap2_clk_functions);

 	omap2_osc_clk_recalc(&osc_ck);
+	omap2_sys_clk_recalc(&sys_ck);

 	for (clkp = onchip_24xx_clks;
 	     clkp < onchip_24xx_clks + ARRAY_SIZE(onchip_24xx_clks);

--5I6of5zJg18YgZEa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--5I6of5zJg18YgZEa--
