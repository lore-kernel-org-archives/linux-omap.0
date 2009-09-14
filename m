From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC] OMAP3 : PM : Handle variable length OPP tables
Date: Mon, 14 Sep 2009 16:36:20 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD88970B@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD6C43CA@dbde02.ent.ti.com>
	<87my528xgv.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD7D0A9A@dbde02.ent.ti.com>
 <87eiqd5g9d.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34822 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbZINLGU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Sep 2009 07:06:20 -0400
In-Reply-To: <87eiqd5g9d.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Saturday, September 12, 2009 2:52 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [RFC] OMAP3 : PM : Handle variable length OPP tables
> 
> "Premi, Sanjeev" <premi@ti.com> writes:
> 
> >> -----Original Message-----
> >> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> >> Sent: Friday, September 11, 2009 12:00 AM
> >> To: Premi, Sanjeev
> >> Cc: linux-omap@vger.kernel.org
> >> Subject: Re: [RFC] OMAP3 : PM : Handle variable length OPP tables
> >> 
> >> "Premi, Sanjeev" <premi@ti.com> writes:
> >> 
> >> > Hi all,
> >> >
> >> > There is no generic function to translate an OPP to FREQ 
> >> and vice versa.
> >> > Came across the problem while trying to submit a follow-up 
> >> to earlier
> >> > patch for change in mpurate via bootargs. 
> >> >
> >> > The function get_opp in resource34xx.c, but it is always 
> >> called with an
> >> > explicit addition of MAX_VDDn_OPP e.g.
> >> >
> >> >   opp = get_opp(mpu_opps + MAX_VDD1_OPP, clk->rate);
> >> >   opp = get_opp(l3_opps + MAX_VDD2_OPP, clk->rate);
> >> >
> >> > This is 'addition' is required as there is no 
> encapsulation of the
> >> > MIN and MAX VDDs associated to the table.
> >> >
> >> > The patch below fixes this issue; buy creating a 'table' 
> object with
> >> > necessary information. It can also help in getting rid of the
> >> > empty {0, 0, 0} at index 0 of each OPP table.
> >> >
> >> > At the moment, it does not break any functionality in 
> >> resource34xx.c;
> >> > migration to this encapsulation can be taken as next step.
> >> >
> >> > This code is bare 'git-diff' for early comments. Formal 
> >> patch to follow...
> >> >
> >> > Best regards,
> >> > Sanjeev
> >> 
> >> Is the goal of the min and max fields so you could have some OPPs
> >> in the table that aren't valid for some SoCs?  IOW, the 'max' value
> >> might be higher on newer SoCs with higher OPPs.
> >
> > The goal is to have get_*() functions where caller 
> shouldn't be aware
> > of the MAX_ for the table. Considering table as an object, it should
> > be able to provide its own length.
> >
> > Reason to use min and max was to maintain current 
> functionality as is.
> > Else, simple 'length' should be sufficient.
> >
> >> 
> >> What if you want a list of OPPs, but want to remove one from the
> >> middle of the list?  The min/max approach doesn't work here.
> >> 
> >> What about a also extending the struct omap_opp to have 
> some sort of
> >> valid field.
> >
> > This doesn't help in eliminating the addition of MAX value for each
> > function call.
> 
> No it doesn't.  I'm just thinking about the next step of 
> having a more flexible list of OPPs.

[sp] Oh yes, it will be a good addition.
     I misunderstood your earlier comment :(

Best regards,
Sanjeev
> 
> Kevin
> 
> snip---snip--snip
