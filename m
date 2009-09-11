From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC] Common mechanism to identify Si revision
Date: Fri, 11 Sep 2009 16:54:23 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD7D0D97@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD60FFF2@dbde02.ent.ti.com>
 <alpine.DEB.2.00.0909100325360.3024@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51934 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752432AbZIKLYY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Sep 2009 07:24:24 -0400
In-Reply-To: <alpine.DEB.2.00.0909100325360.3024@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com] 
> Sent: Thursday, September 10, 2009 2:59 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [RFC] Common mechanism to identify Si revision
> 
> Hello Sanjeev,
> 
> On Thu, 3 Sep 2009, Premi, Sanjeev wrote:
> 
> > Here, I am proposing a common mechanism to identify the si 
> revision; that focuses
> > on the revision bits alone. (See code below)
> > 
> > The usage would then be (example):
> > 
> >    if (omap_rev() > OMAP3430_REV_ES1_0)
> > 
> > To
> > 
> >    if (cpu_is_omap34xx() && OMAP_REV_GT(OMAP_ES_1_0)
> 
> For use in structures like clock34xx.h and 
> powerdomains34xx.h, would you 
> propose that we use two different fields then - one for OMAP 
> type, the 
> other for revision restrictions?  Or a different scheme?
> 
> - Paul
> 

Paul,

First answer:
We could use two fields e.g. omap_type and omap_rev.
For example:

	.omap_type	  = CHIP_IS_OMAP3430,
      .omap_rev     = OMAP_ES_2_1,

Instead of :

	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),

	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
					   CHIP_IS_OMAP3430ES2 |
					   CHIP_IS_OMAP3430ES3_0),

	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1),

Second answer:
>From the snippets above, it appears that we need to:
1) identify which chip is in use
2) which si rev (if any) does the clock/powerdomain definition
   applies to. Actually, we are checking for:
   a) Does definition depend upon a si rev
   b) if so, which rev? - usually LE and GE should be sufficient.

Which chip in use? - can either be a run-time check OR mapped
to an boot-time setting of "valid" field for the si being used.
e.g. (translating the snippet above):

	.valid	  = (cpu_is_omap34xx())

	.valid	  = (cpu_is_omap34xx() &&
				(OMAP_REV_EQ(OMAP_ES_1_0) ||
				 OMAP_REV_EQ(OMAP_ES_2_1) ||
				 OMAP_REV_EQ(OMAP_ES_3_0)))

	.valid	  = (cpu_is_omap34xx() &&
				(OMAP_REV_GE(OMAP_ES_3_1))

Now decision at runtime can be made based on the just this flag.

I haven't really done any prototyping on this, so there may be
holes in explanation above; but I hope general idea is coming
clear.

Best regards,
Sanjeev
