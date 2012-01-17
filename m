From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled
 by uBoot)?
Date: Tue, 17 Jan 2012 16:27:21 +0000
Message-ID: <20120117162720.GG11475@arm.com>
References: <20120116105949.GG16726@n2100.arm.linux.org.uk>
 <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
 <20120116131329.GA928@n2100.arm.linux.org.uk>
 <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk>
 <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com>
 <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com>
 <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36612 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754700Ab2AQQ3S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jan 2012 11:29:18 -0500
Content-Disposition: inline
In-Reply-To: <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Aneesh V <aneesh@ti.com>, Joe Woodward <jw@terrafix.co.uk>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 17, 2012 at 01:58:18PM +0000, Shilimkar, Santosh wrote:
> On Tue, Jan 17, 2012 at 2:39 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Tue, Jan 17, 2012 at 12:40:54PM +0000, Shilimkar, Santosh wrote:
> >> On A15 infact there are other CP15 registers which needs to be set
> >> before MMU is enabled to have best configuration.
> >
> > Yes, there are, and my view is that it is up to the platform firmware to
> > set things right.
>
> Firmware is ROM'ed in SOC's and can't be altered without a new silicon spin.
> Then we get into situations where Errata A will say turn OFF/ON x bit and
> so on. Most of these bits are secure write-only registers hence ROM
> code provides few API's to alter these registers in future if needed.

BTW, does the firmware make any checks on what bits it allows to be set?
Some of them may have security implications (and may not even be
documented).

Anyway, the first step is this API provided by the secure firmware.
Since such API may need to be called before the MMU is initialised,
Linux would need to have knowledge of the platform type early on. Having
some platform hook (asm macro) to call early on wouldn't work with the
single zImage configuration. Stack space is not an issue as we already
have one for ARMv7 for D-cache flushing (XIP kernels would work but they
aren't that many).

> BTW, look at the processor setup functions where we are altering these
> bits in kernel today (Diagnostic, RR policy etc) and they work on
> ARM SoC's which either don't use trustzone or kernel is in secure mode.

What we did for many of them was to check whether the bits are already
set to avoid a fault when running in NS mode.

> Now same thing if needs to be done for SoC's like OMAP where
> these bits are under secure control, we need to use the ROM
> secure API's and kernel don't seems to give any flexibility
> to patch that.
> 
> I don't understand how __only__ these devices needs to be
> patches outside the kernel.

Because there isn't a standard API to set those registers. And such
generic API would not even be easily possible given that you can't tell
what auxiliary (or even undocumented) registers a new CPU may have in
the future (unless the API is part of the TRM).

> Firmware point is actually irrelevant for OMAP since it can't be
> changed once it is ROMed.
> 
> Patching in boot-loaders isn't an option either since every customers
> prefers to use there own boot-loader and then controlling this vital
> bits is impossible.
> 
> So I re-iterate that we need to have solution to this problem.

I don't disagree with this, a solution is needed. In the past I was for
having platform hooks in the early kernel code path but in the light of
latest kernel developments (FDT, single zImage), I no longer see this as
acceptable.

If you can't change the boot loader, an alternative could be for the SoC
vendor to provide an additional binary that is executed by the boot
loader before Linux is started. Such binary could either live in some
flash or it could be wrapped around the Linux kernel image before the
kernel is stored into flash.

-- 
Catalin
