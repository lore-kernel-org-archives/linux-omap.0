From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: State of LDP3430 platform
Date: Mon, 6 Dec 2010 17:22:48 +0000
Message-ID: <20101206172248.GA1000@n2100.arm.linux.org.uk>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk> <20101206155959.GA8345@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49955 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab0LFRW6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 12:22:58 -0500
Content-Disposition: inline
In-Reply-To: <20101206155959.GA8345@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

On Mon, Dec 06, 2010 at 07:59:59AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [101206 04:45]:
> >
> > ------------[ cut here ]------------
> > WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1185 _omap_hwmod_enable+0x34/0x114()
> > omap_hwmod: wd_timer2: enabled state can only be entered from initialized, idle, or disabled state
> > Modules linked in:
> > ---[ end trace 1b75b31a2719ed1c ]---
> > wd_timer2: Could not enable clocks for omap2_disable_wdt
> 
> It seems like there's a problem handling a watchdog that's enabled
> in the bootloader.. But that's not the only problem, looks like I'm
> getting this on overo:
> 
> omap_device: omap_wdt.-1: new worst case activate latency 0: 122070
> OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
> omap_device: omap_wdt.-1: new worst case deactivate latency 0: 30517
> twl4030_wdt twl4030_wdt: Failed to register misc device
> twl4030_wdt: probe of twl4030_wdt failed with error -16

-16 = -EBUSY, which is probably because you have two watchdogs.  The
watchdog subsystem has one minor device number, so you can only have
one watchdog registered.
