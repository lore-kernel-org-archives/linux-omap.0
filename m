From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH] OMAP3: PM: Check in set_pwrdm_state that target state
 is supported by pwrdm
Date: Fri, 14 Nov 2008 20:27:38 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0811142026040.16502@utopia.booyaka.com>
References: <491A0082.4040807@deeprootsystems.com> <1226651923-5682-1-git-send-email-jouni.hogander@nokia.com> <alpine.DEB.2.00.0811141033340.27331@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53223 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbYKOD1k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 22:27:40 -0500
In-Reply-To: <alpine.DEB.2.00.0811141033340.27331@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org


> > diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> > index da098d2..babead5 100644
> > --- a/arch/arm/mach-omap2/pm34xx.c
> > +++ b/arch/arm/mach-omap2/pm34xx.c
> > @@ -239,8 +239,13 @@ static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
> >  	if (pwrdm == NULL || IS_ERR(pwrdm))
> >  		return -EINVAL;
> >  
> > -	cur_state = pwrdm_read_next_pwrst(pwrdm);
> > +	while (!(pwrdm->pwrsts & (1 << state))) {
> > +		if (state < PWRDM_POWER_OFF)
> > +			return ret;
> 
> This if-statement will never execute, since 'state' is unsigned, and 
> PWRDM_POWER_OFF is 0.  Maybe the easiest way to fix it would be to make 
> 'state' a signed int?
 
Hmm.  That if-statement should go after the 'state--' also.



> Other than that, looks good to me.
> 
> 
> > +		state--;
> > +	}
> >  
> > +	cur_state = pwrdm_read_next_pwrst(pwrdm);
> >  	if (cur_state == state)
> >  		return ret;
> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
