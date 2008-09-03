From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 20:34:21 +0100
Message-ID: <20080903193421.GC19980@flint.arm.linux.org.uk>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <200808311447.20312.david-b@pacbell.net> <20080902221501.GD23085@atomide.com> <20080903075541.GA19980@flint.arm.linux.org.uk> <20080903164007.GP23085@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55852 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbYICTes (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 15:34:48 -0400
Content-Disposition: inline
In-Reply-To: <20080903164007.GP23085@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>

On Wed, Sep 03, 2008 at 09:40:08AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [080903 00:56]:
> > > - Use io_p2v() for initializing dynamic stuff as it can be a function
> > >   for non-optimized multiboot binaries.
> > 
> > It can't become a function - it's used in structure initialization so
> > must be constant.
> 
> Outside the drivers we can use XXX_IO_ADDRESS() or set it during resource
> init with io_p2v().

The question is why do we need it?  If the correct physical address
is passed, then things should work out just fine anyway, especially
if drivers start to use ioremap rather than relying on all these fixed
translations.

> > I still want to hear on the other build fix in the patch, and there's
> > also a missing function for mmc stuff which I've not looked into yet.
> 
> The mpuio build fix? That is a correct fix.

No, see drivers/usb/host/ohci-omap.c:

-#ifdef CONFIG_ARCH_OMAP_OTG
+#ifdef CONFIG_USB_OTG /* CHECKME */


