From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 07/13] OMAP PM: early init of the pwrdms states
Date: Thu, 11 Aug 2011 17:12:39 +0200
Message-ID: <CAORVsuU-YqpPH_XY0rKjJkFuNZLF0VByFA8mCKeDPgLtMM_RJA@mail.gmail.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
	<1311841821-10252-8-git-send-email-j-pihet@ti.com>
	<20110729080820.GB26959@google.com>
	<CAORVsuUovg7px5SGC+mt7CoDcXZ8r2d09obkXqSp=g44U1G9EQ@mail.gmail.com>
	<CAORVsuVHAvQRxPz8cCfQ0L1jN1nT5aNDVZ7fpuajAUosyvumeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:32865 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab1HKPMl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Aug 2011 11:12:41 -0400
Received: by qwk3 with SMTP id 3so1108840qwk.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Aug 2011 08:12:40 -0700 (PDT)
In-Reply-To: <CAORVsuVHAvQRxPz8cCfQ0L1jN1nT5aNDVZ7fpuajAUosyvumeA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>, rnayak@ti.com

Todd,

On Tue, Aug 2, 2011 at 10:57 AM, Jean Pihet <jean.pihet@newoldbits.com>=
 wrote:
> Todd,
>
> On Fri, Jul 29, 2011 at 10:50 AM, Jean Pihet <jean.pihet@newoldbits.c=
om> wrote:
>> On Fri, Jul 29, 2011 at 10:08 AM, Todd Poynor <toddpoynor@google.com=
> wrote:
>>> On Thu, Jul 28, 2011 at 10:30:14AM +0200, jean.pihet@newoldbits.com=
 wrote:
> ...
>
>>>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-oma=
p2/powerdomain.c
>>>> index 9af0847..63c3e7a 100644
>>>> --- a/arch/arm/mach-omap2/powerdomain.c
>>>> +++ b/arch/arm/mach-omap2/powerdomain.c
>>>> @@ -108,6 +108,9 @@ static int _pwrdm_register(struct powerdomain =
*pwrdm)
>>>> =A0 =A0 =A0 pwrdm->state =3D pwrdm_read_pwrst(pwrdm);
>>>> =A0 =A0 =A0 pwrdm->state_counter[pwrdm->state] =3D 1;
>>>>
>>>> + =A0 =A0 /* Early init of the next power state */
>>>> + =A0 =A0 pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_RET);
>>>> +
>>>
>>> Wanted to check that it's OK to initialize the next state of a powe=
r
>>> domain to RETENTION early in the boot sequence. =A0I believe patche=
s
>>> have been previously discussed that set the state to ON to ensure t=
he
>>> domain doesn't go to a lower state, and possibly lose context, befo=
re
>>> the PM subsystem is setup to handle it? =A0Not sure, thought maybe =
worth
>>> a doublecheck.
>> Indeed I need to check the behavior for OMAP3 & 4 which seem to
>> initialize the pwrdm states differently.
>> BTW the patch that inits all pwrdms to ON is not yet in l-o master
>> that is why I (lazily) submitted this one for now.
>
> Ok I will update the patch to make it compliant with [1]. v4 will
> include this change.
>
> Thanks,
> Jean
>
> [1] http://marc.info/?l=3Dlinux-arm-kernel&m=3D131052762623823&w=3D2

After more thinking I now realize there is a problem with the PM early
init, PM late init and the constraints framework which all setup the
power domains next states in a non-coherent way.
Definitely this needs to be revisited. More to come on this!

There is a comment about that in [00/15] of the v4 patch set.

Regards,
Jean

>
>>
>>>
>>>
>>> Todd
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
