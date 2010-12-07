From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: State of LDP3430 platform
Date: Tue, 7 Dec 2010 08:37:20 +0000
Message-ID: <20101207083720.GB18336@n2100.arm.linux.org.uk>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk> <20101206181913.GH8345@atomide.com> <alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54211 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673Ab0LGIhd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 03:37:33 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

On Mon, Dec 06, 2010 at 11:27:45AM -0700, Paul Walmsley wrote:
> On Mon, 6 Dec 2010, Tony Lindgren wrote:
> 
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [101206 04:45]:
> > >
> > > NET: Registered protocol family 16
> > > ------------[ cut here ]------------
> > > WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1185 _omap_hwmod_enable+0x34/0x114()
> > > omap_hwmod: wd_timer2: enabled state can only be entered from initialized, idle, or disabled state
> > > Modules linked in:
> > > ---[ end trace 1b75b31a2719ed1c ]---
> > > wd_timer2: Could not enable clocks for omap2_disable_wdt
> > 
> > Can you check if these patches posted by Paul earlier help?
> > 
> > OMAP: wd_timer: update integration code to use new hwmod change
> > https://patchwork.kernel.org/patch/327472/
> > 
> > OMAP2+: wd_timer: disable on boot via hwmod postsetup mechanism
> > https://patchwork.kernel.org/patch/327492/
> > 
> > OMAP: wd_timer: remove old, dead probing code
> > https://patchwork.kernel.org/patch/327482/
> 
> Just FYI, those will need this series ("OMAP2+: hwmod core upgrades 
> for 2.6.38: first set") applied first:
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38632.html

So LDP will remain unusable until after the 2.6.38 merge window?
