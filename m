From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] watchdog: Convert twl4030_wdt to watchdog core
Date: Tue, 11 Sep 2012 00:59:46 +0300
Message-ID: <20120910215946.GB26184@blackmetal.musicnaut.iki.fi>
References: <1347291886-15218-1-git-send-email-jarkko.nikula@jollamobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:40822 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886Ab2IJV7u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 17:59:50 -0400
Content-Disposition: inline
In-Reply-To: <1347291886-15218-1-git-send-email-jarkko.nikula@jollamobile.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@jollamobile.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, linux-omap@vger.kernel.org

On Mon, Sep 10, 2012 at 06:44:46PM +0300, Jarkko Nikula wrote:
> Convert the twl4030_wdt watchdog driver to watchdog core.
> 
> While at there use devm_kzalloc and set the default timeout in order to be
> able test this driver with a simple shell script.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@jollamobile.com>
> ---
>  drivers/watchdog/Kconfig       |    1 +
>  drivers/watchdog/twl4030_wdt.c |  183 ++++++++--------------------------------
>  2 files changed, 35 insertions(+), 149 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 53d7571..21f6205 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -232,6 +232,7 @@ config EP93XX_WATCHDOG
>  config OMAP_WATCHDOG
>  	tristate "OMAP Watchdog"
>  	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS
> +	select WATCHDOG_CORE

This should be under TWL4030_WATCHDOG.

Otherwise the patch looks good. I briefly tested this with the converted
OMAP watchdog driver, and now both drivers can register and co-exist
happily on Nokia N9. Great!

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Thanks,

A.
