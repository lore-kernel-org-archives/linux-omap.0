From: "Taneja, Archit" <archit@ti.com>
Subject: RE: DSS2 patch series
Date: Tue, 10 Aug 2010 15:03:05 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087030635EC1D@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870305FAB57B@dbde02.ent.ti.com>
	 <1280749895.3436.47.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC35608703061EBA59@dbde02.ent.ti.com>
	 <1280825023.3436.111.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC3560870306287736@dbde02.ent.ti.com>
 <1280995782.3436.205.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36521 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756466Ab0HJJdR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 05:33:17 -0400
In-Reply-To: <1280995782.3436.205.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "Semwal, Sumit" <sumit.semwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com] 
> Sent: Thursday, August 05, 2010 1:40 PM
> To: Taneja, Archit
> Cc: Semwal, Sumit; linux-omap@vger.kernel.org
> Subject: RE: DSS2 patch series
> 
> On Thu, 2010-08-05 at 09:06 +0200, ext Taneja, Archit wrote:
> > Hi,
> > 
> > > 
> > > Also, we should think how to reduce if (cpu_is_omap44xx()) lines. 
> > > There should be some kind of DSS capability list somewhere, which 
> > > would tell the features available. I haven't thought this 
> more, but 
> > > it'd be very nice if we could use the DSS HW version number to 
> > > decide what features there are.
> > > 
> > > However, TI answered that information about DSS HW 
> version numbers 
> > > is not available, and thus cannot be used =(. Perhaps you 
> could try 
> > > to dig out some information from inside TI?
> > > 
> > 
> > I read the DSS_REVISON, DISPC_REVISION etc registers on 
> 3430, 3630, 4430:
> > 
> > 3430: DSS rev 2.0, DISPC rev 3.0, RFBI rev 1.0, DSI rev 
> 1.0, VENC rev 
> > 2
> > 3630: DSS rev 2.0, DISPC rev 3.0, RFBI rev 1.0, DSI rev 
> 1.0, VENC rev 
> > 2
> > 4430: DSS rev 4.0, DISPC rev 4.0, DSI rev 3.0, RFBI rev 3.5
> > 
> > I haven't tried on OMAP2 yet..
> > 
> > Don't you think these revision numbers are enough to 
> differentiate the 
> > features of each IP block?
> 
> Perhaps. The problem is, I don't know what the version 
> numbers mean, ie.
> when are they changed, what are the changes. I would hope you 
> that you could find some internal info inside TI that would 
> explain the differences =).
[Archit] I have collected some information about what these revision
numbers mean from the TI folks. The following is what I have gathered:

-For each broad version of OMAP, like OMAP3430, OMAP3630, OMAP4430 and so on,
there is an independent revision list. These are changed/incremented when
the corresponding IP blocks are modified. The numbers which we see are probably
the ones which were chosen to put into the silicon.

So, it is possible that the revision numbers of ES_1 of OMAP3430 is exactly the
same as the ES_1 of OMAP3630 even if the IP blocks have changed. This is what is
seen in the prints of the revision of 3430 and 3630 I sent in the previous mail.

These revision numbers are hence useful only within the revisions of a particular
OMAP. It looks like that there is no single revision chain since OMAP2.

-After discussions with more TI DSS folks, it seems that some changes that we may
need to make in DSS software may not be dependent on the DSS hardware at all. For example,
the patch "OMAP3630:DSS2: Updating MAX divider value" was introduced because of a change
in PRCM.

So it seems that we will need to have omap2, omap3 and omap4 checks , best we can
do is prevent them from scattering around, i.e have them at a single place during
initialization.

How do you think we can clean things up?

Archit

> 
> We can of course reverse engineer the version numbers, and 
> hope that we decipher them correctly. For OMAP3430/3630/4430 
> the differences look clear.
> 
> But how about OMAP rev changes? For example, at some 3430 
> revision the bitfield lengths of video timing registers were 
> changed. Does it show on DSS/DISPC version numbers? I don't 
> think I have boards with those revs, so I can't check.
> 
>  Tomi
> 
> 
> 