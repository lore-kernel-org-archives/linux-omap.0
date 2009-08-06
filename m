From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/20] OMAP: McBSP: Add transmit/receive threshold
	handler
Date: Thu, 6 Aug 2009 15:24:25 +0300
Message-ID: <20090806122425.GM2358@atomide.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com> <1FFEF31EBAA4F64B80D33027D4297760047F6AED00@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59566 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbZHFMY2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 08:24:28 -0400
Content-Disposition: inline
In-Reply-To: <1FFEF31EBAA4F64B80D33027D4297760047F6AED00@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-Eero.Nurkkala@nokia.com
Cc: eduardo.valentin@nokia.com, linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org, jhnikula@gmail.com, peter.ujfalusi@nokia.com

* ext-Eero.Nurkkala@nokia.com <ext-Eero.Nurkkala@nokia.com> [090806 15:22]:
> 
> >>
> >> +/********************** McBSP IRQSTATUS bit definitions ********************/
> >> +#define IRQST_XRDY           (1<<10)
> >> +#define IRQST_RRDY           (1<<3)
> >> +
> >>  /********************** McBSP WAKEUPEN bit definitions *********************/
> >>  #define XEMPTYEOFEN          0x4000
> >>  #define XRDYEN                       0x0400
> >
> > Please add spaces around << defines above.
> > 
> > Regards,
> > 
> > Tony
> 
> No spaces are used in this file at such declarations:
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;f=arch/arm/plat-omap/include/mach/mcbsp.h;h=bb154ea76769509a7937c4ba472e8d04c5bf41d3;hb=HEAD
> 
> to follow the file format exactly, it'd need to be in form of 0x ?

OK, never mind then, it could be done in a clean-up patch later on.

Tony
