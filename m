From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: DSS hwmod/reset fixes for 3.2
Date: Fri, 18 Nov 2011 16:06:00 -0800
Message-ID: <20111119000559.GV31337@atomide.com>
References: <alpine.DEB.2.00.1110061806150.4611@utopia.booyaka.com>
 <20111105003550.GM31337@atomide.com>
 <alpine.DEB.2.00.1111080049470.12394@utopia.booyaka.com>
 <1320746911.1907.47.camel@deskari>
 <alpine.DEB.2.00.1111080329300.8313@utopia.booyaka.com>
 <1320754489.1907.50.camel@deskari>
 <20111114204649.GL31337@atomide.com>
 <alpine.DEB.2.00.1111141438290.19654@utopia.booyaka.com>
 <20111114220423.GQ31337@atomide.com>
 <1321340796.1895.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33305 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab1KSAGC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Nov 2011 19:06:02 -0500
Content-Disposition: inline
In-Reply-To: <1321340796.1895.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [111114 22:31]:
> On Mon, 2011-11-14 at 14:04 -0800, Tony Lindgren wrote:
> > * Paul Walmsley <paul@pwsan.com> [111114 13:05]:
> > > On Mon, 14 Nov 2011, Tony Lindgren wrote:
> > > 
> > > > I suggest we only merge the ones with "fix" in the subject during the -rc
> > > > cycle. The others add new features for the reset, so they should wait until
> > > > v3.3 merge window.
> > > 
> > > Most of the other patches in the branch discuss what they fix in the patch 
> > > descriptions, rather than the subject lines.  Do you want the subject 
> > > lines rewritten to highlight this?
> > 
> > Well we should only merge major bugs and regressions during the -rc cycle.
> > It seems that at least "OMAP: HWMOD: Unify DSS resets for OMAPs" has high
> > flame potential based on that? Maybe we should wait until the next merge
> > window to start removing some of these workarounds?
> 
> I'm not sure what you mean...
> 
> The "Unify DSS resets..." patch itself fixes only a minor bug: "This
> causes causes the HWMOD reset to fail for dss_dispc and dss_rfbi". But
> it makes the next patch, "Ensure DSS works correctly...", possible. And
> that patch fixes a bigger bug, DSS or the whole device hanging if the
> bootloader had enabled the display (which I believe is the default on
> the shipped beagles/pandas).
> 
> There's one patch in the series that is not a fix, though: "ARM: OMAP4:
> HWMOD: remove extra clocks". I'm fine with queuing that for the next
> merge window. But most of the patches have now somehow missed two merge
> windows, and I'd really like to get them in.

OK let's try to get them in then. Hopefully after these DSS will be
more independent from the core omap changes.

Tony
