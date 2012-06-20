From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: omap: dmtimer: set non-posted mode if iclk
 less than 4*fck
Date: Wed, 20 Jun 2012 07:15:57 -0700
Message-ID: <20120620141557.GO12766@atomide.com>
References: <1336744398-23803-1-git-send-email-tarun.kanti@ti.com>
 <1336744398-23803-3-git-send-email-tarun.kanti@ti.com>
 <87pq9mel9i.fsf@ti.com>
 <CAC83ZvKv_kwvYLG3RfN-ttKXU8pg+yqRGa9S83BAJj6=yeVP2g@mail.gmail.com>
 <20120620131346.GI12766@atomide.com>
 <CAMQu2gxVP7_G2GrYYsL+DhJoKW_iS7+6EG9R5QBU50dXG_roFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46005 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab2FTOP7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 10:15:59 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gxVP7_G2GrYYsL+DhJoKW_iS7+6EG9R5QBU50dXG_roFQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120620 06:21]:
> Tony,
> 
> On Wed, Jun 20, 2012 at 6:43 PM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > * DebBarma, Tarun Kanti <tarun.kanti@ti.com> [120606 04:15]:
> > > On Wed, May 30, 2012 at 2:51 AM, Kevin Hilman <khilman@ti.com> wrote:
> > > > Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> > > >
> > > >> Timers in PER domain periodically report old time from TCRR in
> > > >> posted mode if ick < 4*fck. Therefore, set timer to non-posted
> > > >> whenever ick < 4*fck for all timers.
> > > >
> > > > Is there an erratum assocaited with this?
> > > Yes, but it has not yet got into the document. Right now what we have
> > > is a hardware defect.
> > > >
> > > > Does this problem affect every SoC?
> > > Not quite sure about OMAP2 but it affects OMAP3+.
> >
> > This seems not too urgent and OK to queue into fixes-non-critical?
> >
> Lets hold on this entire series. We are thinking of better WA especially to
> avoid static dependencies. So just ignore this series all together for now.

OK

Tony
