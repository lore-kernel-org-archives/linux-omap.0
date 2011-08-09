From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH 11/13] ARM: gpio: consolidate trivial gpiolib
 implementations
Date: Tue, 9 Aug 2011 12:02:40 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F388389375__29424.7603895657$1312909380$gmane$org@AUSP01VMBX24.collaborationhost.net>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
 <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail132.messagelabs.com ([216.82.242.115]:38894 "EHLO
	mail132.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab1HIRCu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 13:02:50 -0400
In-Reply-To: <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel>
Cc: Grant Likely <grant.likely@secretlab.ca>, Nicolas Pitre <nico@fluxnic.net>

On Tuesday, August 09, 2011 1:08 AM, Russell King wrote:
>
> Consolidate 24 trivial gpiolib implementions out of mach/gpio.h
> into asm/gpio.h.  This is basically the include of asm-generic/gpio.h
> and the definition of gpio_get_value, gpio_set_value, and gpio_cansleep
> as described in Documentation/gpio.txt
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/gpio.h                 |   10 ++++++++++
>  arch/arm/mach-ep93xx/include/mach/gpio.h    |    7 +------
>
> diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
> index 166a7a3..15e8970 100644
> --- a/arch/arm/include/asm/gpio.h
> +++ b/arch/arm/include/asm/gpio.h
> @@ -4,4 +4,14 @@
>  /* not all ARM platforms necessarily support this API ... */
>  #include <mach/gpio.h>
>  
> +#ifdef __ARM_GPIOLIB_TRIVIAL
> +/* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio.h */
> +#include <asm-generic/gpio.h>
> +
> +/* The trivial gpiolib dispatchers */
> +#define gpio_get_value  __gpio_get_value
> +#define gpio_set_value  __gpio_set_value
> +#define gpio_cansleep   __gpio_cansleep
> +#endif
> +
>  #endif /* _ARCH_ARM_GPIO_H */
> diff --git a/arch/arm/mach-ep93xx/include/mach/gpio.h b/arch/arm/mach-ep93xx/include/mach/gpio.h
> index c57152c..fbc770e 100644
> --- a/arch/arm/mach-ep93xx/include/mach/gpio.h
> +++ b/arch/arm/mach-ep93xx/include/mach/gpio.h
> @@ -100,12 +100,7 @@
>  #define EP93XX_GPIO_LINE_MAX_IRQ	EP93XX_GPIO_LINE_F(7)
>  
>  /* new generic GPIO API - see Documentation/gpio.txt */
> -
> -#include <asm-generic/gpio.h>
> -
> -#define gpio_get_value	__gpio_get_value
> -#define gpio_set_value	__gpio_set_value
> -#define gpio_cansleep	__gpio_cansleep
> +#define __ARM_GPIOLIB_TRIVIAL
>  
>  /*
>   * Map GPIO A0..A7  (0..7)  to irq 64..71,

For ep93xx:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks!
