From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Date: Sat, 17 Nov 2012 10:46:09 +0000
Message-ID: <CAHkRjk68zKV+oVKk9yYQo_+eXia_X4HqyhjknvJu7HiSW8wRJA@mail.gmail.com>
References: <50A3EBCD.3040801@ti.com> <20121114202244.GE3332@n2100.arm.linux.org.uk>
 <20121114203221.GA6801@atomide.com> <50A413D4.7000405@gmail.com>
 <20121114222159.GB6801@atomide.com> <50A43D58.5030404@gmail.com>
 <20121115110137.GA25985@arm.com> <50A4FCC5.2080604@gmail.com>
 <20121116095921.GH3332@n2100.arm.linux.org.uk> <20121116180928.GB31456@arm.com>
 <20121116183951.GJ3332@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:61674 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747Ab2KQKqa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Nov 2012 05:46:30 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so2255769qcr.19
        for <linux-omap@vger.kernel.org>; Sat, 17 Nov 2012 02:46:29 -0800 (PST)
In-Reply-To: <20121116183951.GJ3332@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Martin <dave.martin@linaro.org>, Tony Lindgren <tony@atomide.com>, Will Deacon <Will.Deacon@arm.com>, Jon Hunter <jon-hunter@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 16 November 2012 18:39, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 16, 2012 at 06:09:28PM +0000, Catalin Marinas wrote:
>> On Fri, Nov 16, 2012 at 09:59:21AM +0000, Russell King - ARM Linux wrote:
>> > On Thu, Nov 15, 2012 at 08:31:33AM -0600, Rob Herring wrote:
>> > > So we should make all these work-arounds depend on !MULTI_PLATFORM then.
>> >
>> > No, because some of the work-arounds don't require setting bits in magic
>> > registers.
>> >
>> > Also realise this: we test for the revision of the CPU to which they're
>> > applicable before attempting to set them.  If you have a work-around
>> > enabled in the kernel, and it fails at boot, _that_ is an indicator not
>> > that the kernel is doing something wrong, but that you need to ensure
>> > that the work-around has been applied by the earlier stages.
>> >
>> > It's not about "but platform X doesn't need it" - it's about platform X
>> > not having the earlier stages updated to fix the errata.
>>
>> There is another aspect. Many CPUs in the field, even if they are a
>> certain rxpy revision, have ECO fixes applied for critical bugs and
>> don't require the workaround. Sometimes those undocumented bits have
>> considerable performance impact and vendors may apply an ECO (unless
>> they are very late in the tape-out process). But the ECO fix does not
>> change the CPU revision, hence the workaround becomes platform specific.
>>
>> That's why I think it's better if those workarounds are just pushed to
>> the boot-loader for multi-platform kernels. Linux could still check the
>> bits and warn about them rather than failing to boot.
>
> ... and that's a U-turn if ever there was one... it's ARM Ltd who've been
> pushing to have these work-arounds in the kernel in the first place.

I wouldn't say it's a U-turn. ARM Ltd never had an official position
(i.e. document) on where the secure-only workarounds should be
implemented (but I think there should have been one). The most
convenient for me and SoC vendors was to push the workarounds into the
kernel, together with other run-time workarounds (which we must keep
in the kernel anyway).

> Should we just remove all the work-arounds, and require boot loaders,
> including the one on Versatile platforms, to implement this?  Why should
> we treat secure platforms be any different from the non-secure ones in
> this regard?  After all, this _does_ stand in the way of a single kernel
> image working properly on secure and non-secure platforms.

I'll ack this (but not all SoC vendors will agree). ARM Ltd, with the
introduction of TZ in ARMv6, made it clear that a general-purpose OS
should not differentiate between secure and non-secure worlds (no
register to read the state from). Furthermore, with the virtualisation
extensions (ARMv7, ARMv8), the general-purpose OS is supposed to run
in non-secure mode. This means that the place for secure-only
workarounds is outside the OS kernel.

> The more this thread progresses, the more I think the decision to put
> errata into the kernel was the wrong one.

Not entirely. This started at a time when we didn't have TZ (ARM1136).
We may also use Linux as a bootloader (kexec) and it's not clear
whether we need a pre-bootloader. But I think for now we could just
make the secure-only boot-time workarounds depend on
!ARCH_MULTIPLATFORM. For newer cores like Cortex-A15/A7 where we know
that Linux always runs in NS mode, don't add new secure-only
workarounds.

For AArch64 I will not merge any secure-only errata workarounds. I'll
leave this to the firmware (can be UEFI or a bootloader). The same for
other implementation-defined bits like SMP/nAMP which Linux can't
touch while in NS mode.

-- 
Catalin
