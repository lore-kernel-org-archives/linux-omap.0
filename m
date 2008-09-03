From: David Brownell <david-b@pacbell.net>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 14:09:14 -0700
Message-ID: <200809031409.14848.david-b@pacbell.net>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <20080903193421.GC19980@flint.arm.linux.org.uk> <20080903194832.GT23085@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:30883 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752259AbYICVP5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 17:15:57 -0400
In-Reply-To: <20080903194832.GT23085@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>

On Wednesday 03 September 2008, Tony Lindgren wrote:
> > > > I still want to hear on the other build fix in the patch, and there's
> > > > also a missing function for mmc stuff which I've not looked into yet.
> > > 
> > > The mpuio build fix? That is a correct fix.
> > 
> > No, see drivers/usb/host/ohci-omap.c:
> > 
> > -#ifdef CONFIG_ARCH_OMAP_OTG
> > +#ifdef CONFIG_USB_OTG /* CHECKME */
> > 
> 
> That's a Dave question.

That stuff's been whacked around a bunch, so I'm not sure
what its latest incarnation is expected to do.  Looks like
that change (to USB_OTG) couldn't hurt ... go for it.

