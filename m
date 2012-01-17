From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by uBoot)?
Date: Tue, 17 Jan 2012 21:27:02 +0100
Message-ID: <CAMQu2gwjOuGadqsGqcpHvdH-Jhhj6cchyoZJMMsOQ20SXsKDOw@mail.gmail.com>
References: <20120116105949.GG16726@n2100.arm.linux.org.uk>
 <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
 <20120116131329.GA928@n2100.arm.linux.org.uk> <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com> <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com> <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <20120117162720.GG11475@arm.com> <CAMQu2gyCcGYk0tC_g2R9+OBYCvwupcjuUkRC5JxJ7maAVTs1YA@mail.gmail.com>
 <alpine.LFD.2.02.1201171425060.2722@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:46490 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751504Ab2AQU10 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jan 2012 15:27:26 -0500
Received: by mail-qy0-f175.google.com with SMTP id p14so2152870qcs.6
        for <linux-omap@vger.kernel.org>; Tue, 17 Jan 2012 12:27:25 -0800 (PST)
In-Reply-To: <alpine.LFD.2.02.1201171425060.2722@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Aneesh V <aneesh@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joe Woodward <jw@terrafix.co.uk>

On Tue, Jan 17, 2012 at 8:39 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Tue, 17 Jan 2012, Shilimkar, Santosh wrote:
>
>> On Tue, Jan 17, 2012 at 5:27 PM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>> > BTW, does the firmware make any checks on what bits it allows to b=
e set?
>> > Some of them may have security implications (and may not even be
>> > documented).
>> >
>> > Anyway, the first step is this API provided by the secure firmware=
=2E
>> > Since such API may need to be called before the MMU is initialised=
,
>> > Linux would need to have knowledge of the platform type early on. =
Having
>> > some platform hook (asm macro) to call early on wouldn't work with=
 the
>> > single zImage configuration. Stack space is not an issue as we alr=
eady
>> > have one for ARMv7 for D-cache flushing (XIP kernels would work bu=
t they
>> > aren't that many).
>> >
>> That's true.
>
> That stack is ugly and _does_ break XIP (even if there aren't that ma=
ny
> if at all on ARMv7). =A0Since we're already writing to RAM while sett=
ing
> up the initial page table and therefore we did the necessary work to
> locate it already, we could as well put a temporary stack for early
> usage right below the page table.
>
>> >> Firmware point is actually irrelevant for OMAP since it can't be
>> >> changed once it is ROMed.
>> >>
>> >> Patching in boot-loaders isn't an option either since every custo=
mers
>> >> prefers to use there own boot-loader and then controlling this vi=
tal
>> >> bits is impossible.
>> >>
>> >> So I re-iterate that we need to have solution to this problem.
>> >
>> > I don't disagree with this, a solution is needed. In the past I wa=
s for
>> > having platform hooks in the early kernel code path but in the lig=
ht of
>> > latest kernel developments (FDT, single zImage), I no longer see t=
his as
>> > acceptable.
>> >
>> Thanks for acknowledging the problem. Not allowing such hooks for si=
ngle
>> zImage doesn't seems to be right. Nobody ships kernel build for all =
socs,
>> and it's usage is really limited to few distro's. But that's differe=
nt topic.
>
> No, I think this is right on topic. =A0If nobody ships a kernel for
> multiple SOCs, this is because right now this can't be done. =A0But
> distros are craving for this ability.
>
>> How about allowing platform hooks for single SOC builds. I mean havi=
ng
>> this code under !single_zImage or something like that. That way we d=
on't
>> impact the single zImage efforts and also allow socs to have all tho=
se
>> critical, vital bits enabled for the SOC specific builds.
>
> Absolutely not! =A0Because if we start doing that, people will get la=
zy
> and no platform will ever work in a multi-SOC kernel.
>
> If your SOC require some fancy setup that is not shared by other
> platforms then please abstract that into the bootloader, or make sure=
 it
> can be deferred later on.
>
There is nothing fancy here. It's an ARM security architecture feature =
which
OMAP implements. Have given enough reason about boot-loaders issues.

Is OMAP getting beaten up here just because it uses ARM security
feature and implements it's mechanics?

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
