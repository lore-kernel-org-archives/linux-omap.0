From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] omap-serial: Request pins using pinctrl framework
Date: Thu, 6 Sep 2012 12:12:17 -0700
Message-ID: <20120906191216.GA1303@atomide.com>
References: <20120906185615.1172.23588.stgit@muffinssi.local>
 <20120906185832.1172.31013.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120906185832.1172.31013.stgit@muffinssi.local>
Sender: linux-serial-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [120906 11:59]:
> Request pins using pinctrl framework. Only show a warning
> on error as some boards set the pins in the bootloader
> even if CONFIG_PINCTRL is enabled.
> 
> Cc: linux-serial@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Greg, this patch should be OK for you to pick, it should not break
anything even if pinctrl is not available yet. Let me know if it
needs rebasing on top of other things you've queued for omap-serial.

Regards,

Tony

>  arch/arm/plat-omap/include/plat/omap-serial.h |    1 +
>  drivers/tty/serial/omap-serial.c              |   10 ++++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
> index 1a52725..0f4de14 100644
> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> @@ -106,6 +106,7 @@ struct uart_omap_port {
>  	struct uart_port	port;
>  	struct uart_omap_dma	uart_dma;
>  	struct platform_device	*pdev;
> +	struct pinctrl		*pins;
>  
>  	unsigned char		ier;
>  	unsigned char		lcr;
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index d3cda0c..068e88c 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -39,6 +39,7 @@
>  #include <linux/irq.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #include <plat/dma.h>
>  #include <plat/dmtimer.h>
> @@ -1492,6 +1493,13 @@ static int serial_omap_probe(struct platform_device *pdev)
>  		goto err_port_line;
>  	}
>  
> +	up->pins = pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(up->pins)) {
> +		dev_warn(&pdev->dev, "did not get pins for uart%i error: %li\n",
> +			 up->port.line, PTR_ERR(up->pins));
> +		up->pins = NULL;
> +	}
> +
>  	sprintf(up->name, "OMAP UART%d", up->port.line);
>  	up->port.mapbase = mem->start;
>  	up->port.membase = devm_ioremap(&pdev->dev, mem->start,
> @@ -1570,6 +1578,8 @@ static int serial_omap_remove(struct platform_device *dev)
>  		pm_runtime_disable(&up->pdev->dev);
>  		uart_remove_one_port(&serial_omap_reg, &up->port);
>  		pm_qos_remove_request(&up->pm_qos_request);
> +		if (up->pins)
> +			pinctrl_put(up->pins);
>  	}
>  
>  	platform_set_drvdata(dev, NULL);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
