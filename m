From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [Resend][PATCH] Maintainers update for hsmmc driver
Date: Thu, 6 Aug 2009 14:31:28 -0500
Message-ID: <001401ca16cc$7eb41130$544ff780@am.dhcp.ti.com>
References: <44306.192.168.10.88.1249576131.squirrel@dbdmail.itg.ti.com> <20090806190602.GA4124@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38415 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbZHFTbh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 15:31:37 -0400
In-Reply-To: <20090806190602.GA4124@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, "'Lavinen Jarkko (Nokia-D/Helsinki)'" <jarkko.lavinen@nokia.com>, "'Hunter Adrian (Nokia-D/Helsinki)'" <adrian.hunter@nokia.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Felipe Balbi
> Sent: Thursday, August 06, 2009 2:06 PM
> To: ext Madhusudhan Chikkature
> Cc: tony@atomide.com; linux-omap@vger.kernel.org; Lavinen Jarkko (Nokia-
> D/Helsinki); Hunter Adrian (Nokia-D/Helsinki)
> Subject: Re: [Resend][PATCH] Maintainers update for hsmmc driver
> 
> On Thu, Aug 06, 2009 at 06:28:51PM +0200, ext Madhusudhan Chikkature
> wrote:
> > Hi,
> >
> > Resending the patch after fixing the conflict pointed out by Nishant.
> >
> > Regards,
> > Madhu
> > -----------------------------------------------
> >
> > Update maintainers entry for TI OMAP HS MMC support.
> >
> > Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> > ---
> >  MAINTAINERS |    8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > Index: linux-omap-2.6/MAINTAINERS
> > ===================================================================
> > --- linux-omap-2.6.orig/MAINTAINERS
> > +++ linux-omap-2.6/MAINTAINERS
> > @@ -3698,7 +3698,13 @@ OMAP MMC SUPPORT
> >  M:	Jarkko Lavinen <jarkko.lavinen@nokia.com>
> >  L:	linux-omap@vger.kernel.org
> >  S:	Maintained
> > -F:	drivers/mmc/host/*omap*
> > +F:	drivers/mmc/host/omap.c
> > +
> > +OMAP HS MMC SUPPORT
> > +M:	Madhusudhan Chikkature <madhu.cr@ti.com>
> > +L:	linux-omap@vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/mmc/host/omap_hs*
> 
> do you think there will be any omap_hs* file besides omap_hsmmc.c ??

I don't have an answer at this point.

> 
> why not just use omap_hsmmc.c ??

Anyone sending a patch later could do the exact modification what I have
done now. But I am fine changing it to omap_hsmmc.c if it is more accurate.

Regards,
Madhu
> 
> --
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


