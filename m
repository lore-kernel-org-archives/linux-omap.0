From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 1/1] OMAP3: Common mechanism to identify cpu revision
Date: Mon, 5 Oct 2009 19:18:16 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDC08B48@dbde02.ent.ti.com>
References: <1253807481-19214-1-git-send-email-premi@ti.com>
 <87bpksr0no.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44514 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859AbZJENtC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 09:49:02 -0400
In-Reply-To: <87bpksr0no.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Wednesday, September 30, 2009 7:32 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/1] OMAP3: Common mechanism to identify 
> cpu revision
> 
> Sanjeev Premi <premi@ti.com> writes:
> 
> > There are multiple mechanisms to identify the cpu revisions.
> > Most common is use of omap_rev(). This, however, does a
> > absolute comparison of omap_revision - which includes
> > CPU id, CPU rev and CPU class. This comparison fails for
> > OMAP35x processors.
> >
> > This patch defines generic functions that use only the
> > CPU rev bits in omap_revision to identify the revision
> > information.
> >
> > Usage will change from (for example):
> > 	if (omap_rev() > OMAP3430_REV_ES2_0)
> > to:
> > 	if (cpu_is_omap34xx() && omap_rev_gt_2_0())
> >
> > Specific check for cpu_is_xxx() will not be needed for
> > files specific to silicon e.g. pm34xx.c, clock34xx.c, etc.
> >
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> 
> Looks mostly good, some minor comments/questions below...
> 
[snip]--[snip]
> 
> I don't think the cpu_is_... is needed here because of the OMAP3
> specific function.

[sp] Yes. This can be removed.

> >  /*
> > + * Silicon revisions
> > + */
> > +#define OMAP_ES_1_0		0x00
> > +#define OMAP_ES_2_0		0x10
> > +#define OMAP_ES_2_1		0x20
> > +#define OMAP_ES_3_0		0x30
> > +#define OMAP_ES_3_1		0x40
> 
> Hmm, are these the same values on OMAP2? and OMAP4?
> 
[sp] Based on the values defined for OMAP2420 and OMA2430,
these definitions are applicable. There aren't as many
Revisions though.

Not sure if it will hold good for OMAP4..

Do you think, we make these definitions silicon specific
now?

> > +#define OMAP_REV_MASK		0x0000ff00
> > +#define OMAP_REV_BITS		((omap_rev() & 
> OMAP_REV_MASK) >> 8)
> > +
> > +#define OMAP_REV_IS(revid)					\
> > +static inline u8 omap_rev_is_ ##revid (void)		
> 	\
> 
> Minor nit, but these should return bool.

[sp] I will update.

> 
> > +{								\
> > +	return (OMAP_REV_BITS == OMAP_ES_ ##revid) ? 1 : 0;	\
> > +}
> > +
> > +#define OMAP_REV_LT(revid)					\
> > +static inline u8 omap_rev_lt_ ##revid (void)		
> 	\
[snip]--[snip]

> 
> Kevin
> 
> 