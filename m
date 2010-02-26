From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/4] USB: MUSB: Enable MUSB for OMAP4 in Kconfig
Date: Fri, 26 Feb 2010 12:54:14 -0600
Message-ID: <20100226185414.GA10835@lixom.net>
References: <1267079758-14480-1-git-send-email-x0082077@ti.com> <20100225184833.GG28173@atomide.com> <20100226004233.GA3241@lixom.net> <000001cab6bf$5df75720$808918ac@apr.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.lixom.net ([66.141.50.11]:41483 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965706Ab0BZSry (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Feb 2010 13:47:54 -0500
Content-Disposition: inline
In-Reply-To: <000001cab6bf$5df75720$808918ac@apr.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maulik <x0082077@ti.com>
Cc: 'Tony Lindgren' <tony@atomide.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, 'Felipe Balbi' <felipe.balbi@nokia.com>, 'Greg Kroah-Hartman' <gregkh@suse.de>, 'David Brownell' <david-b@pacbell.net>

On Fri, Feb 26, 2010 at 02:10:31PM +0530, Maulik wrote:

> >>Adding more and more depends also doesn't scale well. It's time for
> >>someone to switch the test around, add a ARCH_HAS_MUSB, select it on
> >>the platforms that has it and make the config option depend on that,
> >>similar to how (some) platforms to EHCI today.
> 
> >>(i.e. if there's a janitor out there reading this, feel free to go ahead
> >>and do it. :-)
> 
> Olof,
> 
> We have such an option "USB_MUSB_SOC" that takes care of all platforms where
> MUSB is present. But the Inventra DMA case is typical. Not all architectures
> that have MUSB use Inventra DMA for e.g Davinci uses CPPI DMA.

Yeah, sorry. I didn't mean the INVENTRA_DMA config option as much as the top
MUSB one. So you should be able to switch to that instead of adding a check for
OMAP4 there then?

-Olof
