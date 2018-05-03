From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] serial: 8250: omap: Fix idling of clocks for unused uarts
Date: Thu, 3 May 2018 15:48:51 +0530
Message-ID: <58bcba76-d63b-212e-4baf-d40a28c549d3@ti.com>
References: <20180502171500.60462-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502171500.60462-1-tony@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org



On Wednesday 02 May 2018 10:45 PM, Tony Lindgren wrote:
> I noticed that unused UARTs won't necessarily idle properly always
> unless at least one byte tx transfer is done first.
> 
> After some debugging I narrowed down the problem to the scr register
> dma configuration bits that need to be set before softreset for the
> clocks to idle. Unless we do this, the module clkctrl idlest bits
> may be set to 1 instead of 3 meaning the clock will never idle and
> is blocking deeper idle states for the whole domain.
> 
> This might be related to the configuration done by the bootloader
> or kexec booting where certain configurations cause the 8250 or
> the clkctrl clock to jam in a way where setting of the scr bits
> and reset is needed to clear it. I've tried diffing the 8250
> registers for the various modes, but did not see anything specific.
> So far I've only seen this on omap4 but I'm suspecting this might
> also happen on the other clkctrl using SoCs considering they
> already have a quirk enabled for UART_ERRATA_CLOCK_DISABLE.
> 

That's interesting! We do have AM437x suspend/resume working without
this workaround (UARTs on AM437x does not use DMA) and UART IPs clkctrl
do go to idle state. Seems like a OMAP4 specific issue.

> Let's fix the issue by configuring scr before reset for basic dma
> even if we don't use it. The scr register will be reset when we do
> softreset few lines after, and we restore scr on resume. We should
> do this for all the SoCs with UART_ERRATA_CLOCK_DISABLE quirk flag
> set since the ones with UART_ERRATA_CLOCK_DISABLE are all based
> using clkctrl similar to omap4.
> 
> Looks like both OMAP_UART_SCR_DMAMODE_1 | OMAP_UART_SCR_DMAMODE_CTL
> bits are needed for the clkctrl to idle after a softreset.
> 
> And we need to add omap4 to also use the UART_ERRATA_CLOCK_DISABLE
> for the related workaround to be enabled. This same compatible
> value will also be used for omap5.
> 
> Fixes: cdb929e4452a ("serial: 8250_omap: workaround errata around
> idling UART after using DMA")
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1110,13 +1110,14 @@ static int omap8250_no_handle_irq(struct uart_port *port)
>  	return 0;
>  }
>  
> +static const u8 omap4_habit = UART_ERRATA_CLOCK_DISABLE;
>  static const u8 am3352_habit = OMAP_DMA_TX_KICK | UART_ERRATA_CLOCK_DISABLE;
>  static const u8 dra742_habit = UART_ERRATA_CLOCK_DISABLE;
>  
>  static const struct of_device_id omap8250_dt_ids[] = {
>  	{ .compatible = "ti,omap2-uart" },
>  	{ .compatible = "ti,omap3-uart" },
> -	{ .compatible = "ti,omap4-uart" },
> +	{ .compatible = "ti,omap4-uart", .data = &omap4_habit, },
>  	{ .compatible = "ti,am3352-uart", .data = &am3352_habit, },
>  	{ .compatible = "ti,am4372-uart", .data = &am3352_habit, },
>  	{ .compatible = "ti,dra742-uart", .data = &dra742_habit, },
> @@ -1362,6 +1363,16 @@ static int omap8250_soft_reset(struct device *dev)
>  	int sysc;
>  	int syss;
>  
> +	/*
> +	 * At least on omap4, unused uarts may not idle after reset without
> +	 * a basic scr dma configuration even with no dma in use. The
> +	 * module clkctrl status bit will stay set blocking idle for the
> +	 * whole clockdomain. The softreset below will clear scr, and we
> +	 * restore it on resume so this is safe to do on all SoCs needing
> +	 * omap8250_soft_reset() quirk.
> +	 */
> +	serial_out(up, UART_OMAP_SCR,
> +		   OMAP_UART_SCR_DMAMODE_1 | OMAP_UART_SCR_DMAMODE_CTL);

Comment in omap8250_update_scr() warns not to set these two bits in a
single register write because this may lead to malfunction. I would
recommend to split this into two writes.

>  	sysc = serial_in(up, UART_OMAP_SYSC);
>  
>  	/* softreset the UART */
> 

-- 
Regards
Vignesh
