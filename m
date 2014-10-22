From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] tty: serial: omap: increase max consoles to 10
Date: Wed, 22 Oct 2014 10:03:36 +0200
Message-ID: <544764D8.8050804@linutronix.de>
References: <1413908616-843-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413908616-843-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Franklin Cooper Jr." <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

On 10/21/2014 06:23 PM, Nishanth Menon wrote:
> 
> The final solution is to transition off to use 8250 driver and no
> dependency on console structures and move away from omap-serial driver,
> hence no major cleanups are done for this driver.

So the shiny new driver works for you, is this what you are saying?

> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 18c30ca..4f9cbb6 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -46,7 +46,7 @@
>  
>  #include <dt-bindings/gpio/gpio.h>
>  
> -#define OMAP_MAX_HSUART_PORTS	6
> +#define OMAP_MAX_HSUART_PORTS	10
>  
>  #define UART_BUILD_REVISION(x, y)	(((x) << 8) | (y))

Please also add a check in the probe code that "up->port.line" does not
exceed OMAP_MAX_HSUART_PORTS again. So we leave the probe function with
an error code instead.

Sebastian
