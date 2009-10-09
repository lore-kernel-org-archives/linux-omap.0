From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] [RFC] OMAP: eliminate OMAP_MAX_NR_PORTS
Date: Fri, 09 Oct 2009 09:38:33 -0700
Message-ID: <87ljjkwmie.fsf@deeprootsystems.com>
References: <1254995997-26420-1-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:51205 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758241AbZJIQjs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 12:39:48 -0400
Received: by pxi9 with SMTP id 9so6869644pxi.4
        for <linux-omap@vger.kernel.org>; Fri, 09 Oct 2009 09:38:36 -0700 (PDT)
In-Reply-To: <1254995997-26420-1-git-send-email-virtuoso@slind.org> (virtuoso@slind.org's message of "Thu\,  8 Oct 2009 12\:59\:57 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: virtuoso@slind.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

virtuoso@slind.org writes:

> From: Alexander Shishkin <virtuoso@slind.org>
>
> Signed-off-by: Alexander Shishkin <virtuoso@slind.org>

Looks like a good cleanup to me.

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
>  arch/arm/mach-omap1/serial.c             |    2 +-
>  arch/arm/mach-omap2/serial.c             |    6 +++---
>  arch/arm/plat-omap/include/mach/serial.h |    4 ----
>  3 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
> index ed07af1..a86de7c 100644
> --- a/arch/arm/mach-omap1/serial.c
> +++ b/arch/arm/mach-omap1/serial.c
> @@ -123,7 +123,7 @@ void __init omap_serial_init(void)
>  		serial_platform_data[2].uartclk = OMAP1510_BASE_BAUD * 16;
>  	}
>  
> -	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
> +	for (i = 0; i < ARRAY_SIZE(serial_platform_data); i++) {
>  		unsigned char reg;
>  
>  		switch (i) {
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index ae21868..c5bef44 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -549,7 +549,7 @@ static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
>  #define DEV_CREATE_FILE(dev, attr)
>  #endif /* CONFIG_PM */
>  
> -static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS] = {
> +static struct omap_uart_state omap_uart[] = {
>  	{
>  		.pdev = {
>  			.name			= "serial8250",
> @@ -599,7 +599,7 @@ void __init omap_serial_early_init(void)
>  	 * if not needed.
>  	 */
>  
> -	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
> +	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
>  		struct omap_uart_state *uart = &omap_uart[i];
>  		struct platform_device *pdev = &uart->pdev;
>  		struct device *dev = &pdev->dev;
> @@ -641,7 +641,7 @@ void __init omap_serial_init(void)
>  {
>  	int i;
>  
> -	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
> +	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
>  		struct omap_uart_state *uart = &omap_uart[i];
>  		struct platform_device *pdev = &uart->pdev;
>  		struct device *dev = &pdev->dev;
> diff --git a/arch/arm/plat-omap/include/mach/serial.h b/arch/arm/plat-omap/include/mach/serial.h
> index e249186..9951345 100644
> --- a/arch/arm/plat-omap/include/mach/serial.h
> +++ b/arch/arm/plat-omap/include/mach/serial.h
> @@ -20,26 +20,22 @@
>  #define OMAP_UART1_BASE		0xfffb0000
>  #define OMAP_UART2_BASE		0xfffb0800
>  #define OMAP_UART3_BASE		0xfffb9800
> -#define OMAP_MAX_NR_PORTS	3
>  #elif defined(CONFIG_ARCH_OMAP2)
>  /* OMAP2 serial ports */
>  #define OMAP_UART1_BASE		0x4806a000
>  #define OMAP_UART2_BASE		0x4806c000
>  #define OMAP_UART3_BASE		0x4806e000
> -#define OMAP_MAX_NR_PORTS	3
>  #elif defined(CONFIG_ARCH_OMAP3)
>  /* OMAP3 serial ports */
>  #define OMAP_UART1_BASE		0x4806a000
>  #define OMAP_UART2_BASE		0x4806c000
>  #define OMAP_UART3_BASE		0x49020000
> -#define OMAP_MAX_NR_PORTS	3
>  #elif defined(CONFIG_ARCH_OMAP4)
>  /* OMAP4 serial ports */
>  #define OMAP_UART1_BASE		0x4806a000
>  #define OMAP_UART2_BASE		0x4806c000
>  #define OMAP_UART3_BASE		0x48020000
>  #define OMAP_UART4_BASE		0x4806e000
> -#define OMAP_MAX_NR_PORTS	4
>  #endif
>  
>  #define OMAP1510_BASE_BAUD	(12000000/16)
> -- 
> 1.6.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
