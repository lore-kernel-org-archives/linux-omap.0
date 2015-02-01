From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH v7 1/4] Documentation: dt: add common bindings for hwspinlock
Date: Sun, 1 Feb 2015 09:55:02 -0800
Message-ID: <CAJAp7OjVULNRd113TtOEwaa6QO-XCDa0oxBm2H5NPvp_kLTSpA@mail.gmail.com>
References: <1421269101-51105-1-git-send-email-s-anna@ti.com>
	<1421269101-51105-2-git-send-email-s-anna@ti.com>
	<20150115135201.GG16217@leverpostej>
	<20150115135556.GH16217@leverpostej>
	<CAL_JsqL2LZAooMk-V8+xeF2g6acZE21M+-OBRw8aEVa-5wVHuQ@mail.gmail.com>
	<CAK=WgbYQ=BbinqJ5fsw2Y+FKdy=nasLsw9mX8pw6S_o3owy9-g@mail.gmail.com>
	<20150116101746.GA21809@leverpostej>
	<CAK=WgbYBqPoUm9byx0du_g5ZmHdYaUVLpSPZYHoCVzNoatNKpw@mail.gmail.com>
	<CAJAp7Og+-KQd7bygWQjTS72Kye3fkp3s3ry+2bw7Gcv7aPF5AQ@mail.gmail.com>
	<CAK=WgbZ2986xxuAFvMSoyQLaPAxdUpZ8e5g-mSjyETfvd4KKHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:39752 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424AbbBARzF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Feb 2015 12:55:05 -0500
Received: by mail-la0-f51.google.com with SMTP id ge10so34577291lab.10
        for <linux-omap@vger.kernel.org>; Sun, 01 Feb 2015 09:55:03 -0800 (PST)
In-Reply-To: <CAK=WgbZ2986xxuAFvMSoyQLaPAxdUpZ8e5g-mSjyETfvd4KKHw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robherring2@gmail.com>, Suman Anna <s-anna@ti.com>, Kumar Gala <galak@codeaurora.org>, Josh Cartwright <joshc@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>

On Fri, Jan 30, 2015 at 9:41 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Sat, Jan 31, 2015 at 1:29 AM, Bjorn Andersson <bjorn@kryo.se> wrote:
>> In a system where you have two hwlock blocks lckA and lckB, each
>> consisting of 8 locks and you have dspB that can only access lckB
>
> This is a good example - thanks. To be able to cope with such cases we
> will have to pass a hwlock block reference and its relative lock id.
>

Correct, so the #hwlock-cells and hwlock part from the proposal are
the important one. Having an optional hwlock-names will make things
easier to read as well, but is not necessary.

> The DT binding should definitely be prepared for such cases (just kill
> the base-id field?), but let's see what it means about the Linux
> implementation.
>

>From the dt binding PoV, we should be able to skip num-locks as well.
It seems most hwlock blocks have a fixed amount of locks provided and
the drivers are reporting this to the core when registering.

So I think we can reduce the binding to:

Providers:
#hwlock-cells

Consumers:
hwlocks
hwlock-names

For the hardware where number of locks is actually variable (e.g.
different variants of same block) there can be driver specific entries
for this.

> Since the existence of several hwblocks is still fictional (Bjorn,
> please confirm too?), we may prefer to introduce changes to support it
> only when it shows up; it all depends on the amount of changes needed.
> Suman, care to take a look please?
>

I haven't seen any such systems yet.

We could introduce the logic found in other subsystems of allowing -1
as base_id and having the core find a available range. This will work
for all cases where the global ids doesn't have to be static; either
due to the fact that we use block:local-id or that the indices are
hard coded. (Referencing locks via dt is equivalent of the
block:local-id case)

>>> - Sometimes a remote processor, which may not be running Linux, will
>>> have to dynamically allocate a hwlock, and send the ID of the
>>> allocated lock to us (another processor running Linux)
>>>
>> I'm sorry but you cannot have a system on both sides that is allowed
>> to do dynamic allocation from a limited set of resources.
>
> Of course not. On such systems, Linux is not the one responsible for
> allocating the hwlocks, at least not during part of the time or from
> part of the hwlocks. There were a few different use cases, with
> different semantics, that required communicating to Linux an hwlock
> id, but since none of them have reached mainline, we should only
> remember they may show up one day, but not put too much effort to
> support them right now.
>

That makes more sense, although I still believe that you end up with a
system wide setup where locks are statically allocated in some
document beforehand. Either that or you will have to feed that other
system with the list of constraints.

Non the less, that's "unrelated".

If we get an incoming message saying lckX:Y (or the global lckZ), we
probably wouldn't define that in DT. We would need a way to resolve
the hwlock-block "lckX" so we can request lock Y from that block. We
would basically build the DT reference on the fly.

I think this is a future problem to be solved and more importantly I
don't think it's limited to hwlocks. If a system architect designs a
system where a remote entity will do allocation of resources for us,
they will most likely do so not only for hwlocks but also for gpios,
irqs and other resources that we today reference with arguments in DT.
Hopefully that will not happen anytime soon, so let's just ignore that
problem for now and go for a simple binding that will cover todays use
cases (with some thought into multi-block support).

Regards,
Bjorn
