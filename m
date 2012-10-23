From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] genirq: provide means to retrigger parent
Date: Wed, 24 Oct 2012 00:36:47 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210240033310.2756@ionos>
References: <1350425269-11489-1-git-send-email-khilman@deeprootsystems.com> <20121016221502.GY28061@n2100.arm.linux.org.uk> <871ugo7rqv.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871ugo7rqv.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 23 Oct 2012, Kevin Hilman wrote:

> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Tue, Oct 16, 2012 at 03:07:49PM -0700, Kevin Hilman wrote:
> >> From: Thomas Gleixner <tglx@linutronix.de>
> >> 
> >> Attempts to retrigger nested threaded IRQs currently fail because they
> >> have no primary handler.  In order to support retrigger of nested
> >> IRQs, the parent IRQ needs to be retriggered.
> >> 
> >> To fix, when an IRQ needs to be resent, if the interrupt has a parent
> >> IRQ and runs in the context of the parent IRQ, then resend the parent.
> >> 
> >> Also, handle_nested_irq() needs to clear the replay flag like the
> >> other handlers, otherwise check_irq_resend() will set it and it will
> >> never be cleared.  Without clearing, it results in the first resend
> >> working fine, but check_irq_resend() returning early on subsequent
> >> resends because the replay flag is still set.
> >> 
> >> Problem discovered on ARM/OMAP platforms where a nested IRQ that's
> >> also a wakeup IRQ happens late in suspend and needed to be retriggered
> >> during the resume process.
> >> 
> >> Reported-by: Kevin Hilman <khilman@ti.com>
> >> Tested-by: Kevin Hilman <khilman@ti.com>
> >> [khilman@ti.com: changelog edits, clear IRQS_REPLAY in handle_nested_irq()]
> >> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >
> > Umm, we also have the converse situation.  We have platforms where the
> > resend has to be done from the child IRQ, and the parent must not be
> > touched.  I hope that doesn't break those.
> 
> I'm assuming the child IRQs you're concerned with are not threaded,
> right?  This patch only addresses nested, threaded IRQs, and these don't
> have a primary handler to run at all, so cannot do any triggering.

And it involves that you activly set the parent irq via the new
interface: irq_set_parent()

You don't have that yet or you don't use that in your future changes,
then you're good. :)

Thanks,

	tglx
