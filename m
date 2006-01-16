From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] fix compile h3
Date: Mon, 16 Jan 2006 10:40:50 -0800
Message-ID: <20060116184050.GG4511@atomide.com>
References: <20060114141623.41508.qmail@web32914.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060114141623.41508.qmail@web32914.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060114 09:00]:
> Tony,
> 
> Patch fixes following error and selects the GPIOEXPANDER for H3 board.
> 
> arch/arm/mach-omap1/board-h3.c: In function `h3_transceiver_mode':
> arch/arm/mach-omap1/board-h3.c:253: error: incompatible type for
> argument 1 of `cancel_delayed_work'
> arch/arm/mach-omap1/board-h3.c:254: error: invalid type argument of
> `->'
> arch/arm/mach-omap1/board-h3.c:254: error: invalid type argument of
> `->'
> arch/arm/mach-omap1/board-h3.c:255: error: incompatible type for
> argument 1 of `schedule_work'
> make[1]: *** [arch/arm/mach-omap1/board-h3.o] Error 1
> make: *** [arch/arm/mach-omap1] Error 2
> 
> Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>
> 
> Sorry for this mistake :(
> 
> ---Komal Shah
> http://komalshah.blogspot.com/
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
Content-Description: 3029636071-fixh3-linking.patch
> diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
> index f17b4ac..e89e4fd 100644
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -36,6 +36,7 @@ config MACH_OMAP_H2
>  config MACH_OMAP_H3
>  	bool "TI H3 Support"
>  	depends on ARCH_OMAP1 && ARCH_OMAP16XX
> +	select GPIOEXPANDER_OMAP
>      	help
>  	  TI OMAP 1710 H3 board support. Say Y here if you have such
>  	  a board.
> diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
> index 826e741..60311d2 100644
> --- a/arch/arm/mach-omap1/board-h3.c
> +++ b/arch/arm/mach-omap1/board-h3.c
> @@ -250,9 +250,9 @@ static int h3_transceiver_mode(struct de
>  {
>  	struct omap_irda_config *irda_config = dev->platform_data;
>  
> -	cancel_delayed_work(irda_config->gpio_expa);
> -	PREPARE_WORK(irda_config->gpio_expa, set_trans_mode, &mode);
> -	schedule_work(irda_config->gpio_expa);
> +	cancel_delayed_work(&irda_config->gpio_expa);
> +	PREPARE_WORK(&irda_config->gpio_expa, set_trans_mode, &mode);
> +	schedule_work(&irda_config->gpio_expa);
>  
>  	return 0;
>  }

Thanks, pushing this today.

Tony
