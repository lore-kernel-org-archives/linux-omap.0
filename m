From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled
	by uBoot)?
Date: Tue, 31 Jan 2012 09:56:06 +0000
Message-ID: <20120131095606.GA889@n2100.arm.linux.org.uk>
References: <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com> <20120117133918.GE11475@arm.com> <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com> <WC20120120085711.330803@terrafix.co.uk> <20120127173029.GA3281@arm.com> <4F277A6E.9070107@ti.com> <CAHkRjk7z2QYbU09BRfAWmChw5xj9taCarWfnttWveyqtadiEOg@mail.gmail.com> <CAMQu2gxr5ZkH4AE_7QNptxx7onQMGaj+qhUF+DSw9MnkCqCRog@mail.gmail.com> <CAHkRjk7Fh=OUk8K=bJa8xzPqMvT6P6gjT+kqAA0DeVfrF0sUNg@mail.gmail.com> <CAMQu2gwDJ=aezNAUD3YmGHQ6fBxkxgUonYkQYPH8WBeNvZCKMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52230 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab2AaJ46 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 04:56:58 -0500
Content-Disposition: inline
In-Reply-To: <CAMQu2gwDJ=aezNAUD3YmGHQ6fBxkxgUonYkQYPH8WBeNvZCKMQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Aneesh V <aneesh@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joe Woodward <jw@terrafix.co.uk>

On Tue, Jan 31, 2012 at 02:35:51PM +0530, Shilimkar, Santosh wrote:
> On Tue, Jan 31, 2012 at 2:24 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > Not if you write the code sequence in such a way that it also switches
> > the C bit to 0 and back to 1. I think Nicolas suggested that the
> > platform code could go through the power management code. But I think
> > with some carefully coded asm code and cache flushing you could set
> > L2EN without a full MMU reset.
> 
> That would need identity mapping and also correct cache flushing
> as you said above. L2 enabled for A8 is fine but not sure about the
> A15 where L2 is enabled with C bit. Then there are some settings for
> ACTLR, L2ACCTRL and L2PFR which needs to be setup before
> MMU is ebabled.
> 
> And then the errata's on A9, needing setting up dignostic register,
> changing cache policy etc
> Hopefully we don't get hit by those issues/erratas
> in the window from initial MMU setup to this new sequence code.
> 
> Will this approach be ok for other cases I mentioned ?

Santosh,

It is very clear to me from the discussions, and the discussions I've
had with folk in ARM, that everyone thinks that the idea of putting
a platform specific hook in the early bring up code is insane.

Everyone seems to think that the place it is to be solved is either
in the boot loader or with a wrapper around the kernel.

One of my points that I brought up against it was the limited environment,
and the lack of stack at that point.  Let's look at what you're
proposing to do (thanks for the patch):

Your secure hook:
	stmia   r12, {r1-r11, r13-r14}

The stack you're writing to:

        .align  2
__v7_setup_stack:
        .space  4 * 11                          @ 11 registers

And it's layout in the kernel image:

c02ee75c <__v7_setup_stack>:
        ...
c02ee788:       00000c08        .word   0x00000c08
c02ee78c:       00000c09        .word   0x00000c09
c02ee790:       ff0a81a8        .word   0xff0a81a8
c02ee794:       40e040e0        .word   0x40e040e0

c02ee798 <gic_secondary_init>:
c02ee798:       e1a0c00d        mov     ip, sp
...

You're lucky that what you're _only_ overwriting is the two Cortex ID
values which have already been used, and not the following words, which
are the control register masks and the GIC initialization function.

Thank you for proving my point about why platform code can't be allowed
to get its grubby hands that early in the kernel boot - you are making
it more fragile by doing this stuff, because you haven't taken the time
to properly analyse the code before you've modified it.  As such, you
will see more silent boot failures.

So, as many people have said, we're not going to go down the route of
allowing platforms to hook into this code.  There's plenty of other
solutions to this problem in different parts of the system that would
be more than adequate, and would benefit everyone not just the kernel.

You're making bones about whether there's a window if you do it later
in the kernel.  You already have a window of opportunity for things to
have gone wrong and that's the zImage decompressor, which runs with
caches on.  So if you've managed to get to your existing code in the
v7 setup function, then you've already proven that it's fine.

Your continued resistance to every alternative suggestion but your
(broken) hook is getting extremely frustrating.  Please try some of
these other approaches which are being proposed.  Thanks.
