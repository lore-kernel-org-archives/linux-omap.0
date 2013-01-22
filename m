From: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Subject: Re: [PATCH 3/4] ARM: mach-omap2: apply the errata at run time
 rather
Date: Tue, 22 Jan 2013 12:19:32 +0530
Message-ID: <20130122064931.GA21159@bnru10>
References: <20130121131613.GA29876@bnru10>
 <20130121182236.GE22517@atomide.com>
 <20130122060145.GB22429@bnru10>
 <50FE350C.6080504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:54671 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752638Ab3AVGty (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jan 2013 01:49:54 -0500
Content-Disposition: inline
In-Reply-To: <50FE350C.6080504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 22, 2013 at 07:43:24 +0100, Santosh Shilimkar wrote:
> On Tuesday 22 January 2013 11:31 AM, Srinidhi Kasagar wrote:
> > On Mon, Jan 21, 2013 at 19:22:37 +0100, Tony Lindgren wrote:
> >> * srinidhi kasagar <srinidhi.kasagar@stericsson.com> [130121 05:19]:
> >>
> >> Forgot to complete the subject and add the description?
> >
> > No :) It has the subject, but description is intentionally skipped
> > because subject has all the meaning and it is a part of the series
> > of patches I sent..
> >
> "ARM: mach-omap2: apply the errata at run time rather"
> 
> Subject doesn't have all the meaning till you read the series ;)
> Like, this is Pl310 XYZ errata etc. Anyway once you sort
> out the concerns from RMK and with a few lines of
> description on subject patch, you can add my ack on OMAP
> patches.

thanks, the description part will be fixed.
Can you check RMK's comment on set_debug patch, patch 1/4? I need
your comment on that to roll it over because set_debug is something
which is OMAP specific..

> 
> Thanks a lot for doing this.
> 
> Regards,
> Santosh
