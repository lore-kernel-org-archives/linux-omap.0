From: Colin Cross <ccross@google.com>
Subject: Re: RFC, GIC based smp_cross_call cleanup suggestion
Date: Sat, 2 Apr 2011 23:36:41 -0700
Message-ID: <BANLkTinZyiW74enShWguTy_2pBZ9xbsGDA@mail.gmail.com>
References: <10921831-0170-4106-bb3a-a52515a32c3e@VA3EHSMHS002.ehs.local>
	<BANLkTimY+mRXqT7NwUQ86SxnfKw0HX-pTQ@mail.gmail.com>
	<20110402085133.GE8482@n2100.arm.linux.org.uk>
	<BANLkTim+bco_90iPLrc1ioV4bdSw+LRzQQ@mail.gmail.com>
	<4D98124B.6090005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:1485 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab1DCGgo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 3 Apr 2011 02:36:44 -0400
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com [172.24.198.101])
	by smtp-out.google.com with ESMTP id p336ahW4014503
	for <linux-omap@vger.kernel.org>; Sat, 2 Apr 2011 23:36:43 -0700
Received: from vxi40 (vxi40.prod.google.com [10.241.35.40])
	by wpaz37.hot.corp.google.com with ESMTP id p336agb7004073
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Sat, 2 Apr 2011 23:36:42 -0700
Received: by vxi40 with SMTP id 40so4759872vxi.24
        for <linux-omap@vger.kernel.org>; Sat, 02 Apr 2011 23:36:42 -0700 (PDT)
In-Reply-To: <4D98124B.6090005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tglx@linutronix.de, Russell King - ARM Linux <linux@arm.linux.org.uk>, Grant Likely <grant.likely@secretlab.ca>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, John Linn <John.Linn@xilinx.com>, linux-arm-kernel@lists.infradead.org, l-o <linux-omap@vger.kernel.org>

On Sat, Apr 2, 2011 at 11:23 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> + Thomas G,
>
> On 4/2/2011 2:40 PM, Colin Cross wrote:
>>
>> On Sat, Apr 2, 2011 at 1:51 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> =A0wrote:
>>>
>>> On Fri, Apr 01, 2011 at 04:55:02PM -0600, Grant Likely wrote:
>>>>
>>>> On Fri, Apr 1, 2011 at 4:26 PM, John Linn<John.Linn@xilinx.com> =A0=
wrote:
>>>>>
>>>>> I=92m getting ready to submit a patch to add SMP to Xilinx code. =
I notice
>>>>> that
>>>>> smp_cross_call for all GIC based platforms is duplicated across e=
ach
>>>>> platform in smp.h.
>>>>>
>>>>>
>>>>>
>>>>> I thought I=92d try to jump in to help with some cleanup, althoug=
h I
>>>>> realize
>>>>> it=92s minimal, I have to start somewhere.
>>>>>
>>>>>
>>>>>
>>>>> What about moving the smp_cross_call for GIC based designs into g=
ic.h?
>>>>
>>>> Go for it. =A0It's an obvious cleanup.
>>>
>>> That assumes that all SMP implementations will always have a GIC. =A0=
It
>>> looks to me like this is conditional on shmobile, and so I don't th=
ink
>>> its that trivial - maybe Paul or Magnus can first indicate why this=
 is.
>>
>> OMAP4 may also require a custom smp_cross_call implementation if CPU
>> idle is going to be supported in SMP - in CPU off idle modes, a GIC
>> SGI will not wake the CPU, and a write directly to the CPU's power
>> management controller or an external interrupt source would be
>> required.
>
> This can be done without making smp_cross_call() platform
> specific.
> While working on broad-cast notifiers for ARM with Thomas G, this
> point was discussed.
>
> Where the TWD can't wakeup its own local CPU from C3 mode, how do we
> provide a platform specific method to perform this wakeup ?
>
> Thomas Quoted....
> "It would not complicate the OMAP code that much. All it needs is
> extending the clock event device callbacks by an broadcast_affinity()
> function which would be called from the broadcast code when the
> broadcast device is armed. The argument would be a cpumask which woul=
d
> tell you which core(s) to wake up when the broadcast timer fires next=
=2E
>
> So OMAP would fill in that hook and implement the wakeup redirector
> setup, which I guess would be a couple of lines."
>
> From above it's should be trivial once the broad-cast notifiers
> are extended to have "broadcast_affinity()" supported

That fixes the localtimer, but not calls to generic_exec_single, which
also calls smp_cross_call.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
