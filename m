From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: Is Pandaboard cpuhotplug working stably?
Date: Thu, 22 Dec 2011 15:57:48 +0530
Message-ID: <CAMQu2gzXbjiTDbS5bs3sKLu63C9es4hr8VHQ575sLO8QV2F3rg@mail.gmail.com>
References: <CAGsJ_4ydbMaS0DD6+j1m9tdCTCzw3TGELcY=KotupvvMMK1YOA@mail.gmail.com>
 <20111221094624.GB3354@n2100.arm.linux.org.uk> <CAGsJ_4w0iVXC6qmDzmkuOb=ZN=Q0bF7EAFkxeYR_d7-vo+8bqQ@mail.gmail.com>
 <20111221100706.GC3354@n2100.arm.linux.org.uk> <CAMQu2gy8mwJ-aKit0b4d7=4FkxeFakfnL-phy0eMOK81Oe=PCw@mail.gmail.com>
 <20111222102454.GD3354@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:58978 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752416Ab1LVK2K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 05:28:10 -0500
Received: by qadb15 with SMTP id b15so6349429qad.5
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 02:28:09 -0800 (PST)
In-Reply-To: <20111222102454.GD3354@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Barry Song <21cnbao@gmail.com>, linux-omap@vger.kernel.org, yongsheng.liu@csr.com, linaro-dev <linaro-dev@lists.linaro.org>, peiyu.li@csr.com, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, linux-arm-kernel@lists.infradead.org, peterz@infradead.org

On Thu, Dec 22, 2011 at 3:54 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 22, 2011 at 02:19:23PM +0530, Shilimkar, Santosh wrote:
>> + Peter Z
>>
>> On Wed, Dec 21, 2011 at 3:37 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Wed, Dec 21, 2011 at 05:59:07PM +0800, Barry Song wrote:
>> >> 2011/12/21 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> >> > cpu hotplug is basically totally buggered - the preconditions p=
laced
>> >> > upon the bringup code path are basically impossible to satisfy =
in any
>> >> > shape or form at the moment.
>> >> >
>> >> > There's the requirement that the secondary CPU is marked online=
 and
>> >> > active before interrupts are enabled for the thread migration s=
tuff
>> >> > to behave correctly. =A0However, this is incompatible with smp_=
call_function()
>> >> > which will wait for online CPUs to respond to an IPI - which th=
is one
>> >> > won't because interrupts are disabled.
>> >> >
>> >> > I think there was some discussion about how to fix this but I d=
on't
>> >> > recall the details.
>> >>
>> >> thanks, Russell. then could i think this is an ARM-kernel-specifi=
c bug
>> >> which exists on all ARM SMP chips for the moment?
>> >> and that bug doesn't happen on x86:
>> >
>> > I don't think so. =A0There's nothing ARM specific about it.
>>
>> There are few patches floating around for this issue. I posted one v=
ersion
>> long back [1] and then there was one more form Thomas G.
>> The most recent is from one is from Peter Z [2] which is moving the
>> fix for the cup online race to core code.
>>
>> Can you try Peter's patch with your test-case ?
>>
>> Regards,
>> Santosh
>>
>> [1] https://lkml.org/lkml/2011/6/20/79
>> [2] https://lkml.org/lkml/2011/12/15/255
>
> [1] is already fixed - and is not the latest "problem" with this code=
=2E
> Fixing the problem in [1] actually itself created the latest problem
> with smp_call_function() which wasn't there before this change. =A0Pa=
tch
> [2] refers to this problem and proposes a fix for it.

Thanks Russell for information. Looks like I missed in between thread.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
