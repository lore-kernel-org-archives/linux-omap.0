From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH] USB: OTG: Use work_queue in set_vbus for TWL6030
 transciever
Date: Fri, 24 Jun 2011 23:31:16 -0700
Message-ID: <20110625063116.GA14681@google.com>
References: <1308928443-15352-1-git-send-email-m-sonasath@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:16318 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab1FYGba (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Jun 2011 02:31:30 -0400
Content-Disposition: inline
In-Reply-To: <1308928443-15352-1-git-send-email-m-sonasath@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Moiz Sonasath <m-sonasath@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, gregkh@suse.de

On Fri, Jun 24, 2011 at 10:14:03AM -0500, Moiz Sonasath wrote:
...  
> +	if (enabled)
> +		twl->vbus_enable = 1;
> +	else
> +		twl->vbus_enable = 0;
> +

Suggest twl->vbus_enable = enabled;

>  	/*
>  	 * Start driving VBUS. Set OPA_MODE bit in CHARGERUSB_CTRL1
>  	 * register. This enables boost mode.
>  	 */
> -	if (enabled)
> -		twl6030_writeb(twl, TWL_MODULE_MAIN_CHARGE , 0x40,
> -						CHARGERUSB_CTRL1);
> -	 else
> -		twl6030_writeb(twl, TWL_MODULE_MAIN_CHARGE , 0x00,
> -						CHARGERUSB_CTRL1);
> +
> +	schedule_work(&twl->set_vbus_work);
> +

Suggest also moving the comments together with the new location of
the code to write CHARGERUSB_CTRL1.

Add a cancel_work_sync(&twl->set_vbus_work) at twl6030_usb_remove(),
prior to kfree(twl).
