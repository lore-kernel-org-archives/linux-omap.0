From: Paul Walmsley <paul@pwsan.com>
Subject: Re: State of LDP3430 platform
Date: Mon, 6 Dec 2010 11:27:45 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk> <20101206181913.GH8345@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54767 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922Ab0LFS1q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 13:27:46 -0500
In-Reply-To: <20101206181913.GH8345@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

On Mon, 6 Dec 2010, Tony Lindgren wrote:

> * Russell King - ARM Linux <linux@arm.linux.org.uk> [101206 04:45]:
> >
> > NET: Registered protocol family 16
> > ------------[ cut here ]------------
> > WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1185 _omap_hwmod_enable+0x34/0x114()
> > omap_hwmod: wd_timer2: enabled state can only be entered from initialized, idle, or disabled state
> > Modules linked in:
> > ---[ end trace 1b75b31a2719ed1c ]---
> > wd_timer2: Could not enable clocks for omap2_disable_wdt
> 
> Can you check if these patches posted by Paul earlier help?
> 
> OMAP: wd_timer: update integration code to use new hwmod change
> https://patchwork.kernel.org/patch/327472/
> 
> OMAP2+: wd_timer: disable on boot via hwmod postsetup mechanism
> https://patchwork.kernel.org/patch/327492/
> 
> OMAP: wd_timer: remove old, dead probing code
> https://patchwork.kernel.org/patch/327482/

Just FYI, those will need this series ("OMAP2+: hwmod core upgrades 
for 2.6.38: first set") applied first:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38632.html


- Paul
