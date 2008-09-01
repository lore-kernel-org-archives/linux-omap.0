From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/12] serial context save/restore
Date: Mon, 1 Sep 2008 21:06:33 +0100
Message-ID: <20080901200633.GD28999@flint.arm.linux.org.uk>
References: <59386.192.168.10.89.1220276247.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46180 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbYIAUGq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 16:06:46 -0400
Content-Disposition: inline
In-Reply-To: <59386.192.168.10.89.1220276247.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, Sep 01, 2008 at 07:07:27PM +0530, Rajendra Nayak wrote:
> This patch adds the context save restore functions for UART
> --- linux-omap-2.6.orig/include/linux/serial_reg.h	2008-09-01
> 18:11:29.000000000 +0530
> +++ linux-omap-2.6/include/linux/serial_reg.h	2008-09-01 18:11:50.000000000 +0530
> @@ -323,6 +323,7 @@
>  #define UART_OMAP_MVER		0x14	/* Module version register */
>  #define UART_OMAP_SYSC		0x15	/* System configuration register */
>  #define UART_OMAP_SYSS		0x16	/* System status register */
> +#define UART_OMAP_WER           0x17    /* Wake-up enable register */

Please match the indentation style.
> 
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

There should be a blank line between the previous macro and this
ifndef.
