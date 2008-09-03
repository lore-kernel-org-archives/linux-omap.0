From: Tony Lindgren <tony@atomide.com>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 09:40:08 -0700
Message-ID: <20080903164007.GP23085@atomide.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <200808311447.20312.david-b@pacbell.net> <20080902221501.GD23085@atomide.com> <20080903075541.GA19980@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52918 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597AbYICQkX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 12:40:23 -0400
Content-Disposition: inline
In-Reply-To: <20080903075541.GA19980@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080903 00:56]:
> On Tue, Sep 02, 2008 at 03:15:10PM -0700, Tony Lindgren wrote:
> > Back online now. These changes look ggood to me in general, except
> > I suggest that we use the following standard:
> > 
> > - Keep OMAP1_IO_ADDRESS() and OMAP2_IO_ADDRESS() as I have some
> >   experimental patches to compile in both omap1 and omap2 into the
> >   same binary. Booting the kernel currently still requires some
> >   Makefile.boot patching, but at least compiling everything in makes
> >   things easier to maintain in the long run.
> 
> Already decided to do that.

OK

> > - Use io_p2v() for initializing dynamic stuff as it can be a function
> >   for non-optimized multiboot binaries.
> 
> It can't become a function - it's used in structure initialization so
> must be constant.

Outside the drivers we can use XXX_IO_ADDRESS() or set it during resource
init with io_p2v().

> There's a few places where it's used where resources are passed into
> drivers - in which case if the device is at a different physical address
> it's the resources which should be changed, not the translation macro.

Yeah. Luckily it looks like there are only few drivers that would need
patching for the resources.

Other than that, do you see other reasons why io_p2v() could not be a
function?

> Anyway, I've put a modified version in my git tree.

OK, will also apply to l-o tree after shortly.

> I still want to hear on the other build fix in the patch, and there's
> also a missing function for mmc stuff which I've not looked into yet.

The mpuio build fix? That is a correct fix.

Tony
