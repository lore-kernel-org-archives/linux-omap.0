From: Archit Taneja <a0393947@ti.com>
Subject: Re: Problems with 3.4-rc5
Date: Wed, 2 May 2012 17:54:21 +0530
Message-ID: <4FA12775.1090206@ti.com>
References: <WC20120502115251.8503FF@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41546 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754001Ab2EBMZJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 08:25:09 -0400
In-Reply-To: <WC20120502115251.8503FF@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: linux-omap@vger.kernel.org

Hi,

On Wednesday 02 May 2012 05:22 PM, Joe Woodward wrote:
> I've just given 3.4-rc5 a quick run-through on my GUMSTIX Overo (AM3703), and have noticed a couple of issues...
>
> Firstly, it fails to build "drivers/mfd/omap-usb-host.c" if you have:
>
> CONFIG_USB_EHCI_HCD=m
> CONFIG_USB_EHCI_ROOT_HUB_TT=y
> CONFIG_USB_EHCI_TT_NEWSCHED=y
> CONFIG_USB_EHCI_HCD_OMAP=y
>
> drivers/mfd/omap-usb-host.c: In function 'omap_usbhs_init':
> drivers/mfd/omap-usb-host.c:524:3: error: implicit declaration of function 'cpu_is_omap3430'
> drivers/mfd/omap-usb-host.c:524:3: error: implicit declaration of function 'omap_rev'
> drivers/mfd/omap-usb-host.c:524:43: error: 'OMAP3430_REV_ES2_1' undeclared (first use in this function)
> drivers/mfd/omap-usb-host.c:524:43: note: each undeclared identifier is reported only once for each function it appears in
>
> I'm assuming this has been spotted and I've missed the fix (just a missing include?).
>
> Secondly, I get the following when booted:
> ...
> [    4.701232] devtmpfs: mounted
> [    4.704772] Freeing init memory: 168K
> [    4.827301] omapdss DISPC error: FIFO UNDERFLOW on gfx, disabling the overlay
> ...
>

Could you add some dss debug prints? You can add "omapdss.debug=1 debug" 
in the bootargs to get that.

There was a feature called fifo merge added in 3.4, this might lead to 
underflow, we had tested this using a DVI monitor on beagle but didn't 
see any underflows.

Are you trying this out on 3.4 for the first time? What was the last 
kernel revision on which you tested this and didn't see any issues?

Thanks,
Archit

> Which means that the display doesn't work.
>
> I am currently running 3.3, which works just fine and doesn't give an underflow.
>
> So was wondering what changes have been made that may affect this? There were problems in the 3.2-era due to runtime-
> PM causing a similar issue, has anything changed around here again?
>
> (as a side not: the panel I use is a custom 800x480 added to panel-generic-dpi.c, with board-overo.c updated to use it).
>
> Cheers,
> Joe Woodward
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

