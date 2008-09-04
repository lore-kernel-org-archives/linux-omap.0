From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/12] serial context save/restore
Date: Thu, 04 Sep 2008 11:52:47 +0300
Message-ID: <873akg2syo.fsf@deeprootsystems.com>
References: <59386.192.168.10.89.1220276247.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:7013 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbYIDIw6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 04:52:58 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3182636wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 04 Sep 2008 01:52:57 -0700 (PDT)
In-Reply-To: <59386.192.168.10.89.1220276247.squirrel@dbdmail.itg.ti.com> (Rajendra Nayak's message of "Mon\, 1 Sep 2008 19\:07\:27 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"Rajendra Nayak" <rnayak@ti.com> writes:

> This patch adds the context save restore functions for UART
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c             |   55 +++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/serial.h |   13 ++++++-
>  include/linux/serial_reg.h               |    1
>  3 files changed, 68 insertions(+), 1 deletion(-)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/serial.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/serial.c	2008-09-01
> 18:11:33.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/serial.c	2008-09-01 18:11:50.000000000
> +0530
> @@ -290,6 +290,61 @@ void __init omap_serial_init(void)
>  	omap_serial_kick();
>  }
>
> +#ifdef CONFIG_ARCH_OMAP3
> +static struct omap3_uart_regs uart_ctx[OMAP_MAX_NR_PORTS];
> +void omap3_save_uart_ctx(int unum)
> +{
> +	u16 lcr = 0;
> +
> +	struct plat_serial8250_port *p = serial_platform_data + unum;
> +
> +	if (uart_ick[unum] == NULL)
> +		return;
> +
> +	lcr = serial_read_reg(p, UART_LCR);
> +	serial_write_reg(p, UART_LCR, 0xBF);
> +	uart_ctx[unum].dll = serial_read_reg(p, UART_DLL);
> +	uart_ctx[unum].dlh = serial_read_reg(p, UART_DLM);
> +	serial_write_reg(p, UART_LCR, lcr);
> +	uart_ctx[unum].ier = serial_read_reg(p, UART_IER);
> +	uart_ctx[unum].sysc = serial_read_reg(p, UART_OMAP_SYSC);
> +	uart_ctx[unum].scr = serial_read_reg(p, UART_OMAP_SCR);
> +	uart_ctx[unum].wer = serial_read_reg(p, UART_OMAP_WER);
> +}
> +EXPORT_SYMBOL(omap3_save_uart_ctx);
> +
> +void omap3_restore_uart_ctx(int unum)
> +{
> +	u16 efr = 0;
> +
> +	struct plat_serial8250_port *p = serial_platform_data + unum;
> +
> +	if (uart_ick[unum] == NULL)
> +		return;
> +
> +	serial_write_reg(p, UART_OMAP_MDR1, 0x7);
> +	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
> +	efr = serial_read_reg(p, UART_EFR);
> +	serial_write_reg(p, UART_EFR, UART_EFR_ECB);
> +	serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
> +	serial_write_reg(p, UART_IER, 0x0);
> +	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
> +	serial_write_reg(p, UART_DLL, uart_ctx[unum].dll);
> +	serial_write_reg(p, UART_DLM, uart_ctx[unum].dlh);
> +	serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
> +	serial_write_reg(p, UART_IER, uart_ctx[unum].ier);
> +	serial_write_reg(p, UART_FCR, 0xA1);
> +	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
> +	serial_write_reg(p, UART_EFR, efr);
> +	serial_write_reg(p, UART_LCR, UART_LCR_WLEN8);
> +	serial_write_reg(p, UART_OMAP_SCR, uart_ctx[unum].scr);
> +	serial_write_reg(p, UART_OMAP_WER, uart_ctx[unum].wer);
> +	serial_write_reg(p, UART_OMAP_SYSC, uart_ctx[unum].sysc);
> +	serial_write_reg(p, UART_OMAP_MDR1, 0x00); /* UART 16x mode */
> +}
> +EXPORT_SYMBOL(omap3_restore_uart_ctx);
> +#endif /* CONFIG_ARCH_OMAP3 */
> +
>  static struct platform_device serial_device = {
>  	.name			= "serial8250",
>  	.id			= PLAT8250_DEV_PLATFORM,
> Index: linux-omap-2.6/include/linux/serial_reg.h
> ===================================================================
> --- linux-omap-2.6.orig/include/linux/serial_reg.h	2008-09-01
> 18:11:29.000000000 +0530
> +++ linux-omap-2.6/include/linux/serial_reg.h	2008-09-01 18:11:50.000000000 +0530
> @@ -323,6 +323,7 @@
>  #define UART_OMAP_MVER		0x14	/* Module version register */
>  #define UART_OMAP_SYSC		0x15	/* System configuration register */
>  #define UART_OMAP_SYSS		0x16	/* System status register */
> +#define UART_OMAP_WER           0x17    /* Wake-up enable register */

This was added with spaces instead of tabs.


>  #endif /* _LINUX_SERIAL_REG_H */
>
> Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/serial.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/serial.h	2008-09-01
> 18:11:29.000000000 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/serial.h	2008-09-01
> 18:11:50.000000000 +0530
> @@ -39,5 +39,16 @@
>  				__ret = 1;			\
>  			__ret;					\
>  			})
> -
> +#ifndef __ASSEMBLY__
> +struct omap3_uart_regs {
> +	u16 dll;
> +	u16 dlh;
> +	u16 ier;
> +	u16 sysc;
> +	u16 scr;
> +	u16 wer;
> +};
> +extern void omap3_save_uart_ctx(int unum);
> +extern void omap3_restore_uart_ctx(int unum);
> +#endif /* __ASSEMBLY__ */
>  #endif
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
