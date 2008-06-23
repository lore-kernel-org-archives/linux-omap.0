From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] i2c: allow twl modules to be built as modules
Date: Mon, 23 Jun 2008 14:11:17 +0300
Message-ID: <20080623111116.GO7741@atomide.com>
References: <1213351443-3336-1-git-send-email-felipe.balbi@nokia.com> <1213351443-3336-2-git-send-email-felipe.balbi@nokia.com> <1213351443-3336-3-git-send-email-felipe.balbi@nokia.com> <1213351443-3336-4-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [63.208.196.179] ([63.208.196.179]:63901 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752227AbYFWLKv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jun 2008 07:10:51 -0400
Content-Disposition: inline
In-Reply-To: <1213351443-3336-4-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080613 13:05]:
> Besides twl core and twl gpio, all the others can
> be dynamically linked.

Pushing today.

Tony

> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/i2c/chips/Kconfig |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
> index cba8abf..b421727 100644
> --- a/drivers/i2c/chips/Kconfig
> +++ b/drivers/i2c/chips/Kconfig
> @@ -150,7 +150,7 @@ config TWL4030_MADC
>  	  called twl4030-madc.ko
>  
>  config TWL4030_USB
> -	bool "TWL4030 USB Transceiver Driver"
> +	tristate "TWL4030 USB Transceiver Driver"
>  	depends on TWL4030_CORE
>  
>  choice
> @@ -170,11 +170,11 @@ config TWL4030_USB_HS_ULPI
>  endchoice
>  
>  config TWL4030_PWRBUTTON
> -	bool "TWL4030 Power button Driver"
> +	tristate "TWL4030 Power button Driver"
>  	depends on TWL4030_CORE
>  
>  config TWL4030_POWEROFF
> -	bool "TWL4030 device poweroff"
> +	tristate "TWL4030 device poweroff"
>  	depends on TWL4030_CORE
>  
>  config SENSORS_MAX6875
> -- 
> 1.5.6.rc1
> 
