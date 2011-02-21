From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: hwmod: multi-omap: disabling smartreflex on AM3517
Date: Mon, 21 Feb 2011 21:11:49 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BD48BED@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB5930248A017D9@dbde02.ent.ti.com>
 <4D5A75FF.5040703@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024B83BF08@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024BD4894D@dbde02.ent.ti.com>
 <4D623ED8.4050906@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024BD489B1@dbde02.ent.ti.com>
 <4D6273FE.3000205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49102 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948Ab1BUPlz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 10:41:55 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1LFfqrH019944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 09:41:54 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1LFfpku012113
	for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 21:11:51 +0530 (IST)
In-Reply-To: <4D6273FE.3000205@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Cousson, Benoit
> Sent: Monday, February 21, 2011 7:48 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: hwmod: multi-omap: disabling smartreflex on AM3517
> 
> On 2/21/2011 11:39 AM, Premi, Sanjeev wrote:
> >> From: Cousson, Benoit
> >> Sent: Monday, February 21, 2011 4:01 PM
> >>
> >> Hi Sanjeev,
> >>
> >> On 2/21/2011 10:57 AM, Premi, Sanjeev wrote:
> >>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >>>> owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> >>>> Sent: Friday, February 18, 2011 5:43 PM
> >>>> To: Cousson, Benoit
> >>>> Cc: linux-omap@vger.kernel.org
> >>>> Subject: RE: hwmod: multi-omap: disabling smartreflex on AM3517
> >>>>
> >>>>> From: Cousson, Benoit
> >>>>> Sent: Tuesday, February 15, 2011 6:18 PM
> >>>>> To: Premi, Sanjeev
> >>>>> Cc: linux-omap@vger.kernel.org
> >>>>> Subject: Re: hwmod: multi-omap: disabling smartreflex on AM3517
> >>>>>
> >>>>> Hi Sanjeev,
> >>>>>
> >>>>> On 2/15/2011 12:51 PM, Premi, Sanjeev wrote:
> >>>>>> AM3517 doesn't support SmartReflex.
> >>>>>>
> >>>>>> However, these HWMODS are defined in omap3xxxx_hwmods[]:
> >>>>>> 	&omap34xx_sr1_hwmod,
> >>>>>> 	&omap34xx_sr2_hwmod,
> >>>>>> 	&omap36xx_sr1_hwmod,
> >>>>>> 	&omap36xx_sr2_hwmod,
> >>>>>>
> >>>>>> (similar definition in l4_slaves as well)
> >>>>>>
> >>>>>> This leads to crash when booting the kernel on AM3517EVM during
> >>>>>> _setup().
> >>>>>>
> >>>>>> I see the field .omap_chip being initialized; but not used.
> >>>>>
> >>>>> Yes, it is. During the hwmod initialization (omap_hwmod_init), only
> >> the
> >>>>> hwmods that match the correct chip version are kept.
> >>>>> I guess that your problem is that AM3517 is probably seen as a
> regular
> >>>>> 3430 for the moment.
> >>>>>
> >>>>>> If I were to use this - along with cpu_is_omap3517(), I would need
> >>>>>> to define a new flag e.g. CHIP_IS_AM3517 and add it to almost all
> >>>>>> devices defined in omap_hwmod_3xxx_data.c.
> >>>>>>
> >>>>>> Before going all out on making changes, wanted to check if there is
> >>>>>> a better way. Has this/similar possibility been considered earlier?
> >>>>>
> >>>>> Well, this is the best way to do that for my point of view. This
> >>>>> .omap_chip field was done for that purpose.
> >>>>> During device init, the sr code will do query for the smartreflex
> >> hwmod
> >>>>> and will failed, thus avoiding to do further initialization.
> >>>>
> >>>> [sp] Trying to avoid big change, and thinking 'narrowly' about this
> >>>>        issue in isolation, I had been mulling adding SmartReflex to
> >>>>        the omap3_features; and (somehow) using the same.
> >>>>
> >>>>        But after noticing the patch related to USBOTG on AM35x, I
> think
> >>>>        original proposal is unambiguous and best way forward.
> >>>>
> >>>>        Started working on the patch. Hope to have it ready later
> tonight
> >>>>        or tomorrow.
> >>>>
> >>>
> >>> [sp] Just came across another issue while making this patch:
> >>>        Checking for presence of IVA.
> >>>
> >>>        There is not IVA on AM3517. With existing CHIP_IS_3430 flag,
> the
> >>>        hwmod for IVA will be initialized.
> >>>
> >>>        Benoit, Any ideas here?
> >>
> >> Yes, still the same one :-).
> >> Since the AM3517 does not contains the exact same list of IPs, you have
> >> to create a dedicated CHIP_IS_3517 and then change the CHIP_IS_3430 by
> >> CHIP_IS_3430 | CHIP_IS_3517 to every hwmod entries except SR, IVA and
> >> any others IP that will not be there.
> >>
> >> The hwmod list should be considered as a very details "features" list.
> >> So you should not have to create a new feature list elsewhere. it is a
> >> duplication of what the hwmod list is already doing. By dumping the
> >> hwmod list, you should know exactly what is supported by the chip.
> >>
> >> I'm quite sure you will have different clock nodes as well, so you will
> >> have to do the same in the clock_data file.
> >
> > Benoit,
> >
> > I am only worried about making cpu_is_omap3517() or equiv calls in the
> > generic functions _init(), _setup() etc.
> >
> > Gives impression of a hack when I look at the code.
> 
> Yes, it is :-)
> 
> But you do not have to do that, if you create a CHIP_IS_3517.
> 
> It looks like there is some mis-understanding somewhere...
> 
> 
> The hwmod filtering is done here based on the omap_chip_is() call.
> 
> int __init omap_hwmod_init(struct omap_hwmod **ohs)
> {
> 	struct omap_hwmod *oh;
> 	int r;
> 
> 	if (inited)
> 		return -EINVAL;
> 
> 	inited = 1;
> 
> 	if (!ohs)
> 		return 0;
> 
> 	oh = *ohs;
> 	while (oh) {
> 		if (omap_chip_is(oh->omap_chip)) {
> 			r = _register(oh);
> 			WARN(r, "omap_hwmod: %s: _register returned "
> 			     "%d\n", oh->name, r);
> 		}
> 		oh = *++ohs;
> 	}
> 
> 	return 0;
> }
> 
> And the omap_chip is initialized here. So you should add the AM3517
> support here (arch/arm/mach-omap2/id.c)
> 
> static void __init omap3_check_revision(void)
> [...]
> 	case 0xb868:
> 		/* Handle OMAP35xx/AM35xx devices
> 		 *
> 		 * Set the device to be OMAP3505 here. Actual device
> 		 * is identified later based on the features.
> 		 *
> 		 * REVISIT: AM3505/AM3517 should have their own CHIP_IS
> 		 */
> 		omap_revision = OMAP3505_REV(rev);
> 		omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
> 		break;
> [...]
> 
> The comment is already there BTW, so you just have to replace that by some
> real code:-)

[sp] I have already added real code, but the problem lies here:
     On same file (few lines up) omap_chip.oc is assigned value of
     CHIP_IS_OMAP3430. CHIP_IS_AM3517 now needs to be added to all
     places where CHIP_IS_OMAP3430ES3_1 is chosen.

     All this to support a chip that differs in 4 peripherals and IVA.
     ... and this is what I was planning to minimize.

     Leaving aside AM3517; we have AM3703 - same as OMAP3630 but without
     IVA and SGX. Here obviously hwmods for either of IVA, SGX shouldn't
     be initialized. Isn't it?

     Creating CHIP_IS_ ... here would be an overkill. Thoughts?

~sanjeev

> 
> Regards,
> Benoit
