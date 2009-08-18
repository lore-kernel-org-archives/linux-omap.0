From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Resend][PATCH] Maintainers update for hsmmc driver
Date: Tue, 18 Aug 2009 15:43:15 +0300
Message-ID: <20090818124314.GE17595@atomide.com>
References: <50872.192.168.10.88.1249658504.squirrel@dbdmail.itg.ti.com> <87zla3cs1t.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53539 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721AbZHRMnS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 08:43:18 -0400
Content-Disposition: inline
In-Reply-To: <87zla3cs1t.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org, jarkko.lavinen@nokia.com, adrian.hunter@nokia.com, felipe.balbi@nokia.com

* Kevin Hilman <khilman@deeprootsystems.com> [090814 00:39]:
> "Madhusudhan Chikkature" <madhu.cr@ti.com> writes:
> 
> > Hi,
> >
> > Resending the patch after changing omap_hs* to omap_hsmmc.c.
> >
> > Regards,
> > Madhu
> >
> >
> >
> > Update maintainers entry for TI OMAP HS MMC support.
> >
> > Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> 
> Madhu is the right guy for the job.
> 
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>


This should go in via the new linux-mmc@vger.kernel.org list.

Tony

> 
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
> > +F:	drivers/mmc/host/omap_hsmmc.c
> >
> >  OMAP RANDOM NUMBER GENERATOR SUPPORT
> >  M:	Deepak Saxena <dsaxena@plexity.net>
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
