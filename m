From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] USB: OTG: twl4030 build fix
Date: Tue, 16 Dec 2008 14:01:55 -0800
Message-ID: <20081216220155.GB3291@kroah.com>
References: <1229385603-27035-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:50496 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751927AbYLPWDK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Dec 2008 17:03:10 -0500
Content-Disposition: inline
In-Reply-To: <1229385603-27035-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Mon, Dec 15, 2008 at 04:00:03PM -0800, Kevin Hilman wrote:
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  drivers/usb/otg/twl4030-usb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
> index a000fb3..416e441 100644
> --- a/drivers/usb/otg/twl4030-usb.c
> +++ b/drivers/usb/otg/twl4030-usb.c
> @@ -696,7 +696,7 @@ static int __exit twl4030_usb_remove(struct platform_device *pdev)
>  
>  static struct platform_driver twl4030_usb_driver = {
>  	.probe		= twl4030_usb_probe,
> -	.remove		= __exit_p(twl4030_remove),
> +	.remove		= __exit_p(twl4030_usb_remove),
>  	.driver		= {
>  		.name	= "twl4030_usb",
>  		.owner	= THIS_MODULE,

This driver is not in the mainline, or my USB tree.  Where is it at?

confused,

greg k-h
