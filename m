From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Add omap34xx revision detection for ES3.1.1
Date: Thu, 24 Sep 2009 17:11:18 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A1C5923@dbde02.ent.ti.com>
References: <1251288272-17209-1-git-send-email-gadiyar@ti.com>
 <20090922213822.GE4919@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53190 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693AbZIXLlW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 07:41:22 -0400
In-Reply-To: <20090922213822.GE4919@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren wrote:
> * Anand Gadiyar <gadiyar@ti.com> [090826 05:04]:
> > ARM: OMAP: Add omap34xx revision detection for ES3.1.1
> > 
> > - Add omap34xx revision detection for ES3.1.1 silicon.
> > - Change default silicon to ES3.1.1
> > 
> > - Also minor bug-fix: ES2.0 rev field is 1, not 0.
> >   - This means that ES2.0 silicon would have wrongly been
> >     detected as unknown
> > 
> > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> > ---
> > Let me know if this should be split into a bug-fix patch,
> > and a separate patch for adding ES 3.1.1 revision info.
> > I felt the change was too minor to split out, since
> > ES2.0 silicon is rare.
> > 
> > This patch is against linus' tree - so the cpu.h
> > change will apply with an offset
> > 
> >  arch/arm/mach-omap2/id.c              |    8 ++++++--
> >  arch/arm/plat-omap/include/mach/cpu.h |    1 +
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > index a98201c..414c520 100644
> > --- a/arch/arm/mach-omap2/id.c
> > +++ b/arch/arm/mach-omap2/id.c
> > @@ -185,7 +185,7 @@ void __init omap34xx_check_revision(void)
> >  
> >  	if (hawkeye == 0xb7ae) {
> >  		switch (rev) {
> > -		case 0:
> > +		case 1:
> >  			omap_revision = OMAP3430_REV_ES2_0;
> >  			rev_name = "ES2.0";
> >  			break;
> 
> Are you sure about this change? Can you please check on real
> ES2.0 hardware, I believe the TRM may have a typo.
> 
> Regards,
> 
> Tony
> 

No, I'm not sure. I only caught it when I looked at the TRM to get
the ES3.1.1 ID.

I'll have to dig up an ES2.0 board to really verify, but that
won't happen for a couple of weeks at least.

If someone has this board around, please test and report.

Thanks,
Anand
