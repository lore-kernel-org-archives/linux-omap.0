From: "Taneja, Archit" <archit@ti.com>
Subject: RE: DSS2 patch series
Date: Fri, 20 Aug 2010 00:13:55 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703064DD0C6@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870305FAB57B@dbde02.ent.ti.com>
	 <1280749895.3436.47.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC35608703061EBA59@dbde02.ent.ti.com>
	 <1280825023.3436.111.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC3560870306287736@dbde02.ent.ti.com>
	 <1280995782.3436.205.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC356087030635EC1D@dbde02.ent.ti.com>
 <1282042346.2348.35.camel@tubuntu.research.nokia.com>
 <FCCFB4CDC6E5564B9182F639FC35608703064DC3F9@dbde02.ent.ti.com>
 <4C6A7354.9010200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42576 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424Ab0HSSoF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 14:44:05 -0400
In-Reply-To: <4C6A7354.9010200@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi Benoit,

Thanks for the comments, ill study how we can leverage the hwmod fw for DSS features.

Archit

> -----Original Message-----
> From: Cousson, Benoit 
> Sent: Tuesday, August 17, 2010 5:03 PM
> To: Taneja, Archit
> Cc: Tomi Valkeinen; Semwal, Sumit; 
> linux-omap@vger.kernel.org; Paul Walmsley; Kevin Hilman
> Subject: Re: DSS2 patch series
> 
> Hi Archit,
> 
> On 8/17/2010 1:16 PM, Taneja, Archit wrote:
> > Hi,
> >
> >> Ok. Well, good that it's clear now =).
> >>
> >>> How do you think we can clean things up?
> >>
> >> If I remember right, there's some kind of feature framework being 
> >> worked on (or ready?), but I haven't looked at that at 
> all. That may 
> >> or may not suit our needs.
> >>
> >> But perhaps we could just have a separate dss_features.c 
> file, which 
> >> would contain a bunch of functions that can be used to ask 
> whether a 
> >> certain feature is supported, and also to ask certain values (max 
> >> dividers or similar).
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
> 
> You can use hwmod to store that as well. Other IPs might 
> require features management, so instead of doing a DSS 
> dedicated solution, you can directly leverage the existing 
> fmwk and extend it to manage your features.
> 
> > One good input was that we can manage internal DSS clocks using the 
> > exisiting clock framework and custom clock modes. I don't know much 
> > about it. Others in the list can probably help out with this :)
> >
> > The present way of handling DSS2 clocks is good, but we 
> need to see if 
> > it can be scalable when more OMAPs come in.
> 
> Good? It works, but this is still redoing what the clocks 
> framework can already do. The good approach will be to encode 
> your clocks nodes using the clock framework, as you've just said.
> 
> > The dss_features.c idea sounds good, we will still have these new 
> > bunch of functions scattered around in the code. But it 
> will be much than an if else chain of omap checks.
> >
> > So should we stick with this idea?
> 
> Using directly the hwmod struct sound a much better idea for 
> my point of view.
> 
> Regards,
> Benoit
> 