From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Failure to boot...
Date: Thu, 31 Jan 2013 16:19:57 +0000
Message-ID: <20130131161957.GU2637@n2100.arm.linux.org.uk>
References: <20130131104044.GO2637@n2100.arm.linux.org.uk> <510A6877.9080307@ti.com> <20130131130437.GP2637@n2100.arm.linux.org.uk> <510A78E1.8010308@ti.com> <20130131141320.GQ2637@n2100.arm.linux.org.uk> <20130131141635.GR2637@n2100.arm.linux.org.uk> <510A7D9F.7040507@ti.com> <20130131142758.GS2637@n2100.arm.linux.org.uk> <510A82FE.6050803@ti.com> <20130131160000.GW15361@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60342 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab3AaQUL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 11:20:11 -0500
Content-Disposition: inline
In-Reply-To: <20130131160000.GW15361@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Nicolas Pitre <nico@fluxnic.net>, arm@kernel.org, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 31, 2013 at 08:00:02AM -0800, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130131 06:45]:
> > On Thursday 31 January 2013 07:57 PM, Russell King - ARM Linux wrote:
> > >>>
> > >>># 13 Jan 2013: Update for OMAP moving to multiplatform
> > >>>CONFIG_ARCH_MULTIPLATFORM=y
> > >>>CONFIG_ARCH_MULTI_V7=y
> > >>>
> > >>>don't fix it either, it needs more options defined...
> 
> Just trying to figure out what was the missing entry in case
> others have the same problem.
> 
> In addition to the ones above, I had also CONFIG_ARCH_OMAP2PLUS=y
> listed in my comments. Did you also need something else added
> manually?

Interesting, that's the one which got missed.  The ones which did get
updated on the 13th were just the noconfigs which were failing to build,
and not the two oldconfigs which are the booted ones.  The noconfigs
already had OMAP2PLUS enabled in them which is probably how it got
lost.
