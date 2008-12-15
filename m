From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc6-omap-git 0/5] drivers/usb/otg seeding
Date: Mon, 15 Dec 2008 11:11:20 -0800
Message-ID: <20081215191120.GD10664@atomide.com>
References: <200812011311.25404.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58915 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbYLOTLW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 14:11:22 -0500
Content-Disposition: inline
In-Reply-To: <200812011311.25404.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081201 13:55]:
> These five patches go on top of the two twl4030-usb patches sent
> last Wednesday.
> 
> The first four are in the USB queue (though the fourth has some
> minor updates that haven't yet made it there, like speling Tony's
> name right) ... the last one moves one more OMAP-only driver out
> of drivers/i2c/chips, to help it swim upstream.
> 
>  - move drivers/i2c/chips/isp1301-omap.c to drivers/usb/otg
>  - add new gpio_vbus "transceiver" (not used for now with OMAP)
>  - add missing otg_put_transceiver() call
>  - move OMAP's transceiver glue to drivers/usb/otg
>  - move drivers/i2c/chips/twl4030-usb.c to drivers/usb/otg
> 
> That last patch is the one which will break if the two preceding
> patches aren't applied.
> 
> After this the twl4030-usb code will more or less be ready to
> go upstream ... doesn't yet use regulator framework, but that's
> not upstream either.

Great. Pushing these to l-o tree today.

Tony


> 
> - Dave
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
