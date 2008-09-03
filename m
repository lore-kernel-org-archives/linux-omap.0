From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 08:55:41 +0100
Message-ID: <20080903075541.GA19980@flint.arm.linux.org.uk>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <200808311447.20312.david-b@pacbell.net> <20080902221501.GD23085@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35637 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbYICHz7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 03:55:59 -0400
Content-Disposition: inline
In-Reply-To: <20080902221501.GD23085@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>

On Tue, Sep 02, 2008 at 03:15:10PM -0700, Tony Lindgren wrote:
> Back online now. These changes look ggood to me in general, except
> I suggest that we use the following standard:
> 
> - Keep OMAP1_IO_ADDRESS() and OMAP2_IO_ADDRESS() as I have some
>   experimental patches to compile in both omap1 and omap2 into the
>   same binary. Booting the kernel currently still requires some
>   Makefile.boot patching, but at least compiling everything in makes
>   things easier to maintain in the long run.

Already decided to do that.

> - Use io_p2v() for initializing dynamic stuff as it can be a function
>   for non-optimized multiboot binaries.

It can't become a function - it's used in structure initialization so
must be constant.

There's a few places where it's used where resources are passed into
drivers - in which case if the device is at a different physical address
it's the resources which should be changed, not the translation macro.

Anyway, I've put a modified version in my git tree.

I still want to hear on the other build fix in the patch, and there's
also a missing function for mmc stuff which I've not looked into yet.
