From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Parse ATAG_VIDEOLFB to screen_info
Date: Tue, 25 Nov 2008 22:08:00 +0000
Message-ID: <20081125220800.GA29020@flint.arm.linux.org.uk>
References: <1227263136-14862-1-git-send-email-tomi.valkeinen@nokia.com> <20081124121217.GB5330@flint.arm.linux.org.uk> <1227601063.7197.18.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56939 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbYKYWIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 17:08:14 -0500
Content-Disposition: inline
In-Reply-To: <1227601063.7197.18.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Tue, Nov 25, 2008 at 10:17:43AM +0200, Tomi Valkeinen wrote:
> Hi,
> 
> On Mon, 2008-11-24 at 12:12 +0000, ext Russell King - ARM Linux wrote:
> > On Fri, Nov 21, 2008 at 12:25:36PM +0200, Tomi Valkeinen wrote:
> > > Parse ATAG_VIDEOLFB received from bootloader to screen_info struct,
> > > so that video drivers can use the information.
> > 
> > Boot loaders tend to be absolutely diabolical about passing correct
> > information to the kernel, so I really don't want to see such platform
> > specific stuff being passed.  Please put it in the board specific file
> > instead, just like everyone else does.
> 
> I though a general file would be better, because:
> 
> a) the tag contains only generic stuff and it is parsed directly to
> screen_info, which is also generic
> 
> b) ATAG_VIDEOTEXT, which is very similar to ATAG_VIDEOLFB, is parsed in
> setup.c also.
> 
> c) it is not used anywhere currently

I was meaning "don't do it this way at all" - instead, do it like every
other platform does, and keep the framebuffer settings in the platform
specific files.  Don't encode them into the boot loader and pass them
to the kernel.

Boot loaders are fragile and buggy.  No one likes fixing them.  It takes
_years_ to get problems with them fixed.  It may seem like it's a good
idea to pass lots of platform specific data from the boot loader to the
kernel, but it's just not worth the hastle of getting people to fix that
data when it's not 100% correct.

We've seen this many times.  We've seen it with simple things like passing
the machine number to the kernel.  Just don't go there - it's a pain in
the back side and causes years of grief.

