From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/9] tty/serial/omap: console can only be built-in
Date: Fri, 23 Mar 2012 11:33:39 -0700
Message-ID: <20120323183339.GH9859@atomide.com>
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
 <1332522836-29517-6-git-send-email-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1332522836-29517-6-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

* mathieu.poirier@linaro.org <mathieu.poirier@linaro.org> [120323 10:16]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When the omap serial driver is built as a module, we must
> not allow the console driver to be selected, because consoles
> can not be loadable modules.

Looks valid to me, this should get posted and merged via
linux-serial@vger.kernel.org.

Tony

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Acked-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  drivers/tty/serial/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 2de9924..bcf7e24 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1041,7 +1041,7 @@ config SERIAL_OMAP
>  
>  config SERIAL_OMAP_CONSOLE
>  	bool "Console on OMAP serial port"
> -	depends on SERIAL_OMAP
> +	depends on SERIAL_OMAP=y
>  	select SERIAL_CORE_CONSOLE
>  	help
>  	  Select this option if you would like to use omap serial port as
> -- 
> 1.7.5.4
> 
