From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: SERIAL: Provide function to enable/disable uart
	clocks
Date: Fri, 2 May 2008 16:32:42 -0700
Message-ID: <20080502233242.GE8981@atomide.com>
References: <1209539325-10443-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50737 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937387AbYEBXcn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2008 19:32:43 -0400
Content-Disposition: inline
In-Reply-To: <1209539325-10443-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jouni Hogander <jouni.hogander@nokia.com> [080430 00:09]:
> This patch adds common function to enable/disable omap2/3 uart
> clocks. Enabled uarts are passed by bootloader in atags and clocks for
> these enabled uarts are touched.

Pushing today.

Tony

> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/serial.c       |   79 ++++++++++++++---------------------
>  include/asm-arm/arch-omap/common.h |    1 +
>  2 files changed, 33 insertions(+), 47 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index c9697a4..54ab7af 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -3,7 +3,7 @@
>   *
>   * OMAP2 serial support.
>   *
> - * Copyright (C) 2005 Nokia Corporation
> + * Copyright (C) 2005-2008 Nokia Corporation
>   * Author: Paul Mundt <paul.mundt@nokia.com>
>   *
>   * Based off of arch/arm/mach-omap/omap1/serial.c
> @@ -23,12 +23,8 @@
>  #include <asm/arch/common.h>
>  #include <asm/arch/board.h>
>  
> -static struct clk * uart1_ick = NULL;
> -static struct clk * uart1_fck = NULL;
> -static struct clk * uart2_ick = NULL;
> -static struct clk * uart2_fck = NULL;
> -static struct clk * uart3_ick = NULL;
> -static struct clk * uart3_fck = NULL;
> +static struct clk *uart_ick[OMAP_MAX_NR_PORTS];
> +static struct clk *uart_fck[OMAP_MAX_NR_PORTS];
>  
>  static struct plat_serial8250_port serial_platform_data[] = {
>  	{
> @@ -87,10 +83,24 @@ static inline void __init omap_serial_reset(struct plat_serial8250_port *p)
>  	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
>  }
>  
> +void omap_serial_enable_clocks(int enable)
> +{
> +	int i;
> +	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
> +		if (uart_ick[i])
> +			enable ? clk_enable(uart_ick[i]) :
> +				clk_disable(uart_ick[i]);
> +		if (uart_fck[i])
> +			enable ? clk_enable(uart_fck[i]) :
> +				clk_disable(uart_fck[i]);
> +	}
> +}
> +
>  void __init omap_serial_init(void)
>  {
>  	int i;
>  	const struct omap_uart_config *info;
> +	char name[16];
>  
>  	/*
>  	 * Make sure the serial ports are muxed on at this point.
> @@ -112,47 +122,22 @@ void __init omap_serial_init(void)
>  			continue;
>  		}
>  
> -		switch (i) {
> -		case 0:
> -			uart1_ick = clk_get(NULL, "uart1_ick");
> -			if (IS_ERR(uart1_ick))
> -				printk("Could not get uart1_ick\n");
> -			else
> -				clk_enable(uart1_ick);
> -
> -			uart1_fck = clk_get(NULL, "uart1_fck");
> -			if (IS_ERR(uart1_fck))
> -				printk("Could not get uart1_fck\n");
> -			else
> -				clk_enable(uart1_fck);
> -			break;
> -		case 1:
> -			uart2_ick = clk_get(NULL, "uart2_ick");
> -			if (IS_ERR(uart2_ick))
> -				printk("Could not get uart2_ick\n");
> -			else
> -				clk_enable(uart2_ick);
> -
> -			uart2_fck = clk_get(NULL, "uart2_fck");
> -			if (IS_ERR(uart2_fck))
> -				printk("Could not get uart2_fck\n");
> -			else
> -				clk_enable(uart2_fck);
> -			break;
> -		case 2:
> -			uart3_ick = clk_get(NULL, "uart3_ick");
> -			if (IS_ERR(uart3_ick))
> -				printk("Could not get uart3_ick\n");
> -			else
> -				clk_enable(uart3_ick);
> -
> -			uart3_fck = clk_get(NULL, "uart3_fck");
> -			if (IS_ERR(uart3_fck))
> -				printk("Could not get uart3_fck\n");
> -			else
> -				clk_enable(uart3_fck);
> -			break;
> +		sprintf(name, "uart%d_ick", i+1);
> +		uart_ick[i] = clk_get(NULL, name);
> +		if (IS_ERR(uart_ick[i])) {
> +			printk(KERN_ERR "Could not get uart%d_ick\n", i+1);
> +			uart_ick[i] = NULL;
> +		}
> +		else
> +			clk_enable(uart_ick[i]);
> +		sprintf(name, "uart%d_fck", i+1);
> +		uart_fck[i] = clk_get(NULL, name);
> +		if (IS_ERR(uart_fck[i])) {
> +			printk(KERN_ERR "Could not get uart%d_fck\n", i+1);
> +			uart_ick[i] = NULL;
>  		}
> +		else
> +			clk_enable(uart_fck[i]);
>  
>  		omap_serial_reset(p);
>  	}
> diff --git a/include/asm-arm/arch-omap/common.h b/include/asm-arm/arch-omap/common.h
> index 36a3b62..6c072de 100644
> --- a/include/asm-arm/arch-omap/common.h
> +++ b/include/asm-arm/arch-omap/common.h
> @@ -34,6 +34,7 @@ struct sys_timer;
>  extern void omap_map_common_io(void);
>  extern struct sys_timer omap_timer;
>  extern void omap_serial_init(void);
> +extern void omap_serial_enable_clocks(int enable);
>  #ifdef CONFIG_I2C_OMAP
>  extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
>  				 struct i2c_board_info const *info,
> -- 
> 1.5.5
> 
