From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] [RFC] dmtimer library is very inefficient today
Date: Tue, 18 Mar 2008 13:51:18 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742903CCA132@dlee13.ent.ti.com>
References: <ae36f8040803061301y6e0823a8pbdf0b6f0b47e5639@mail.gmail.com><3B6D69C3A9EBCA4BA5DA60D91302742903AFC880@dlee13.ent.ti.com><20080307071454.GC7635@atomide.com><3B6D69C3A9EBCA4BA5DA60D91302742903C4A2ED@dlee13.ent.ti.com> <87abkv9917.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43755 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757591AbYCSUEU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2008 16:04:20 -0400
Content-class: urn:content-classes:message
In-Reply-To: <87abkv9917.fsf@paris.hilman.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi Kevin,

> "Woodruff, Richard" <r-woodruff2@ti.com> writes:
> 
> > Here is a patch to look at it.  Seems to work for me.  It adds the
use
> > of posting for the timer.  Previously, every write could lock the
> > requestor for almost 3x32KHz cycles.  This now only synchronizes
before
> > writes and reads instead of after them and it does it on a register
per
> > register basis.  Doing it this way there is some chance to hide some
of
> > the sync latency.  It also removes some needless reads when
non-posted
> > mode is there.
> >
> > The code probably would be a little smaller if a wpost[256] were
used.
> > Probably the structure comes in on the cache line read so it is not
like
> > its adding so much with the ARM running in the hundreds of MHz
range.
> >
> > Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
> 
> I confirm that this indeed works and noticably reduces latency in
> proramming the timers.  I'm running it along with the latency tracer
> which is part of the -rt patch, and have verified that this is no
> longer as noticable of a source of latency.

Great.  Thanks for the verification.  I was expecting the same based on
lauterbach trace information.

> WRT the code, any reason you removed the 'static' and 'inline' from
> the read function?

I had removed it along the way after getting some recursive inline call.
I think those issues are fixed.  It might be they can go back in.

As the function grew in it might be the inline is not wanted.  If it is
only called inside the dmtimer code then the static can go back in.

> Also, a few CodingStyle issues should be cleaned up:
> 
> like:
> 
> -  if(timer->posted)
> +  if (timer->posted)

Ok, I can fix that.

> and upstream folks tend dislike the polling loops like this:
> 
>    while(condition);
> 
> and prefer the semicolon on its own line to be clear that the loop is
> indeed doing nothing.
> 
>    while(condition)
>            ;

Ok. I can fix that.

Regards,
Richard W.

