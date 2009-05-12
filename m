From: "vimal singh" <vimalsingh@ti.com>
Subject: Re: [PATCH 2/2][RFC] OMAP4: UART4 Support for OMAP_4430SDP.
Date: Tue, 12 May 2009 12:10:40 +0530 (IST)
Message-ID: <34881.192.168.10.89.1242110440.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36863 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbZELGk7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 02:40:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Syed Rafiuddin <rafiuddin.syed@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



On Tue, May 12, 2009 at 11:50 AM, Syed Rafiuddin <rafiuddin.syed@ti.com> wrote:
> This patch enables support for UART4 on OMAP4430 development platform.
>
> Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> ---
> arch/arm/mach-omap2/board-4430sdp.c |    2 +-
>  arch/arm/mach-omap2/serial.c        |   12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> Index: linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/board-4430sdp.c  2009-05-12
> 10:43:41.000000000 +0530
> +++ linux-2.6/arch/arm/mach-omap2/board-4430sdp.c       2009-05-12
11:40:54.000000000
> +0530
This patch has lines wrapped here. Please correct this and re-send the patch.

> @@ -38,7 +38,7 @@
>  };
>
>  static struct omap_uart_config sdp4430_uart_config __initdata = {
> -       .enabled_uarts  = ((1 << 0) | (1 << 1) | (1 << 2)),
> +       .enabled_uarts  = ((1 << 0) | (1 << 1) | (1 << 2) | (1 << 3)),
>  };
>
>  static struct omap_lcd_config sdp4430_lcd_config __initdata = {
> Index: linux-2.6/arch/arm/mach-omap2/serial.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/serial.c 2009-05-12 11:35:55.000000000
> +0530
> +++ linux-2.6/arch/arm/mach-omap2/serial.c      2009-05-12 11:46:13.000000000
+0530

Ditto...

> @@ -53,8 +53,20 @@
>                .iotype         = UPIO_MEM,
>                .regshift       = 2,
>                .uartclk        = OMAP24XX_BASE_BAUD * 16,
> +
> +       }, {
> +#ifdef CONFIG_ARCH_OMAP4
> +               .membase        = IO_ADDRESS(OMAP_UART3_BASE),
> +               .mapbase        = OMAP_UART4_BASE,
> +               .irq            = 70,
> +               .flags          = UPF_BOOT_AUTOCONF,
> +               .iotype         = UPIO_MEM,
> +               .regshift       = 2,
> +               .uartclk        = OMAP24XX_BASE_BAUD * 16,
>        }, {
> +#else
>                .flags          = 0
> +#endif
>        }
>  };
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>




---
Regards,
\/ | |\/| /-\ |_


