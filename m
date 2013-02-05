From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] ARM part of USB patches
Date: Tue, 5 Feb 2013 10:37:29 -0800
Message-ID: <20130205183729.GA18954@kroah.com>
References: <51112418.5020000@ti.com>
 <51112495.4060908@ti.com>
 <20130205172724.GA1601@kroah.com>
 <20130205181947.GI25185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:47661 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755429Ab3BESfS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 13:35:18 -0500
Received: by mail-pa0-f42.google.com with SMTP id kq12so294001pab.15
        for <linux-omap@vger.kernel.org>; Tue, 05 Feb 2013 10:35:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130205181947.GI25185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, kishon <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>

On Tue, Feb 05, 2013 at 10:19:47AM -0800, Tony Lindgren wrote:
> * gregkh@linuxfoundation.org <gregkh@linuxfoundation.org> [130205 09:28]:
> > On Tue, Feb 05, 2013 at 08:56:13PM +0530, kishon wrote:
> > > Hi Tony, Greg,
> > > 
> > > On Tuesday 05 February 2013 08:54 PM, kishon wrote:
> > > >Hi Tony,
> > > >
> > > >As discussed, I'm sending a pull request for the arch/arm part of my USB
> > > >patches. These patches are necessary to get MUSB functional in both dt
> > > >and non-dt boot. Also added dt data for dwc3 present in OMAP. This patch
> > > >series *depends* on some of the patches which are merged in usb-next.
> > > 
> > > This patch series should go in only after USB. Or else it will break
> > > compilation.
> > 
> > Then it probably should go through the USB tree, right?  We don't want
> > to break bisectability.
> 
> Looks like this branch needs to be based on at least 01658f0f (usb: phy:
> add a new driver for usb part of control module) to compile. Probably
> needs other USB patches too to make sense.
> 
> This branch has a high likelihood of conflicting with .dts files, so
> Kishon, I suggest you do two branches:
> 
> 1. A branch for Greg based on top of the USB changes
> 
>    This branch should contain:
> 
>    ARM: OMAP4: remove control module address space from PHY and OTG
>    ARM: OMAP: devices: create device for usb part of control module
>    ARM: OMAP2: MUSB: Specify omap4 has mailbox
>    ARM: OMAP: USB: Add phy binding information
> 
>    Naturally please make sure they compile and boot on their own.
>    Looks like this will only cause few trivial include merge conflicts
>    with what I have queued up.
> 
>    You can add my Acked-by: Tony Lindgren <tony@atomide.com> for those.

If that happens, please send me patches in email, I don't take git
pull requests, especially for something as small as 4 patches.

thanks,

greg k-h
