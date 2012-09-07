From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: omap: Request pins using pinctrl framework
Date: Fri, 7 Sep 2012 11:27:29 -0700
Message-ID: <20120907182729.GK1303@atomide.com>
References: <20120907175939.GE1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120907175939.GE1303@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [120907 11:00]:
> Request pins using pinctrl framework. Only show a warning
> on error as some boards set the pins in the bootloader
> even if CONFIG_PINCTRL is enabled.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> ---
> 
> Note that this has only so far been tested with the legacy
> non-devicetree boot as devicetree boot now has a regression
> issue with omap-serial.

Now also tested with devicetree case on top tty-next +
Felipe's "[PATCH] serial: omap: fix DeviceTree boot.

Tony
 
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -40,6 +40,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
>  #include <linux/gpio.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #include <plat/omap-serial.h>
>  
> @@ -108,6 +109,7 @@ struct uart_omap_port {
>  	u32			latency;
>  	u32			calc_latency;
>  	struct work_struct	qos_work;
> +	struct pinctrl		*pins;
>  };
>  
>  #define to_uart_omap_port(p)	((container_of((p), struct uart_omap_port, port)))
> @@ -1371,6 +1373,13 @@ static int __devinit serial_omap_probe(struct platform_device *pdev)
>  		goto err_port_line;
>  	}
>  
> +	up->pins = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(up->pins)) {
> +		dev_warn(&pdev->dev, "did not get pins for uart%i error: %li\n",
> +			 up->port.line, PTR_ERR(up->pins));
> +		up->pins = NULL;
> +	}
> +
>  	sprintf(up->name, "OMAP UART%d", up->port.line);
>  	up->port.mapbase = mem->start;
>  	up->port.membase = devm_ioremap(&pdev->dev, mem->start,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
