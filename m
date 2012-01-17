From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by uBoot)?
Date: Tue, 17 Jan 2012 18:27:15 +0100
Message-ID: <CAMQu2gyCcGYk0tC_g2R9+OBYCvwupcjuUkRC5JxJ7maAVTs1YA@mail.gmail.com>
References: <20120116105949.GG16726@n2100.arm.linux.org.uk>
 <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
 <20120116131329.GA928@n2100.arm.linux.org.uk> <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com> <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com> <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <20120117162720.GG11475@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:34235 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750856Ab2AQR1h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jan 2012 12:27:37 -0500
Received: by mail-tul01m020-f178.google.com with SMTP id tb2so7975008obb.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Jan 2012 09:27:36 -0800 (PST)
In-Reply-To: <20120117162720.GG11475@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Aneesh V <aneesh@ti.com>, Joe Woodward <jw@terrafix.co.uk>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 17, 2012 at 5:27 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Tue, Jan 17, 2012 at 01:58:18PM +0000, Shilimkar, Santosh wrote:
>> On Tue, Jan 17, 2012 at 2:39 PM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>> > On Tue, Jan 17, 2012 at 12:40:54PM +0000, Shilimkar, Santosh wrote:
>> >> On A15 infact there are other CP15 registers which needs to be set
>> >> before MMU is enabled to have best configuration.
>> >
>> > Yes, there are, and my view is that it is up to the platform firmware to
>> > set things right.
>>
>> Firmware is ROM'ed in SOC's and can't be altered without a new silicon spin.
>> Then we get into situations where Errata A will say turn OFF/ON x bit and
>> so on. Most of these bits are secure write-only registers hence ROM
>> code provides few API's to alter these registers in future if needed.
>
> BTW, does the firmware make any checks on what bits it allows to be set?
> Some of them may have security implications (and may not even be
> documented).
>
> Anyway, the first step is this API provided by the secure firmware.
> Since such API may need to be called before the MMU is initialised,
> Linux would need to have knowledge of the platform type early on. Having
> some platform hook (asm macro) to call early on wouldn't work with the
> single zImage configuration. Stack space is not an issue as we already
> have one for ARMv7 for D-cache flushing (XIP kernels would work but they
> aren't that many).
>
That's true.

>> BTW, look at the processor setup functions where we are altering these
>> bits in kernel today (Diagnostic, RR policy etc) and they work on
>> ARM SoC's which either don't use trustzone or kernel is in secure mode.
>
> What we did for many of them was to check whether the bits are already
> set to avoid a fault when running in NS mode.
>
Yes but then as I mentioned for the secure kernels, they can set from the
kernel code.

>> Now same thing if needs to be done for SoC's like OMAP where
>> these bits are under secure control, we need to use the ROM
>> secure API's and kernel don't seems to give any flexibility
>> to patch that.
>>
>> I don't understand how __only__ these devices needs to be
>> patches outside the kernel.
>
> Because there isn't a standard API to set those registers. And such
> generic API would not even be easily possible given that you can't tell
> what auxiliary (or even undocumented) registers a new CPU may have in
> the future (unless the API is part of the TRM).
>
>> Firmware point is actually irrelevant for OMAP since it can't be
>> changed once it is ROMed.
>>
>> Patching in boot-loaders isn't an option either since every customers
>> prefers to use there own boot-loader and then controlling this vital
>> bits is impossible.
>>
>> So I re-iterate that we need to have solution to this problem.
>
> I don't disagree with this, a solution is needed. In the past I was for
> having platform hooks in the early kernel code path but in the light of
> latest kernel developments (FDT, single zImage), I no longer see this as
> acceptable.
>
Thanks for acknowledging the problem. Not allowing such hooks for single
zImage doesn't seems to be right. Nobody ships kernel build for all socs,
and it's usage is really limited to few distro's. But that's different topic.

How about allowing platform hooks for single SOC builds. I mean having
this code under !single_zImage or something like that. That way we don't
impact the single zImage efforts and also allow socs to have all those
critical, vital bits enabled for the SOC specific builds.

> If you can't change the boot loader, an alternative could be for the SoC
> vendor to provide an additional binary that is executed by the boot
> loader before Linux is started. Such binary could either live in some
> flash or it could be wrapped around the Linux kernel image before the
> kernel is stored into flash.
>
We tried something similar with boot-loaders and failed badly to get that
right for all the product trees. So if the single zImage is the blocker
I would like to tackle that and have all this important information within
kernel code.

Regards
Santosh
