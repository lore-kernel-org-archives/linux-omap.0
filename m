From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 3/3] ARM: OMAP3: PM: cpuidle: optimize the clkdm idle
 latency in C1 state
Date: Wed, 20 Jun 2012 13:34:06 +0200
Message-ID: <CAORVsuXdszF5+m24tzQg=OXydsVpqFCHH0TxxKobfSvihpBhtQ@mail.gmail.com>
References: <1338563468-31403-1-git-send-email-j-pihet@ti.com>
	<1338563468-31403-4-git-send-email-j-pihet@ti.com>
	<4FE187A8.8060203@ti.com>
	<CAORVsuWEpsY2MDO=6oLWs=Sdxq+0gk5PHvMvqCwYCjv1+4WDOw@mail.gmail.com>
	<4FE18E02.6020008@ti.com>
	<4FE18F3A.8090103@ti.com>
	<4FE19062.6010502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48412 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab2FTLeH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 07:34:07 -0400
Received: by lbbgm6 with SMTP id gm6so483682lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 20 Jun 2012 04:34:06 -0700 (PDT)
In-Reply-To: <4FE19062.6010502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

Hi Rajendra,

On Wed, Jun 20, 2012 at 10:57 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> Jean,
>
>
> On Wednesday 20 June 2012 02:22 PM, Rajendra Nayak wrote:
>>
>> Hi Jean,
>>
>> On Wednesday 20 June 2012 02:16 PM, Rajendra Nayak wrote:
>>>
>>> On Wednesday 20 June 2012 02:01 PM, Jean Pihet wrote:
>>>>
>>>> Hi Rajendra,
>>>>
>>>> On Wed, Jun 20, 2012 at 10:19 AM, Rajendra Nayak<rnayak@ti.com> wr=
ote:
>>>>>
>>>>> Hi Jean,
>>>>>
>>>>>
>>>>> On Friday 01 June 2012 08:41 PM, Jean Pihet wrote:
>>>>>>
>>>>>>
>>>>>> For a power domain to idle all the clock domains in it must idle=
=2E
>>>>>> This patch implements an optimization of the cpuidle code by
>>>>>> denying and later allowing only the first registered clock domai=
n
>>>>>> of a power domain, and so optimizes the latency of the low power=
 code.
>>>>>
>>>>>
>>>>>
>>>>> How much do we really save doing this? I understand what you are =
doing
>>>>> by looking at the patch but the changelog seems very confusing.
>>>>
>>>> The gain is on the registers accesses and the internal PRCM state
>>>> machine.
>>>> If needed the changelog can be updated.
>>>
>>>
>>> Can you explain a bit more on which register accesses are you talki=
ng
>>> about? and some more on the PRCM state machine.
>>
>>
>> never mind, I looked at the patch again and then the cpuidle code an=
d
>> figured what you are doing. Makes sense to me now :-)
Ok!

>
>
> How do you like this updated changelog, I just added one more line.
>
>
> "
> For a power domain to idle all the clock domains in it must idle.
> Denying just *one* clkdm in a pwrdm from idling should have the
> same effect as denying *all*.
>
> This patch implements an optimization of the cpuidle code by
> denying and later allowing only the first registered clock domain
> of a power domain, and so optimizes the latency of the low power code=
=2E
> "
That looks great!

Kevin,
Can you take this change still in your for_3.6/pm/performance branch?

Thanks & regards,
Jean

>
> regards,
> Rajendra
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
