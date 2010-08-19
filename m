From: "Taneja, Archit" <archit@ti.com>
Subject: RE: DSS2 patch series
Date: Fri, 20 Aug 2010 03:03:57 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703064DD0E3@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870305FAB57B@dbde02.ent.ti.com>
	 <1280749895.3436.47.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC35608703061EBA59@dbde02.ent.ti.com>
	 <1280825023.3436.111.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC3560870306287736@dbde02.ent.ti.com>
	 <1280995782.3436.205.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC356087030635EC1D@dbde02.ent.ti.com>
	 <1282042346.2348.35.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC35608703064DC3F9@dbde02.ent.ti.com>
 <1282045184.2348.49.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33695 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753636Ab0HSVeG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 17:34:06 -0400
In-Reply-To: <1282045184.2348.49.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "Semwal, Sumit" <sumit.semwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi, 

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com] 
> Sent: Tuesday, August 17, 2010 5:10 PM
> To: Taneja, Archit
> Cc: Semwal, Sumit; linux-omap@vger.kernel.org
> Subject: RE: DSS2 patch series
> 
> On Tue, 2010-08-17 at 13:16 +0200, ext Taneja, Archit wrote:
> > Hi,
> > 
> > > Ok. Well, good that it's clear now =).
> > > 
> > > > How do you think we can clean things up?
> > > 
> > > If I remember right, there's some kind of feature framework being 
> > > worked on (or ready?), but I haven't looked at that at 
> all. That may 
> > > or may not suit our needs.
> > > 
> > > But perhaps we could just have a separate dss_features.c 
> file, which 
> > > would contain a bunch of functions that can be used to 
> ask whether a 
> > > certain feature is supported, and also to ask certain values (max 
> > > dividers or similar).
> > 
> > I talked to some more folks about this. To summarize:
> > 
> > - The revision registers aren't reliable enough, it's better to use 
> > the combination of cpu_is_xxxx and and omap_rev macros. 
> These should 
> > be enough for making an DSS specific feature list.
> > 
> > -The feature framework(HWMOD) can help out with the following things
> > 	- The internal IP blocks within DSS.
> > 	- The PRCM clocks and IRQs coming to DSS, and PM stuff 
> which I don't
> > 	know much about.
> > 	- Effectively, the information on how the outside world 
> communicates with DSS.
> > 
> > -DSS features like number of vid pipelines, supported color 
> > modes,internal clocks and PLL info, bit fields needs to be 
> managed by us.
> > 
> > One good input was that we can manage internal DSS clocks using the 
> > exisiting clock framework and custom clock modes. I don't know much 
> > about it. Others in the list can probably help out with this :)
> > 
> > The present way of handling DSS2 clocks is good, but we 
> need to see if 
> > it can be scalable when more OMAPs come in.
> > 
> > The dss_features.c idea sounds good, we will still have these new 
> > bunch of functions scattered around in the code. But it 
> will be much than an if else chain of omap checks.
> > 
> > So should we stick with this idea?
> 
> Yes, and even if the dss_features.c isn't what is needed in 
> the end, it'll still be easier to convert to whatever way we 
> want in the future.
> 
> But this is also not a very high priority thing. So I don't 
> see a need to start converting everything to use 
> dss_features.c right away. We can start by converting the 
> places where OMAP4 changes require feature checks.
> 
>  Tomi
> 

Okay, I'll come up with a way to implement the dss_features.c idea,
I'll also try to learn how we can use hwmod for dss specific features.

Archit