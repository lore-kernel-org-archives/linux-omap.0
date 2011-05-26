From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 02/15] OMAP2PLUS: GPIO: Fix non-wakeup GPIO and rev_ids
Date: Thu, 26 May 2011 18:49:44 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D1781A3@dbde02.ent.ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
 <1306247094-25372-3-git-send-email-tarun.kanti@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024D177FCC@dbde02.ent.ti.com>
 <4DDE2745.3030307@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024D178110@dbde02.ent.ti.com>
 <4DDE435C.8060506@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024D17815E@dbde02.ent.ti.com>
 <4DDE4BB0.7010809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43269 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755058Ab1EZNTy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 May 2011 09:19:54 -0400
In-Reply-To: <4DDE4BB0.7010809@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan, Charulatha" <charu@ti.com>, Paul Walmsley <paul@pwsan.com>

> -----Original Message-----
> From: Cousson, Benoit 
> Sent: Thursday, May 26, 2011 6:17 PM
> To: Premi, Sanjeev
> Cc: DebBarma, Tarun Kanti; linux-omap@vger.kernel.org; 
> Hilman, Kevin; Shilimkar, Santosh; tony@atomide.com; 
> linux-arm-kernel@lists.infradead.org; Varadarajan, 
> Charulatha; Paul Walmsley
> Subject: Re: [PATCH 02/15] OMAP2PLUS: GPIO: Fix non-wakeup 
> GPIO and rev_ids
> 
> On 5/26/2011 2:38 PM, Premi, Sanjeev wrote:
> >> -----Original Message-----
> >> From: Cousson, Benoit
> >> Sent: Thursday, May 26, 2011 5:41 PM
> >> To: Premi, Sanjeev
> >> Cc: DebBarma, Tarun Kanti; linux-omap@vger.kernel.org;
> >> Hilman, Kevin; Shilimkar, Santosh; tony@atomide.com;
> >> linux-arm-kernel@lists.infradead.org; Varadarajan,
> >> Charulatha; Paul Walmsley
> >> Subject: Re: [PATCH 02/15] OMAP2PLUS: GPIO: Fix non-wakeup
> >> GPIO and rev_ids
> >>
> >> On 5/26/2011 1:47 PM, Premi, Sanjeev wrote:
> >>>> -----Original Message-----
> >>>> From: Cousson, Benoit
> >>>> Sent: Thursday, May 26, 2011 3:41 PM
> >>>> To: Premi, Sanjeev
> >>>> Cc: DebBarma, Tarun Kanti; linux-omap@vger.kernel.org;
> >>>> Hilman, Kevin; Shilimkar, Santosh; tony@atomide.com;
> >>>> linux-arm-kernel@lists.infradead.org; Varadarajan,
> >>>> Charulatha; Paul Walmsley
> >>>> Subject: Re: [PATCH 02/15] OMAP2PLUS: GPIO: Fix non-wakeup
> >>>> GPIO and rev_ids
> >>>>
> >>>> On 5/26/2011 11:23 AM, Premi, Sanjeev wrote:
> >>>>>> From: linux-omap-owner@vger.kernel.org
> >>>>>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> >>>>>> DebBarma, Tarun Kanti
> >>>>>> Sent: Tuesday, May 24, 2011 7:55 PM
> >>>>>>
> >>>>>> From: Charulatha V<charu@ti.com>
> >>>>>>
> >>>>>> Non-wakeup GPIOs are available only in OMAP2420 and 
> OMAP3430. But
> >>>>>> the GPIO driver initializes the non-wakeup GPIO bits 
> for OMAP24xx
> >>>>>> (bothe OMAP 2420 and 2430)&    not for OMAP3 which is 
> incorrect.
> >>>>>>
> >>>>>> Fix the above by providing non-wakeup GPIO information
> >>>> through pdata
> >>>>>> specific to the SoC.
> >>>>>>
> >>>>>> The GPIO rev id provided in the hwmod database is the same
> >>>>>> for OMAP2420
> >>>>>> and OMAP2430. Change the GPIO rev ids in hwmod database as
> >>>> given below
> >>>>>> so that it can be used to identify OMAP2420 and OMAP2430.
> >>>>>> OMAP2420 - 0
> >>>>>> OMAP2430 - 1
> >>>>>> OMAP3    - 2
> >>>>>> OMAP4    - 3
> >>>>>
> >>>>> [sp] Magic numbers should be avoided.
> >>>>>         Suggest using something like:
> >>>>>         #define GPIO_REV_2420	0
> >>>>>         #define GPIO_REV_2430	1
> >>>>>         #define GPIO_REV_34XX	2
> >>>>>         #define GPIO_REV_44xx	3
> >>>>
> >>>> Well, it is not a magic number, it is a revision id that is
> >>>> incremented
> >>>> each time there is a difference in the IP.

[sp] Just to quote a definition:
     [quote]The term magic number or magic constant also refers to
     the programming practice of using numbers directly in source code.
     [/quote]

     It has no relation to whether/how it can signify something
     important.

> >>>> The OMAP version ->   IP version link is done at hwmod level.
> >>>> The driver
> >>>> does not have to know it is an OMAP3 or OMAP4. In that 
> case we did
> >>>> change the IP version for every revisions, but OMAP5 will use
> >>>> the OMAP4
> >>>> revision.

[sp] I don't understand the confusion because IPs are anyways
     going to be used across. Many macros originally created
     for OMAP34XX are true/valid for OMAP36XX. And same holds
     good (probably) for OMAP24XX as well.

     But in each context, we are aware of the intended usage and
     can relate to the use and reuse better because it is quite
     evident. Use of OMAP2_CONTROL_GENERAL in OMAP34xx specific
     function is not accurate by your example below, but we all
     know the meaning and need for the same.

> >>>> I'm not even considering all the Davinci variants that are
> >> not named
> >>>> OMAP but do use OMAP IPs... as you already know...
> >>>> That can provide a rather confusing information for my
> >> point of view.

[sp] So now what happens when existing IP gets changed to fix
     an issue in existing OMAP3 design. Going by same logic will
     we add another id for the same?

> >>>>
> >>>> Whereas a comment like that will give you the exhaustive
> >> information.
> >>>>
> >>>> 0: OMAP2420
> >>>> 1: OMAP2430
> >>>> 2: OMAP3, DMxxx
> >>>> 3: OMAP4, OMAP5, DM816x
> >>>>
> >>>> That being said, some drivers already did that, so I'm not
> >> opposed to
> >>>> such change. I just think it is not the best approach.

[sp] Taking same point further, if the IP from OMAP4 above
     gets used to create OMAP3699 (for example). How does this
     case get handled? OR we expect users to know about exceptions
     each time they read code?

     Leaving aside the fact the situation is hypothetical; design
     should be generic to handle such situations.

> >>>> At least it gives a pointer to the TRM that contains the IP doc.
> >>>
> >>> [sp] Benoit, your are right from generation perspectove where the
> >>>        it is easier to increment numbers but when we use 
> comparison
> >>
> >> This is not even related to generation. A version number 
> is a number.
> >> If OMAP2 is using GPIO v1.6 and OMAP3 the version v2.2, 
> only that IP
> >> version is relevant for the driver.
> >> For the documentation point of view, since we do not have a
> >> per IP TRM,
> >> then it can make sense to know where that IP is 
> documented. But as I
> >> said a comment is enough and will allow a much more 
> relevant level of
> >> details information than a define.

[sp] Based on what I have read, it makes more sense is to have
     the IP version used in this field verbatim. Then there is no
     pollution with processor containing the IP.

> >>
> >>>        code - as in this patch, comparison against a number isn't
> >>>        readable.
> >>>
> >>>        As example:
> >>>
> >>>    +	switch (oh->class->rev) {     ## This is auto-generated.
> >>>    +	case 0:				## But this is our code.
> >>>
> >>>        I am recommending this to read as:
> >>>
> >>>    +	switch (oh->class->rev) {     ## This is auto-generated.
> >>>    +	case GPIO_REV_2420:		## More readable.
> >>
> >> More readable, maybe, but not necessarily relevant nor
> >> accurate if the
> >> same IP version is used in another chip or revision.
> >>
> >> What IP version is used in a DM816x? GPIO_REV_3430, GPIO_REV_4430?
> >
> > How is value 0 accurate?
> 
> 0 is just the revision number that can give you the exact list of Soc 
> that does use that IP. Thanks to an exhaustive comment.

[sp] The exhaustive comment will not accompany every place the field
     "rev" is used in the code. So someone needs to find this comment
     and then get the meaning of a revision.

     Otherwise why do we define so many macros in files like control.h?
     Exhaustive comments would have served well!

> 
> 0: OMAP2420
> 1: OMAP2430
> 2: OMAP3, DMxxx
> 3: OMAP4, OMAP5, DM816x
> 
> 
> BTW, I'm still waiting the answer for previous question...

[sp] I didn't find a question - but responsded to what I appeared to
     me as question(s).
     I will be offline for few days. Futher responses will be delayed.

~sanjeev

> 
> Regards,
> Benoit
> 
