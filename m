From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH v7 1/4] Documentation: dt: add common bindings for hwspinlock
Date: Fri, 30 Jan 2015 15:29:44 -0800
Message-ID: <CAJAp7Og+-KQd7bygWQjTS72Kye3fkp3s3ry+2bw7Gcv7aPF5AQ@mail.gmail.com>
References: <1421269101-51105-1-git-send-email-s-anna@ti.com>
	<1421269101-51105-2-git-send-email-s-anna@ti.com>
	<20150115135201.GG16217@leverpostej>
	<20150115135556.GH16217@leverpostej>
	<CAL_JsqL2LZAooMk-V8+xeF2g6acZE21M+-OBRw8aEVa-5wVHuQ@mail.gmail.com>
	<CAK=WgbYQ=BbinqJ5fsw2Y+FKdy=nasLsw9mX8pw6S_o3owy9-g@mail.gmail.com>
	<20150116101746.GA21809@leverpostej>
	<CAK=WgbYBqPoUm9byx0du_g5ZmHdYaUVLpSPZYHoCVzNoatNKpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:46690 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760531AbbA3X3q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2015 18:29:46 -0500
Received: by mail-lb0-f176.google.com with SMTP id z12so38717411lbi.7
        for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2015 15:29:44 -0800 (PST)
In-Reply-To: <CAK=WgbYBqPoUm9byx0du_g5ZmHdYaUVLpSPZYHoCVzNoatNKpw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robherring2@gmail.com>, Suman Anna <s-anna@ti.com>, Kumar Gala <galak@codeaurora.org>, Josh Cartwright <joshc@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>

On Fri, Jan 16, 2015 at 4:46 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Mark,
>
> On Fri, Jan 16, 2015 at 12:17 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>> The hwlock is a basic hardware primitive that allow synchronization
>>> between different processors in the system, which may be running Linux
>>> as well as other operating systems, and may have no other means of
>>> communication.
>>>
>>> The hwlock id numbers are predefined, global and static across the
>>> entire system: Linux may boot well after other operating systems are
>>> already running and using these hwlocks to communicate, and therefore,
>>> in order to use these hardware devices, it must not enumerate them
>>> differently than the rest of the system.
>>
>> That's not true.
>>
>> In order to communicate it must agree with the other users as to the
>> meaning of each instance, and the protocol for use. That doesn't
>> necessarily mean that Linux needs to know the numerical ID from a
>> datasheet, and regardless that ID is separate from the logical ID Linux
>> uses internally.
>
> Let me describe hwspinlocks a bit more so we all get to know it better
> and can then agree on a proper solution.
>
> - What makes handling of hwspinlock ID numbers convenient is the fact
> that it's not based on random datasheet numbers. In fact, hwspinlocks
> is just special memory: usually datasheets just define the base
> address and the size of the hwspinlock area. So any numerical ID we
> use to call the locks themselves are already logical and sane, similar
> to the way we handle memory (i.e. if we have 32 locks we'll always use
> 0..31). So hwlocks ids are very much like memory addressing, and not
> irq numbers.
>

But that's exactly how irqs or gpios work as well. If you have 32
gpios in a system they used to be numbered 0-31 and people would
reference them directly by that number. Every one of the systems that
was designed in this way is moving away from it.

> - Sometimes Linux will have to dynamically allocate a hwlock, and send
> the ID of the allocated lock to a remote processor (which may not be
> running Linux).

In a system where you have two hwlock blocks lckA and lckB, each
consisting of 8 locks and you have dspB that can only access lckB;
will you tell the firmware engineers to always subtract 8 from the
numbers you pass them?

Wouldn't it make much more sense to have local indexes here and pass
them e.g lckB:2?

> - Sometimes a remote processor, which may not be running Linux, will
> have to dynamically allocate a hwlock, and send the ID of the
> allocated lock to us (another processor running Linux)
>

I'm sorry but you cannot have a system on both sides that is allowed
to do dynamic allocation from a limited set of resources.

Further more this dynamic allocation leads to interesting race
conditions as what happens if you dynamically allocate a hwlock that
is statically allocated by another part of the system?
The only solution I can think of is to have a static allocation of ids
that the dynamic allocator might use, and then we're just carrying
extra code when the system is already statically configured...

> We cannot tell in advance what kind of IPC is going to be used for
> sending and receiving this hwlock ID. Some are handled by Linux
> (kernel) and some by the user space. So we must be able to expose an
> ID the system will understand as well as receive one.
>

Designing this interface to take into consideration that someone might
send us something completely crazy isn't productive.


The only reason for having num-locks and base-id in device tree is
because of the current Linux implementation. base-id is not a property
of the hardware and num-locks is not needed for anything but book
keeping of base-id's in the hwlock framework.

This is why I preferred Sumans earlier suggestion of having the
binding consist of #hwlock-cells = <X> and the necessary accessor
functions for resolving a hwlock based on a dt reference.

Regards,
Bjorn
