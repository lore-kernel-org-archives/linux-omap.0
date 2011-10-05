From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [RFC PATCH v2 0/6] TI81XX: Add clock and hwmod data
Date: Wed, 5 Oct 2011 11:37:04 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110051112230.4611@utopia.booyaka.com>
References: <1314119594-22647-1-git-send-email-hemantp@ti.com> <alpine.DEB.2.00.1110040318260.4611@utopia.booyaka.com> <2A3DCF3DA181AD40BDE86A3150B27B6B03B4FB3EA2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50916 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935027Ab1JERhG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 13:37:06 -0400
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4FB3EA2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>

Hello Hemant,

On Wed, 5 Oct 2011, Pedanekar, Hemant wrote:

> Paul Walmsley wrote on Tuesday, October 04, 2011 2:54 PM:
> 
> > I've been spending some time with these patches.  A few aspects don't make
> > much sense to me.  For example, looking at the TRMs, the 816x doesn't seem
> > to have powerdomains for HDVICP0, 1, or 2, although they are listed in the
> > patch.
> 
> Can you please check 18.2.1 in TRM from [1].
> 
> Above powerdomains are listed there as HDVICP2-0, 1, 2.

I see them there in SPRUGX8.  But the most recent revision of the 816x TRM 
is SPRUGX9, correct? 

http://focus.ti.com/general/docs/lit/getliterature.tsp?literatureNumber=sprugx9&fileType=pdf

SPRUGX9 doesn't list these three powerdomains.

If they're really there, then we should definitely keep your original data 
based on SPRUGX8.  Maybe you could get some clarification on that from the 
hardware people?

> > Will send over the current reworked patches for TI81XX PRCM accessors,
> > powerdomain code & data, and clockdomain code & data.  They are intended
> > to apply over the TI814x patches that you sent recently.  I'd like to get
> > your opinion(s) on these reworked patches.  Please note, so far they have
> > only been compile-tested.
> 
> Thanks, I will try those and respond.

Since they've only been compile-tested so far, they are unlikely to boot.  
What I'm most interested in at this point are any comments you might have 
about the general approach.  For example:

1. considering the first patch, it would be good to get your views on my 
perception that:

A. the TI81xx PRCM is effectively a single IP block, with a single 
interconnect target port, with multiple internal PRM/CM instances mixed in 
the same IP block;

B. that in some of the internal PRM and CM instances, the register layout 
is identical between 816x and 814x, and that those macros, etc. should be 
shared; with the 816x-specific macros split into an 816x-specific file and 
the 814x-specific macros split into an 814x-specific file;

C. the CM register structure is closer to the OMAP4430 CM register 
structure than it is to OMAP3, with the important exception that the 
CLKSTCTRL and CLKCTRL registers are not grouped together for each 
clockdomain.  Instead, all of the the CLKSTCTRL registers are grouped 
together, followed by the CLKCTRL registers all grouped together, and 
therefore, the OMAP4 *_CDOFFS & OMAP3 *_CLKDM* macro style is basically 
useless;

and

2. considering the second and fourth patches,

A. that given the different power management functionality of TI81xx 
compared to OMAP4 & OMAP3, that it makes sense to create a new 
powerdomain/clockdomain code implementation file, rather than attempting 
to modify the OMAP2/3 file;

B. that we should discuss whether it makes sense to remove the powerdomain 
names from the clockdomain names, if we can share clock nodes or hwmod 
nodes for L3_MED and L3_SLOW between 814x and 816x;

and

3. considering the third and fifth patches,

A. that the modified powerdomain and clockdomain data (per SPRUGX9) is 
correct vs the SPRUGX8 data;

B. that the 814x powerdomains/clockdomains that have been added are 
accurate.


- Paul
