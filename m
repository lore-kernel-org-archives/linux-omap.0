From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM: omap1: avoid unused variable warning
Date: Tue, 23 Feb 2016 08:10:04 -0800
Message-ID: <20160223161003.GY13417@atomide.com>
References: <1456235876-4088840-1-git-send-email-arnd@arndb.de>
 <1456235876-4088840-3-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456235876-4088840-3-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [160223 05:58]:
> The osk_mistral_init() contains code that is only compiled when
> CONFIG_PM is set, but it uses a variable that is declared outside
> of the #ifdef:
> 
> arch/arm/mach-omap1/board-osk.c: In function 'osk_mistral_init':
> arch/arm/mach-omap1/board-osk.c:513:7: warning: unused variable 'ret' [-Wunused-variable]
> 
> This puts the variable in the same #ifdef to avoid the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-omap1/board-osk.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
> index 209aecb0df68..fcc5c0650429 100644
> --- a/arch/arm/mach-omap1/board-osk.c
> +++ b/arch/arm/mach-omap1/board-osk.c
> @@ -510,7 +510,9 @@ static void __init osk_mistral_init(void)
>  	 */
>  	omap_cfg_reg(N15_1610_MPUIO2);
>  	if (gpio_request(OMAP_MPUIO(2), "wakeup") == 0) {
> +#ifdef	CONFIG_PM
>  		int ret = 0;
> +#endif
>  		int irq = gpio_to_irq(OMAP_MPUIO(2));
>  
>  		gpio_direction_input(OMAP_MPUIO(2));

Let's just remove the #ifdef CONFIG_PM in osk_mistral_init()
instead. That's for the wake-up button and I'm not aware
of any other use cases for that button.

Regards,

Tony
