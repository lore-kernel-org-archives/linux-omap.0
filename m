From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv1 1/3] OMAP UART: Adds omap-serial driver support.
Date: Wed, 7 Oct 2009 14:51:17 -0700
Message-ID: <20091007215116.GB29320@atomide.com>
References: <65168.192.168.10.89.1253788033.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754525AbZJGVwG@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <65168.192.168.10.89.1253788033.squirrel@dbdmail.itg.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Govindraj.R <govindraj.raja@ti.com> [090924 03:29]:
> From: Govindraj R <govindraj.raja@ti.com>
> 
> This patch adds support for OMAP3430-HIGH SPEED UART Controller.
> 
> Signed-off-by:	Govindraj R <govindraj.raja@ti.com>
> Reviewed-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Reviewed-by: Tony Lindgren <tony@atomide.com>

You should only add Reviewed-by if Alan or me have replied with it.

So far I've only replied with some comments that have not yet
been fixed, so we're few more steps from being Reviewd-by.

<snip>

> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 6553833..67a7129 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1359,6 +1359,53 @@ config SERIAL_OF_PLATFORM
>  	  Currently, only 8250 compatible ports are supported, but
>  	  others can easily be added.
> 
> +config SERIAL_OMAP
> +	bool "OMAP serial port support"
> +	depends on ARM && ARCH_OMAP
> +	select SERIAL_CORE
> +	help
> +	If you have a machine based on an Texas Instruments OMAP CPU you
> +	can enable its onboard serial ports by enabling this option.
> +
> +config SERIAL_OMAP_CONSOLE
> +	bool "Console on OMAP serial port"
> +	depends on SERIAL_OMAP
> +	select SERIAL_CORE_CONSOLE
> +	help
> +	If you have enabled the serial port on the Texas Instruments OMAP
> +	CPU you can make it the console by answering Y to this option.
> +
> +	Even if you say Y here, the currently visible virtual console
> +	(/dev/tty0) will still be used as the system console by default, but
> +	you can alter that using a kernel command line option such as
> +	"console=ttyS0". (Try "man bootparam" or see the documentation of
> +	your boot loader (lilo or loadlin) about how to pass options to the
> +	kernel at boot time.)
> +
> +config SERIAL_OMAP_DMA_UART1
> +	bool "UART1 DMA support"
> +	depends on SERIAL_OMAP
> +	help
> +	If you have enabled the serial port on the Texas Instruments OMAP
> +	CPU you can enable the DMA transfer on UART 1 by answering
> +	to this option.
> +
> +config SERIAL_OMAP_DMA_UART2
> +	bool "UART2 DMA support"
> +	depends on SERIAL_OMAP
> +	help
> +	If you have enabled the serial port on the Texas Instruments OMAP
> +	CPU you can enable the DMA transfer on UART 2 by answering
> +	to this option.
> +
> +config SERIAL_OMAP_DMA_UART3
> +	bool "UART3 DMA support"
> +	depends on SERIAL_OMAP
> +	help
> +	If you have enabled the serial port on the Texas Instruments OMAP
> +	CPU you can enable the DMA transfer on UART 3 by answering
> +	to this option.
> +
>  config SERIAL_OF_PLATFORM_NWPSERIAL
>  	tristate "NWP serial port driver"
>  	depends on PPC_OF && PPC_DCR

There's absolutely no need for having Kconfig options for the DMA
support. Please pass that in platform_data from the board-*.c files.

This is the third time I'm commenting on the same issue!

What's the point of posting these patches for review if the issues
don't get solved?

Regards,

Tony
