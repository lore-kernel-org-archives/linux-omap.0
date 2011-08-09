From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH 13/13] ARM: gpio: make trivial GPIOLIB implementation
 the	default
Date: Tue, 9 Aug 2011 12:04:30 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F388389379__16011.1344223425$1312909485$gmane$org@AUSP01VMBX24.collaborationhost.net>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
 <E1QqhMg-0003an-GW@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail160.messagelabs.com ([216.82.253.99]:15966 "EHLO
	mail160.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011Ab1HIREf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 13:04:35 -0400
In-Reply-To: <E1QqhMg-0003an-GW@rmk-PC.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel>
Cc: Grant Likely <grant.likely@secretlab.ca>, Nicolas Pitre <nico@fluxnic.net>

On Tuesday, August 09, 2011 1:09 AM, Russell King wrote:
>
> Rather than marking the mach/gpio.h header files which want to use the
> trivial GPIOLIB implementation, mark those which do not want to use it
> instead.  This means that by default, you get the trivial implementation
> and only have to do something extra if you need to.  This should
> encourage the use of the trivial default implementation.
> 
> As an additional bonus, several gpio.h header files become empty.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/gpio.h                 |    2 +-
>  arch/arm/include/asm/hardware/iop3xx-gpio.h |    2 ++
> 
> diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
> index 5032224..11ad0bf 100644
> --- a/arch/arm/include/asm/gpio.h
> +++ b/arch/arm/include/asm/gpio.h
> @@ -4,7 +4,7 @@
>  /* not all ARM platforms necessarily support this API ... */
>  #include <mach/gpio.h>
>  
> -#ifdef __ARM_GPIOLIB_TRIVIAL
> +#ifndef __ARM_GPIOLIB_COMPLEX
>  /* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio.h */
>  #include <asm-generic/gpio.h>
>  
> diff --git a/arch/arm/mach-ep93xx/include/mach/gpio.h b/arch/arm/mach-ep93xx/include/mach/gpio.h
> index fbc770e..071f676 100644
> --- a/arch/arm/mach-ep93xx/include/mach/gpio.h
> +++ b/arch/arm/mach-ep93xx/include/mach/gpio.h
> @@ -99,9 +99,6 @@
>  /* maximum value for irq capable line identifiers */
>  #define EP93XX_GPIO_LINE_MAX_IRQ	EP93XX_GPIO_LINE_F(7)
>  
> -/* new generic GPIO API - see Documentation/gpio.txt */
> -#define __ARM_GPIOLIB_TRIVIAL
> -
>  /*
>   * Map GPIO A0..A7  (0..7)  to irq 64..71,
>   *          B0..B7  (7..15) to irq 72..79, and

For ep93xx:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks!
