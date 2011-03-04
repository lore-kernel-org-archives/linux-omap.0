From: Ben Tucker <btucker@mpcdata.com>
Subject: RE: OMAP2,3: DSS2: Report -EBUSY when to many registered isr
Date: Fri, 4 Mar 2011 09:32:37 -0000
Message-ID: <30fa969aa5e0ff131b9af03df567437b@mail.gmail.com>
References: <1295585610-24179-1-git-send-email-btucker@mpcdata.com> <1298280509.4931.36.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60995 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834Ab1CDJcf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 04:32:35 -0500
Received: by eyx24 with SMTP id 24so631671eyx.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 01:32:34 -0800 (PST)
In-Reply-To: <1298280509.4931.36.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Ben Tucker <btucker@mpc-data.co.uk>

Thankyou Tomi. Please go ahead and fix the bug yourself.

Ben


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@ti.com]
> Sent: 21 February 2011 09:28
> To: Ben Tucker
> Cc: linux-omap@vger.kernel.org; Ben Tucker
> Subject: Re: OMAP2,3: DSS2: Report -EBUSY when to many registered isr
>
> Hi,
>
> On Fri, 2011-01-21 at 04:53 +0000, Ben Tucker wrote:
> > From: Ben Tucker <btucker@mpc-data.co.uk>
> >
> > This patch fixes a problem with map_dispc_register_isr() where it
> > fails to return -EBUSY if it has no more space for registrations.
>
> Looks correct, but a couple of things:
> - Missing signed-off
> - Indentation is wrong
> - Don't use { } when there's just one line in the if block
>
> Please fix those, or alternatively I can fix the bug myself and add you
> as reported-by.
>
>  Tomi
>
>
> >
> > ---
> > drivers/video/omap2/dss/dispc.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/video/omap2/dss/dispc.c
> b/drivers/video/omap2/dss/dispc.c
> > index e0e8275..f566177 100644
> > --- a/drivers/video/omap2/dss/dispc.c
> > +++ b/drivers/video/omap2/dss/dispc.c
> > @@ -2579,6 +2579,10 @@ int omap_dispc_register_isr(omap_dispc_isr_t
> isr, void *arg, u32 mask)
> >  		break;
> >  	}
> >
> > +    if (ret) {
> > +        goto err;
> > +    }
> > +
> >  	_omap_dispc_set_irqs();
> >
> >  	spin_unlock_irqrestore(&dispc.irq_lock, flags);
>
