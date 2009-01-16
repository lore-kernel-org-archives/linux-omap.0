From: Tony Lindgren <tony@atomide.com>
Subject: Re: Git tree updated to v2.6.29-rc1, omap-2.6.28 branch added
Date: Fri, 16 Jan 2009 09:44:45 +0200
Message-ID: <20090116074443.GQ4128@atomide.com>
References: <20090115154327.GF4128@atomide.com> <200901151401.17763.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53943 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbZAPHoo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 02:44:44 -0500
Content-Disposition: inline
In-Reply-To: <200901151401.17763.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [090116 00:03]:
> On Thursday 15 January 2009, Tony Lindgren wrote:
> > I've updated our git tree to v2.6.29-rc1,
> 
> OK, after adding the IRQ patch from Anand, and the appended
> USB patch (from before the 2.6.29 merge window), it builds.
> 
> Then when it tries to boot, (a) the HSMMC driver reports
> "error -110" then chokes, so no root FS; and then (b) MUSB
> misdetects the high speed hub as full speed then chokes,
> so no network links either.  I'm not thinking (a) relates
> to the "can't get debounce clock" message, I saw that on
> earlier code that still booted just fine.

Thanks, applied and pushed to l-o tree.

> That's on a trusty Beagle config.  I don't think I'll be
> upgrading anything else just yet...

Hmm, that sounds conservative! :)

Tony


> 
> - Dave
> 
> 
> ============= CUT HERE
> Subject: drivers/usb/core/hub.c: fix CONFIG_USB_OTG=y build
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Carry out the PM-routine interface change in the USB OTG pathway.  This
> was omitted from the earlier interface-change patch by mistake.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg KH <greg@kroah.com>
> Cc: Russell King <rmk@arm.linux.org.uk>
> Cc: Felipe Balbi <felipe.balbi@nokia.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/usb/core/hub.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/usb/core/hub.c~drivers-usb-core-hubc-fix-config_usb_otg=y-build drivers/usb/core/hub.c
> --- a/drivers/usb/core/hub.c~drivers-usb-core-hubc-fix-config_usb_otg=y-build
> +++ a/drivers/usb/core/hub.c
> @@ -1554,7 +1554,7 @@ static int usb_configure_device_otg(stru
>  		 * (Includes HNP test device.)
>  		 */
>  		if (udev->bus->b_hnp_enable || udev->bus->is_b_host) {
> -			err = usb_port_suspend(udev);
> +			err = usb_port_suspend(udev, PMSG_SUSPEND);
>  			if (err < 0)
>  				dev_dbg(&udev->dev, "HNP fail, %d\n", err);
>  		}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
