From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Tue, 25 Jan 2011 18:06:27 +0530
Message-ID: <4534e82bf14eeea9f96769df760df5ae@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
 <1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com>
 <20110125114635.GB13300@n2100.arm.linux.org.uk> <236d45e400a960cc3b32db538b3a79ae@mail.gmail.com>
 <20110125121655.GD13300@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:52521 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751545Ab1AYMg6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 07:36:58 -0500
Received: by mail-fx0-f54.google.com with SMTP id 16so5445191fxm.27
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 04:36:57 -0800 (PST)
In-Reply-To: <20110125121655.GD13300@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, ccross@android.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Tuesday, January 25, 2011 5:47 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel@lists.infradead.org; catalin.marinas@arm.com;
> ccross@android.com; linus.ml.walleij@gmail.com; linux-
> omap@vger.kernel.org
> Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header
> file
>
> On Tue, Jan 25, 2011 at 05:32:57PM +0530, Santosh Shilimkar wrote:
> > I have similar patch implemented but what it does is just
> > prepares the value to be programmed and stores it to a scratchpad.
> > I see your point but below patch may now work well. The reason is
> the SCU
> > register needs to accessed at the lowest level. May be even when
> > stack is not available. Also this register needs to be cleared in
> cases
> > where the attempted power state is failed for some reason.
>
> From the documentation I have, the power control register has no
> effect
> until the CPU enters WFI mode - which means that provided we can
> guarantee no one issues a WFI instruction between setting the power
> mode,
> and executing that instruction, being woken up (or failing) and
> resetting
> the power mode back... that shouldn't require the power mode to be
> programmed from assembly code.
>
> In any case, we actually need the help of spinlocks to deal with
> concurrent access to the SCU power control register - something you
> can't do in assembly code.
>
> On the way down to a WFI low power mode, we can call
> scu_power_mode(),
> do the rest of the cleanup (which must not schedule) and issue WFI.
> On
> the way back up, do whatever needs to be done and call
> scu_power_mode()
> to reset back to 'normal' mode.
>
Ok. I missed some information my last email.
The SCU power status programming is used to take CPU in/out
of coherency as an alternative to SMP bit. We don't
have an access to SMP bit on OMAP4. ARM has already
confirmed SCU programming is same as SMP bit enable/disable.

I don't know how safe is to use spin lock when one CPU is
goes out of coherency after programming the power state. The
spin lock release may not even be visible to other CPU.
The programming happens from IDLE or suspend where the
>
> > Also note that this register can be blocked using trust-zone which
> > again makes it platform dependent because direct write won't be
> > allowed in that case.
>
> Yes, I did notice.  What's the OMAP SMC interface for that?
>
> > I would prefer the header export if there is no major
> > objection since there is already a possibility of custom
> > implementation with trust zone.
> >
> > On OMAP4, on ES1.0 we need to use a secure API to achieve
> > this where as on ES2.0, it can be directly accessed.
>
> As I say, I'd rather not have each SoC implementing access to this
> as
> someone's bound to forget the spinlock if they're dealing with more
> than
> one CPU, which'll make stuff unreliable (just like I did on my
> initial
> version.)
> We could have a callback to SoC code which does the appropriate SMC
> call,
> but first I'll need to know what's required for the SMC call.

Ok. Will try to see if things can be worked out as pet your
suggestion.

Regards,
Santosh
