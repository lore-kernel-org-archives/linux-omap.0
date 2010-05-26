From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] serial: Add OMAP high-speed UART driver
Date: Wed, 26 May 2010 15:48:58 -0700
Message-ID: <87wruqmg85.fsf@deeprootsystems.com>
References: <58269.192.168.10.88.1274708590.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <58269.192.168.10.88.1274708590.squirrel@dbdmail.itg.ti.com> (Govindraj R.'s message of "Mon\, 24 May 2010 19\:13\:10 +0530 \(IST\)")
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> This patch adds driver support for OMAP3/4 high speed UART.
>
> The driver is made separate from 8250 driver as we cannot
> over load 8250 driver with omap platform specific configuration for
> features like DMA, it makes easier to implement features like DMA and
> hardware flow control and software flow control configuration with
> this driver as required for the omap-platform.This patch involves only
> the core driver and its dependent.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Tested-by: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
> Platform data support for this driver is currently
> present in Kevin's PM tree remotes/origin/pm-wip/uart branch
> This branch contains uart-hwmod platform conversion which
> utilizes the omap-hwmod framework. Tested using OMAP
> 3430/3630/4430SDP boards.
>
>  arch/arm/plat-omap/include/plat/omap-serial.h |  129 +++
>  drivers/serial/Kconfig                        |   27 +
>  drivers/serial/Makefile                       |    1 +
>  drivers/serial/omap-serial.c                  | 1318 +++++++++++++++++++++++++
>  include/linux/serial_core.h                   |    3 +
>  5 files changed, 1478 insertions(+), 0 deletions(-)

[...]

> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index f55c494..4346bfa 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1387,6 +1387,33 @@ config SERIAL_OF_PLATFORM
>  	  Currently, only 8250 compatible ports are supported, but
>  	  others can easily be added.
>
> +config SERIAL_OMAP
> +	tristate "OMAP serial port support"
> +	depends on ARCH_OMAP3 || ARCH_OMAP4

FYI... this also works on OMAP2.  

I tested it on my n810 along with UART hwmod conversion and it works
just fine there.

Kevin
