From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] OMAP UART: Adding support for omap-serial driver.
Date: Tue, 22 Sep 2009 11:03:56 -0700
Message-ID: <20090922180356.GJ14890@atomide.com>
References: <51076.192.168.10.88.1253639068.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757018AbZIVSEC@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51076.192.168.10.88.1253639068.squirrel@dbdmail.itg.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Govindraj.R <govindraj.raja@ti.com> [090922 10:06]:
> From: Govindraj R <govindraj.raja@ti.com>
> 
> This patch adds support for OMAP3430-HIGH SPEED UART Controller.

Why do you have the same subject anad description is the same for all of them?

> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1359,6 +1359,98 @@ config SERIAL_OF_PLATFORM
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
> +	 to this option.
> +

Didn't I already comment these options should be passed in platform_data
from board-*.c files?

> +config SERIAL_OMAP_UART1_RXDMA_TIMEOUT
> +	int "Timeout value for RX DMA in microseconds"
> +	depends on SERIAL_OMAP_DMA_UART1
> +	default "1"
> +	help
> +	  Set the timeout value in which you want the data pulled by RX dma to
> +	  be passed to the tty framework.
> +

This too.


> +config SERIAL_OMAP_UART1_RXDMA_BUFSIZE
> +	int "DMA buffer size for RX in bytes"
> +	depends on SERIAL_OMAP_DMA_UART1
> +	default "4096"
> +	help
> +	  Set the dma buffer size for UART Rx
> +

And this.


> +config SERIAL_OMAP_DMA_UART2
> +	bool "UART2 DMA support"
> +	depends on SERIAL_OMAP
> +	help
> +	  If you have enabled the serial port on the Texas Instruments OMAP
> +	  CPU you can enable the DMA transfer on UART 2 by answering
> +	  to this option.
> +

And this.


> +config SERIAL_OMAP_UART2_RXDMA_TIMEOUT
> +	int "Timeout value for RX DMA in microseconds"
> +	depends on SERIAL_OMAP_DMA_UART2
> +	default "1"
> +	help
> +	  Set the timeout value in which you want the data pulled by RX dma to
> +	  be passed to the tty framework.
> +

Yup this too.


> +config SERIAL_OMAP_UART2_RXDMA_BUFSIZE
> +	int "DMA buffer size for RX in bytes"
> +	depends on SERIAL_OMAP_DMA_UART2
> +	default "4096"
> +	help
> +	  Set the dma buffer size for UART Rx
> +

And this.

> +config SERIAL_OMAP_DMA_UART3
> +	bool "UART3 DMA support"
> +	depends on SERIAL_OMAP
> +	help
> +	  If you have enabled the serial port on the Texas Instruments OMAP
> +	  CPU you can enable the DMA transfer on UART 3 by answering
> +	  to this option.
> +

And this.

> +config SERIAL_OMAP_UART3_RXDMA_TIMEOUT
> +	int "Timeout value for RX DMA in microseconds"
> +	depends on SERIAL_OMAP_DMA_UART3
> +	default "1"
> +	help
> +	  Set the timeout value in which you want the data pulled by RX dma to
> +	  be passed to the tty framework.
> +

Ditto.

> +config SERIAL_OMAP_UART3_RXDMA_BUFSIZE
> +	int "DMA buffer size for RX in bytes"
> +	depends on SERIAL_OMAP_DMA_UART3
> +	default "4096"
> +	help
> +	  Set the dma buffer size for UART Rx
> +

Ditto.
