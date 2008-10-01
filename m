From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 2.6.27-rc8 1/2] drivers/mfd/twl4030-core.c
Date: Wed, 1 Oct 2008 12:44:07 -0700
Message-ID: <20081001124407.aa090ccd.randy.dunlap@oracle.com>
References: <200810011144.20510.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:61596 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbYJAToe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 15:44:34 -0400
In-Reply-To: <200810011144.20510.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Samuel Ortiz <sameo@openedhand.com>, lkml <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Wed, 1 Oct 2008 11:44:19 -0700 David Brownell wrote:

>  drivers/mfd/Kconfig                |   14 
>  drivers/mfd/Makefile               |    2 
>  drivers/mfd/twl4030-core.c         | 1255 +++++++++++++++++++++++++++++++++++
>  include/linux/i2c/twl4030-gpio.h   |   76 ++
>  include/linux/i2c/twl4030-madc.h   |  134 +++
>  include/linux/i2c/twl4030-pwrirq.h |   37 +
>  include/linux/i2c/twl4030.h        |  191 +++++
>  7 files changed, 1709 insertions(+)
> 
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -50,6 +50,20 @@ config HTC_PASIC3
>  	  HTC Magician devices, respectively. Actual functionality is
>  	  handled by the leds-pasic3 and ds1wm drivers.
>  
> +config TWL4030_CORE
> +	bool "Texas Instruments TWL4030/TPS659x0 Support"
> +	depends on I2C=y && (ARCH_OMAP2 || ARCH_OMAP3)
> +	help
> +	  Say yes here if you have TWL4030 family chip on your board.
> +	  This core driver provides register access and IRQ handling
> +	  facilities, and registers devices for the various functions
> +	  so that function-specific drivers can bind to them.
> +
> +	  These multi-function chps are found on many OMAP2 and OMAP3

	                       chips

> +	  boards, providing power management, RTC, GPIO, keypad, a
> +	  high speed USB OTG transceiver, an audio codec (on most
> +	  versions) and many other features.
> +
>  config MFD_TMIO
>  	bool
>  	default n

> --- /dev/null
> +++ b/include/linux/i2c/twl4030-madc.h
> @@ -0,0 +1,134 @@
> +/*
> + * include/linux/i2c/twl4030-madc.h
> + *
> + * TWL4030 MADC module driver header
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + * Mikko Ylinen <mikko.k.ylinen@nokia.com>


> +#define TWL4030_MADC_IOC_MAGIC '`'

Add that to Documentation/ioctl-number.txt (?)

---
~Randy
