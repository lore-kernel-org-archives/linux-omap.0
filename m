From: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH] ARM: omap2: remove incorrect __init annotation
Date: Wed, 19 Jun 2019 14:32:25 +0100
Message-ID: <20190619133224.GX20984@e119886-lin.cambridge.arm.com>
References: <20190619130529.1502322-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190619130529.1502322-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@codeaurora.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 19, 2019 at 03:04:54PM +0200, Arnd Bergmann wrote:
> omap3xxx_prm_enable_io_wakeup() is marked __init, but its caller is not, so
> we get a warning with clang-8:
> 
> WARNING: vmlinux.o(.text+0x343c8): Section mismatch in reference from the function omap3xxx_prm_late_init() to the function .init.text:omap3xxx_prm_enable_io_wakeup()
> The function omap3xxx_prm_late_init() references
> the function __init omap3xxx_prm_enable_io_wakeup().
> This is often because omap3xxx_prm_late_init lacks a __init
> annotation or the annotation of omap3xxx_prm_enable_io_wakeup is wrong.
> 

That's unfortunate, both omap3xxx_prm_enable_io_wakeup and
omap3xxx_prm_late_init are only ever called at init time (by prm_late_init
which is also __init annotated). However the omap3xxx_prm_ll_data
structure containing the late_init has a life beyond init. Otherwise I
would have suggested annotating omap3xxx_prm_late_init.

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> When building with gcc, omap3xxx_prm_enable_io_wakeup() is always
> inlined, so we never noticed in the past.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/prm3xxx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
> index 05858f966f7d..dfa65fc2c82b 100644
> --- a/arch/arm/mach-omap2/prm3xxx.c
> +++ b/arch/arm/mach-omap2/prm3xxx.c
> @@ -433,7 +433,7 @@ static void omap3_prm_reconfigure_io_chain(void)
>   * registers, and omap3xxx_prm_reconfigure_io_chain() must be called.
>   * No return value.
>   */
> -static void __init omap3xxx_prm_enable_io_wakeup(void)
> +static void omap3xxx_prm_enable_io_wakeup(void)
>  {
>  	if (prm_features & PRM_HAS_IO_WAKEUP)
>  		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
> -- 
> 2.20.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
