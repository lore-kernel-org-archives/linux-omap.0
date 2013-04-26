From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 4/6] SERIAL: OMAP: Remove the slave idle handling from the driver
Date: Fri, 26 Apr 2013 11:05:24 -0700
Message-ID: <8761z9yxp7.fsf@linaro.org>
References: <1366973695-2088-1-git-send-email-rnayak@ti.com>
	<1366973695-2088-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:35787 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab3DZSF2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Apr 2013 14:05:28 -0400
Received: by mail-da0-f46.google.com with SMTP id x4so1502433daj.19
        for <linux-omap@vger.kernel.org>; Fri, 26 Apr 2013 11:05:27 -0700 (PDT)
In-Reply-To: <1366973695-2088-5-git-send-email-rnayak@ti.com> (Rajendra
	Nayak's message of "Fri, 26 Apr 2013 16:24:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org

Rajendra Nayak <rnayak@ti.com> writes:

> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> UART IP slave idle handling now taken care by runtime pm backend(hwmod layer)
> so remove the hackery from the driver.
>
> As discussed on the list, in future if dma mode needs to be brought
> back to this driver, UART sysc handling needs to be updated in
> framework such a way that no-idle/force idle profile can be supported.
> Given the broken dma mode for OMAP uarts, its very unlikely.
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Rajendra nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

nit: the ordering of this patch with the following one will break
bisect.  

IOW, with this patch applied, but not the following one, compilation
will be broken because the func pointers are removed from the header,
but still used in omap-serial.c.

A simple fix is to just apply the other one first.

Kevin

> ---
>  drivers/tty/serial/omap-serial.c          |   23 -----------------------
>  include/linux/platform_data/serial-omap.h |    2 --
>  2 files changed, 25 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 4dc4140..08332f3 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -202,26 +202,6 @@ static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
>  	return pdata->get_context_loss_count(up->dev);
>  }
>  
> -static void serial_omap_set_forceidle(struct uart_omap_port *up)
> -{
> -	struct omap_uart_port_info *pdata = up->dev->platform_data;
> -
> -	if (!pdata || !pdata->set_forceidle)
> -		return;
> -
> -	pdata->set_forceidle(up->dev);
> -}
> -
> -static void serial_omap_set_noidle(struct uart_omap_port *up)
> -{
> -	struct omap_uart_port_info *pdata = up->dev->platform_data;
> -
> -	if (!pdata || !pdata->set_noidle)
> -		return;
> -
> -	pdata->set_noidle(up->dev);
> -}
> -
>  static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool enable)
>  {
>  	struct omap_uart_port_info *pdata = up->dev->platform_data;
> @@ -298,8 +278,6 @@ static void serial_omap_stop_tx(struct uart_port *port)
>  		serial_out(up, UART_IER, up->ier);
>  	}
>  
> -	serial_omap_set_forceidle(up);
> -
>  	pm_runtime_mark_last_busy(up->dev);
>  	pm_runtime_put_autosuspend(up->dev);
>  }
> @@ -364,7 +342,6 @@ static void serial_omap_start_tx(struct uart_port *port)
>  
>  	pm_runtime_get_sync(up->dev);
>  	serial_omap_enable_ier_thri(up);
> -	serial_omap_set_noidle(up);
>  	pm_runtime_mark_last_busy(up->dev);
>  	pm_runtime_put_autosuspend(up->dev);
>  }
> diff --git a/include/linux/platform_data/serial-omap.h b/include/linux/platform_data/serial-omap.h
> index ff9b0aa..c860c1b 100644
> --- a/include/linux/platform_data/serial-omap.h
> +++ b/include/linux/platform_data/serial-omap.h
> @@ -43,8 +43,6 @@ struct omap_uart_port_info {
>  	int			DTR_present;
>  
>  	int (*get_context_loss_count)(struct device *);
> -	void (*set_forceidle)(struct device *);
> -	void (*set_noidle)(struct device *);
>  	void (*enable_wakeup)(struct device *, bool);
>  };
