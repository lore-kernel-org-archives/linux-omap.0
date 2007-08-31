From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] To fix OMAP3430 Compilation error
Date: Fri, 31 Aug 2007 11:29:16 -0700
Message-ID: <20070831182916.GN12350@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C4701A91231@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C4701A91231@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070830 16:12]:
> This patch is to fix OMAP3430 compilation error.
> 
> Signed-off-by: Syed Mohammed Khasim <x0khasim@ti.com>
> 
> File Changed:
>  include/asm-arm/arch-omap/clock.h
> 
> =======================================================================
> 
> --- linux-omap/include/asm-arm/arch-omap/clock.h	2007-08-21 15:44:29.000000000 -0500
> +++ my_linux-omap/include/asm-arm/arch-omap/clock.h	2007-08-30 17:26:19.000000000 -0500
> @@ -34,7 +34,7 @@ struct clk {
>  	void			(*init)(struct clk *);
>  	int			(*enable)(struct clk *);
>  	void			(*disable)(struct clk *);
> -#if defined(CONFIG_ARCH_OMAP2)
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>  	u8			fixed_div;
>  #endif
>  };

Pushing today.

Tony
