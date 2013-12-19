From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP display subsystem - does it work?
Date: Thu, 19 Dec 2013 08:56:07 -0800
Message-ID: <20131219165607.GN27438@atomide.com>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
 <52B1A922.6020901@ti.com>
 <20131218180240.GG27438@atomide.com>
 <52B282BE.9050705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:36418 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753789Ab3LSQ4P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 11:56:15 -0500
Content-Disposition: inline
In-Reply-To: <52B282BE.9050705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131218 21:24]:
> On 2013-12-18 20:23, Tony Lindgren wrote:
> 
> > Hmm I had the framebuffer working with DT on LDP after fixing the twl4030
> > gpio regression with 0b2aa8bed3e1 (gpio: twl4030: Fix regression for twl
> > gpio output) using this pdata quirks patch:
> > 
> > [PATCH 3/5] ARM: OMAP2+: Add DT init code for DPI displays and make omap3 LDP to use it
> > 
> > AFAIK the pdata hack above should not be needed now, but I have not tried
> > with Tomi's DSS DT patches yet.
> > 
> > Tomi do you have some sample panel dpi .dts entry somewhere for the LDP I
> > could try at some point?
> 
> Hmm, I thought this was about legacy booting on v3.14-rc4. That still
> uses the board files for omap3.

AFAIK 0b2aa8bed3e1 was the only thing needed for legacy booting and it's
in -rc4.
 
> > Russell, maybe all you're missing is just omapfb.vram=0:2M,1:5M or similar
> > from your kernel cmdline?
> 
> Nothing like that should be required for normal operation.

Hmm maybe these instructions need some updating then:

http://omappedia.org/wiki/Bootargs_for_enabling_display

Regards,

Tony
