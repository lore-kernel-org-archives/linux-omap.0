From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.21-rc5-omap1-git] fix OMAP1 dmtimer build warning
Date: Tue, 3 Apr 2007 14:51:18 -0400
Message-ID: <20070403185116.GD32591@atomide.com>
References: <200704021245.50935.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200704021245.50935.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070402 17:11]:
> Remove the OMAP1 version of omap_dm_timer_get_fclk(), and its associated
> compile-time warning.  It would only BUG() if called, while it's only
> called on OMAP2.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -271,11 +271,6 @@ int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
>  
>  #if defined(CONFIG_ARCH_OMAP1)
>  
> -struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
> -{
> -	BUG();
> -}
> -
>  /**
>   * omap_dm_timer_modify_idlect_mask - Check if any running timers use ARMXOR
>   * @inputmask: current value of idlect mask

Pushing to omap-upstream branch.

Tony
