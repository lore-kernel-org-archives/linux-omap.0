From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf not capturing stack traces
Date: Mon, 26 Jan 2015 11:37:59 -0300
Message-ID: <20150126143759.GB5906@kernel.org>
References: <20150123195128.GE26557@saruman.tx.rr.com>
 <20150123205959.GD3073@kernel.org>
 <20150123223745.GJ26557@saruman.tx.rr.com>
 <20150124151204.GF3073@kernel.org>
 <20150124222342.GA26941@saruman.tx.rr.com>
 <20150125155651.GB11502@n2100.arm.linux.org.uk>
 <20150126102711.GC15598@arm.com>
 <20150126135123.GC11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150126135123.GC11502@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>, Felipe Balbi <balbi@ti.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Em Mon, Jan 26, 2015 at 01:51:23PM +0000, Russell King - ARM Linux escreveu:
> On Mon, Jan 26, 2015 at 10:27:11AM +0000, Will Deacon wrote:
> > On Sun, Jan 25, 2015 at 03:56:52PM +0000, Russell King - ARM Linux wrote:
> > > On Sat, Jan 24, 2015 at 04:23:42PM -0600, Felipe Balbi wrote:
> > > > yeah, I'll try a few older kernels, also see if I can reproduce on other
> > > > boards.

> > > Perf works for me with CONFIG_FRAME_POINTER=y, but that's only for kernel
> > > space, and for userspace where the programs have been built for ARM mode
> > > with frame pointers.

> > > The kernel may work without CONFIG_FRAME_POINTER set, but I've never
> > > tested that, and I'd suggest that (given my experience looking at oops
> > > dumps) it's not all that reliable.

> > > Lastly, userspace without frame pointers is pretty much hopeless.

> > FWIW, perf can now use libunwind for unwinding the userspace side of
> > things, so it's not quite as bad as it used to be. For the kernel side,
> > if the unwinder isn't working properly it would be nice to know *why*,
> > but I agree that it tends to be far flakier than the frame-pointer method.

> I don't see how userspace could be unwound without capturing the entire
> userspace stack on every perf event - and that could be a considerable
> size.  We have no way to know within the kernel which words on the

That is what you can do using 'perf record --call-graph dwarf':

    -g               enables call-graph recording
        --call-graph <mode[,dump_size]>
                     setup and enables call-graph (stack chain/backtrace)
                     recording: fp dwarf

That will use:

        PERF_SAMPLE_REGS_USER                   = 1U << 12,
        PERF_SAMPLE_STACK_USER                  = 1U << 13,

struct perf_event_attr {
<SNIP>
        /*
         * Defines set of user regs to dump on samples.
         * See asm/perf_regs.h for details.
         */
        __u64   sample_regs_user;

        /*
         * Defines size of the user stack to dump on samples.
         */
        __u32   sample_stack_user;
<SNIP>
}

> userspace stack are part of the callchain and which aren't - the only
> way we'd know is by loading the userspace's unwind tables, having the
> kernel parsing them and generate a list of functions.

Or deferring it to userspace to do that later.

- Arnaldo
