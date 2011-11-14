From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: DSS hwmod/reset fixes for 3.2
Date: Mon, 14 Nov 2011 14:04:23 -0800
Message-ID: <20111114220423.GQ31337@atomide.com>
References: <alpine.DEB.2.00.1110061806150.4611@utopia.booyaka.com>
 <20111105003550.GM31337@atomide.com>
 <alpine.DEB.2.00.1111080049470.12394@utopia.booyaka.com>
 <1320746911.1907.47.camel@deskari>
 <alpine.DEB.2.00.1111080329300.8313@utopia.booyaka.com>
 <1320754489.1907.50.camel@deskari>
 <20111114204649.GL31337@atomide.com>
 <alpine.DEB.2.00.1111141438290.19654@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60042 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751723Ab1KNWE0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Nov 2011 17:04:26 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1111141438290.19654@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111114 13:05]:
> On Mon, 14 Nov 2011, Tony Lindgren wrote:
> 
> > I suggest we only merge the ones with "fix" in the subject during the -rc
> > cycle. The others add new features for the reset, so they should wait until
> > v3.3 merge window.
> 
> Most of the other patches in the branch discuss what they fix in the patch 
> descriptions, rather than the subject lines.  Do you want the subject 
> lines rewritten to highlight this?

Well we should only merge major bugs and regressions during the -rc cycle.
It seems that at least "OMAP: HWMOD: Unify DSS resets for OMAPs" has high
flame potential based on that? Maybe we should wait until the next merge
window to start removing some of these workarounds?

Tony
