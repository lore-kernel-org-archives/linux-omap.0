From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc6-omap] sync isp1301_omap with mainlne
Date: Tue, 25 Nov 2008 15:38:28 -0800
Message-ID: <20081125233828.GF11997@atomide.com>
References: <200811241032.50037.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55130 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbYKYXi2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 18:38:28 -0500
Content-Disposition: inline
In-Reply-To: <200811241032.50037.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081124 10:33]:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Sync OMAP git with mainline ... build tested.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> This will help with an upcoming patch to move this to drivers/usb/otg.

Pushing today.

Tony

>  drivers/i2c/chips/isp1301_omap.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- a/drivers/i2c/chips/isp1301_omap.c
> +++ b/drivers/i2c/chips/isp1301_omap.c
> @@ -32,7 +32,6 @@
>  #include <linux/usb/otg.h>
>  #include <linux/i2c.h>
>  #include <linux/workqueue.h>
> -#include <linux/io.h>
>  
>  #include <asm/irq.h>
>  #include <asm/mach-types.h>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
