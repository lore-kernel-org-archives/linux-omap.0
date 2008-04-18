From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] I2C: TWL4030: Fix Kconfig
Date: Fri, 18 Apr 2008 12:02:14 -0700
Message-ID: <20080418190214.GH12099@atomide.com>
References: <1208443436-26722-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52057 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756263AbYDRTCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 15:02:16 -0400
Content-Disposition: inline
In-Reply-To: <1208443436-26722-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080417 07:46]:
> Misc cleanup patch.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/i2c/chips/Kconfig |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
> index f3ea82d..5cf4657 100644
> --- a/drivers/i2c/chips/Kconfig
> +++ b/drivers/i2c/chips/Kconfig
> @@ -160,10 +160,6 @@ choice
>  	  TWL4030 USB transceiver can operate in various
>  	  mutually-exclusive modes. Select one of them.
>  
> -config TWL4030_PWRBUTTON
> -        bool "TWL4030 Power button Driver"
> -	depends on TWL4030_CORE
> -
>  config TWL4030_USB_HS_ULPI
>  	depends on TWL4030_USB
>  	bool "High-speed ULPI"
> @@ -173,6 +169,10 @@ config TWL4030_USB_HS_ULPI
>  
>  endchoice
>  
> +config TWL4030_PWRBUTTON
> +        bool "TWL4030 Power button Driver"
> +	depends on TWL4030_CORE
> +
>  config TWL4030_POWEROFF
>  	bool "TWL4030 device poweroff"
>  	depends on TWL4030_CORE

How about fix the spaces into a tabl for bool "TWL4030 Power.." above?

Tony
