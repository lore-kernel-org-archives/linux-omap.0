From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: PM: introduce power domains functional
 states
Date: Thu, 17 May 2012 15:34:53 +0530
Message-ID: <4FB4CD45.4050807@ti.com>
References: <1334752782-28804-1-git-send-email-j-pihet@ti.com> <1334752782-28804-3-git-send-email-j-pihet@ti.com> <alpine.DEB.2.00.1205070043230.9984@utopia.booyaka.com> <CAORVsuXUbz_f54x=hoFLEQpfAGTDcZGnTQ-fBgY_j415LC0TiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:48580 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756049Ab2EQKFA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 06:05:00 -0400
Received: by obbtb18 with SMTP id tb18so2310997obb.19
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 03:04:58 -0700 (PDT)
In-Reply-To: <CAORVsuXUbz_f54x=hoFLEQpfAGTDcZGnTQ-fBgY_j415LC0TiQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

Jean,
On Tuesday 08 May 2012 02:10 PM, Jean Pihet wrote:
> Paul,
> 
> On Mon, May 7, 2012 at 11:28 AM, Paul Walmsley <paul@pwsan.com> wrote:
>> Hi
>>
>> On Wed, 18 Apr 2012, jean.pihet@newoldbits.com wrote:
>>
>>> From: Jean Pihet <j-pihet@ti.com>
>>>
>>> Introduce functional (or logical) states for power domains and the
>>> API functions to read the power domains settings and to convert
>>> between the functional (i.e. logical) and the internal (or registers)
>>> values.
>>>
>>> OMAP2, OMAP3 and OMAP4 platforms are defining a conversion routine.
>>>
>>> In the new API the function omap_set_pwrdm_state takes the functional
>>> states as parameter; while at it the function is moved to the power
>>> domains code.
>>>
>>> The memory and logic states are not using the functional states, this
>>> comes as a subsequent patch.
>>>
>>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>>
>> This patch results in several checkpatch warnings; please resolve them.
> Oops. Will check and update.
> 
>>
>>> ---
>>>  arch/arm/mach-omap2/pm.c                   |   66 -----------
>>>  arch/arm/mach-omap2/powerdomain-common.c   |   61 ++++++++++
>>>  arch/arm/mach-omap2/powerdomain.c          |  175 ++++++++++++++++++++++++++++
>>>  arch/arm/mach-omap2/powerdomain.h          |   21 ++++
>>>  arch/arm/mach-omap2/powerdomain2xxx_3xxx.c |    5 +
>>>  arch/arm/mach-omap2/powerdomain44xx.c      |    2 +
>>>  6 files changed, 264 insertions(+), 66 deletions(-)
>>>
> ...
> 
>>> +/*
>>> + * Functional (i.e. logical) to internal (i.e. registers)
>>> + * values for the power domains states
>>> + */
>>
>> Please use kerneldoc-style function comments.
> Ok
> 
>>
>>> +int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst)
>>> +{
>>> +     int ret;
>>> +
>>> +     switch (func_pwrst) {
>>> +     case PWRDM_FUNC_PWRST_ON:
>>> +             ret = PWRDM_POWER_ON;
>>> +             break;
>>> +     case PWRDM_FUNC_PWRST_INACTIVE:
>>> +             ret = PWRDM_POWER_INACTIVE;
>>> +             break;
>>> +     case PWRDM_FUNC_PWRST_CSWR:
>>> +     case PWRDM_FUNC_PWRST_OSWR:
>>> +             ret = PWRDM_POWER_RET;
>>> +             break;
>>> +     case PWRDM_FUNC_PWRST_OFF:
>>> +             ret = PWRDM_POWER_OFF;
>>> +             break;
>>> +     default:
>>> +             ret = -1;
>>> +     }
>>> +
>>> +     return ret;
>>> +}
>>
>> At a quick glance, I don't think that this function is appropriate for all
>> OMAP2+ chips.  For example, off-mode is not supported in our OMAP2xxx
>> kernels.  And OMAP2xxx/3xxx do not support the INACTIVE powerstate.  So
>> probably this function should differ by chip, and be located in the
>> powerdomain[2-4]*xx*.c files.
> I hope to make this function as generic as possible, hence the
> location (powerdomain-common.c). Some states are not programmed by the
> pwrdm_* functions since there forbidden by the contents of the
> pwrdm->pwrst field.
> Now if the need arises some platform specific function can be defined
> for conversion functions since the pwrdm->ops function pointers are
> used. I do not think it is needed now but it can easily be changed.
> 
>> Also, what about the logic and memory bank power states?  Shouldn't this
>> function pass those back as well?
> Cf. in the description "The memory and logic states are not using the
> functional states, this comes as a subsequent patch."
> 
I don't see much difference between the functional power states to
actual power states with some cases here and there.

+     case PWRDM_FUNC_PWRST_CSWR:
+     case PWRDM_FUNC_PWRST_OSWR:
+             ret = PWRDM_POWER_RET;

This is not true and even if you add logic/memmort etc support,
I still think, we are just duplicating stuff between functional
vs actual power state.

If the idea is to have one single interface to program the power
domain states, so that Generic frameworks, or PM code movement to
driver/* directories is easier, we may want think about alternative
which is scalable.

Just a wild thought...

May be we can abstract all the necessary/used power domain programming
entities inside a structure and export that. That should contain, power
state, logic state, mem state, special quirk flags like SAR etc.
being structure is always expandable and an API taking structure as
a parameter need not change.

Regards
Santosh

