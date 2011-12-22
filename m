From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: Is Pandaboard cpuhotplug working stably?
Date: Thu, 22 Dec 2011 14:19:23 +0530
Message-ID: <CAMQu2gy8mwJ-aKit0b4d7=4FkxeFakfnL-phy0eMOK81Oe=PCw@mail.gmail.com>
References: <CAGsJ_4ydbMaS0DD6+j1m9tdCTCzw3TGELcY=KotupvvMMK1YOA@mail.gmail.com>
 <20111221094624.GB3354@n2100.arm.linux.org.uk> <CAGsJ_4w0iVXC6qmDzmkuOb=ZN=Q0bF7EAFkxeYR_d7-vo+8bqQ@mail.gmail.com>
 <20111221100706.GC3354@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56138 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751868Ab1LVItr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 03:49:47 -0500
Received: by mail-qy0-f176.google.com with SMTP id c2so5357978qcs.7
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 00:49:46 -0800 (PST)
In-Reply-To: <20111221100706.GC3354@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-omap@vger.kernel.org, yongsheng.liu@csr.com, linaro-dev <linaro-dev@lists.linaro.org>, peiyu.li@csr.com, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, linux-arm-kernel@lists.infradead.org, peterz@infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

+ Peter Z

On Wed, Dec 21, 2011 at 3:37 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Dec 21, 2011 at 05:59:07PM +0800, Barry Song wrote:
>> 2011/12/21 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> > cpu hotplug is basically totally buggered - the preconditions plac=
ed
>> > upon the bringup code path are basically impossible to satisfy in =
any
>> > shape or form at the moment.
>> >
>> > There's the requirement that the secondary CPU is marked online an=
d
>> > active before interrupts are enabled for the thread migration stuf=
f
>> > to behave correctly. =A0However, this is incompatible with smp_cal=
l_function()
>> > which will wait for online CPUs to respond to an IPI - which this =
one
>> > won't because interrupts are disabled.
>> >
>> > I think there was some discussion about how to fix this but I don'=
t
>> > recall the details.
>>
>> thanks, Russell. then could i think this is an ARM-kernel-specific b=
ug
>> which exists on all ARM SMP chips for the moment?
>> and that bug doesn't happen on x86:
>
> I don't think so. =A0There's nothing ARM specific about it.

There are few patches floating around for this issue. I posted one vers=
ion
long back [1] and then there was one more form Thomas G.
The most recent is from one is from Peter Z [2] which is moving the
fix for the cup online race to core code.

Can you try Peter's patch with your test-case ?

Regards,
Santosh

[1] https://lkml.org/lkml/2011/6/20/79
[2] https://lkml.org/lkml/2011/12/15/255
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
