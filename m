From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: OMAP3: enabling CPU idle leads to panic
Date: Fri, 27 Nov 2009 18:13:35 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE7B92D1@dbde02.ent.ti.com>
References: <48239d390911240713v50bcae9ek855fb1e07c081486@mail.gmail.com>
	 <48239d390911250737q35fc602fu9bce0b0f96f6970d@mail.gmail.com>
	 <87iqcyh5p5.fsf@deeprootsystems.com>
	 <48239d390911270202s3f6fcdbchaa7053bace5c36@mail.gmail.com>
	 <48239d390911270248se826f84r84d6b42cbd69344@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE7B9217@dbde02.ent.ti.com>
	 <48239d390911270332tdf05c1lb5014e56cd3aa18b@mail.gmail.com>
	 <48239d390911270336r37e3b127i409ea5927aa9c505@mail.gmail.com>
	 <48239d390911270402u4fe05d96s4d2a05e39919cb75@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE7B92B6@dbde02.ent.ti.com>
 <48239d390911270437u4c917263o925b0524be826626@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46864 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbZK0Mnf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Nov 2009 07:43:35 -0500
In-Reply-To: <48239d390911270437u4c917263o925b0524be826626@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergey Lapin <slapinid@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Sergey Lapin [mailto:slapinid@gmail.com] 
> Sent: Friday, November 27, 2009 6:08 PM
> To: Premi, Sanjeev
> Cc: Kevin Hilman; linux-omap@vger.kernel.org
> Subject: Re: OMAP3: enabling CPU idle leads to panic
> 
> >> -----Original Message-----
> >> From: Sergey Lapin [mailto:slapinid@gmail.com]
> >> Sent: Friday, November 27, 2009 5:33 PM
> >> To: Premi, Sanjeev
> >> Cc: Kevin Hilman; linux-omap@vger.kernel.org
> >> Subject: Re: OMAP3: enabling CPU idle leads to panic
> >>
> >> On Fri, Nov 27, 2009 at 2:36 PM, Sergey Lapin
> >> <slapinid@gmail.com> wrote:
> >> >>
> >> >> Alas, that's not because omap_chip_is() function fails
> >> >> on these structures.
> >> >>
> >> >
> >> > I mean during registration of power domains.
> >> >
> >>

[snip]--[snip]

> > Had submitted a patch earlier; will need some time to
> > find it.
> >
> >        } else if (cpu_is_omap343x()) {
> >                omap_chip.oc = CHIP_IS_OMAP3430;
> >                if (omap_rev() == OMAP3430_REV_ES1_0)
> >                        omap_chip.oc |= CHIP_IS_OMAP3430ES1;
> >                else if (omap_rev() >= OMAP3430_REV_ES2_0 &&
> >                         omap_rev() <= OMAP3430_REV_ES2_1)
> >                        omap_chip.oc |= CHIP_IS_OMAP3430ES2;
> >                else if (omap_rev() == OMAP3430_REV_ES3_0)
> >                        omap_chip.oc |= CHIP_IS_OMAP3430ES3_0;
> >                else if (omap_rev() == OMAP3430_REV_ES3_1)
> >                        omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
> >        } else {
> >
> > In meantime, can you try setting the following (explicitly)
> > to the code above:
> >                else if (omap_rev() == OMAP3430_REV_ES3_1)
> >                        omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
> > +               else
> > +                       omap_chip.oc |= CHIP_IS_OMAP3430ES3_1
> >
> > ~sanjeev
> 
> It is fixed, no more panics, thanks a lot!
> 
Great! I will take ongoing touchscreen issues to closure and
submit a formal patch again.

~sanjeev