From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP4: Fix NULL pointer dereference crash.
Date: Mon, 24 Aug 2009 17:10:40 +0300
Message-ID: <20090824141040.GH5165@atomide.com>
References: <1250846095-6381-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54644 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbZHXOKy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 10:10:54 -0400
Content-Disposition: inline
In-Reply-To: <1250846095-6381-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: rmk@arm.linux.org.uk, khilman@deeprootsystems.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Syed Rafiuddin <rafiuddin.syed@ti.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [090821 12:15]:
> After the patch series "[PATCH 00/14] OMAP PM fixes for .31-rc"
> merge in 2.6.31-rc5, the kernel crashed during boot on OMAP4430.
> This patch fixes it by adding UART4 support and related code.
> Without this patch omap_serial_init() would produce " NULL pointer
> dereference" and kernel crashes in the bootup on OMAP4430 platform.
> 
> Some more info on the merge issue can be found here.
> More info- http://lkml.org/lkml/2009/8/20/192
> 
> Note: While merging this patch,"IO_ADDRESS" needs to be changed 
> to "OMAP2_IO_ADDRESS" if the Tony's below series is already merged in.
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg15072.html
> 
> Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c |    2 +-
>  arch/arm/mach-omap2/serial.c        |   27 ++++++++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index b0c7402..1b22307 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -39,7 +39,7 @@ static struct platform_device *sdp4430_devices[] __initdata = {
>  };
>  
>  static struct omap_uart_config sdp4430_uart_config __initdata = {
> -	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2),
> +	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3),
>  };
>  

This part above won't be needed any longer with patches in omap for next.


>  static struct omap_lcd_config sdp4430_lcd_config __initdata = {
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index a7421a5..e1be77b 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -112,7 +112,21 @@ static struct plat_serial8250_port serial_platform_data2[] = {
>  		.flags		= 0
>  	}
>  };
> -
> +#ifdef CONFIG_ARCH_OMAP4
> +static struct plat_serial8250_port serial_platform_data3[] = {
> +	{
> +		.membase	= IO_ADDRESS(OMAP_UART4_BASE),
> +		.mapbase	= OMAP_UART4_BASE,
> +		.irq		= 70,
> +		.flags		= UPF_BOOT_AUTOCONF,
> +		.iotype		= UPIO_MEM,
> +		.regshift	= 2,
> +		.uartclk	= OMAP24XX_BASE_BAUD * 16,
> +	}, {
> +		.flags		= 0
> +	}
> +};
> +#endif
>  static inline unsigned int serial_read_reg(struct plat_serial8250_port *up,
>  					   int offset)
>  {
> @@ -550,6 +564,17 @@ static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS] = {
>  			},
>  		},
>  	},
> +#ifdef CONFIG_ARCH_OMAP4
> +	{
> +		.pdev = {
> +			.name			= "serial8250",
> +			.id			= PLAT8250_DEV_FOURPORT,
> +			.dev			= {
> +				.platform_data	= serial_platform_data3,
> +			},
> +		},
> +	},
> +#endif
>  };
>  
>  void __init omap_serial_init(void)
> -- 
> 1.5.4.7
> 
