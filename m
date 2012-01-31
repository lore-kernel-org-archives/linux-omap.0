From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by uBoot)?
Date: Tue, 31 Jan 2012 09:53:25 +0000
Message-ID: <CAHkRjk6KQXR1kt8VTPC3GOaHUusKikxXHR=Mge8akaVL2ipvaw@mail.gmail.com>
References: <20120116131329.GA928@n2100.arm.linux.org.uk> <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com> <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com> <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <WC20120120085711.330803@terrafix.co.uk> <20120127173029.GA3281@arm.com>
 <4F277A6E.9070107@ti.com> <CAHkRjk7z2QYbU09BRfAWmChw5xj9taCarWfnttWveyqtadiEOg@mail.gmail.com>
 <CAMQu2gxr5ZkH4AE_7QNptxx7onQMGaj+qhUF+DSw9MnkCqCRog@mail.gmail.com>
 <CAHkRjk7Fh=OUk8K=bJa8xzPqMvT6P6gjT+kqAA0DeVfrF0sUNg@mail.gmail.com> <CAMQu2gwDJ=aezNAUD3YmGHQ6fBxkxgUonYkQYPH8WBeNvZCKMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:54865 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab2AaJxq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 04:53:46 -0500
Received: by qcqw6 with SMTP id w6so202387qcq.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 01:53:45 -0800 (PST)
In-Reply-To: <CAMQu2gwDJ=aezNAUD3YmGHQ6fBxkxgUonYkQYPH8WBeNvZCKMQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Aneesh V <aneesh@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joe Woodward <jw@terrafix.co.uk>

On 31 January 2012 09:05, Shilimkar, Santosh <santosh.shilimkar@ti.com>=
 wrote:
> On Tue, Jan 31, 2012 at 2:24 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
>> On 31 January 2012 07:38, Shilimkar, Santosh <santosh.shilimkar@ti.c=
om> wrote:
>>> On Tue, Jan 31, 2012 at 1:01 PM, Catalin Marinas
>>> <catalin.marinas@arm.com> wrote:
>>>> On 31 January 2012 05:21, Aneesh V <aneesh@ti.com> wrote:
>>>>> On Friday 27 January 2012 11:00 PM, Catalin Marinas wrote:
>>>>>> On Fri, Jan 20, 2012 at 08:57:11AM +0000, Joe Woodward wrote:
>>>>>>>> So I re-iterate that we need to have solution to this problem.
>>>>>>>
>>>>>>> ... I don't want to be a pain, but it seems to me that this dic=
ussion
>>>>>>> didn't reach a full conclussion?
>>>>>>
>>>>>> Probably not, because it depends on many variables. See below my=
 take on
>>>>>> this.
>>>>>>
>>>>>>> I think it was left with the open options being:
>>>>>>> 1) Leave the L2/outer cache enabled in the bootloader (not idea=
l and
>>>>>>> may cause problems with future devices)
>>>>>>
>>>>>> This depends on whether the L2 is inner or outer:
>>>>>>
>>>>>> L2 inner - leave it enabled in the boot loader
>>>>>> L2 outer - leave it disabled in the boot loader
>>>>>>
>>>>>>> 2) Turn the L2/outer cache on for OMAP3 later in the kernel boo=
t when
>>>>>>> the device is known
>>>>>>
>>>>>> Same as above:
>>>>>>
>>>>>> L2 inner - don't do anything, it gets used when SCTLR.M is enabl=
ed
>>>>>> L2 outer - enabled at boot time via the platform code (later, af=
ter MMU
>>>>>> =A0 =A0 =A0 =A0was enabled).
>>>>>
>>>>> What is the reasoning behind this recommendation? Why the distinc=
tion
>>>>> between L2 being inner or outer. I don't see anything to this eff=
ect in
>>>>> the Cortex-A8 TRM? In fact the only recommendation I could find(s=
ection
>>>>> 8.3) is asking to set L2EN to 1 before setting C bit to 1 irrespe=
ctive
>>>>> of inner/outer?
>>>>
>>>> Actually you have a good point. I was thinking about outer caches =
like
>>>> PL310 or L220 that Linux enables later during platform initialisat=
ion.
>>>> They could be left enabled or disabled at boot time but they must =
be
>>>> cleaned/invalidated (you would need to flush after disabling just =
to
>>>> make sure there are no further lines fetched; alternatively, there
>>>> shouldn't be any cacheable mappings).
>>>>
>>>> So I would say in the context of A8, just leave the L2 enabled in =
the
>>>> boot loader. As long as the MMU is disabled, it won't be used. The
>>>> alternative is to enable L2 slightly later in Linux in the platfor=
m
>>>> code to avoid SoC-dependent code in proc-v7.S.
>>>>
>>>> So in summary, either option is possible. You could take the appro=
ach
>>>> of the cache-l2x0.c - check whether it is already enabled and, if =
not,
>>>> issue an SMC from the platform code to enable the L2 cache.
>>>>
>>> if done late in kernel, wouldn't it violate "set L2EN to 1 before
>>> setting C bit to 1"
>>
>> Not if you write the code sequence in such a way that it also switch=
es
>> the C bit to 0 and back to 1. I think Nicolas suggested that the
>> platform code could go through the power management code. But I thin=
k
>> with some carefully coded asm code and cache flushing you could set
>> L2EN without a full MMU reset.
>>
> That would need identity mapping and also correct cache flushing
> as you said above. L2 enabled for A8 is fine but not sure about the
> A15 where L2 is enabled with C bit.

I don't see any problem here - why would you want to treat the L2
separately form the L1 cache? They are both inner caches, just treat
them as such - enabled when the C and M bits are set.

> Then there are some settings for
> ACTLR, L2ACCTRL and L2PFR which needs to be setup before
> MMU is ebabled.

These in general should go in the boot monitor/loader. There isn't
other easy clean solution if we want to keep the kernel booting
generic.

Maybe we could factor out the CPU-specific settings from proc-v*.S
into a separate arch/arm/boot/preload directory. We keep proc-v*.S
entirely generic and the implementation-defined bits setting in the
preload code. You could have an option to link the preload with the
kernel but we could recommend that people run this code from
boot-loader before invoking the kernel. This code would be dependent
on platform and chosen at build-time. But the actual kernel image
would be generic.

> And then the errata's on A9, needing setting up dignostic register,
> changing cache policy etc
> Hopefully we don't get hit by those issues/erratas
> in the window from initial MMU setup to this new sequence code.

We already enable the MMU in the decompressor and it doesn't have any
knowledge of CPU errata. But the preload code could solve this as
well.

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
