From: Nishanth Menon <nm@ti.com>
Subject: Re: How to introduce omap_features (was Re: [PATCH RESEND] update
 	omap3 features bitmap and API to generic names)
Date: Tue, 11 May 2010 08:43:32 -0500
Message-ID: <4BE95F04.5010309@ti.com>
References: <1273521338-2896-1-git-send-email-svenkatr@ti.com>	 <AANLkTimNjnKG3WFK8mdpgHaLh-Xpv54fohFgEYYiVVcg@mail.gmail.com>	 <0680EC522D0CC943BC586913CF3768C003B3209B23@dbde02.ent.ti.com>	 <4BE9483C.7090308@gmail.com> <AANLkTimHN0XUlBsj3FvhpOkuMhrFHSvPu3MQI9ZtEqvc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59114 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757186Ab0EKNnh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 May 2010 09:43:37 -0400
In-Reply-To: <AANLkTimHN0XUlBsj3FvhpOkuMhrFHSvPu3MQI9ZtEqvc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

Venkatraman S had written, on 05/11/2010 07:19 AM, the following:
>  Nishanth Menon <menon.nishanth@gmail.com> wrote:
>> -linux-arm
>>
>> On 05/10/2010 10:53 PM, S, Venkatraman wrote:
>>>> -----Original Message-----
>>>> From: menon.nishanth@gmail.com
>>>> [mailto:menon.nishanth@gmail.com] On Behalf Of Menon, Nishanth
>>>> Sent: Tuesday, May 11, 2010 5:02 AM
>>>> To: S, Venkatraman
>>>> Cc: linux-omap@vger.kernel.org;
>>>> linux-arm-kernel@lists.infradead.org; Tony Lindgren;
>>>> Chikkature Rajashekar, Madhusudhan
>>>> Subject: Re: [PATCH RESEND] update omap3 features bitmap and
>>>> API to generic names
>>>>
>>>> On Mon, May 10, 2010 at 2:55 PM, Venkatraman S
>>>> <svenkatr@ti.com>  wrote:
>>>>>        OMAP3 features bitmap is used a method to check for SoC
>>>>> specific features. This patch renames the global variables and the
>>>>> accessor functions to use a generic name from omap3_* to
>>>>> omap_*
>>>>>
>>>>> Signed-off-by: Venkatraman S<svenkatr@ti.com>
>>>>> CC: Nishant Menon<nm@ti.com>
>>>> Just for the patchworks
>>>> NAK - discussed before -
>>>> http://marc.info/?l=linux-omap&m=127349696800651&w=2
>>> This patch doesn't have the descriptor load changes, and just the rename.
>>> Did you take a look at it first?
>> Arrgh - my bad - there was no reference to previous discussions or anything
>> in this patch, please do add references in diffstat section if you are
>> refering to a previous discussed strategy to help the reviewers
>> differentiate and understand you better.
>>
>> overall this still opens up a question for me -> can we blindly replace
>> omap3-features with omap features? how do we think of omap1,2,3,4 are
>> handled consistently with a 32 bit field?
>>
>> I agree on the need to have a omap independent field, but is omap3_features
>> the one we need to modify OR should we be introducing a new field?
>>
>> my vote goes for introducing a new field.
>>
> 
> You are confusing the interface with implementation (or rather,
> worrying about both of them simultaneously).
> 
> The interface has to be consistent and SoC independent, to the extent possible.
>   So the macro changes are relevant and readable / extensible.
> 
> Regarding the variable name (implementation):-
>    Given the minimal set that we have (5 -6 fields today, so there is
> room for 25 more 'features" still), I don't think
> we should over-engineer it now to accomodate all permutations and use
> cases. It's not even found use
> beyond 1 or 2 files. YAGNI ?

huh? I dont understand you. lets see what we we are doing here:
a) we are causing an ABI breakage by moving omap3_feature to 
omap_feature (which by the way should also include changes to the macros 
as well..)
b) we have a real need to have a cross OMAP feature distinction to 
differentiate between generic omap feature and omap3/2/1/4 features.

This patch does not address the same in a consistent scalable way. NOTE: 
we are starting to introduce other OMAP4 features as well, SOC level 
feature distinction should ideally be handled by FEATURE framework - 
that is the reason it was introduced in the first place.

if your feel this is overengineering - well, I believe this is 
conceptual definition -> Specific OMAP[1234] *family* features Vs OMAP 
generic features.. two different things in my mind -> it does not matter 
if I have 32 bits in the original variable OR if I had 64bit.. i dont 
prefer to reuse a variable and mess up the conceptual distinction.


-- 
Regards,
Nishanth Menon
