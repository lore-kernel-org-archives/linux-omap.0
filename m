From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/2] ARM: omap: dmtimer: set non-posted mode if iclk less
 than 4*fck
Date: Wed, 20 Jun 2012 18:47:10 +0530
Message-ID: <CAMQu2gxVP7_G2GrYYsL+DhJoKW_iS7+6EG9R5QBU50dXG_roFQ@mail.gmail.com>
References: <1336744398-23803-1-git-send-email-tarun.kanti@ti.com>
 <1336744398-23803-3-git-send-email-tarun.kanti@ti.com> <87pq9mel9i.fsf@ti.com>
 <CAC83ZvKv_kwvYLG3RfN-ttKXU8pg+yqRGa9S83BAJj6=yeVP2g@mail.gmail.com> <20120620131346.GI12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:40674 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751595Ab2FTNRc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jun 2012 09:17:32 -0400
Received: by qabg27 with SMTP id g27so3011183qab.14
        for <linux-omap@vger.kernel.org>; Wed, 20 Jun 2012 06:17:30 -0700 (PDT)
In-Reply-To: <20120620131346.GI12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com

Tony,

On Wed, Jun 20, 2012 at 6:43 PM, Tony Lindgren <tony@atomide.com> wrote:
>
> * DebBarma, Tarun Kanti <tarun.kanti@ti.com> [120606 04:15]:
> > On Wed, May 30, 2012 at 2:51 AM, Kevin Hilman <khilman@ti.com> wrote:
> > > Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> > >
> > >> Timers in PER domain periodically report old time from TCRR in
> > >> posted mode if ick < 4*fck. Therefore, set timer to non-posted
> > >> whenever ick < 4*fck for all timers.
> > >
> > > Is there an erratum assocaited with this?
> > Yes, but it has not yet got into the document. Right now what we have
> > is a hardware defect.
> > >
> > > Does this problem affect every SoC?
> > Not quite sure about OMAP2 but it affects OMAP3+.
>
> This seems not too urgent and OK to queue into fixes-non-critical?
>
Lets hold on this entire series. We are thinking of better WA especially to
avoid static dependencies. So just ignore this series all together for now.

Regards
Santosh
