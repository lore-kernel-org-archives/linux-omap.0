From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by uBoot)?
Date: Tue, 17 Jan 2012 14:58:18 +0100
Message-ID: <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
References: <WC20120116100344.4204CC@terrafix.co.uk> <CAMQu2gw4H=m1QA+ucORYsO_LZR8Sj57=+jwmrkHu_7sdCzhN8g@mail.gmail.com>
 <20120116105949.GG16726@n2100.arm.linux.org.uk> <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
 <20120116131329.GA928@n2100.arm.linux.org.uk> <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com> <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:58789 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753484Ab2AQN6k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jan 2012 08:58:40 -0500
Received: by qabg27 with SMTP id g27so13841296qab.9
        for <linux-omap@vger.kernel.org>; Tue, 17 Jan 2012 05:58:39 -0800 (PST)
In-Reply-To: <20120117133918.GE11475@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Aneesh V <aneesh@ti.com>, Joe Woodward <jw@terrafix.co.uk>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 17, 2012 at 2:39 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Tue, Jan 17, 2012 at 12:40:54PM +0000, Shilimkar, Santosh wrote:
>> On Tue, Jan 17, 2012 at 1:27 PM, Aneesh V <aneesh@ti.com> wrote:
>> > Hi Catalin,
>> >
>> >
>> > On Tuesday 17 January 2012 05:41 PM, Catalin Marinas wrote:
>> >>
>> >> On Tue, Jan 17, 2012 at 08:54:44AM +0000, Joe Woodward wrote:
>> >>>
>> >>> So, is the upshot of this that the kernel isn't going to be in a
>> >>> position to enable the L2/outer cache on OMAP3 (due to the need =
for
>> >>> hacky/unmaintainable code)?
>> >>>
>> >>> Hence the bootloader/uBoot had better leave it enabled...
>> >>
>> >> It could but the Linux decompressor needs to be aware and either =
flush
>> >> the L2 (more difficult as it doesn't have all the device informat=
ion) or
>> >
>> > Cortex-A8 is aware of L2$ and can flush it, isn't it?
>> >
>> >> set the page table attributes to outer non-cacheable (TEX[2:0] =3D=
 0b100).
>> >
>> > If the above is right, this is not needed right?
>>
>> Well the L2 can be configured as inner or outer, so above
>> alone won't work.
>>
>> Boot-loader disabling L2 cache ( all caches) =A0is still right thing
>> and that's what kernel expect.
>>
>> Since the early kernel code can't be patches for A8, may be
>> delaying L2 enabled would work.
>
> Ah, I missed the fact that the L2 is an inner cache on OMAP3+A8. In t=
his
> case, I would argue to just leave it enabled since as long as the MMU=
 is
> off it won't be accessed. Why does U-Boot need to disable the L2 (I
> suspect via some auxiliary control register)?
>
>> But then on A15, we are back to square one since there is no
>> control to turn ON/OFF l2 cache.
>
> Well, it's an inner cache, it gets disabled/enabled via the SCTLR.M b=
it
> as is the L1 cache. It does not need to be disabled independently.
>
>> On A15 infact there are other CP15 registers which needs to be set
>> before MMU is enabled to have best configuration.
>
> Yes, there are, and my view is that it is up to the platform firmware=
 to
> set things right.
>
=46irmware is ROM'ed in SOC's and can't be altered without a new silico=
n spin.
Then we get into situations where Errata A will say turn OFF/ON x bit a=
nd
so on. Most of these bits are secure write-only registers hence ROM
code provides few API's to alter these registers in future if needed.

BTW, look at the processor setup functions where we are altering these
bits in kernel today (Diagnostic, RR policy etc) and they work on
ARM SoC's which either don't use trustzone or kernel is in secure mode.

Now same thing if needs to be done for SoC's like OMAP where
these bits are under secure control, we need to use the ROM
secure API's and kernel don't seems to give any flexibility
to patch that.

I don't understand how __only__ these devices needs to be
patches outside the kernel. Firmware point is actually irrelevant for
OMAP since it can't be changed once it is ROMed.

Patching in boot-loaders isn't an option either since every customers
prefers to use there own boot-loader and then controlling
this vital bits is impossible.

So I re-iterate that we need to have solution to this problem.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
