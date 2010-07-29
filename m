From: Roger Quadros <roger.quadros@nokia.com>
Subject: Re: [PATCH 5/5 v4] omap2/3/4: serial: errata i202: fix for MDR1 access
Date: Thu, 29 Jul 2010 12:07:55 +0300
Message-ID: <4C5144EB.5020501@nokia.com>
References: <1277266674-5906-1-git-send-email-nm@ti.com> <1277266674-5906-6-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31305 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638Ab0G2JHq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jul 2010 05:07:46 -0400
In-Reply-To: <1277266674-5906-6-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Deepak K <deepak.k@ti.com>, Govindraj R <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>

Hi,

On 06/23/2010 07:17 AM, ext Nishanth Menon wrote:
> From: Deepak K<deepak.k@ti.com>
>
> Original patch:
> http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=42d4a342c009bd9727c100abc8a4bc3063c22f0c
>
> Errata i202 (OMAP3430 - 1.12, OMAP3630 - 1.6):
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
> Cc: Govindraj R<govindraj.raja@ti.com>
> Cc: Kevin Hilman<khilman@deeprootsystems.com>
> Cc: Tero Kristo<tero.kristo@nokia.com>
> Cc: Tony Lindgren<tony@atomide.com>
>
> Signed-off-by: Deepak K<deepak.k@ti.com>
> Signed-off-by: Nishanth Menon<nm@ti.com>
> ---
>   arch/arm/mach-omap2/serial.c |   52 +++++++++++++++++++++++++++++++++++++++--
>   1 files changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 009b63f..566e991 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -38,6 +38,7 @@
>   #define UART_OMAP_WER		0x17	/* Wake-up enable register */
>
>   #define UART_ERRATA_FIFO_FULL_ABORT	(0x1<<  0)
> +#define UART_ERRATA_i202_MDR1_ACCESS	(0x1<<  1)
>
>   /*
>    * NOTE: By default the serial timeout is disabled as it causes lost characters
> @@ -184,6 +185,42 @@ static inline void __init omap_uart_reset(struct omap_uart_state *uart)
>
>   #if defined(CONFIG_PM)&&  defined(CONFIG_ARCH_OMAP3)
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
> +	while (UART_LSR_THRE != (serial_read_reg(p, UART_LSR)&
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
>   static void omap_uart_save_context(struct omap_uart_state *uart)
>   {
>   	u16 lcr = 0;
> @@ -221,7 +258,10 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
>
>   	uart->context_valid = 0;
>
> -	serial_write_reg(p, UART_OMAP_MDR1, 0x7);
> +	if (uart->errata&  UART_ERRATA_i202_MDR1_ACCESS)
> +		omap_uart_mdr1_errataset(uart, 0x07, 0xA0);

If errata you set both MDR1 and FCR
> +	else
> +		serial_write_reg(p, UART_OMAP_MDR1, 0x7);

If not errata you set only MDR1

>   	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
>   	efr = serial_read_reg(p, UART_EFR);
>   	serial_write_reg(p, UART_EFR, UART_EFR_ECB);
> @@ -234,14 +274,16 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
>   	serial_write_reg(p, UART_IER, uart->ier);
>   	serial_write_reg(p, UART_LCR, 0x80);
>   	serial_write_reg(p, UART_MCR, uart->mcr);
> -	serial_write_reg(p, UART_FCR, 0xA1);

If not errata, FCR is never set.

>   	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
>   	serial_write_reg(p, UART_EFR, efr);
>   	serial_write_reg(p, UART_LCR, UART_LCR_WLEN8);
>   	serial_write_reg(p, UART_OMAP_SCR, uart->scr);
>   	serial_write_reg(p, UART_OMAP_WER, uart->wer);
>   	serial_write_reg(p, UART_OMAP_SYSC, uart->sysc);
> -	serial_write_reg(p, UART_OMAP_MDR1, 0x00); /* UART 16x mode */
> +	if (uart->errata&  UART_ERRATA_i202_MDR1_ACCESS)
> +		omap_uart_mdr1_errataset(uart, 0x00, 0xA1);
> +	else
> +		serial_write_reg(p, UART_OMAP_MDR1, 0x00); /* UART 16x mode */
same here

FCR is never touched if no errata condition?
Is this going to be a problem for non erroneous devices?

>   }
>   #else
>   static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
> @@ -769,6 +811,10 @@ void __init omap_serial_init_port(int port)
>   		uart->p->serial_in = serial_in_override;
>   		uart->p->serial_out = serial_out_override;
>   	}
> +
> +	/* Enable the MDR1 errata for OMAP3 */
> +	if (cpu_is_omap34xx())
> +		uart->errata |= UART_ERRATA_i202_MDR1_ACCESS;
>   }
>
>   /**

