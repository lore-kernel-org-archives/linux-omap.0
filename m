From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Tue, 25 Jan 2011 18:35:59 +0530
Message-ID: <f1a315fae482bbc82fc15cb7df2561de@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
 <1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com>
 <20110125114635.GB13300@n2100.arm.linux.org.uk> <236d45e400a960cc3b32db538b3a79ae@mail.gmail.com>
 <20110125121655.GD13300@n2100.arm.linux.org.uk> <4534e82bf14eeea9f96769df760df5ae@mail.gmail.com>
 <20110125125656.GG13300@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:60411 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753400Ab1AYNGE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 08:06:04 -0500
Received: by fxm9 with SMTP id 9so5524926fxm.3
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 05:06:02 -0800 (PST)
In-Reply-To: <20110125125656.GG13300@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, ccross@android.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Tuesday, January 25, 2011 6:27 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel@lists.infradead.org; catalin.marinas@arm.com;
> ccross@android.com; linus.ml.walleij@gmail.com; linux-
> omap@vger.kernel.org
> Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header
> file
>
> On Tue, Jan 25, 2011 at 06:06:27PM +0530, Santosh Shilimkar wrote:
> > Ok. I missed some information my last email.
> > The SCU power status programming is used to take CPU in/out
> > of coherency as an alternative to SMP bit. We don't
> > have an access to SMP bit on OMAP4. ARM has already
> > confirmed SCU programming is same as SMP bit enable/disable.
> >
> > I don't know how safe is to use spin lock when one CPU is
> > goes out of coherency after programming the power state. The
> > spin lock release may not even be visible to other CPU.
>
> Erm, I do hope that's not the case, as that means it is unsafe for
> CPUs in
> a SMP system to write to this register without them potentially
> trampling
> over each other.
>
> If it is the case, then the solutions are either:
> 1. Fix the hardware so that coherency requests only yet turned off
>    when entering the WFI state.
> 2. Fix the hardware such that each CPU has a separate register.
>
> I can't see a software solution to this as we can't use ldrex/strex
> anything
> but memory regions, and memory regions without coherency won't work.
> Maybe ARM Support can help by suggesting how a 4-CPU system is
> supposed
> to safely read/modify/write the SCU power control register...

On system wide suspend scenario's this is already handled because
CPU's are taken down always sequentially.

In CPU ILDE because of some other hardware restrictions we have it
sequenced in 2 CPU system. CPU1 needs to be in OFF mode before any
power management can be done on system along with master core.
And that's how it is working without any races on OMAP

Regards,
Santosh
