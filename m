From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/8] OMAP2+: hwmod/clockevent: allow late-init of
 individual hwmods
Date: Fri, 4 Mar 2011 22:18:10 +0530
Message-ID: <d0a7ba9bd56a8522eca446a4a1ebaa74@mail.gmail.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
 <4D651998.3040002@ti.com> <alpine.DEB.2.00.1102271928550.505@utopia.booyaka.com>
 <4D6B845A.9000900@ti.com> <20110302175422.GY20560@atomide.com>
 <4D6F7723.5040001@ti.com> <4D70FC5B.9040701@ti.com> <20110304161933.GV20560@atomide.com>
 <4D7115BF.7000009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:45233 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759801Ab1CDQsM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 11:48:12 -0500
Received: by mail-qy0-f174.google.com with SMTP id 7so314871qyk.12
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 08:48:11 -0800 (PST)
In-reply-to: <4D7115BF.7000009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Thara Gopinath <thara@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Rajendra Nayak <rnayak@ti.com>

> -----Original Message-----
> From: Cousson, Benoit [mailto:b-cousson@ti.com]
> Sent: Friday, March 04, 2011 10:09 PM
> To: Tony Lindgren
> Cc: Paul Walmsley; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Hilman, Kevin; Shilimkar, Santosh;
> Gopinath, Thara; DebBarma, Tarun Kanti; Nayak, Rajendra
> Subject: Re: [PATCH 0/8] OMAP2+: hwmod/clockevent: allow late-init
> of individual hwmods
>
> On 3/4/2011 5:19 PM, Tony Lindgren wrote:
> > * Cousson, Benoit<b-cousson@ti.com>  [110304 06:49]:
> >>
> >> Tony,
> >> Do you plan to re-merge this branch or should I just send a
> revert
> >> on top of it?
> >
> > Please just provide a patch.
> >
> > Regards,
> >
> > Tony
>
> I posted it with the one from Rajendra to fix the regression with
> Santosh's series, but I do need Santosh to rebase and re-test the
> second one.
>
I just replied on another thread Benoit. I still see an issue with MPU
OFF.

Regards,
Santosh
