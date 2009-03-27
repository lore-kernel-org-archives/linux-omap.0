From: Russ Dill <russ.dill@gmail.com>
Subject: Re: PM branch rebased to 2.6.29
Date: Fri, 27 Mar 2009 13:50:42 -0700
Message-ID: <f9d2a5e10903271350x2d534c76nc55c492b8acd1d4e@mail.gmail.com>
References: <87bprz9zju.fsf@deeprootsystems.com>
	 <1237914611.23022.124.camel@blackhole>
	 <87zlfaztcd.fsf@deeprootsystems.com>
	 <1237925484.23022.133.camel@blackhole>
	 <49C940CA.9070805@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:29336 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453AbZC0Uun convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Mar 2009 16:50:43 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1441852rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2009 13:50:42 -0700 (PDT)
In-Reply-To: <49C940CA.9070805@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Peter Barada <peterb@logicpd.com>, linux-omap@vger.kernel.org

On Tue, Mar 24, 2009 at 1:21 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Peter Barada wrote:
>>
>> On Tue, 2009-03-24 at 11:08 -0700, Kevin Hilman wrote:
>>>
>>> Peter Barada <peterb@logicpd.com> writes:
>>>
>>>> On Tue, 2009-03-17 at 22:21 -0700, Kevin Hilman wrote:
>>>>>
>>>>> FYI...
>>>>> The PM branch has now been rebased to today's linux-omap HEAD whi=
ch is
>>>>> based on v2.6.29-rc8. =C2=A0The previous PM branch has been renam=
ed to
>>>>> pm-2.6.28. =C2=A0Depending on when you look, Tony's linux-omap tr=
ee may not
>>>>> (yet) have the latest PM branch. =C2=A0If not, you can use my PM =
tree[1]
>>>>> directly. =C2=A0Also, pm-2.6.28 will only be available on my tree=
=2E
>>>>>
>>>>> Tested on OMAP3 Beagle and RX51 and was able to hit RET and OFF i=
n
>>>>> suspend and in PM idle with minimal kernel. =C2=A0No testing yet =
done for
>>>>> CPUidle or DVFS. =C2=A0Please test on your hardware and submit re=
sults to
>>>>> the list. =C2=A0Thanks.
>>>>
>>>> Kevin, =C2=A0did you build/test with
>>>> the /arc/arm/config/omap3_beagle_defconfig, and
>>>> arc/arm/configs/rx51_defconfig or some other config(could you send=
 it to
>>>> me if it isn't in the PM tree)?
>>>
>>> I started with the ones in the tree, but I disable most of the driv=
ers
>>> and turn on some debugging features. =C2=A0Attached is the one I us=
ed for
>>> beagle.
>>> [...]
>>
>> Hmm, I modified your config to add smc911x support so I can have an
>> nfsroot, added selector/code for my board(based on omap3beagle.c) an=
d
>> brought it up on my hardware, but I'm not sure if its working correc=
tly.
>> It does look to pause in the suspend sate, and comes out when I hit =
a
>> key on the console, but the messages don't look quite right as
>> core_pwrdm and per_pwrdm state they didn't go into state 1 (full log
>> attached):
>>
>> omap3530# echo mem > /sys/power/state
>> PM: Syncing filesystems ... done.
>> PM: Preparing system for mem sleep
>> Freezing user space processes ... (elapsed 0.00 seconds) done.
>> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
>> PM: Entering mem sleep
>> Powerdomain (core_pwrdm) didn't enter target state 1
>> Powerdomain (per_pwrdm) didn't enter target state 1
>> Could not enter target state in pm_suspend
>> eth0: smc911x_reset timeout waiting for PM restore
>>
>> eth0: link down
>> PM: Finishing wakeup.
>> Restarting tasks ... done.
>> omap3530# omap3530# eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
>>
>>
>> Is this expected?
>>
>
> Yes, you haven't allowed the UART clocks to go off during idle/suspen=
d and
> there are UARTs in both CORE and PER.
>
> Try this before going into suspend:
>
> =C2=A0echo 1 > /sys/power/clocks_off_while_idle
>
> This will allow UART clocks to be disabled on suspend, and also allow=
 them
> to be disabled after 5 seconds of UART inactivity allowing retention =
in idle
> as well.
>

I'm having the same problem, and setting clocks_off_while_idle doesn't
help. I was initially suspicious that the bits in PM_WKEN1_CORE and
PM_WKEN3_CORE needed to be cleared (for core), but using devmem2 to
clear them didn't help.

=46or the purposes that I'm using my board for, I need to get everythin=
g
into the lowest power consumption possible while sleeping. eg,
everything in off mode but the WKUP domain.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
