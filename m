From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
Date: Sun, 21 Mar 2010 04:30:00 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703045F314F@dbde02.ent.ti.com>
References: <20100320003605.GA11448@atomide.com>
 <20100320004746.GB11448@atomide.com> <20100320024827.GC11448@atomide.com>
 <20100320030239.GD11448@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57048 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752508Ab0CTXAP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Mar 2010 19:00:15 -0400
In-Reply-To: <20100320030239.GD11448@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pais, Allen" <allen.pais@ti.com>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Friday, March 19, 2010 10:03 PM
> To: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> Cc: Pais, Allen; Pandita, Vikram
> Subject: Re: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
> 
> * Tony Lindgren <tony@atomide.com> [100319 19:43]:
> > * Tony Lindgren <tony@atomide.com> [100319 17:42]:
> > > * Tony Lindgren <tony@atomide.com> [100319 17:30]:
> > > > Hi all,
> > > >
> > > > Got a zoom3 finally! This is needed to boot with DEBUG_LL +
> earlyprintk.
> > >
> > > And of course it won't compile because of a missing #.
> > > Here's the working version.
> >
> > One more time. Looks like what I posted is not enough, we
> > also need to make sure the mapping does not overlap with
> > other regions. So basically we can't use 0xfb000000 like
> > we currently have, let's use 0xf7000000 instead unless
> > somebody has better ideas.
> 
> And now 0xf7000000 is in vmalloc area.. Needs to be looked
> more.

On internal TI trees, we do have 0xfa400000 working.
Guess that is the magic number.

> 
> Tony
