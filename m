From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by uBoot)?
Date: Tue, 31 Jan 2012 16:21:01 +0530
Message-ID: <CAMQu2gwG_JwPMzV0v2hedvDz=HHq0SNbbH+Zapyd8fJt47kjGQ@mail.gmail.com>
References: <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com> <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <WC20120120085711.330803@terrafix.co.uk> <20120127173029.GA3281@arm.com>
 <4F277A6E.9070107@ti.com> <CAHkRjk7z2QYbU09BRfAWmChw5xj9taCarWfnttWveyqtadiEOg@mail.gmail.com>
 <CAMQu2gxr5ZkH4AE_7QNptxx7onQMGaj+qhUF+DSw9MnkCqCRog@mail.gmail.com>
 <CAHkRjk7Fh=OUk8K=bJa8xzPqMvT6P6gjT+kqAA0DeVfrF0sUNg@mail.gmail.com>
 <CAMQu2gwDJ=aezNAUD3YmGHQ6fBxkxgUonYkQYPH8WBeNvZCKMQ@mail.gmail.com> <20120131095606.GA889@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:53468 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752419Ab2AaKvW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 05:51:22 -0500
Received: by mail-qy0-f175.google.com with SMTP id o7so227440qcs.20
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 02:51:21 -0800 (PST)
In-Reply-To: <20120131095606.GA889@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Aneesh V <aneesh@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joe Woodward <jw@terrafix.co.uk>

On Tue, Jan 31, 2012 at 3:26 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 31, 2012 at 02:35:51PM +0530, Shilimkar, Santosh wrote:
>> On Tue, Jan 31, 2012 at 2:24 PM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>> > Not if you write the code sequence in such a way that it also swit=
ches
>> > the C bit to 0 and back to 1. I think Nicolas suggested that the
>> > platform code could go through the power management code. But I th=
ink
>> > with some carefully coded asm code and cache flushing you could se=
t
>> > L2EN without a full MMU reset.
>>
>> That would need identity mapping and also correct cache flushing
>> as you said above. L2 enabled for A8 is fine but not sure about the
>> A15 where L2 is enabled with C bit. Then there are some settings for
>> ACTLR, L2ACCTRL and L2PFR which needs to be setup before
>> MMU is ebabled.
>>
>> And then the errata's on A9, needing setting up dignostic register,
>> changing cache policy etc
>> Hopefully we don't get hit by those issues/erratas
>> in the window from initial MMU setup to this new sequence code.
>>
>> Will this approach be ok for other cases I mentioned ?
>
> Santosh,
>
> It is very clear to me from the discussions, and the discussions I've
> had with folk in ARM, that everyone thinks that the idea of putting
> a platform specific hook in the early bring up code is insane.
>
> Everyone seems to think that the place it is to be solved is either
> in the boot loader or with a wrapper around the kernel.
>
> One of my points that I brought up against it was the limited environ=
ment,
> and the lack of stack at that point. =A0Let's look at what you're
> proposing to do (thanks for the patch):
>
> Your secure hook:
> =A0 =A0 =A0 =A0stmia =A0 r12, {r1-r11, r13-r14}
>
> The stack you're writing to:
>
> =A0 =A0 =A0 =A0.align =A02
> __v7_setup_stack:
> =A0 =A0 =A0 =A0.space =A04 * 11 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0@ 11 registers
>
> And it's layout in the kernel image:
>
> c02ee75c <__v7_setup_stack>:
> =A0 =A0 =A0 =A0...
> c02ee788: =A0 =A0 =A0 00000c08 =A0 =A0 =A0 =A0.word =A0 0x00000c08
> c02ee78c: =A0 =A0 =A0 00000c09 =A0 =A0 =A0 =A0.word =A0 0x00000c09
> c02ee790: =A0 =A0 =A0 ff0a81a8 =A0 =A0 =A0 =A0.word =A0 0xff0a81a8
> c02ee794: =A0 =A0 =A0 40e040e0 =A0 =A0 =A0 =A0.word =A0 0x40e040e0
>
> c02ee798 <gic_secondary_init>:
> c02ee798: =A0 =A0 =A0 e1a0c00d =A0 =A0 =A0 =A0mov =A0 =A0 ip, sp
> ...
>
> You're lucky that what you're _only_ overwriting is the two Cortex ID
> values which have already been used, and not the following words, whi=
ch
> are the control register masks and the GIC initialization function.
>
> Thank you for proving my point about why platform code can't be allow=
ed
> to get its grubby hands that early in the kernel boot - you are makin=
g
> it more fragile by doing this stuff, because you haven't taken the ti=
me
> to properly analyse the code before you've modified it. =A0As such, y=
ou
> will see more silent boot failures.
>
> So, as many people have said, we're not going to go down the route of
> allowing platforms to hook into this code. =A0There's plenty of other
> solutions to this problem in different parts of the system that would
> be more than adequate, and would benefit everyone not just the kernel=
=2E
>
Sure. The marco has missed those details. Thanks for the
useful information. At least I can fix the stack size for internal
use.

> You're making bones about whether there's a window if you do it later
> in the kernel. =A0You already have a window of opportunity for things=
 to
> have gone wrong and that's the zImage decompressor, which runs with
> caches on. =A0So if you've managed to get to your existing code in th=
e
> v7 setup function, then you've already proven that it's fine.
>
I see your point.

> Your continued resistance to every alternative suggestion but your
> (broken) hook is getting extremely frustrating. =A0Please try some of
> these other approaches which are being proposed. =A0Thanks.

I was just trying to get more information about the alternatives and
trying to bring out possible issues. I know for sure that boot-loader i=
s
not an option since we have had many instances where it has not worked.

I also understand that patching early common code is going to be tricky
and of-course against the single zImage.

So the option mentioned by Nicolas and Catalin about 1:1 mapping
and configuring the registers in platform specific code was looking
a way forward. So was asking more questions about whether this can
work in all cases. Specifically for A15. As per Catalin's email, it is
best to handle those cases before MMU is enabled with
boot-monitor or pre-load code.

I am not against trying option. Just trying to understand what is the
best option we have.

Regards
santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
