From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv4 4/8] ARM: OMAP4: hwmod: flag hwmods/modules supporting
 module level context status
Date: Tue, 22 May 2012 16:29:41 +0200
Message-ID: <4FBBA2D5.2000101@ti.com>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com>  <1334913591-26312-5-git-send-email-t-kristo@ti.com>  <4F957ACD.2040103@ti.com> <1335278815.2149.93.camel@sokoban>  <4F96DF8C.6040400@ti.com> <87pqa5axuo.fsf@ti.com> <4FB33A29.4030404@ti.com>  <4FB33EF2.90705@ti.com> <1337696432.20948.44.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36861 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960Ab2EVO3r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 May 2012 10:29:47 -0400
In-Reply-To: <1337696432.20948.44.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@ti.com>, Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On 5/22/2012 4:20 PM, Tero Kristo wrote:
> On Wed, 2012-05-16 at 11:15 +0530, Rajendra Nayak wrote:
>> On Wednesday 16 May 2012 10:54 AM, Rajendra Nayak wrote:
>>> On Wednesday 16 May 2012 03:52 AM, Kevin Hilman wrote:
>>>> "Cousson, Benoit"<b-cousson@ti.com>  writes:
>>>>
>>>>> On 4/24/2012 4:46 PM, Tero Kristo wrote:
>>>>>> On Mon, 2012-04-23 at 10:52 -0500, Jon Hunter wrote:
>>>>>>> Hi Tero,
>>>>>>>
>>>>>>> On 04/20/2012 04:19 AM, Tero Kristo wrote:
>>>>>>>> From: Rajendra Nayak<rnayak@ti.com>
>>>>>>>>
>>>>>>>> On OMAP4 most modules/hwmods support module level context status. On
>>>>>>>> OMAP3 and earlier, we relyed on the power domain level context
>>>>>>>> status.
>>>>>>>> Identify all such modules using a 'HWMOD_CONTEXT_REG' flag, all such
>>>>>>>> hwmods already have a valid 'context_offs' populated in .prcm
>>>>>>>> structure.
>>>>>>>
>>>>>>> Is it necessary to add another flag? Can't we just check if
>>>>>>> context_offs
>>>>>>> is non-zero? Would save adding a lot more lines to an already large
>>>>>>> file
>>>>>>> :-)
>>>>>>
>>>>>> Actually one of the older versions of this patch was just checking
>>>>>> against a non-zero value, but it was decided to be changed as
>>>>>> potentially the context_offs can be zero even if it is a valid offset.
>>>>
>>>> Potentially? Is that the case on OMAP4/5 today? I don't see any for
>>>> OMAP4 in mainline.
>>>
>>> No, we don;t have any such cases today in either OMAP4 or OMAP5.
>>>
>>>>
>>>> If zero really is a valid offset somewhere (where?), then we could use
>>>> -1 (or USHRT_MAX in this case.)
>>>
>>> This makes sense for OMAP4 and beyond (and same with having a flag
>>> to indicate the *lack* of having the feature) as it will mean just
>>> adding a few entries in hwmod data files to indicate IP blocks (very
>>> few) which do not support this feature.
>>>
>>> However since none of OMAP2/3 varients (except I guess the AMxxxx
>>> family) support this, it would also mean we mark
>>> *most* blocks in OMAP2/3 to indicate they *lack* this feature, which
>>> would mean bloating the OMAP2/3 data files, but your
>>> comment below about doing it for all IPs during hwmod registration
>>> makes sense at least for OMAP2 since *all* blocks can be marked at
>>> registration. OMAP3 would probably need more data files to be updated
>>> to indicate which ones support and which ones don't.
>>>
>>> Having said that I also see 'context_reg' being defined inside
>>> omap_hwmod_omap4_prcm would need to be fixed if we have to
>>> support this for SoCs which fall as OMAP3 varients.
>>
>> I just went back and looked at Vaibhavs patch which adds am33xx
>> hwmod data and I think none of what I said above is a problem.
>> I think we can safely mark the few blocks on OMAP4 which do
>> not have a valid context_reg with -1 or USHRT_MAX as you suggested
>> and mark all OMAP2/3 blocks with this at registration.
>>
>> Benoit/Paul, does that sound good?
>
> Any comments to this? This is blocking v6 for this set.

That's OK for me.

> Also, who is going to generate the hwmod data?

Well, in that case, only two entries have to be changed I guess, but 
I'll update anyway the scripts to populate the missing one with the 
macros you will create.

Benoit
