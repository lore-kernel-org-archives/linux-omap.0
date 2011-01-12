From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/0] RFC: ARM: Thumb-2: Symbol manipulation macros for
	function body copying
Date: Wed, 12 Jan 2011 16:11:51 +0000
Message-ID: <20110112161151.GB18833@n2100.arm.linux.org.uk>
References: <1294790551-17069-1-git-send-email-dave.martin@linaro.org> <20110112093209.GA18833@n2100.arm.linux.org.uk> <AANLkTimB1dcK=F1bFh6bUtBPY0gk+Y+Y0SQqrSRW0YFa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37860 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212Ab1ALQME (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jan 2011 11:12:04 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimB1dcK=F1bFh6bUtBPY0gk+Y+Y0SQqrSRW0YFa@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Wed, Jan 12, 2011 at 10:00:25AM -0600, Dave Martin wrote:
> omap provides some infrastructure for both allocating SRAM space and
> doing the copy, using omap_sram_push() and friends.  So I wasn't sure
> what the correct level of abstraction was for the new helpers.
> Certainly, providing a sort of "function memcpy" macro like your
> copy_fn_to_sram makes sense.

It'd just be a matter of splitting the copying out of omap_sram_push().

> I think this should still be safe from a type system perspective:
> providing the "blind" type casts using asm() appear somewhere in
> the execution flow C shouldn't make silly assumptions even if Linux
> ends up enabling multifile optimisation sometime in the future.

Yes.  The only thing that is missing from my version is the
flush_icache_range() which should also be there.

> > Used by:
> > extern void my_func(int foo);
> > extern int my_func_size;
> 
> Potentially, we could define, an extra assembler macro to complement
> ENDPROC() which records the size of a function automatically.  What do
> you think?

That would pad the code out with a fair number of additional integers.
That's probably not a good idea.

> The model used in the omap code is to copy some functions into SRAM
> ahead of time and stash the pointers away to be called later: for that
> model, it's not so useful to have something like call_my_func
> directly.  Also, I wasn't sure whether conflating other functionality
> such as cache flushing into the new macros would be a good idea -- is
> might be cleaner and more maintainable, but might result in less
> efficient usage.  Any thoughts?

My example was only that - an example.  You can also use it in the
way you describe too:

	to = omap_sram_push(size);
	_omap_sram_reprogram_clock = copy_fn_to_sram(to,
					omap1_sram_reprogram_clock, size);

and it'll also ensure type-safety between the omap1_sram_reprogram_clock
and _omap_sram_reprogram_clock symbols, which the current code doesn't
do.
