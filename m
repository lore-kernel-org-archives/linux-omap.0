From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] omap: serial: fix non-empty uart fifo read abort
Date: Fri, 4 Dec 2009 11:04:00 -0800
Message-ID: <20091204190400.GF24013@atomide.com>
References: <1259882986-11009-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56740 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755616AbZLDTD6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Dec 2009 14:03:58 -0500
Content-Disposition: inline
In-Reply-To: <1259882986-11009-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>

* Vikram Pandita <vikram.pandita@ti.com> [091203 15:27]:
> OMAP3xxx and OMAP4430 UART IP blocks have a restriction wrt RX FIFO.
> Empty RX fifo read causes an abort.
> 
> OMAP3xxx:
> 	UART IP revision >= 0x52 have this issue
> 	MVR register format is:
> 	Bits  Field Name  Description  				Type  Reset
> 	31:8   RESERVED 					RO  	0x0
> 	7:4    MAJOR  	Major revision number of the module.  	RO  	0x--  
> 	3:0    MINOR  	Minor revision number of the module.  	RO  	0x--
> 
> OMAP4xxx: 
> 	All revisions have this issue
> 	Revision id check is not used as the format of MVR resigster has changed
> 	For omap4 MVR register reads as: 0x50410602 => Revision id = 0x0602
> 	Format of MVR register on omap4 is: (Courtesy: Cousson, Benoit)
> 	Bits  Field Name  Description  				Type  Reset
> 	31:30 SCHEME  	Scheme revision number of module  	RO  	0x1
> 	29:28 RESERVED   					RO  	0x1  
> 	27:16 FUNC  	Function revision number of module  	RO  	0x041  
> 	15:11 RTL  		Rtl revision number of module  	RO  	0x00  
> 	10:8  MAJOR 	Major revision number of the module.  	RO  	0x6  
> 	7:6   CUSTOM  	Custom revision number of the module.  	RO  	0x0  
> 	5:0   MINOR  	Minor revision number of the module.  	RO  	0x02
> 
> Override the default 8250 read handler: mem_serial_in()
> by a custom handler: serial_in_8250()
> which makes sure that RX fifo is not read when empty
> 
> tested on zoom3(3630) board
> 
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
> History of Patch:
> V1:
> 	http://patchwork.kernel.org/patch/61671/
> 	http://patchwork.kernel.org/patch/61672/
> 
> V2: Incorporate approach suggested by Tony L
> 	Introduce IP version check in mach-omap2/serial.c file	
> 
>  arch/arm/mach-omap2/serial.c |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 2e17b57..bd646a2 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -33,6 +33,7 @@
>  #include "pm.h"
>  #include "prm-regbits-34xx.h"
>  
> +#define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
>  #define UART_OMAP_WER		0x17	/* Wake-up enable register */
>  
>  #define DEFAULT_TIMEOUT (5 * HZ)
> @@ -572,6 +573,23 @@ static struct omap_uart_state omap_uart[] = {
>  #endif
>  };
>  
> +/*
> + * Override the default 8250 read handler: mem_serial_in()
> + * Empty RX fifo read causes an abort on omap3630 and omap4
> + * This function makes sure that an empty rx fifo is not read on these silicons
> + * (OMAP1/2/3 are not affected)
> + */
> +static unsigned int serial_in_override(struct uart_port *up, int offset)
> +{
> +	if (UART_RX == offset) {
> +		unsigned int lsr;
> +		lsr = serial_read_reg(omap_uart[up->line].p, UART_LSR);
> +		if (!(lsr & UART_LSR_DR))
> +			return -EPERM;
> +	}
> +	return serial_read_reg(omap_uart[up->line].p, offset);
> +}
> +
>  void __init omap_serial_early_init(void)
>  {
>  	int i;
> @@ -650,5 +668,16 @@ void __init omap_serial_init(void)
>  			device_init_wakeup(dev, true);
>  			DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
>  		}
> +
> +#ifdef CONFIG_ARCH_OMAP4
> +		/* Never read empty UART fifo on omap4 */
> +		p->serial_in = serial_in_override;
> +#else
> +		/* OMAP2/3 */
> +		/* Never read empty UART fifo on UARTs with IP rev >=0x52 */
> +		if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
> +				>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
> +			uart->p->serial_in = serial_in_override;
> +#endif
>  	}
>  }

We need to avoid ifdef else stuff, that just causes problems compiling
in support for many omaps. In theory, we should be able to compile in
support for all omaps starting with 16xx with v5 options..

Using cpu_is_omapxxxx() should do the trick here.

Tony
