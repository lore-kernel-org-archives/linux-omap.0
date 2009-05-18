From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/11] OMAP2/3: PM: push core PM code from linux-omap
Date: Mon, 18 May 2009 19:30:01 +0100
Message-ID: <20090518183001.GK7042@n2100.arm.linux.org.uk>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-2-git-send-email-khilman@deeprootsystems.com> <20090518133241.GH3067@n2100.arm.linux.org.uk> <878wku8hkb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33504 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbZERSaQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 14:30:16 -0400
Content-Disposition: inline
In-Reply-To: <878wku8hkb.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Jouni Hogander <jouni.hogander@nokia.com>, Paul Walmsley <paul@pwsan.com>

On Mon, May 18, 2009 at 10:08:36AM -0700, Kevin Hilman wrote:
> [ adding Richard W. to To: since he can probably shed some light here ]
> 
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Fri, May 15, 2009 at 11:40:41AM -0700, Kevin Hilman wrote:
> >> This patch is to sync the core linux-omap PM code with mainline.  This
> >> code has evolved and been used for a while the linux-omap tree, but
> >> the attempt here is to finally get this into mainline.
> 
> [...]
> 
> Upon a quick glance, using cpu_init() would not cover all the things
> that this code does.  cpu_init() only handles the init of sp for the
> various modes, where this code saves/resores all the banked registers:
> sp, lr and spsr as well as r8-r12 of FIQ mode.

It doesn't touch sp, lr and spsr for the other modes because there's
no requirement to do so.  Think about it for a moment.

Is there any point to saving LR and SPSR for the abort, FIQ and IRQ
modes?  No - LR and SPSR are overwritten by the hardware immediately
upon entry to the relevent mode via an exception.

What about SP?  We use SP in the vector entry code, and we need to
ensure that this is re-initialized.  We never change their value, so
we know that these are constant, and therefore if we initialize them
once we can repeat the same initialization to restore their values
when those values are lost.  This is precisely what cpu_init() does.

As for FIQ r8-r12, yes this is missing, and it's something that needs
to be handled by _every_ platform which puts the CPU into low power
state, be that PXA, S3C2410, and so forth.  We have code to allow the
FIQ vector to be managed, and as yet those architectures which do
support sleep modes don't use FIQ mode, hence why there's nothing for
it yet.  Feel free to add the necessary suspend/resume code to (eg)
arch/arm/kernel/fiq.c to fill this hole though.

Lastly is system mode.  The kernel doesn't use system mode, and this
mode doesn't exist in all CPUs (its marked as unpredictable on many
older CPUs.)  We need a _generic_ extension to support that mode _if_
it is used.  Presently it is not used, and so we simply don't bother
saving those registers.

> The question in my mind however is whether the lr and spsr need to be
> saved/restored?  Do we really need to preserve the context of these
> handlers across idle?

Idle is called essentially in process context, with the exception that
it's SVC mode rather than user mode.  That means no exception handlers
will be running.

So I think you'll find cpu_init() does everything you require.
