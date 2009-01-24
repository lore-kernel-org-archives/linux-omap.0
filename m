From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] usb: musb: fix bug in musbhsdma programming
Date: Sat, 24 Jan 2009 08:34:52 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403FA6CCD3A@dbde02.ent.ti.com>
References: <1231417896-32363-1-git-send-email-ajay.gupta@ti.com>
 <20090123101812.GP9233@scadufax.research.nokia.com>,<200901231036.04376.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32933 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956AbZAXDFM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 22:05:12 -0500
In-Reply-To: <200901231036.04376.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> On Thu, Jan 08, 2009 at 06:01:36PM +0530, Ajay Kumar Gupta wrote:
> > Mode bit should be set based on function parameter "mode" of
> > configure_channel() function.
> >
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
>
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

> NAK -- interpretation of the MODE parameter is correct
> (t hough it's not clear to me that the callers set it right),
> but this won't apply to current GIT since the code differs.

> I don't know what this is *against* but it's not mainline
> or the OMAP tree...

>        csr |= (musb_channel->epnum << MUSB_HSDMA_ENDPOINT_SHIFT)
>                | (1 << MUSB_HSDMA_ENABLE_SHIFT)
>                | (1 << MUSB_HSDMA_IRQENABLE_SHIFT)
>                | (musb_channel->transmit
>                                ? (1 << MUSB_HSDMA_TRANSMIT_SHIFT)
>                                : 0);

>Ajay, if this needs to merge to mainline (e.g. so it can be
>pulled down to omap-git and fix DMA there) please re-issue.

This patch is not for mainline. 
It is intended for MV's OMAP GIT to solve the bug introduced by [1] below
and is already applied at [2], the modified version of this patch. 

As [1] is not yet gone to mainline so this patch is also not required in mainline.

[1] usb: musb: musbhsdma cleanup
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6-historic.git;a=commitdiff;h=cd66af4a8d9ea5923e9e935a9d6fb7bded6e1655
[2]usb: musb: fix bug in musbhsdma programming
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6-historic.git;a=commitdiff;h=15f75b6226c2d3b82062bb721e7cb9a1d6f35efd

-Ajay
>- Dave

>
> > ---
> >  drivers/usb/musb/musbhsdma.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> > index a23d005..d87c6c7 100644
> > --- a/drivers/usb/musb/musbhsdma.c
> > +++ b/drivers/usb/musb/musbhsdma.c
> > @@ -225,13 +225,14 @@ static void configure_channel(struct dma_channel *channel,
> >                     csr |= MUSB_HSDMA_BURSTMODE_INCR4;
> >
> >             csr |= (musb_channel->epnum << MUSB_HSDMA_ENDPOINT_SHIFT)
> > -                   | MUSB_HSDMA_MODE1
> >                     | MUSB_HSDMA_ENABLE
> >                     | MUSB_HSDMA_IRQENABLE
> >                     | (musb_channel->transmit
> >                                     ? MUSB_HSDMA_TRANSMIT
> >                                     : 0);
> >
> > +           if (mode)
> > +                   csr |= MUSB_HSDMA_MODE1;
> >             /* address/count */
> >             musb_write_hsdma_addr(mbase, bchannel, dma_addr);
> >             musb_write_hsdma_count(mbase, bchannel, len);
> > --
> > 1.5.6
>
> --
> balbi
>
>



