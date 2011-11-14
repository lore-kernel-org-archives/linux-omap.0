From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: DSS hwmod/reset fixes for 3.2
Date: Mon, 14 Nov 2011 12:46:49 -0800
Message-ID: <20111114204649.GL31337@atomide.com>
References: <alpine.DEB.2.00.1110061806150.4611@utopia.booyaka.com>
 <20111105003550.GM31337@atomide.com>
 <alpine.DEB.2.00.1111080049470.12394@utopia.booyaka.com>
 <1320746911.1907.47.camel@deskari>
 <alpine.DEB.2.00.1111080329300.8313@utopia.booyaka.com>
 <1320754489.1907.50.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15974 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab1KNUqw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Nov 2011 15:46:52 -0500
Content-Disposition: inline
In-Reply-To: <1320754489.1907.50.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [111108 03:40]:
> On Tue, 2011-11-08 at 03:33 -0700, Paul Walmsley wrote:
> > On Tue, 8 Nov 2011, Tomi Valkeinen wrote:
> > 
> > > On Tue, 2011-11-08 at 00:50 -0700, Paul Walmsley wrote:
> > > > On Fri, 4 Nov 2011, Tony Lindgren wrote:
> > > > 
> > > > > * Paul Walmsley <paul@pwsan.com> [111006 16:33]:
> > > > > > The following changes since commit be73246058737beec52ae232bcab7776332a9e06:
> > > > > > 
> > > > > >   ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-09-26 17:50:37 -0700)
> > > > > > 
> > > > > > are available in the git repository at:
> > > > > >   git://git.pwsan.com/linux-2.6 hwmod_dss_fixes_3.2
> > > > > 
> > > > > Looks like you should take a look at the merge conflicts with
> > > > > this one, maybe rebase it on 994c0e992522c123298b4a91b72f5e67ba2d1123.
> > > > 
> > > > Do you want this series for 3.2-rc or 3.3 at this point?
> > > 
> > > Seems that at least HDMI output is broken due to this series missing.
> > 
> > OK thanks, 3.2-rc it is.

I suggest we only merge the ones with "fix" in the subject during the -rc
cycle. The others add new features for the reset, so they should wait until
v3.3 merge window.

Regards,

Tony
