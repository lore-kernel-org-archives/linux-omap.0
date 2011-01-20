From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2-beagle: Depend upon CONFIG_GPIO_TWL4030
Date: Thu, 20 Jan 2011 09:27:41 -0800
Message-ID: <20110120172741.GU4957@atomide.com>
References: <1295299548-22839-1-git-send-email-bgamari.foss@gmail.com>
 <20110118031038.GA2436@legolas.emea.dhcp.ti.com>
 <87d3nus4jr.fsf@gmail.com>
 <20110119034528.GA2406@legolas.emea.dhcp.ti.com>
 <874o947j9e.fsf@gmail.com>
 <20110120040825.GB2389@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38147 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109Ab1ATR1y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 12:27:54 -0500
Content-Disposition: inline
In-Reply-To: <20110120040825.GB2389@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Ben Gamari <bgamari.foss@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Felipe Balbi <balbi@ti.com> [110119 20:07]:
> On Wed, Jan 19, 2011 at 03:04:13PM -0500, Ben Gamari wrote:
> > On Wed, 19 Jan 2011 05:45:28 +0200, Felipe Balbi <balbi@ti.com> wrote:
> > > The point is, being able to disable features I don't want on my kernel
> > > image, is completely valid, if there's a compile breakage, then fix the
> > > breakage but don't prevent the board from compiling.
> > > 
> > I understand. That being said, Linus has made it well known that
> > defconfigs will not be an option going forward. Have we found another
> 
> I never mentioned defconfigs here.
> 
> > means of selecting the basic drivers necessary to get a fully functional
> > board? Perhaps a CONFIG_MACH_OMAP3_BEAGLE_CORE option selecting the
> > necessary driver for a fully functional board would be a solution. I
> 
> I'll leave this for Tony to decide, but I don't like your proposal.
> 
> > remember this being discussed several months ago (when Linus started
> > pulling defconfigs out of the tree), but I don't recall there being any
> > replacement proposals. It should be possible to build a functional
> > kernel from the mainline without iterating over all available
> > configuration options.
> 
> So you're saying that when you're building a kernel for you
> laptop/desktop you don't have to get a menuconfig and choose the drivers
> you want to compile ? I dare to doubt that.

What we want to do in the long run is build a minimal kernel and make
everything else loaded as modules from initramfs. In order to do that
we need to cut down all the dependencies between core omap code and
the drivers. So I'd stay away from selecting things for boards where
possible.

Tony
