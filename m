From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] [PATCH v3 2/4] OMAP4: Keyboard device registration
Date: Fri, 11 Jun 2010 10:31:14 +0300
Message-ID: <20100611073114.GH32208@atomide.com>
References: <27F9C60D11D683428E133F85D2BB4A53043E537F74@dlee03.ent.ti.com>
 <20100601094358.GJ841@atomide.com>
 <27F9C60D11D683428E133F85D2BB4A53043E538286@dlee03.ent.ti.com>
 <20100601185358.GE23818@nokia.com>
 <20100601201314.GA17468@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61637 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756043Ab0FKHbQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 03:31:16 -0400
Content-Disposition: inline
In-Reply-To: <20100601201314.GA17468@core.coreip.homeip.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "ext Arce, Abraham" <x0066660@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [100601 23:07]:
> On Tue, Jun 01, 2010 at 09:53:58PM +0300, Felipe Balbi wrote:
> > On Tue, Jun 01, 2010 at 05:14:09PM +0200, ext Arce, Abraham wrote:
> > >I am using #ifdef CONFIG_ARCH_OMAP4 for this portion of code, what
> > >you are suggesting is to check at runtime?
> > 
> > you need to add both checks. If you build omap3-only or omap2-only
> > you don't want that code to be compiled, but if you build
> > omap1-2-3-4 kernel, you want it to work correctly on all cases.
> > 
> 
> It sould be nice if cpu_is_xxx were stubbed out for "wrong" arches
> withing the same group (like omap, etc) so we could reduce the #ifdef
> clutter.

They are defined as stubs for for non-selected omaps. So in general a
function doing this in the beginning of the function:

	if (!cpu_is_omap44xx())
		return -ENODEV;

Should already get optimized out if 44xx is not selected in Kconfig.

Regards,

Tony
