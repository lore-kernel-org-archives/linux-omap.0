From: Venkatraman S <svenkatr@ti.com>
Subject: Re: How to introduce omap_features (was Re: [PATCH RESEND] update
	omap3 features bitmap and API to generic names)
Date: Tue, 11 May 2010 20:08:03 +0530
Message-ID: <AANLkTimWjse-eXqzZx3nO8VwrFogdC2a0Lo8laevWuie@mail.gmail.com>
References: <1273521338-2896-1-git-send-email-svenkatr@ti.com>
	 <AANLkTimNjnKG3WFK8mdpgHaLh-Xpv54fohFgEYYiVVcg@mail.gmail.com>
	 <0680EC522D0CC943BC586913CF3768C003B3209B23@dbde02.ent.ti.com>
	 <4BE9483C.7090308@gmail.com>
	 <AANLkTimHN0XUlBsj3FvhpOkuMhrFHSvPu3MQI9ZtEqvc@mail.gmail.com>
	 <4BE95F04.5010309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49039 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab0EKOpx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 10:45:53 -0400
Received: by pwi5 with SMTP id 5so2265450pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 07:45:52 -0700 (PDT)
In-Reply-To: <4BE95F04.5010309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

On Tue, May 11, 2010 at 7:13 PM, Nishanth Menon <nm@ti.com> wrote:
> Venkatraman S had written, on 05/11/2010 07:19 AM, the following:
>>
>> =A0Nishanth Menon <menon.nishanth@gmail.com> wrote:
>>>
>>> -linux-arm
>>>
>>> On 05/10/2010 10:53 PM, S, Venkatraman wrote:
>>>>>
>>>>> -----Original Message-----
>>>>> From: menon.nishanth@gmail.com
>>>>> [mailto:menon.nishanth@gmail.com] On Behalf Of Menon, Nishanth
>>>>> Sent: Tuesday, May 11, 2010 5:02 AM
>>>>> To: S, Venkatraman
>>>>> Cc: linux-omap@vger.kernel.org;
>>>>> linux-arm-kernel@lists.infradead.org; Tony Lindgren;
>>>>> Chikkature Rajashekar, Madhusudhan
>>>>> Subject: Re: [PATCH RESEND] update omap3 features bitmap and
>>>>> API to generic names
>>>>>
>>>>> On Mon, May 10, 2010 at 2:55 PM, Venkatraman S
>>>>> <svenkatr@ti.com> =A0wrote:
>>>>>>
>>>>>> =A0 =A0 =A0 OMAP3 features bitmap is used a method to check for =
SoC
>>>>>> specific features. This patch renames the global variables and t=
he
>>>>>> accessor functions to use a generic name from omap3_* to
>>>>>> omap_*
>>>>>>
>>>>>> Signed-off-by: Venkatraman S<svenkatr@ti.com>
>>>>>> CC: Nishant Menon<nm@ti.com>
>>>>>
>>>>> Just for the patchworks
>>>>> NAK - discussed before -
>>>>> http://marc.info/?l=3Dlinux-omap&m=3D127349696800651&w=3D2
>>>>
>>>> This patch doesn't have the descriptor load changes, and just the
>>>> rename.
>>>> Did you take a look at it first?
>>>
>>> Arrgh - my bad - there was no reference to previous discussions or
>>> anything
>>> in this patch, please do add references in diffstat section if you =
are
>>> refering to a previous discussed strategy to help the reviewers
>>> differentiate and understand you better.
>>>
>>> overall this still opens up a question for me -> can we blindly rep=
lace
>>> omap3-features with omap features? how do we think of omap1,2,3,4 a=
re
>>> handled consistently with a 32 bit field?
>>>
>>> I agree on the need to have a omap independent field, but is
>>> omap3_features
>>> the one we need to modify OR should we be introducing a new field?
>>>
>>> my vote goes for introducing a new field.
>>>
>>
>> You are confusing the interface with implementation (or rather,
>> worrying about both of them simultaneously).
>>
>> The interface has to be consistent and SoC independent, to the exten=
t
>> possible.
>> =A0So the macro changes are relevant and readable / extensible.
>>
>> Regarding the variable name (implementation):-
>> =A0 Given the minimal set that we have (5 -6 fields today, so there =
is
>> room for 25 more 'features" still), I don't think
>> we should over-engineer it now to accomodate all permutations and us=
e
>> cases. It's not even found use
>> beyond 1 or 2 files. YAGNI ?
>
> huh? I dont understand you. lets see what we we are doing here:
> a) we are causing an ABI breakage by moving omap3_feature to omap_fea=
ture


The omap3_feature variable is not supposed to be used by modules
*querying* for the feature. They don't even have to know it's existence=
=2E
 That is what the macros/inline functions  omap_has_***() are for.

All the uses of omap3_has_** have been replaced by omap_has_** in this =
patch.
This is an ABI change (due to the previous interface tying it to OMAP3)
and *not* ABI breakage (All previous uses have been replaced)

> (which by the way should also include changes to the macros as well..=
)
    This is different. There could be different ways in which the
actual snooping
of whether a feature exists on not is implemented. For OMAP3, it is
looking up the control module.
(This, I have preserved). For other SoCs, it could be different, I
don't know how to
snoop them for. Your comments are welcome.

> b) we have a real need to have a cross OMAP feature distinction to
> differentiate between generic omap feature and omap3/2/1/4 features.
>
> This patch does not address the same in a consistent scalable way. NO=
TE: we
> are starting to introduce other OMAP4 features as well, SOC level fea=
ture
> distinction should ideally be handled by FEATURE framework - that is =
the
> reason it was introduced in the first place.

 I never claimed this patch to be a mother of all 'features
framework'. It was just
a name improvement to the bunch of macros that existed. Again,

a) it preserves the separtion of interface. We can have a full fledged =
tree
   of generic / OMAP[12345] specific features, but the interface need n=
ot
change.

>
> if your feel this is overengineering - well, I believe this is concep=
tual
> definition -> Specific OMAP[1234] *family* features Vs OMAP generic
> features.. two different things in my mind -> it does not matter if I=
 have
> 32 bits in the original variable OR if I had 64bit.. i dont prefer to=
 reuse
> a variable and mess up the conceptual distinction.
>

b) Are you simply saying that the existing features bitmap (all 6 of
them) are tied to OMAP3 ? For good ?
In that case, I really understand your comments and can change back
the variable name.

At the same time, it's not easy to classify what category a feature bel=
ongs to.
What could a single SoC specific feature today (SDMA descriptor
loading) could then become
a series (OMAP4, OMAP5 etc).  Or it could occur at disjoint intervals
(OMAP3 and OMAP5).
Even if it somehow could be boxed to a series, I think the interface
would then be tied to
that series, which would break future expansion.

So a *flat* structure of "uniquely named" features storage
is what we want, which eventually could flow over to an array of bitfie=
lds.

In other words, if the interface is defined as omapX_has_feature(), it =
is not
maintainable, for any X. It should always be omap_has_feature(), even
if it is found in a single SoC.

This is what I understand your intention in change of $SUBJECT.
If you have another proposal, please post it here and I can work with
you on that.

Regards,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
