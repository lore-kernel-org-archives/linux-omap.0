From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by uBoot)?
Date: Wed, 18 Jan 2012 09:43:19 +0100
Message-ID: <CAMQu2gw3jmcmNU23g14n9=d+ikNvZjq7A6ePAZn+pQ2U9ce1pw@mail.gmail.com>
References: <20120116105949.GG16726@n2100.arm.linux.org.uk>
 <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
 <20120116131329.GA928@n2100.arm.linux.org.uk> <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com> <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com> <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <20120117162720.GG11475@arm.com> <CAMQu2gyCcGYk0tC_g2R9+OBYCvwupcjuUkRC5JxJ7maAVTs1YA@mail.gmail.com>
 <alpine.LFD.2.02.1201171425060.2722@xanadu.home> <CAMQu2gwjOuGadqsGqcpHvdH-Jhhj6cchyoZJMMsOQ20SXsKDOw@mail.gmail.com>
 <alpine.LFD.2.02.1201171536470.2722@xanadu.home> <CAMQu2gzJHvTSbMhzwLx22PSh190Nun+x=6+NZpWJPz4p3BAMJA@mail.gmail.com>
 <alpine.LFD.2.02.1201171601200.2722@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:36132 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756075Ab2ARInp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jan 2012 03:43:45 -0500
Received: by qcsr22 with SMTP id r22so1508114qcs.15
        for <linux-omap@vger.kernel.org>; Wed, 18 Jan 2012 00:43:43 -0800 (PST)
In-Reply-To: <alpine.LFD.2.02.1201171601200.2722@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Aneesh V <aneesh@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joe Woodward <jw@terrafix.co.uk>

On Tue, Jan 17, 2012 at 10:02 PM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
> On Tue, 17 Jan 2012, Shilimkar, Santosh wrote:
>
>> On Tue, Jan 17, 2012 at 9:45 PM, Nicolas Pitre <nico@fluxnic.net> wr=
ote:
>> > On Tue, 17 Jan 2012, Shilimkar, Santosh wrote:
>> >
>> >> On Tue, Jan 17, 2012 at 8:39 PM, Nicolas Pitre <nico@fluxnic.net>=
 wrote:
>> >> > On Tue, 17 Jan 2012, Shilimkar, Santosh wrote:
>> >> >
>> >> >> How about allowing platform hooks for single SOC builds. I mea=
n having
>> >> >> this code under !single_zImage or something like that. That wa=
y we don't
>> >> >> impact the single zImage efforts and also allow socs to have a=
ll those
>> >> >> critical, vital bits enabled for the SOC specific builds.
>> >> >
>> >> > Absolutely not! =A0Because if we start doing that, people will =
get lazy
>> >> > and no platform will ever work in a multi-SOC kernel.
>> >> >
>> >> > If your SOC require some fancy setup that is not shared by othe=
r
>> >> > platforms then please abstract that into the bootloader, or mak=
e sure it
>> >> > can be deferred later on.
>> >> >
>> >> There is nothing fancy here. It's an ARM security architecture fe=
ature which
>> >> OMAP implements. Have given enough reason about boot-loaders issu=
es.
>> >
>> > I was not convinced by those reasons. Just push harder on the boot=
loader
>> > side. =A0There is _no_ reason for the bootloader not to take care =
of this
>> > very platform specific issue. =A0You can even do it into a standal=
one
>> > uImage that returns to u-Boot after it is done with its magic.
>> >
>> >> Is OMAP getting beaten up here just because it uses ARM security
>> >> feature and implements it's mechanics?
>> >
>> > I don't care if this is OMAP, UX500 or i.MX. =A0There is a line to=
 be
>> > drawn and this is just too bad if you are trying to cross it.
>> >
>> Well I was trying to get a solution for a genuine problem.
>> Let's take an example.
>>
>> #ifdef CONFIG_ARM_ERRATA_742230
>> =A0 =A0 =A0 =A0 cmp =A0 =A0 r6, #0x22 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 @ only present up to r2p2
>> =A0 =A0 =A0 =A0 mrcle =A0 p15, 0, r10, c15, c0, 1 =A0 =A0 =A0 =A0 @ =
read diagnostic register
>> =A0 =A0 =A0 =A0 orrle =A0 r10, r10, #1 << 4 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 @ set bit #4
>> =A0 =A0 =A0 =A0 mcrle =A0 p15, 0, r10, c15, c0, 1 =A0 =A0 =A0 =A0 @ =
write diagnostic register
>> #endif
>>
>> The SoC's which doesn't have security restriction and the kernel
>> is in secure mode, above errata is applied in it's right place. Befo=
re
>> MMU is enabled. There are many bits like this which are patched
>> in kernel.
>>
>> On OMAP, all these can't be set-up in kernel since kernel is
>> in non-secure mode. To set such bit's we need to call some
>> pre-defined security calls.
>
> Absolutely. =A0Just don't do it in the early kernel boot code where i=
t is
> not convenient to do so.
>
Got it.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
