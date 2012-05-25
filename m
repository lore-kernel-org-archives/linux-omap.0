From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] omap legacy full speed usb cleanup for v3.6
Date: Fri, 25 May 2012 10:22:46 +0300
Message-ID: <20120525072245.GA6206@atomide.com>
References: <20120521185323.927.88012.stgit@muffinssi.local>
 <alpine.DEB.2.00.1205241401070.2572@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:42611 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405Ab2EYHWu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 May 2012 03:22:50 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1205241401070.2572@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, balbi@ti.com

* Paul Walmsley <paul@pwsan.com> [120524 23:05]:
> On Mon, 21 May 2012, Tony Lindgren wrote:
> 
> > This series removes the old legacy fulls speed support for
> > omap2 as it's pretty much only used for omap1 only.
> > 
> > For omap2, only n8x0 seems to have active development, and
> > that has the external high speed tusb chip instead.
> 
> Just FYI, full speed host USB exists on OMAP4.  It's in section 23.13 of 
> the TRM and we have a hwmod for it.  No idea if anyone is actually using 
> it.

Interesting, so it's back on omap4 for some legacy compability reasons
i guess. It's not mentioned for omap3 at all, but maybe it's lurking
around there somewhere too.

Looking at the omap4 TRM, looks like there are two instances of OHCI:
The HS OHCI/EHCI controller, and the legacy FS OHCI only controller.
The legacy one is using separate transceiver pins (usbc1_*) from the
HS OHCI/EHCI controller pins (usbb[12]_*).

As the OHCI registers are standard, I'd assume it would be possible
to make the FS USB instance to work with the mach-omap2/usb-host.c
and drivers/usb/host/ohci-omap3.c driver. So it should still be OK
to remove the code in this series.

I doubt that anybody would want to use the legacy FS OHCI controller
instead of the HS OHCI/EHCI controller though.. If somebody
is actually using the legacy controller at usbc1_* pins, please
respond. 

Regards,

Tony
