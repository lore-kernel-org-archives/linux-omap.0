From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: DSS2 patch series
Date: Tue, 17 Aug 2010 14:39:44 +0300
Message-ID: <1282045184.2348.49.camel@tubuntu.research.nokia.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870305FAB57B@dbde02.ent.ti.com>
	 <1280749895.3436.47.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC35608703061EBA59@dbde02.ent.ti.com>
	 <1280825023.3436.111.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC3560870306287736@dbde02.ent.ti.com>
	 <1280995782.3436.205.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC356087030635EC1D@dbde02.ent.ti.com>
	 <1282042346.2348.35.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC35608703064DC3F9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:52922 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab0HQLjz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 07:39:55 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703064DC3F9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "Semwal, Sumit" <sumit.semwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2010-08-17 at 13:16 +0200, ext Taneja, Archit wrote:
> Hi,
> 
> > Ok. Well, good that it's clear now =).
> > 
> > > How do you think we can clean things up?
> > 
> > If I remember right, there's some kind of feature framework 
> > being worked on (or ready?), but I haven't looked at that at 
> > all. That may or may not suit our needs.
> > 
> > But perhaps we could just have a separate dss_features.c 
> > file, which would contain a bunch of functions that can be 
> > used to ask whether a certain feature is supported, and also 
> > to ask certain values (max dividers or similar).
> 
> I talked to some more folks about this. To summarize:
> 
> - The revision registers aren't reliable enough, it's better to
> use the combination of cpu_is_xxxx and and omap_rev macros. These
> should be enough for making an DSS specific feature list.
> 
> -The feature framework(HWMOD) can help out with the following things
> 	- The internal IP blocks within DSS.
> 	- The PRCM clocks and IRQs coming to DSS, and PM stuff which I don't
> 	know much about.
> 	- Effectively, the information on how the outside world communicates with DSS.
> 
> -DSS features like number of vid pipelines, supported color modes,internal clocks
> and PLL info, bit fields needs to be managed by us.
> 
> One good input was that we can manage internal DSS clocks using the exisiting
> clock framework and custom clock modes. I don't know much about it. Others
> in the list can probably help out with this :)
> 
> The present way of handling DSS2 clocks is good, but we need to see if it can be
> scalable when more OMAPs come in.
> 
> The dss_features.c idea sounds good, we will still have these new bunch of functions
> scattered around in the code. But it will be much than an if else chain of omap checks.
> 
> So should we stick with this idea?

Yes, and even if the dss_features.c isn't what is needed in the end,
it'll still be easier to convert to whatever way we want in the future.

But this is also not a very high priority thing. So I don't see a need
to start converting everything to use dss_features.c right away. We can
start by converting the places where OMAP4 changes require feature
checks.

 Tomi


