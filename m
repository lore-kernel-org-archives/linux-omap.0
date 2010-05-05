From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM][PATCH v3 2/4] OMAP3: Serial: Errata i202: fix for MDR1 access
Date: Wed, 05 May 2010 16:55:08 -0700
Message-ID: <87d3x9ykdf.fsf@deeprootsystems.com>
References: <[PM][PATCH v2 2/4] OMAP3: Serial: Errata i202: fix for MDR1
	access> <1271097933-22981-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f189.google.com ([209.85.221.189]:56284 "EHLO
	mail-qy0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381Ab0EEXzN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 19:55:13 -0400
Received: by qyk27 with SMTP id 27so11203876qyk.23
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 16:55:12 -0700 (PDT)
In-Reply-To: <1271097933-22981-1-git-send-email-nm@ti.com> (Nishanth Menon's message of "Mon\, 12 Apr 2010 13\:45\:33 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Deepak K <deepak.k@ti.com>, Govindraj R <govindraj.raja@ti.com>, Tero Kristo <tero.kristo@nokia.com>

Nishanth Menon <nm@ti.com> writes:

> From: Deepak K <deepak.k@ti.com>
>
> Original patch:
> http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=42d4a342c009bd9727c100abc8a4bc3063c22f0c
>
> Errata i202 (OMAP3430 - 1.12, OMAP3630 - 1.6):

This workaround is currently done for all OMAPs.  

Presumably, this errata will eventually be fixed.  So, as with other
errata fixes, we need some sort of SoC-rev based flag and the errata
workaround done based on that flag.

Also, shouldn't there be a fix for this in the 8250 and omap-serial
drivers too?

Kevin

> UART module MDR1 register access can cause a dummy underrun
> condition which could result in a freeze in the case of IrDA
> communication or if used as UART, corrupted data.
>
> Workaround is as follows for everytime MDR1 register is changed:
> * setup all required UART registers
> * setup MDR1.MODE_SELECT bit field
> * Wait 5 L4 clk cycles + 5 UART functional clock cycles
> * Clear the Tx and RX fifo using FCR register
>
> Note: The following step is not done as I am assuming it is not
> needed due to reconfiguration being done and there is no halted
> operation perse.
> * Read if required, the RESUME register to resume halted operation
>
> Cc: Govindraj R <govindraj.raja@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tero Kristo <tero.kristo@nokia.com>
>
> Signed-off-by: Deepak K <deepak.k@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes from V2:
>   * Use macros instead of hardcoded values
>
> Ref:
> V2: http://marc.info/?t=127084514600010&r=1&w=2&n=2
> v1: http://marc.info/?t=127074933100005&r=1&w=2
>
>  arch/arm/mach-omap2/serial.c |   41 ++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index a7c45b5..6d13183 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -185,6 +185,42 @@ static inline void __init omap_uart_reset(struct omap_uart_state *uart)
>  
>  #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
>  
> +/*
> + * Work Around for Errata i202 (3430 - 1.12, 3630 - 1.6)
> + * The access to uart register after MDR1 Access
> + * causes UART to corrupt data.
> + *
> + * Need a delay =
> + * 5 L4 clock cycles + 5 UART functional clock cycle (@48MHz = ~0.2uS)
> + * give 10 times as much
> + */
> +static void omap_uart_mdr1_errataset(struct omap_uart_state *uart, u8 mdr1_val,
> +		u8 fcr_val)
> +{
> +	struct plat_serial8250_port *p = uart->p;
> +	u8 timeout = 255;
> +
> +	serial_write_reg(p, UART_OMAP_MDR1, mdr1_val);
> +	udelay(2);
> +	serial_write_reg(p, UART_FCR, fcr_val | UART_FCR_CLEAR_XMIT |
> +			UART_FCR_CLEAR_RCVR);
> +	/*
> +	 * Wait for FIFO to empty: when empty, RX_FIFO_E bit is 0 and
> +	 * TX_FIFO_E bit is 1.
> +	 */
> +	while (UART_LSR_THRE != (serial_read_reg(p, UART_LSR) &
> +				(UART_LSR_THRE | UART_LSR_DR))) {
> +		timeout--;
> +		if (!timeout) {
> +			/* Should *never* happen. we warn and carry on */
> +			dev_crit(&uart->pdev.dev, "Errata i202: timedout %x\n",
> +				serial_read_reg(p, UART_LSR));
> +			break;
> +		}
> +		udelay(1);
> +	}
> +}
> +
>  static void omap_uart_save_context(struct omap_uart_state *uart)
>  {
>  	u16 lcr = 0;
> @@ -222,7 +258,7 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
>  
>  	uart->context_valid = 0;
>  
> -	serial_write_reg(p, UART_OMAP_MDR1, 0x7);
> +	omap_uart_mdr1_errataset(uart, 0x07, 0xA0);
>  	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
>  	efr = serial_read_reg(p, UART_EFR);
>  	serial_write_reg(p, UART_EFR, UART_EFR_ECB);
> @@ -235,14 +271,13 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
>  	serial_write_reg(p, UART_IER, uart->ier);
>  	serial_write_reg(p, UART_LCR, 0x80);
>  	serial_write_reg(p, UART_MCR, uart->mcr);
> -	serial_write_reg(p, UART_FCR, 0xA1);
>  	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
>  	serial_write_reg(p, UART_EFR, efr);
>  	serial_write_reg(p, UART_LCR, UART_LCR_WLEN8);
>  	serial_write_reg(p, UART_OMAP_SCR, uart->scr);
>  	serial_write_reg(p, UART_OMAP_WER, uart->wer);
>  	serial_write_reg(p, UART_OMAP_SYSC, uart->sysc);
> -	serial_write_reg(p, UART_OMAP_MDR1, 0x00); /* UART 16x mode */
> +	omap_uart_mdr1_errataset(uart, 0x00, 0xA1);
>  }
>  #else
>  static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
> -- 
> 1.6.3.3
