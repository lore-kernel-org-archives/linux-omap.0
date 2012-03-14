From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] OMAPDSS: Ensure OPP100 when DSS is operational
Date: Wed, 14 Mar 2012 08:38:51 +0200
Message-ID: <1331707131.1618.7.camel@lappy>
References: <1331205217-19927-1-git-send-email-tomi.valkeinen@ti.com>
	 <1331205217-19927-2-git-send-email-tomi.valkeinen@ti.com>
	 <1331646353.2856.354.camel@deskari>  <87zkbkmjo1.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:47059 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751785Ab2CNGi6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Mar 2012 02:38:58 -0400
Received: by lahc1 with SMTP id c1so1334144lah.40
        for <linux-omap@vger.kernel.org>; Tue, 13 Mar 2012 23:38:55 -0700 (PDT)
In-Reply-To: <87zkbkmjo1.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, archit@ti.com

On Tue, 2012-03-13 at 11:37 -0700, Kevin Hilman wrote:
> Hi Tomi,
> 
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
> 
> > Hi Kevin, Paul,
> >
> > I know you're busy, but I'd appreciate a comment/ack on these two small
> > patches, so I could get them in to next merge window. Otherwise using
> > any other OPP than OPP100 will most likely break the DSS.
> >
> > This looks quite straightforward fix for me, but I'm not sure if there
> > could be any side effects.
> 
> How does it affect OMAP3?  OPP50/OPP100 names are specific to OMAP4.

They are? At least 3630 TRM speaks of them in the DSS chapter.

> Also, Can you help us understand the exact nature of the constraint?

The TRM lists maximum clock rates for the DSS clocks. You should be able
to find them by searching "OPP100" in the DSS chapter. In my TRMs there
are:

OMAP3630: Table 7-19. Display Subsystem Clocks
OMAP4430: Table 10-4. DSS Clock Frequencies

> It sounds to me like it acutally is a throughput constraint on CORE.  If
> so, wouldn't it be clearer to set a throughput constraint that is
> calculated based on the pixel clock and resulting bitrate that would
> have the same effect?

I don't see that these limits would have anything to do with CORE. I'm
guessing that the DSS HW just can't function properly with high clocks
and low voltage.

Making a constraint for the throughput is another matter, which should
be also fixed at some point. So in the future I hope we'll have PM
constraints coming from two sources: 1) a calculation based on the
memory throughput needs 2) the minimum clock rates.

But both of those are non-trivial to code, so this patch aims to keep
DSS working until those are implemented. Also, in practice, it's quite
rare that the DSS clocks would all be below the limits in the tables.
That could only happen with a fixed, known configuration with rather
small displays.

 Tomi


