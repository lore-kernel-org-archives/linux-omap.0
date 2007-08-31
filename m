From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] To fix HS I2C driver for OMAP2430
Date: Fri, 31 Aug 2007 11:27:56 -0700
Message-ID: <20070831182756.GM12350@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C4701A90B86@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C4701A90B86@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070829 16:17]:
> This should fix HSI2C, Keypad and T2 failures on 2430SDP
> 
> Signed-off-by: Syed Mohammed Khasim <x0khasim@ti.com>
> 
> File Changed:
>  arch/arm/mach-omap2/clock.h
> 
> =======================================================================
> 
> --- linux-omap/arch/arm/mach-omap2/clock.h	2007-08-21 15:44:23.000000000 -0500
> +++ my_linux-omap/arch/arm/mach-omap2/clock.h	2007-08-29 18:07:40.000000000 -0500
> @@ -1734,7 +1734,7 @@ static struct clk i2c2_ick = {
>  	.name		= "i2c_ick",
>  	.id		= 2,
>  	.parent		= &l4_ck,
> -	.flags		= CLOCK_IN_OMAP242X,
> +	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
>  	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
>  	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
>  	.recalc		= &followparent_recalc,
> @@ -1764,7 +1764,7 @@ static struct clk i2c1_ick = {
>  	.name		= "i2c_ick",
>  	.id		= 1,
>  	.parent		= &l4_ck,
> -	.flags		= CLOCK_IN_OMAP242X,
> +	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
>  	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
>  	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
>  	.recalc		= &followparent_recalc,

Pushing today.

Tony
