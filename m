From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] usb: musb: add MODULE_ALIAS for udev module loading
Date: Mon, 23 Jun 2008 14:11:04 +0300
Message-ID: <20080623111103.GN7741@atomide.com>
References: <1213351443-3336-1-git-send-email-felipe.balbi@nokia.com> <1213351443-3336-2-git-send-email-felipe.balbi@nokia.com> <1213351443-3336-3-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [63.208.196.178] ([63.208.196.178]:52487 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751695AbYFWLKi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jun 2008 07:10:38 -0400
Content-Disposition: inline
In-Reply-To: <1213351443-3336-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080613 13:06]:
> platform drivers should add MODULE_ALIAS for allowing
> udev module loading.

Pushing today.

Tony

> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/usb/musb/musb_core.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 5b92f21..75c3013 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -134,11 +134,13 @@ MODULE_PARM_DESC(debug, "initial debug message level");
>  
>  #define DRIVER_INFO DRIVER_DESC ", v" MUSB_VERSION
>  
> -const char musb_driver_name[] = "musb_hdrc";
> +#define MUSB_DRIVER_NAME "musb_hdrc"
> +const char musb_driver_name[] = MUSB_DRIVER_NAME;
>  
>  MODULE_DESCRIPTION(DRIVER_INFO);
>  MODULE_AUTHOR(DRIVER_AUTHOR);
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" MUSB_DRIVER_NAME);
>  
>  
>  /*-------------------------------------------------------------------------*/
> -- 
> 1.5.6.rc1
> 
