From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC 10/12] omap: mcbsp: Move sidetone clock management to
 mach-omap2/mcbsp.c
Date: Fri, 1 Jul 2011 03:34:25 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107010331230.27025@utopia.booyaka.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com> <1309510356-27147-11-git-send-email-jhnikula@gmail.com> <alpine.DEB.2.00.1107010317460.27025@utopia.booyaka.com> <4E0D92CC.5030006@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40372 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161Ab1GAJe0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 05:34:26 -0400
In-Reply-To: <4E0D92CC.5030006@ti.com>
Content-ID: <alpine.DEB.2.00.1107010332101.27025@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>

cc'ing Kishon 

On Fri, 1 Jul 2011, Cousson, Benoit wrote:

> On 7/1/2011 11:23 AM, Paul Walmsley wrote:
> > On Fri, 1 Jul 2011, Jarkko Nikula wrote:
> > 
> > > Active sidetone requires that McBSP interface clock doesn't idle and there
> > > is no mechanism in hwmod to turn autoidling on/off in runtime. McBSP2 and
> > > 3
> > > in OMAP34xx share their interface clock with McBSP sidetone module and
> > > that interface clock must be active when the sidetone is operating.
> > > 
> > > Sidetone has its own autoidle bit which should keep the interface clock
> > > active but it is broken. Putting the McBSP core to no-idle mode when the
> > > sidetone is active is no good either since it results to higher power
> > > consumption when using the threshold based DMA transfers.
> > 
> > In the hwmod code/data, we've got the OCPIF_SWSUP_IDLE flag that can be
> > set on a struct omap_hwmod_ocp_if.  I think this is probably what's needed
> > here.  The only problem is that we haven't linked that to the clock code
> > to deny idle on the interface clock yet (see omap_hwmod.c:_setup()).
> > Adding that code in, plus adding that OCPIF_SWSUP_IDLE flag to the
> > McBSP2/3 data, seems like the right approach here.
> > 
> > I guess we also will need some basic usecounting for denying idle in the
> > clock code.
> > 
> > Otherwise these direct register manipulations of clock registers, outside
> > the clock code, could turn into a mess :-(
> 
> AFAIR Kishon did submit some patches to expose this feature to the driver
> through omap_device API. The point is that other broken IP like SDMA of USB
> will require such feature.
> 
> Didn't we pull them?

You sent him some comments on March 1 but it looks like the series never 
got updated and reposted, at least not that I can find in my mail 
archive.  Kishon?

Anyway, those patches won't help in this case if the sidetone AUTOIDLE bit 
is broken - looks like the interface clock autoidle bit is what needs to 
change.


- Paul
