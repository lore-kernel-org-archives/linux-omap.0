From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC] Common mechanism to identify Si revision
Date: Mon, 7 Sep 2009 18:32:33 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD6C436A@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD60FFF2@dbde02.ent.ti.com>
 <20090906124639.GA22239@lixom.net>
 <B85A65D85D7EB246BE421B3FB0FBB59301DD6C3EBD@dbde02.ent.ti.com>
 <20090907123404.GA26304@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52881 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422AbZIGNCr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Sep 2009 09:02:47 -0400
In-Reply-To: <20090907123404.GA26304@lixom.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Olof Johansson [mailto:olof@lixom.net] 
> Sent: Monday, September 07, 2009 6:04 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [RFC] Common mechanism to identify Si revision
> 
> Hi,
> 
> On Mon, Sep 07, 2009 at 11:33:32AM +0530, Premi, Sanjeev wrote:
> 
> > > What's the purpose of most of these checks in the first 
> place? I can
> > > see two immediate needs:
> > > 
> > > 1) To check for various errata and do appropriate workarounds
> > 
> > [sp] I believe the only need would be to make easy check if 
> the version
> >      has multiple errata fixes and/or enhancements. And, of 
> course, a
> >      verbose information to user who may not have (and may not need)
> >      information of all the errata/enhancements.
> > 
> >      Today, there are multiple ways of doing the same 
> thing... Each way
> >      builds upon minor issues in the existing one; but adds its own.
> 
> Yeah, ok. I was just fearing that this added ES-level 
> checking would be
> used to clutter up the code with extra testing instead of 
> hiding it away in
> header files. But it seems like most of it is covered already.
> 
> 
> > > 2) To check if the current chip has a certain feature
> > > 
> > > Both of these could just as well be abstracted away such 
> that you use
> > > tests on the form:
> > > 
> > > 	if (OMAP_HAS_ERRATA_FOO) ...
> > > 
> > > or:
> > > 	if (OMAP_FEATURE_FOO) ...
> > > 
> > > And then move the actual checking of a feature into the 
> header file
> > > where the errata/feature setups are defined.
> > 
> > [sp I have submitted a patch that takes the first step toward this:
> >     http://marc.info/?l=linux-omap&m=125050987112798&w=2
> >     ...still waiting to hear from Tony on this.
> 
> Looks good. I didn't subscribe to linux-omap until recently so I don't
> have the original emails (and thus can't comment on them), but my only
> feedback is that it really doesn't belong in /proc/cpuinfo whether a
> SoC has SGX on-chip or not. 
> 
> It'd be better to move that information somewhere else. Keep in mind
> that adding information to a /proc file means that you are changing an
> API that we would need to live with forever.
> 
> > > There's two major benefits to this:
> > > 
> > > 1) Readability. No need to sit and look up in a manual 
> why there's a
> > > check for version X here.
> > >  (and/or no need to add a specific comment about it).
> > > 
> > > 2) Keeping changes centralized. If there's a new revision or chip,
> > > there's just one header file to update, not 20 different 
> source files.
> > > 
> > > For example, a bunch of the checks in pm34xx.c would be nicer 
> > > to have as:
> > > 
> > > 	if (OMAP_HAS_USBHOST()) 
> > 
> > [sp] Can you look and comment on this discussion as well:
> >      http://marc.info/?l=linux-omap&m=125017671720718&w=2
> 
> I think it is a great step in the right direction. My only concern is
> that the usage conventions are confusing:
> 
> OMAP3_HAS_FEATURE(neon, NEON)

[sp] This is only used to declare a function that would translate to:
     unsigned int omap3_has_neon(void)
     {
	     return (omap_features & OMAP_HAS_NEON);
     }
     EXPORT_SYMBOL(omap3_has_neon);

     A user would always do something like:
     if (omap_has_neon())
         do_neon_specific_stuff();

Best regards,
Sanjeev
> 
> Just seeing that, what is the difference between neon and NEON? Also,
> it always requires two consecutive calls to check for a feature (get
> the flags, then check the mask).
> 
> I would personally prefer to keep a global that is initialized early
> in boot (called __omap_features or so -- the __-prefix would indicate
> that it is not for direct use in code), then have OMAP3_HAS_FEATURE()
> just look at that value instead of having it passed in. It's not like
> it changes during runtime anyway.
> 
> It can be debated if the format should then be 
> OMAP3_HAS_FEATURE_SGX or
> OMAP3_HAS_FEATURE(SGX), but either is fine with me.
> 
> 
> -Olof
> 
> 