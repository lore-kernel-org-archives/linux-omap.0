From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [Resend][PATCH] Maintainers update for hsmmc driver
Date: Tue, 18 Aug 2009 10:34:27 -0500
Message-ID: <006601ca2019$5f37bcc0$544ff780@am.dhcp.ti.com>
References: <50872.192.168.10.88.1249658504.squirrel@dbdmail.itg.ti.com> <87zla3cs1t.fsf@deeprootsystems.com> <20090818124314.GE17595@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59073 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759271AbZHRPeg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 11:34:36 -0400
In-Reply-To: <20090818124314.GE17595@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Tony Lindgren' <tony@atomide.com>, 'Kevin Hilman' <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, jarkko.lavinen@nokia.com, adrian.hunter@nokia.com, felipe.balbi@nokia.com



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Tuesday, August 18, 2009 7:43 AM
> To: Kevin Hilman
> Cc: Madhusudhan Chikkature; linux-omap@vger.kernel.org;
> jarkko.lavinen@nokia.com; adrian.hunter@nokia.com; felipe.balbi@nokia.com
> Subject: Re: [Resend][PATCH] Maintainers update for hsmmc driver
> 
> * Kevin Hilman <khilman@deeprootsystems.com> [090814 00:39]:
> > "Madhusudhan Chikkature" <madhu.cr@ti.com> writes:
> >
> > > Hi,
> > >
> > > Resending the patch after changing omap_hs* to omap_hsmmc.c.
> > >
> > > Regards,
> > > Madhu
> > >
> > >
> > >
> > > Update maintainers entry for TI OMAP HS MMC support.
> > >
> > > Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> >
> > Madhu is the right guy for the job.
> >
> > Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> 
> This should go in via the new linux-mmc@vger.kernel.org list.
> 
> Tony
> 
Sure. I will post this patch to the linux-mmc@vger.kernel.org list.

Regards,
Madhu

> >
> > > ---
> > >  MAINTAINERS |    8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > Index: linux-omap-2.6/MAINTAINERS
> > > ===================================================================
> > > --- linux-omap-2.6.orig/MAINTAINERS
> > > +++ linux-omap-2.6/MAINTAINERS
> > > @@ -3698,7 +3698,13 @@ OMAP MMC SUPPORT
> > >  M:	Jarkko Lavinen <jarkko.lavinen@nokia.com>
> > >  L:	linux-omap@vger.kernel.org
> > >  S:	Maintained
> > > -F:	drivers/mmc/host/*omap*
> > > +F:	drivers/mmc/host/omap.c
> > > +
> > > +OMAP HS MMC SUPPORT
> > > +M:	Madhusudhan Chikkature <madhu.cr@ti.com>
> > > +L:	linux-omap@vger.kernel.org
> > > +S:	Maintained
> > > +F:	drivers/mmc/host/omap_hsmmc.c
> > >
> > >  OMAP RANDOM NUMBER GENERATOR SUPPORT
> > >  M:	Deepak Saxena <dsaxena@plexity.net>
> > >
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html


