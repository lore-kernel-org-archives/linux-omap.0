From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] i2c: change twl4030-usb back to subsys_initcall
Date: Mon, 6 Oct 2008 09:41:31 +0300
Message-ID: <20081006064130.GD14042@atomide.com>
References: <200810030136.33838.david-b@pacbell.net> <1223027154-20385-1-git-send-email-felipe.balbi@nokia.com> <20081003235001.GH10743@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49965 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbYJFGig (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 02:38:36 -0400
Content-Disposition: inline
In-Reply-To: <20081003235001.GH10743@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [081004 02:50]:
> without it, otg_get/set_transceiver won't be useful and
> twl4030-usb transceiver won't get to musb code.

Pushed to l-o tree.

Tony

> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/i2c/chips/twl4030-usb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
> index 133cc0f..922d7d6 100644
> --- a/drivers/i2c/chips/twl4030-usb.c
> +++ b/drivers/i2c/chips/twl4030-usb.c
> @@ -774,7 +774,7 @@ static int __init twl4030_usb_init(void)
>  {
>  	return platform_driver_register(&twl4030_driver);
>  }
> -module_init(twl4030_usb_init);
> +subsys_initcall(twl4030_usb_init);
>  
>  static void __exit twl4030_usb_exit(void)
>  {
> -- 
> 1.6.0.2.307.gc427
> 
> -- 
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
