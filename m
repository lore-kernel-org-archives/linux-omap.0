From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v6 0/7] OMAP: WDT: Implement WDT in hwmod way
Date: Tue, 21 Sep 2010 18:35:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009211833150.4677@utopia.booyaka.com>
References: <1284733136-20952-1-git-send-email-charu@ti.com> <20100917172215.GE29610@atomide.com> <87mxrguhhf.fsf@deeprootsystems.com> <20100920171653.GE4611@atomide.com> <87sk14rvik.fsf@deeprootsystems.com> <20100920205630.GJ4611@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48717 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab0IVAfl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 20:35:41 -0400
In-Reply-To: <20100920205630.GJ4611@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Varadarajan, Charulatha" <charu@ti.com>, wim@iguana.be, linux-watchdog@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org

On Mon, 20 Sep 2010, Tony Lindgren wrote:

> * Kevin Hilman <khilman@deeprootsystems.com> [100920 13:40]:
> > Tony Lindgren <tony@atomide.com> writes:
> > 
> > > So let's get all the dependencies out of the way and pull them into linux-omap
> > > master branch for testing. Sounds like we should base this on Paul's core
> > > hwmod branch and your pm-next.
> > 
> > Yes, those two branches are required as the bare minimum.

Just a quick note - the branch

git://git.pwsan.com/linux-2.6 hwmod_2.6.37

contains the current set of hwmod core patches that I'd like to get 
upstream for 2.6.37.  Will send a pull request tomorrow.

I plan to have a few more branches for 2.6.37 with some SCM, SDRC, clock, 
clockdomain, and powerdomain patches.  Will post those separately and also 
assemble a composite 'for_2.6.37' branch with both the hwmod and the 
clock/clockdomain/powerdomain/SCM/SDRC patches.

regards,


- Paul
