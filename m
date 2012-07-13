From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: RFC: Simplification of Power Domain Control
Date: Fri, 13 Jul 2012 15:55:51 +0200
Message-ID: <CAORVsuXU+4xvb9ydcA6bw68gUDJVK1NYKGgyo9e=GEt4OvFOCA@mail.gmail.com>
References: <CAOMWX4d=bYzb3+ao0DFLi8SHk5_gZ9dO=g0JV19NnTgxH89b4w@mail.gmail.com>
	<5000007E.6070801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37867 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab2GMNzx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jul 2012 09:55:53 -0400
Received: by lbbgm6 with SMTP id gm6so5854752lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Jul 2012 06:55:51 -0700 (PDT)
In-Reply-To: <5000007E.6070801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, "Menon, Nishanth" <nm@ti.com>
Cc: Paul <paul@pwsan.com>, Jean <j-pihet@ti.com>, Kevin <khilman@ti.com>, Santosh <santosh.shilimkar@ti.com>, Benoit <b-cousson@ti.com>, David <dderrick@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Nishant, Rajendra,

On Fri, Jul 13, 2012 at 1:03 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> Hi Nishanth,
>
>
> On Friday 13 July 2012 03:21 PM, Menon, Nishanth wrote:
>>
>> On Thursday 05 July 2012, Rajendra Nayak wrote:
>> [..]
>>>
>>>  From 5f5e4eb342110286bf719c7d9d7c1959f53e34f9 Mon Sep 17 00:00:00 2001
>>> From: Rajendra Nayak<rnayak@ti.com>
>>> Date: Thu, 5 Jul 2012 17:33:28 +0530
>>> Subject: [RFC] ARM: OMAP: Powerdomain: control memory and logic bits
>>> internally
>>>
>>> Powerdomain framework exposes various apis for memory and logic
>>> control for powerdomains, for its users to program OSWR: Open SWitch
>>> Retention state. While in theory, there are various combinations of
>>> memory and logic states possible which can be configured as OSWR,
>>> in practice all OMAPs use just one combination. Logic lost, memory
>>> retained.
>>>
>>> This can very easily be handled within the powerdomain framework itself,
>>> without exposing all complex memory/logic control apis to upper layer
>>> drivers like cpuidle and suspend.
>>>
>>> To do this, introduce 2 new power domain states PWRDM_POWER_CSWR and
>>> PWRDM_POWER_OSWR usable by the users of powerdomain framework and
>>> make all memory/logic control apis internal to powerdomain framework.
>>> Change all users of powerdomain framework to get rid of all usage
>>> of memory/logic control apis and use the newly defined states for
>>> CSWR and OSWR with the already used powerstate control apis.
>>>
>>> Some functions (which are now made internal) are forward declared
>>> to avoid moving functions around in the file (which can be done in a
>>> later patch) to help keep the patch reviewable.
>>>
>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>
>>
>>
>> Ref: http://marc.info/?t=133968586800004&r=1&w=2
>>
>> Apologies, but i've had to copypaste the original message, so inline
>> response
>> might be a bit messed up.
>>
>>  From an initial port to get cpuidle working on OMAP5, my experiences
>> follow:
>
>
> Thanks for the tests and the review.
>
>>
>> a) counter handling (pm-debug.c) - we can now do better than give our
>> arcane RET:5
>> LOGIC-POWER-OFF:4 , instead we can clearly indicate OSWR, CSWR in
>> counter
>> Part of the issue also now becomes that count and time arrays are in
>> the range of
>> PWRDM_POWER_ON. They break when CSWR/OSWR is in pwrdm->state
Cf. http://marc.info/?l=linux-omap&m=133968582005062&w=2 for an
implementation of the power domains statistics using the func power
states. Of course the string format can be updated.

>>
>> b) pwrst handling this becomes a hard one to handle (as usual) when
>> comparisons of
>> while (!(pwrdm->pwrsts&  (1<<  pwrst))) {
>>
>>          if (pwrst == PWRDM_POWER_OFF)
>>                  goto out;
>>          pwrst--;
>> }
>>
>> with value 4, 5 ->  pwrsts should either now use OSWR, CSWR definitions
>> OR we will need translate back before checks
That is correct. The proposed implementation introduces a new function
pwrdm_get_achievable_func_pwrst that walks through the _internal_
(i.e. registers) states for both the power state and the logic state.
Cf. http://marc.info/?l=linux-omap&m=133968582005061&w=2. The patch is
in RFC state and so it would be ideal to get some comments from the
knowledgeable persons.

>>
>> c) in few critical places, these mentioned error checks do silent
>> error returns - example:
>>   if (!(pwrdm->pwrsts_logic_ret&  (1<<  pwrst)))
>>
>>           return -EINVAL;
>>   this bit me more than once while i tried to bring up the patch
>> we should be doing a patch which introduces a ratelimited WARN to kill the
>> bad callers.
Right!

>>
>> d) we have been lazy in programming and have been using cur_pwrst<
>> PWRDM_POWER_ON or INACTIVE etc.. and do a set of operations based off
>> that. this wont work as CSWR, OSWR>  POWER_INACTIVE. (e.g. pm3 code)
That is one of the concerns with the current code. Any suggestion on that?

>
>
> All are valid issues. Some I overlooked, some like the array index
> issues due to CSWR/OSWR being defined post OFF, I knew but did not
> handle well because it was  a hastily cooked up RFC to clarify our
> thoughts.
Correct. That is the problem with the RFC, which is trying to retain
most of the original code for the states handling.

>
> now that I have more feedback I will certainly wort on improving it.
>
>
>>
>> e) similar to what Jean did, omap_set_pwrdm_state will need to move
>> over from pm.c to powerdomain.c
Correct! The function could even be renamed to pwrdm_... Also the
private header file is a good concept.

>>
>> f) We probably should also will need an updated patch for
>> http://marc.info/?l=linux-omap&m=133968581105049&w=2
>
>
> Yes, certainly, they would be needed as well.
I have a new version of the patch. Cf. the tree at
https://gitorious.org/jpihet/linux (functional-pwrst branch).

>
> regards,
> Rajendra

Thanks and regards,
Jean

>
>>
>> Regards,
>> Nishanth Menon
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
