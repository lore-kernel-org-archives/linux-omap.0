From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Mon, 30 Aug 2010 15:23:42 -0700
Message-ID: <1283207022.11841.110.camel@localhost>
References: <20100715084118.GB26212@n2100.arm.linux.org.uk>
	 <20100715.120807.39160135.Hiroshi.DOYU@nokia.com>
	 <20100716075243.GB16124@n2100.arm.linux.org.uk>
	 <20100716.121034.193687021.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45090 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946Ab0H3WXt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Aug 2010 18:23:49 -0400
Received: by eyg5 with SMTP id 5so3502066eyg.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Aug 2010 15:23:48 -0700 (PDT)
In-Reply-To: <20100716.121034.193687021.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, pavel@ucw.cz, teerth@ti.com, linux-pm@lists.linux-foundation.org, Yoshiya.Hirase@nokia.com, linux-omap@vger.kernel.org

On Fri, 2010-07-16 at 12:10 +0300, Hiroshi DOYU wrote:
> From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
> Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
> Date: Fri, 16 Jul 2010 09:52:44 +0200
> 
> > On Thu, Jul 15, 2010 at 12:08:07PM +0300, Hiroshi DOYU wrote:
> >> From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
> >> Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
> >> Date: Thu, 15 Jul 2010 10:41:18 +0200
> >> 
> >> > On Thu, Jul 15, 2010 at 08:34:50AM +0300, Hiroshi DOYU wrote:
> >> >> Russell, would it be possible to put this into your next merge queue?
> >> > 
> >> > I think it needs quite a bit of rework - I certainly don't like all
> >> > those CP15 register accesses there - that's asking for lots of ifdefs
> >> > to spring up as more CPUs are supported.
> >> >
> >> > Eg, what about ensuring that state such as iWMMXt on PXA CPUs is
> >> > properly restored?
> >> 
> >> Right. This arch specific part can be something like
> >> "suspend-v[3-7].S" to accomodate those differences
> > 
> > It's not quite that simple - things like iWMMXt aren't part of the ARM
> > arch specs.
> >
> >> > We already have code which knows what needs to be saved across a
> >> > power-off transition - its what we use for our normal suspend/resume
> >> > functionality, so we should look at re-using that code for hibernate
> >> > as well.  We really don't want to be maintaining two sets of code
> >> > doing the same thing.
> >> 
> >> Could you explain which code you're refering for the existing one?
> > 
> > The code which handles saving state for the existing suspend/resume
> > support.  This code already saves the necessary state from CP15 and
> > any other state which needs to be saved prior to putting the system
> > into low power mode.
> > 
> > Every machine class which supports suspend today has their own chunk
> > of code which does this, normally called something like sleep.S
> 
> Ok, it seems to be the way to try to make use of the existing one for
> suspend-to-ram with some modifications.

[sorry to be late to the party here]

At least on OMAP, we already have everything needed to save/restore
context for off-mode transitions handled in the suspend (and idle)
paths.  So, at least in terms of context save/restore, there should be
minimal changes needed there.

Kevin




