From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 06/16] OMAP3: PM: Smartreflex class related changes for
 smartreflex.c
Date: Fri, 5 Mar 2010 20:48:43 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321CBD2B8@dbde02.ent.ti.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
	<1267003757-22456-2-git-send-email-thara@ti.com>
	<1267003757-22456-3-git-send-email-thara@ti.com>
	<1267003757-22456-4-git-send-email-thara@ti.com>
	<1267003757-22456-5-git-send-email-thara@ti.com>
	<1267003757-22456-6-git-send-email-thara@ti.com>
	<1267003757-22456-7-git-send-email-thara@ti.com>
 <87iq9es2lx.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33068 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688Ab0CEPSs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 10:18:48 -0500
In-Reply-To: <87iq9es2lx.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Wednesday, March 03, 2010 5:23 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Menon, Nishanth; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH 06/16] OMAP3: PM: Smartreflex class related changes for smartreflex.c
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> OMAP3 smartreflex modules are capable of two different classes
>>> of implementaion -
>>> 	Class-2: Continuous Software Calibration
>>> 	Class-3: Continuous Hardware Calibration.
>>> OMAP3 along with T2/Gaia supports the Class 3 implementaion.
>>> With a different PMIC it can support Class 2 implementaion also.
>>>
>>> The idea behind this patch is that smartreflex.c should be able
>>> to support both the classes of Smartreflex and the class specific
>>> details for smartreflex should stay out of this file in a separate
>>> class file.
>>> This patch introduces smartreflex class specific hooks in
>>> smartreflex.c. This patch only takes care of smartreflex enable
>>> disable hooks which differ between Class 2 and Class 3. There
>>> are some register setting changes between both the classes which
>>> will be taken care of in a later patch.
>>> This will form the base for adding class specific
>>> drivers in later patches.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/pm34xx.c      |    8 +-
>>>  arch/arm/mach-omap2/smartreflex.c |  251 ++++++++++++++++++++----------------
>>>  arch/arm/mach-omap2/smartreflex.h |   48 ++++++--
>>>  3 files changed, 182 insertions(+), 125 deletions(-)
>>>
>>
>>[...]
>>
>>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
>>> index c00925d..ba9f899 100644
>>> --- a/arch/arm/mach-omap2/smartreflex.c
>>> +++ b/arch/arm/mach-omap2/smartreflex.c
>>> @@ -55,6 +55,7 @@ struct omap_sr {
>>>
>>>  /* sr_list contains all the instances of smartreflex module */
>>>  static LIST_HEAD(sr_list);
>>> +static struct omap_smartreflex_class_data *sr_class;
>>>
>>>  #define SR_REGADDR(offs)	(sr->srbase_addr + offset)
>>>
>>> @@ -388,14 +389,86 @@ static int sr_reset_voltage(int srid)
>>>  	return 0;
>>>  }
>>>
>>> -static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
>>> +static void sr_start_vddautocomap(int srid)
>>
>>Either in this patch or in an additional patch (previous to this one)
>>can you fix the name of these autocomp functions: *_vddautocomap ->
>>*_vddautocomp.  I don't think comap means anything.

I can fix this. I would prefer this change to be a part of one of the existing patches in the patch set so that I do not increase the patch count and it will be easier for me to sen a V2.

Regards
Thara
>>
>>Kevin
