From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: RFC, GIC based smp_cross_call cleanup suggestion
Date: Sun, 03 Apr 2011 11:53:07 +0530
Message-ID: <4D98124B.6090005@ti.com>
References: <10921831-0170-4106-bb3a-a52515a32c3e@VA3EHSMHS002.ehs.local>	<BANLkTimY+mRXqT7NwUQ86SxnfKw0HX-pTQ@mail.gmail.com>	<20110402085133.GE8482@n2100.arm.linux.org.uk> <BANLkTim+bco_90iPLrc1ioV4bdSw+LRzQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:48841 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751710Ab1DCGXZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 3 Apr 2011 02:23:25 -0400
Received: by yib12 with SMTP id 12so2799961yib.1
        for <linux-omap@vger.kernel.org>; Sat, 02 Apr 2011 23:23:24 -0700 (PDT)
In-Reply-To: <BANLkTim+bco_90iPLrc1ioV4bdSw+LRzQQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>, tglx@linutronix.de
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Grant Likely <grant.likely@secretlab.ca>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, John Linn <John.Linn@xilinx.com>, linux-arm-kernel@lists.infradead.org, l-o <linux-omap@vger.kernel.org>

+ Thomas G,

On 4/2/2011 2:40 PM, Colin Cross wrote:
> On Sat, Apr 2, 2011 at 1:51 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk>  wrote:
>> On Fri, Apr 01, 2011 at 04:55:02PM -0600, Grant Likely wrote:
>>> On Fri, Apr 1, 2011 at 4:26 PM, John Linn<John.Linn@xilinx.com>  wr=
ote:
>>>> I=92m getting ready to submit a patch to add SMP to Xilinx code. I=
 notice that
>>>> smp_cross_call for all GIC based platforms is duplicated across ea=
ch
>>>> platform in smp.h.
>>>>
>>>>
>>>>
>>>> I thought I=92d try to jump in to help with some cleanup, although=
 I realize
>>>> it=92s minimal, I have to start somewhere.
>>>>
>>>>
>>>>
>>>> What about moving the smp_cross_call for GIC based designs into gi=
c.h?
>>>
>>> Go for it.  It's an obvious cleanup.
>>
>> That assumes that all SMP implementations will always have a GIC.  I=
t
>> looks to me like this is conditional on shmobile, and so I don't thi=
nk
>> its that trivial - maybe Paul or Magnus can first indicate why this =
is.
>
> OMAP4 may also require a custom smp_cross_call implementation if CPU
> idle is going to be supported in SMP - in CPU off idle modes, a GIC
> SGI will not wake the CPU, and a write directly to the CPU's power
> management controller or an external interrupt source would be
> required.

This can be done without making smp_cross_call() platform
specific.
While working on broad-cast notifiers for ARM with Thomas G, this
point was discussed.

Where the TWD can't wakeup its own local CPU from C3 mode, how do we
provide a platform specific method to perform this wakeup ?

Thomas Quoted....
"It would not complicate the OMAP code that much. All it needs is
extending the clock event device callbacks by an broadcast_affinity()
function which would be called from the broadcast code when the
broadcast device is armed. The argument would be a cpumask which would
tell you which core(s) to wake up when the broadcast timer fires next.

So OMAP would fill in that hook and implement the wakeup redirector
setup, which I guess would be a couple of lines."

 From above it's should be trivial once the broad-cast notifiers
are extended to have "broadcast_affinity()" supported

Regards
Santosh



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
