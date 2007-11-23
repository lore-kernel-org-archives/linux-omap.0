From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Remove unused and broken core_l3_ck clk_get from
	board-3430sdp.c
Date: Fri, 23 Nov 2007 12:29:08 -0800
Message-ID: <20071123202907.GD559@atomide.com>
References: <Pine.LNX.4.64.0711161713550.13378@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711161713550.13378@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [071116 16:15]:
> 
> board-3430sdp.c tries to clk_get core_l3_ck.  This clock doesn't exist
> any longer in the current clock34xx.h, so it fails.  The code then tries
> to fetch the clock's rate, which is also not currently used.  This is 
> dead code, so remove it.  
> 
> Tested on 3430SDP ES1.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> ---
>  arch/arm/mach-omap2/board-3430sdp.c |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> Index: linux-omap/arch/arm/mach-omap2/board-3430sdp.c
> ===================================================================
> --- linux-omap.orig/arch/arm/mach-omap2/board-3430sdp.c	2007-11-16 16:36:01.000000000 -0700
> +++ linux-omap/arch/arm/mach-omap2/board-3430sdp.c	2007-11-16 16:37:42.000000000 -0700
> @@ -264,16 +264,8 @@
>  {
>  	int eth_cs;
>  	unsigned long cs_mem_base;
> -	unsigned int rate;
> -	struct clk *l3ck;
>  
> -	eth_cs	= SDP3430_SMC91X_CS;
> -
> -	l3ck = clk_get(NULL, "core_l3_ck");
> -	if (IS_ERR(l3ck))
> -		rate = 100000000;
> -	else
> -		rate = clk_get_rate(l3ck);
> +	eth_cs  = SDP3430_SMC91X_CS;
>  
>  	if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
>  		printk(KERN_ERR "Failed to request GPMC mem for smc91x\n");

Pushing today.

Tony
