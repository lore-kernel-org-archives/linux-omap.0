From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/4] arm: omap: hwmod: 43xx: add DebugSS hwmod data
Date: Tue, 10 Feb 2015 23:12:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1502102311570.3767@utopia.booyaka.com>
References: <1422054704-14915-1-git-send-email-balbi@ti.com> <1422054704-14915-2-git-send-email-balbi@ti.com> <alpine.DEB.2.02.1501260142590.5450@utopia.booyaka.com> <20150126165640.GA10679@saruman.tx.rr.com> <20150126194933.GG6660@saruman.tx.rr.com>
 <20150127160143.GH14623@saruman.tx.rr.com> <alpine.DEB.2.02.1501271652340.7149@utopia.booyaka.com> <20150127171532.GC14878@saruman.tx.rr.com> <20150127171843.GD14878@saruman.tx.rr.com> <alpine.DEB.2.02.1501271751020.4845@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59173 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbbBJXMl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2015 18:12:41 -0500
In-Reply-To: <alpine.DEB.2.02.1501271751020.4845@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org

Hi Felipe

On Tue, 27 Jan 2015, Paul Walmsley wrote:

> On Tue, 27 Jan 2015, Felipe Balbi wrote:
> 
> > On Tue, Jan 27, 2015 at 11:15:32AM -0600, Felipe Balbi wrote:
> > > On Tue, Jan 27, 2015 at 05:12:05PM +0000, Paul Walmsley wrote:
> > > > On Tue, 27 Jan 2015, Felipe Balbi wrote:
> > > > 
> > > > > On Mon, Jan 26, 2015 at 01:49:33PM -0600, Felipe Balbi wrote:
> > > > > > On Mon, Jan 26, 2015 at 10:56:40AM -0600, Felipe Balbi wrote:
> > > > > >
> > > > > > > hm... modulemode SWCTRL causes wait_target_ready to fail. Any hints ?
> > > > > > 
> > > > > > gets stuck in transition state. PRCM_CM_WKUP_DBGSS_CLKCTRL is always
> > > > > > read as 0x 12510f00 which would translate into:
> > > > > > 
> > > > > > - module disabled
> > > > > > - all opt clocks are on
> > > > > > - module is transitioning
> > > > > > - module in standby
> > > > > > - clkA as TPIU and STM trace clock
> > > > > > - all dividers set to 2
> > > > > 
> > > > > just fyi, checking with HW folks, this might be a new bug, unless
> > > > > debugss needs something special.
> > > > 
> > > > If that happens on DEBUGSS disable, it's probably the same issue as on 
> > > > AM33xx:
> > > > 
> > > > http://www.spinics.net/lists/arm-kernel/msg320801.html
> > > > http://www.spinics.net/lists/arm-kernel/msg321930.html
> > > > http://www.spinics.net/lists/arm-kernel/msg329151.html
> > > > 
> > > > Does adding HWMOD_INIT_NO_IDLE fix the issue you're seeing?
> > > 
> > > I'll try it out in a bit...
> > 
> > nope, same thing.
> > 
> > [   27.633235] omap_hwmod: debugss: _wait_target_disable failed
> 
> OK, looking at the code, this makes sense.  So here's what I'd suggest 
> asking the hardware team: is the right approach to:
> 
> 1. keep the DEBUGSS CLKCTRL MODULEMODE bitfield at 0x2 all the time, even 
> when it's not in use or when entering chip low-power states, or
> 
> 2. program the DEBUGSS CLKCTRL MODULEMODE bitfield to 0x0 when the DEBUGSS 
> is not in use or when entering chip low-power states, but ignore the 
> DEBUGSS CLKCTRL IDLEST register 
> 
> We'll need a new hwmod flag either way; the question is whether it should 
> be something like HWMOD_CANNOT_DISABLE (case 1), or 
> HWMOD_DISABLE_IGNORE_IDLEST (case 2).

Just checking on this.  Heard anything from the hardware team?  If not I'd 
say the HWMOD_CANNOT_DISABLE approach is probably the right one for now...


- Paul
