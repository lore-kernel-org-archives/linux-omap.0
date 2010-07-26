From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap: Add macros to evaluate cpu revision
Date: Mon, 26 Jul 2010 20:57:15 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7DA1AB2@dbde02.ent.ti.com>
References: <1279725163-3481-1-git-send-email-premi@ti.com>
 <4C4710DB.6060901@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0323B40084@dbde02.ent.ti.com>
 <4C481185.3090005@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7C764FD@dbde02.ent.ti.com>
 <4C4821E9.6030405@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7D0A002@dbde02.ent.ti.com>
 <4C482F8F.1090401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57580 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753918Ab0GZP1U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jul 2010 11:27:20 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6QFRHxu007233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 26 Jul 2010 10:27:19 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o6QFRFUf006809
	for <linux-omap@vger.kernel.org>; Mon, 26 Jul 2010 20:57:16 +0530 (IST)
In-Reply-To: <4C482F8F.1090401@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Thursday, July 22, 2010 5:16 PM
> To: Premi, Sanjeev
> Cc: Gadiyar, Anand; linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap: Add macros to evaluate cpu revision
> 
> Premi, Sanjeev had written, on 07/22/2010 06:20 AM, the following:
> >> -----Original Message-----
> >> From: Menon, Nishanth 
> >> Sent: Thursday, July 22, 2010 4:18 PM
> >> To: Premi, Sanjeev
> >> Cc: Gadiyar, Anand; linux-omap@vger.kernel.org
> >> Subject: Re: [PATCH] omap: Add macros to evaluate cpu revision
> >>
> >> Premi, Sanjeev had written, on 07/22/2010 04:49 AM, the following:
> >>>> -----Original Message-----
> >>>> From: Menon, Nishanth 
> >>>> Sent: Thursday, July 22, 2010 3:08 PM
> >>>> To: Gadiyar, Anand
> >>>> Cc: Premi, Sanjeev; linux-omap@vger.kernel.org
> >>>> Subject: Re: [PATCH] omap: Add macros to evaluate cpu revision
> >>>>
> >>>> On 07/22/2010 01:53 AM, Gadiyar, Anand wrote:
> >>>>>>> @@ -460,4 +461,35 @@ OMAP3_HAS_FEATURE(isp, ISP)
> >>>>>>>   OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
> >>>>>>>   OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
> >>>>>>>
> >>>>>>> +/*
> >>>>>>> + * Map revision bits to silicon specific revisions
> >>>>>>> + */
> >>>>>>> +#define ES_1_0		OMAP_REVBITS_00
> >>>>>> probably need ES_1_1, 1_2 (considering 3630)
> >>>>> This should be okay, since the 3630 is out with
> >>>>> these revisions, but...
> >>>>>
> >>>>>>> +#define ES_2_0		OMAP_REVBITS_10
> >>>>>>> +#define ES_2_1		OMAP_REVBITS_20
> >>>>>> makes sense to go to 2_2
> >>>>>>> +#define ES_3_0		OMAP_REVBITS_30
> >>>>>>> +#define ES_3_1		OMAP_REVBITS_40
> >>>>>>> +#define ES_3_1_2	OMAP_REVBITS_50
> >>>>>> 3_2?
> >>>>> This may not make sense to add now as there are no
> >>>>> 2.2 or 3.2 revisions of any OMAP3/4 silicon?
> >>>>>
> >>>> Agreed for 3 and 4, but considering this is 
> >>>> arch/arm/plat-omap/include/plat/cpu.h, does it make sense in 
> >>>> looking all 
> >>>> OMAPs?
> >>> In this case, the best option would be to prefix 
> OMAP34X_/ OMAP36X_
> >>> OMAP44X_ etc and define the ES revisions for each context.
> >> doing that is gonna make the code real dirty looking. at the 
> > 
> > dirty?? How come? The intent is to increase readability.
> > 
> huh? should we start the old debate again?
> Read this thread
> http://marc.info/?l=linux-omap&m=127903615629407&w=2
> 
> >> very least 
> >> mebbe bracket it in with #ifdef  with CONFIG_OMAP2PLUS?
> > 
> > What purpose does this #ifdef. The macro should/could be used
> > quite generically.
> 
> Now we are back in a full circle -> if you would like to 
> introduce the 
> patch for ALL omap silicon, you might want to consider 2420 
> and so on.. 
> at the very least.
> 
> introducing this for OMAP3 and 4 alone does not allow logic 
> to scale up.

[sp] The logic is only in the macros viz. cpu_rev_ge(), cpu_rev_le,
     etc. The support for other omap silicons means having the
     mapping of the revision bits to actual silicon version.

> 
> information about the cputype is already being passed as a 
> parameter, so 
> it is just a matter of figuring out which ES revs should be 
> defined there..

[sp] I have been trying to avoid creating another set of functions
     or introduce new data structures for the purpose. This means
     living with the problem of lower/uppercase in the definition
     e.g. cpu_is_omap34xx() and #define OMAP334XX_(*) macros.

     An added complexity is checking for "family" of devices and
     "specific" device in a family. 

    I am tried to limit the changes introduced and still keep the
    overall code readable - not necessarily reduction in code size.

> 
> > 
> > Here is a sample usage from one of the patch I am reworking
> > for submission here:
> > 
> > @@ -488,7 +494,9 @@ void omap_sram_idle(void)
> >         * of AUTO_CNT = 1 enabled. This takes care of errata 1.142.
> >         * Hence store/restore the SDRC_POWER register here.
> >         */
> > -       if (omap_rev() >= OMAP3430_REV_ES3_0 &&
> > +       if ((cpu_is_omap3630()
> > +               || cpu_is_omap3505() || cpu_is_omap3517()
> > +               || cpu_rev_ge(34xx, OMAP34XX_ES_3_0)) &&
> cpu_rev_ge(34xx, OMAP34XX_ES_3_0) -> this is the cause of my 
> comment on 
> dirty code - redundant OMAP34XX_ in the macro when I do say 
> it is 34xx 
> in the first parameter!
> 

[sp] Dirtiness is in eye of beholder :)
     I did say earlier, that the patch is meant for increasing
     readability. I could have overcome this by using lowercase
     for revision macros.

     I did think of "exploiting" enums; but had been avoiding
     the need for adding new data structures. It, however, can
     be ugly!

> >             omap_type() != OMAP2_DEVICE_TYPE_GP &&
> >             core_next_state == PWRDM_POWER_OFF)
> >                 sdrc_pwr = sdrc_read_reg(SDRC_POWER);
> > 
> > Don't try to look more into the actual content of this example,
> > but try to use existing macros to re-implement this condition.
> > 
> > omap_rev() is always > OMAP3430_REV_ES3_0 for all OMAP35x devices;
> > even for OMAP3530 at ES2.1 level (0x35302034 > 0x34304034)
> > 
> > And the original condition doesn't hold good.
> > 
> > Try to visualize silicon revision viz. "2.1" for OMAP3505 requiring
> > the same example condition to be updated.
> 
> I see similar potential use in enabling quirks and features 
> (the above 
> code btw could be better handled with a single variable 
> errata which is 
> populated with a flag at pm_init time..

[sp] The need for detection of cpu revision arises much before pm_init()
     is executed. The code snippet above was just an illustration. It is
     neither the first nor the only place where the revision comparison
     is necessary.

     I, possibly, did mention in an earlier comment that OMAP3505 and
     OMAP3530 are way too different to be handled as simple "errata".

> 
> > 
> > ~sanjeev
> >> -- 
> >> Regards,
> >> Nishanth Menon
> 
> 
> -- 
> Regards,
> Nishanth Menon
> 