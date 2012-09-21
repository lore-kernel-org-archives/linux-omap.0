From: Tony Lindgren <tony@atomide.com>
Subject: Re: Help needed with remaining plat headers
Date: Fri, 21 Sep 2012 11:46:45 -0700
Message-ID: <20120921184644.GD28835@atomide.com>
References: <20120920232907.GN28835@atomide.com>
 <505C2E22.9020001@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:22785 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757439Ab2IUSqr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 14:46:47 -0400
Content-Disposition: inline
In-Reply-To: <505C2E22.9020001@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org

* Igor Grinberg <grinberg@compulab.co.il> [120921 02:07]:
> On 09/21/12 02:29, Tony Lindgren wrote:
> > Hi all,
> > 
> > With the recent pull request I sent for v3.7, we now have pretty
> > much all the mach includes fixed up for omap2+ for single zImage
> > support.
> > 
> > We still have quite a few plat headers that we need to sort
> > out manually.
> > 
> > Please take a look at the following list, and reply to this
> > thread if you are working on patches moving one of the headers
> > in the list so we can coordinate things. The rules are simple
> > for most of them:
> > 
> > 1. For driver related data, the header should now be in
> >    include/linux/platform_data/*.h

Just to clarify this, these headers should only contain
the platform data shared between the SoC specific code and
driver. Things that are driver internal should be in the driver
specific header or moved to the driver. Things that are SoC
internal should be in the local *.[chS] files in the
arch/arm/mach-omap2 directory.

> > 2. For mach-omap2 specific things, the headers should be
> >    in arch/arm/mach-omap2.
> > 
> > 3. Drivers should not include anything from plat or mach.
> > 
> > I'll be looking into getting rid of cpu.h etc for v3.8 merge
> > window, but won't be looking much at the driver related
> > headers. So some help would be appreciated here :)
> > 
> > Regards,
> > 
> > Tony
> > 
> > 
> > $ ls arch/arm/plat-omap/include/plat/
> 
> [...]
> 
> > timex.h
> 
> I'll try to deal with this one,
> as it is related to the work I currently do for CONFIG_OMAP_32K_TIMER removal.
> Probably for v3.8 merge window.

OK great thanks,

Tony
