From: "Pagare, Abhijit" <abhijitpagare@ti.com>
Subject: RE: [PATCH 1/1] ARM: OMAP4: PM: Add check for avoiding dependency
 related update.
Date: Wed, 30 Dec 2009 17:38:42 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C02E919C@dbde02.ent.ti.com>
References: <1261583238-22187-1-git-send-email-abhijitpagare@ti.com>
 <alpine.DEB.2.00.0912300125320.24862@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44378 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326AbZL3MIy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Dec 2009 07:08:54 -0500
In-Reply-To: <alpine.DEB.2.00.0912300125320.24862@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Paul,


> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, December 30, 2009 2:02 PM
> To: Pagare, Abhijit
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/1] ARM: OMAP4: PM: Add check for avoiding dependency
> related update.
> 
> Hello Abhijit,
> 
> On Wed, 23 Dec 2009, Abhijit Pagare wrote:
> 
> > A check is added for avoiding the sleep/wakeup dependency updates
> > for OMAP4 as the structures for the dependencies are currently absent.
> 
> As a threshold matter, code and data added in temporary hack patches like
> this need to be marked with XXX or FIXME or something similar to indicate
> that these are not intended features, but rather, temporary lines that
> need to be removed in the near term.

I think I missed that. I will add the FIXME indication to the check below. I think that this check is essential for OMAP4 kernel boot-up as long as the dependency patches are not pushed in.

> 
> But really, I'd rather not apply this patch.  The best way forward is to
> apply a patch that adds the OMAP4 wakeup and sleep dependencies
> themselves.  Have you had a chance to look at the series that I sent you a
> few weeks ago off-list that reorganizes the wakeup and sleep dependencies
> to determine if it is adequate for you to add the OMAP4 wakeup/sleep
> dependencies afterwards?

I had a look at the dependency patches that you had sent to me earlier and it seems feasible to add the OMAP4 related dependency data on top of those patches. A small change exists but can be taken care of.

Regards,
Abhijit

> 
> 
> - Paul
> 
> >
> > Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > ---
> >
> > Compiled and Boot Tested on OMAP4430 simulator, ES1 Chip & OMAP3430 SDP.
> > And also Compiled for OMAP2430 and OMAP2420
> >
> > This patch has a dependency on the earlier set of OMAP4 clock-domain
> patches.
> >
> >  arch/arm/mach-omap2/clockdomain.c |   10 ++++++----
> >  1 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-
> omap2/clockdomain.c
> > index 8c9e78c..6ec25ee 100644
> > --- a/arch/arm/mach-omap2/clockdomain.c
> > +++ b/arch/arm/mach-omap2/clockdomain.c
> > @@ -507,8 +507,9 @@ void omap2_clkdm_allow_idle(struct clockdomain
> *clkdm)
> >  	pr_debug("clockdomain: enabling automatic idle transitions for
> %s\n",
> >  		 clkdm->name);
> >
> > -	if (atomic_read(&clkdm->usecount) > 0)
> > -		_clkdm_add_autodeps(clkdm);
> > +	if (!cpu_is_omap44xx())
> > +		if (atomic_read(&clkdm->usecount) > 0)
> > +			_clkdm_add_autodeps(clkdm);
> >
> >  	_omap2_clkdm_set_hwsup(clkdm, 1);
> >
> > @@ -540,8 +541,9 @@ void omap2_clkdm_deny_idle(struct clockdomain
> *clkdm)
> >
> >  	_omap2_clkdm_set_hwsup(clkdm, 0);
> >
> > -	if (atomic_read(&clkdm->usecount) > 0)
> > -		_clkdm_del_autodeps(clkdm);
> > +	if (!cpu_is_omap44xx())
> > +		if (atomic_read(&clkdm->usecount) > 0)
> > +			_clkdm_del_autodeps(clkdm);
> >  }
> >
> >
> > --
> > 1.5.4.7
> >
> 
> 
> - Paul
