From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP3: Make I2C bus 2 configurable for
	BeagleBoard
Date: Tue, 5 Aug 2008 14:40:13 +0300
Message-ID: <20080805114010.GV7193@atomide.com>
References: <486DD383.1040800@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53564 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbYHELkQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 07:40:16 -0400
Content-Disposition: inline
In-Reply-To: <486DD383.1040800@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [080704 10:39]:
>
> I2C2 at BeagleBoard is connected to expansion connector, i.e. unused if 
> nothing is connected to this connector. As internal OMAP3 pull up
> resistors are not strong enough, enabled but unused I2C2 bus results in 
> error messages (e.g. I2C timeouts). I2C2 should be enabled only if
> something is connected to I2C2 at board's expansion connector and this  
> extension has additional pull up resistors for I2C2 bus.
>
> - Add configuration option for this
> - Use configuration option in board-omap3beagle
> - While being there, add OMAP3 to OMAP I2C help text

Pushing today to linux-omap. I guess we'll have to wait on sending
these to lm-sensors until we have board-*.c files in mainline tree.

Tony


>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
>

> 
> Subject: ARM: OMAP3: Make I2C bus 2 configurable for BeagleBoard 
> 
> From: Dirk Behme <dirk.behme@gmail.com>
> 
> I2C2 at BeagleBoard is connected to expansion connector, i.e. unused if
> nothing is connected to this connector. As internal OMAP3 pull up resistors
> are not strong enough, enabled but unused I2C2 bus results in error messages
> (e.g. I2C timeouts). I2C2 should be enabled only if something is connected to
> I2C2 at board's expansion connector and this extension has additional pull up
> resistors for I2C2 bus.
> 
> - Add configuration option for this
> - Use configuration option in board-omap3beagle
> - While being there, add OMAP3 to OMAP I2C help text
> 
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> 
> ---
> 
> Changes in v2: Incorporate Jarkko's comments. Pin mux is already done
>                depending on enabled busses in omap_i2c_mux_pins(int bus).
>                We don't have to do it manually here. Thanks!
> 
> Index: linux-beagle/arch/arm/mach-omap2/board-omap3beagle.c
> ===================================================================
> --- linux-beagle.orig/arch/arm/mach-omap2/board-omap3beagle.c
> +++ linux-beagle/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -40,7 +40,9 @@ static struct omap_uart_config omap3_bea
>  static int __init omap3_beagle_i2c_init(void)
>  {
>  	omap_register_i2c_bus(1, 2600, NULL, 0);
> +#ifdef CONFIG_I2C2_OMAP_BEAGLE
>  	omap_register_i2c_bus(2, 400, NULL, 0);
> +#endif
>  	omap_register_i2c_bus(3, 400, NULL, 0);
>  	return 0;
>  }
> Index: linux-beagle/drivers/i2c/busses/Kconfig
> ===================================================================
> --- linux-beagle.orig/drivers/i2c/busses/Kconfig
> +++ linux-beagle/drivers/i2c/busses/Kconfig
> @@ -332,10 +332,27 @@ config I2C_OMAP
>  	default y if MACH_OMAP_H3 || MACH_OMAP_OSK
>  	help
>  	  If you say yes to this option, support will be included for the
> -	  I2C interface on the Texas Instruments OMAP1/2 family of processors.
> -	  Like OMAP1510/1610/1710/5912 and OMAP242x.
> +	  I2C interface on the Texas Instruments OMAP1/2/3 family of
> +	  processors.
> +	  Like OMAP1510/1610/1710/5912, OMAP242x, OMAP34x and OMAP35x.
>  	  For details see http://www.ti.com/omap.
>  
> +config I2C2_OMAP_BEAGLE
> +	bool "Enable I2C2 for OMAP3 BeagleBoard"
> +	depends on ARCH_OMAP && MACH_OMAP3_BEAGLE
> +	select OMAP_MUX
> +	default n
> +	help
> +	  Say Y here if you want to enable I2C bus 2 at OMAP3 based
> +	  BeagleBoard.
> +	  I2C2 at BeagleBoard is connected to expansion connector, i.e. unused
> +	  if nothing is connected to this connector. As internal OMAP3 pull up
> +	  resistors are not strong enough, enabled but unused I2C2 bus results
> +	  in error messages (e.g. I2C timeouts). Enable this only if you have
> +	  something connected to I2C2 at board's expansion connector and this
> +	  extension has additional pull up resistors for I2C2 bus.
> +
> +
>  config I2C_PARPORT
>  	tristate "Parallel port adapter"
>  	depends on PARPORT

