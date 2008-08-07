From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Thu, 7 Aug 2008 18:07:50 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620361FBB835@dlee02.ent.ti.com>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
	<1218016428.25235.11.camel@pc1117.cambridge.arm.com>
	<13B9B4C6EF24D648824FF11BE89671620361F4E504@dlee02.ent.ti.com>
	<20080807073035.GA10255@flint.arm.linux.org.uk>
	<13B9B4C6EF24D648824FF11BE89671620361FBB4FB@dlee02.ent.ti.com>
	<20080807192531.GF5737@flint.arm.linux.org.uk>
	<13B9B4C6EF24D648824FF11BE89671620361FBB662@dlee02.ent.ti.com>
	<20080807212033.GH5737@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20080807212033.GH5737@flint.arm.linux.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]

<snip> - sorry for cutting of quality text.  If that is bad practice let me know and I'll not do it.

> What you're therefore asking for is a weak memory ordering model which
> doesn't require any effort on the software programmers part - that's
> a CPU architecture thing which you'll need to talk to ARM about.

I don't know that I'm asking.  But yes it would be great to have this all for free.  Winning the lottery would be good also :)

Yes, the architecture is a major part of the coding complexity.

> x86 can do this for the most part because x86's development has been
> such that the hardware has had to work around the software to make
> improvements.  On ARM, normally when there's updates, software has
> to work around the hardware.

Yes, I agree with your statements on x86.

PowerPC has had a weak model for a long time with these kinds of restrictions and it has done ok.  Many things ARM or x86 are doing today have existed in PPC long ago.

A discussion on merits of the weak memory model and peoples observations does seem fair.  Without public discussion and actual work on arm-linux and kernel.org I don't see how anyone would reasonably expect it in the common code.  In the past TI hasn't done so much but the plan is to do more of it going forward.

<snip>

> So, in the case of arch/arm/common/gic.c, we should be reading one of
> the gic control registers after the writes.  In the case of
> arch/arm/mach-omap2/irq.c, reading the INTC_REVISION reg after masking
> should be a sufficient solution.

Yes reading back a register from the same level is a valid method.  It may be sufficient here.

> But, not a barrier.

As I recall the original guidance from ARM (for irq-cntrl sync), was they didn't recommend using a sync instruction at the PIC as that would always block.  They recommended some sync instruction near CPSR changes which touched the irq mask bits.  This way the impact might be not always felt and would be folded in.

The cpu-memory-port is synchronized with the pipeline but not the cpu-peripheral-port (where pic was at and there is a write buffer) so the explicit sync was needed. You could unmask IRQs at the ARM before the PIC operation had completed otherwise.

There are a few sync primitives today barrier might not be the right word for this situation.

Our placement choice was mainly to keep code changes down.  Aggressive placement seemed more in the domain for people who care about tight real time constraints.

> I believe ARMv7 has some restrictions on dual mapping of the same
> space with different types, so don't expect this technique to always
> work.

Sounds familiar but I don't recall it.

As were not planning on using dual maps there isn't much consideration.  In this context it just helps illustrate weak memory behavior at devices.

> > Say TX IRQ happens at UART, I might check status bits through a SO
> mapping,
> > but when it comes time to fill the FIFO I write to the DEVICE mapping.
>
> Why?  Firstly, the read _has_ to complete before the program can
> continue.  (If it hasn't completed, you don't have the data to decide
> what to do next.)  Secondly, any previous device writes will have to
> complete before the read completes.
>
> So what does reading the status bits through a SO mapping gain you?
> The answer is, all other reads and writes previously issued by the
> program completing.  Does that affect the status that the UART is
> giving you?

Sorry, I'm missing something.

I thought the main point was you could load and unload your FIFO faster by taking advantage of bus posting & bursting if the FIFO was mapped as DEVICE when using PIO.

Control register access before you start to deal with the FIFO will always be synchronizing and you want it this way (when mixing reads and writes).

If I write a series of control register commands to device A, then write a go operation to device  B, I would hope all of A's writes had completed before B gets the go.  SO gives you this.  DEVICE may not with out barriers.

Regards,
Richard W.


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
