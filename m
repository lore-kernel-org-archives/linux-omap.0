From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators
 for v3.4
Date: Tue, 3 Apr 2012 11:44:27 -0700
Message-ID: <20120403184426.GJ8240@atomide.com>
References: <877gywjhht.fsf@ti.com>
 <20120308021843.GQ12083@atomide.com>
 <87399jc6cj.fsf@ti.com>
 <20120309003217.GB12083@atomide.com>
 <20120309114731.GA3273@opensource.wolfsonmicro.com>
 <87zkbp4wtj.fsf@ti.com>
 <20120311204232.GC3171@opensource.wolfsonmicro.com>
 <87399dzq5e.fsf@ti.com>
 <20120312173215.GL3110@opensource.wolfsonmicro.com>
 <87pqchv1pc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:47173 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab2DCSob (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 14:44:31 -0400
Content-Disposition: inline
In-Reply-To: <87pqchv1pc.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

* Kevin Hilman <khilman@ti.com> [120312 16:30]:
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
> 
> > On Mon, Mar 12, 2012 at 10:26:53AM -0700, Kevin Hilman wrote:
> >> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
> >
> >> > The branch itself is essentially stable but I'm not enthused about the
> >> > idea of merging the whole thing via the OMAP tree.  
> >
> >> Right, I wasn't suggesting we merge it via OMAP tree.   I was just
> >> looking for a stable point we could use as s dependency when merging
> >> everything together for the arm-soc tree.
> >
> > Well, if you don't base the OMAP changes that depend on it off the
> > regulator changes then you'll break bisection as you'll have a bunch of
> > commits which won't have all their dependencies present on a branch
> > (since they're not present in the branch point and aren't otherwise
> > merged in), if bisect goes down that branch it'll be miserable.  That
> > seems bad and while I've not run into it with OMAP in particular it's
> > rather painful when it does happen.
> >
> > It's much better if the branch has the required changes merged into it
> > prior to their being used.
> 
> OK.
> 
> Tony, updated pull request below.  This includes all the TWL depencies
> merged from the 'topic/twl' tag in Mark's tree.

Pulled in this into pm-regulator branch finally.

Tony
