From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Fix double-linking of drivers/usb/otg when ULPI is
 selected
Date: Fri, 18 Dec 2009 18:44:53 +0200
Message-ID: <1261154693.3430.0.camel@gandalf>
References: <1261151842-577-1-git-send-email-bgat@billgatliff.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60938 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846AbZLRQo5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 11:44:57 -0500
In-Reply-To: <1261151842-577-1-git-send-email-bgat@billgatliff.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, beagleboard@googlegroups.com, daniel@caiaq.de

On Fri, 2009-12-18 at 09:57 -0600, Bill Gatliff wrote:
> This patch corrects a problem where drivers/usb/otg is linked twice
> if CONFIG_USB_ULPI is selected, resulting in a build error (symbol
> conflict). The files in that directory are properly linked already
> as part of CONFIG_USB, and need not be indicated specifically for
> CONFIG_USB_ULPI.
> 
> Signed-off-by: Bill Gatliff <bgat@billgatliff.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

drivers/usb/otg is linked when CONFIG_USB_OTG_UTILS is set.

> ---
>  drivers/usb/Makefile |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
> index 473aa1a..be3c9b8 100644
> --- a/drivers/usb/Makefile
> +++ b/drivers/usb/Makefile
> @@ -44,5 +44,3 @@ obj-y				+= early/
>  
>  obj-$(CONFIG_USB_ATM)		+= atm/
>  obj-$(CONFIG_USB_SPEEDTOUCH)	+= atm/
> -
> -obj-$(CONFIG_USB_ULPI)		+= otg/

-- 
balbi

