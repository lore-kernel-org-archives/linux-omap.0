From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Thu, 4 Sep 2008 00:02:07 +0100
Message-ID: <20080903230207.GP19980@flint.arm.linux.org.uk>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <20080903193421.GC19980@flint.arm.linux.org.uk> <20080903194832.GT23085@atomide.com> <200809031409.14848.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57680 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbYICXCZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 19:02:25 -0400
Content-Disposition: inline
In-Reply-To: <200809031409.14848.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>

On Wed, Sep 03, 2008 at 02:09:14PM -0700, David Brownell wrote:
> On Wednesday 03 September 2008, Tony Lindgren wrote:
> > > > > I still want to hear on the other build fix in the patch, and there's
> > > > > also a missing function for mmc stuff which I've not looked into yet.
> > > > 
> > > > The mpuio build fix? That is a correct fix.
> > > 
> > > No, see drivers/usb/host/ohci-omap.c:
> > > 
> > > -#ifdef CONFIG_ARCH_OMAP_OTG
> > > +#ifdef CONFIG_USB_OTG /* CHECKME */
> > > 
> > 
> > That's a Dave question.
> 
> That stuff's been whacked around a bunch, so I'm not sure
> what its latest incarnation is expected to do.  Looks like
> that change (to USB_OTG) couldn't hurt ... go for it.

Thanks.
