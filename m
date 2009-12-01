From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCHV3 2/4] OMAP3: Clock Type change for OMAP3 Clocks
Date: Tue, 1 Dec 2009 06:06:57 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912010600050.13408@utopia.booyaka.com>
References: <1259211517-12713-1-git-send-email-vishwanath.bs@ti.com> <1259211517-12713-2-git-send-email-vishwanath.bs@ti.com> <1259211517-12713-3-git-send-email-vishwanath.bs@ti.com> <alpine.DEB.2.00.0911300114370.17083@utopia.booyaka.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA902493@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46446 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbZLANGv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 08:06:51 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA902493@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Vishwanath,

On Tue, 1 Dec 2009, Sripathy, Vishwanath wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Monday, November 30, 2009 1:57 PM
> > To: Sripathy, Vishwanath
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCHV3 2/4] OMAP3: Clock Type change for OMAP3 Clocks
> >
> > Hi Vishwanath,
> >
> > On Thu, 26 Nov 2009, Vishwanath BS wrote:
> >
> > > In omap34xx_clks, CK_343X type is used by all OMAP3 family of
> > > processors. It makes more sense to name clock type as CK_3XXX since it
> > > is common to all OMAP3 processors.
> >
> > Hmmm.  Do all of the CK_3XXX clocks apply to AM3503/3517?
> >
> Currently all OMAP3 chip families are using CK_343X as the common clock 
> and this clock has been renamed to CK_3XXX. So CK_3XXX should be 
> applicable for all.

Just based on a quick spot-check, there are several clocks that this patch 
marks as CK_3XXX that are really only applicable to the 34xx and 36xx 
families.  For example:

> > > -   CLK(NULL,       "sdrc_ick",     &sdrc_ick,      CK_343X), 
> > > +   CLK(NULL,       "sdrc_ick",     &sdrc_ick,      CK_3XXX), 
  
> > > -   CLK(NULL,       "iva2_ck",      &iva2_ck,       CK_343X),
> > > +   CLK(NULL,       "iva2_ck",      &iva2_ck,       CK_3XXX),

We should not mark clocks that are not present on 3503/3517 as being 
present on 3XXX, otherwise this chip numbering scheme will become even 
more perplexing than it currently is.  How about adding RATE_IN_36XX or 
CK_36XX as appropriate?


- Paul
