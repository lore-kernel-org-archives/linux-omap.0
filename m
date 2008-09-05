From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] input: touchscreen: Fix typo on Kconfig
Date: Fri, 5 Sep 2008 09:39:13 -0700
Message-ID: <20080905163913.GE24202@atomide.com>
References: <1220219817-22651-1-git-send-email-me@felipebalbi.com> <1220219817-22651-2-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57739 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbYIEQjO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 12:39:14 -0400
Content-Disposition: inline
In-Reply-To: <1220219817-22651-2-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

* Felipe Balbi <me@felipebalbi.com> [080831 14:57]:
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/input/touchscreen/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index f32361f..98e37fc 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -220,7 +220,7 @@ config TOUCHSCREEN_ATMEL_TSADCC
>  config TOUCHSCREEN_TSC2005
>  	tristate "TSC2005 touchscreen support"
>  	help
> -	  Say Y here for if you are using the touchscreen features of TSC2301.
> +	  Say Y here for if you are using the touchscreen features of TSC2005.
>  
>  config TOUCHSCREEN_TSC2102
>  	tristate "TSC 2102 based touchscreens"
> -- 

Pushing this too.

Tony
