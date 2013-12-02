From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Powerdomain: Fix unchecked dereference of
 arch_pwrdm
Date: Mon, 2 Dec 2013 11:20:58 -0800
Message-ID: <20131202192057.GJ26766@atomide.com>
References: <1385553437-22568-1-git-send-email-rnayak@ti.com>
 <5296A29C.50006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35333 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753738Ab3LBTVA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Dec 2013 14:21:00 -0500
Content-Disposition: inline
In-Reply-To: <5296A29C.50006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, dan.carpenter@oracle.com

* Nishanth Menon <nm@ti.com> [131127 17:56]:
> On 11/27/2013 05:57 AM, Rajendra Nayak wrote:
> > Commit 'cd8abed' "ARM: OMAP2+: Powerdomain: Remove the need to
> > always have a voltdm associated to a pwrdm" leads to the following
> > Smatch complaint:
> > 
> > arch/arm/mach-omap2/powerdomain.c:131 _pwrdm_register()
> > 	 error: we previously assumed 'arch_pwrdm' could be null (see line 105)
> > 
> > So, fix the unchecked dereference of arch_pwrdm.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > ---
> >  arch/arm/mach-omap2/powerdomain.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> > index e233dfc..93a2a6e 100644
> > --- a/arch/arm/mach-omap2/powerdomain.c
> > +++ b/arch/arm/mach-omap2/powerdomain.c
> > @@ -128,7 +128,8 @@ skip_voltdm:
> >  	for (i = 0; i < pwrdm->banks; i++)
> >  		pwrdm->ret_mem_off_counter[i] = 0;
> >  
> > -	arch_pwrdm->pwrdm_wait_transition(pwrdm);
> > +	if (arch_pwrdm && arch_pwrdm->pwrdm_wait_transition)
> > +		arch_pwrdm->pwrdm_wait_transition(pwrdm);
> >  	pwrdm->state = pwrdm_read_pwrst(pwrdm);
> >  	pwrdm->state_counter[pwrdm->state] = 1;
> >  
> > 
> Acked-by: Nishanth Menon <nm@ti.com>

I'll queue this into omap-for-v3.13/fixes-take4.

Regards,

Tony
